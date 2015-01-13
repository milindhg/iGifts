using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using prototype3.Models;
using Microsoft.Samples.ServiceHosting.StorageClient;
using System.Collections.Specialized;
using System.Globalization;
using System.Web.UI.WebControls;
using Microsoft.WindowsAzure.ServiceRuntime;
using System.Drawing;
using System.IO;

namespace prototype3.Models
{
    public class UserRepository
    {
        iGiftDBDataContext _db = new iGiftDBDataContext();

        private BlobContainer container;

        #region UserRelatedMethods

        public IQueryable<User> ListAll()
        {
            return from u in _db.Users select u;
        }

        public User GetUser(int id)
        {
            return _db.Users.SingleOrDefault(u => u.UserID == id);
        }

        public User GetUser(string username, string password)   //for user login
        {
            return _db.Users.SingleOrDefault(u => u.Username == username && u.Password == password);
        }

        public void Add(User user)
        {
            _db.Users.InsertOnSubmit(user);
        }

        public void Save()
        {
            _db.SubmitChanges();
        }

        #endregion

        #region FriendsRelatedMethods

        public IQueryable<User> GetFriends(int id)
        {
            IQueryable<User> friends = (from u in _db.Users                    
                                        join c in _db.Connections 
                                        on u.UserID equals c.FID
                                        where ((c.UserID == id) && (c.ReqConfirm == 1))
                                        select u);
            return friends;
        }

        public IQueryable<User> GetOnlineFriends(int id)
        {
            IQueryable<User> friends = GetFriends(id);
            IQueryable<User> onlinefriends = (from u in friends
                                              join c in _db.OnlineUsers
                                              on u.UserID equals c.UID
                                              select u);
            return friends.Intersect(onlinefriends);
        }

        public IQueryable<User> GetMututalFriends(int id1,int id2)
        {
            IQueryable<User> _friends1 = GetFriends(id1);
            IQueryable<User> _friends2 = GetFriends(id2);            
            IQueryable<User> _commonfriends;
            _commonfriends = _friends1.Intersect(_friends2);
            return _commonfriends;
        }

        public IQueryable<Event> GetUpcomingEvents(int id)
        {
            IQueryable<User> friends = (from u in _db.Users
                                        join c in _db.Connections
                                        on u.UserID equals c.FID
                                        where ((c.UserID == id) && (c.ReqConfirm == 1))
                                        select u);
            return (from ue in _db.Events
                    join f in friends
                    on ue.UserID equals f.UserID
                    orderby ue.EventDate descending
                    select ue);
        }

        public Boolean IsFriend(int id1, int id2)
        {
            IQueryable<User> _checkfriends = GetFriends(id1);
            foreach (User item in _checkfriends)
            {
                if (id2 == (int)item.UserID)
                    return true;
            }
            return false;
        }

        public void AddFriendRequest(int id1, int id2)
        {
            //add connection from id1 to id2 
            Connection _newfriendconn = new Connection()
            {
                CreditsGifted = 0,
                ReqConfirm = 0,
                UserID = id1,
                FID = id2
            };
            _db.Connections.InsertOnSubmit(_newfriendconn);
        }

        public void AcceptFriendRequest(int id1, int id2)   //id1: acceptor     id2: Requestor
        {
            //make confirm reuest bit to one for friend's request
            Connection _request = GetFriendConnection(GetUser(id2), GetUser(id1));
            _request.ReqConfirm = 1;
            Save();

            //and then add connection from id1 to id2 

            Connection _newfriendconn = new Connection()
            {
                CreditsGifted = 0,
                ReqConfirm = 1,
                UserID = id1,
                FID = id2
            };
            _db.Connections.InsertOnSubmit(_newfriendconn);
        }

        public Connection GetFriendConnection(User Source, User Destination)
        {
            return _db.Connections.SingleOrDefault(c => c.UserID == Source.UserID && c.FID == Destination.UserID);
        }

        public IQueryable<User> GetSearchResult(string searchtext)
        {
            return (from u in _db.Users
                    where ((u.FirstName.Contains(searchtext)) || (u.LastName.Contains(searchtext)) ||
                           (u.MiddleName.Contains (searchtext)) || (u.Username.Contains(searchtext)))
                    select u);
        }

        public IQueryable<Connection> GetPendingRequests(User SessionMaster)
        {
            return (from c in _db.Connections
                    where ((c.FID == SessionMaster.UserID) && (c.ReqConfirm == 0))
                    select c);
        }


        #endregion

        #region WishlistRelatedMethods

        public IQueryable<Wishlist> GetWishlist(int id)
        {           
            return (from w in _db.Wishlists
                    where ((w.UserID == id))
                    orderby w.Preference
                    select w);
        }

        public void AddWishItem(Wishlist wishItem)
        {
            _db.Wishlists.InsertOnSubmit(wishItem);
        }

        public void DeleteWishItem(Wishlist wishItem)
        {
            _db.Wishlists.DeleteOnSubmit(wishItem);
        }

        public Wishlist GetWishItem(int WishID)
        {
            return _db.Wishlists.SingleOrDefault(w => w.WID == WishID);
        }

        #endregion

        #region EventRelatedMethods

        public IQueryable<Event> GetEvents(int id)
        {
            return (from w in _db.Events
                    where ((w.UserID == id))
                    orderby w.EventDate
                    select w);
        }

        public void AddEventItem(Event eventItem)
        {
            _db.Events.InsertOnSubmit(eventItem);
        }

        public void DeleteEventItem(Event eventItem)
        {
            _db.Events.DeleteOnSubmit(eventItem);
        }

        public Event GetEventItem(int eventID)
        {
            return _db.Events.SingleOrDefault(w => w.EventID == eventID);
        }

        #endregion

        #region TransactionRelatedMethods

        public void addTrans(Transaction _trans)
        {
            _db.Transactions.InsertOnSubmit(_trans);
        }

        public Transaction GetLatestTransaction(User Source, User Destination)
        {
            Connection _c = GetFriendConnection(Source, Destination);
            IQueryable<Transaction> translist;
            translist = (from t in _db.Transactions
                         where ((t.CID == _c.CID))
                         orderby t.Timestamp descending
                         select t);
            return translist.First();

        }

        #endregion

        #region EventRelatedFunctions

        #endregion

        public void AddFeedback(Feedback fd)
        {
            _db.Feedbacks.InsertOnSubmit(fd);
        
        }

        public void GetContainer()
        {
            BlobStorage blobStorage = BlobStorage.Create(StorageAccountInfo.GetDefaultBlobStorageAccountFromConfiguration());
            BlobContainer newContainer = blobStorage.GetBlobContainer(RoleEnvironment.GetConfigurationSettingValue("ContainerName"));

            newContainer.CreateContainer(null, ContainerAccessControl.Public);
            container=newContainer;
        }


        public void SaveImage(string id, string contentType, byte[] data)
        {
            BlobProperties properties = new BlobProperties(string.Format(CultureInfo.InvariantCulture, "image_{0}", id));
            NameValueCollection metadata = new NameValueCollection();
            metadata["Id"] = id;
            metadata["Filename"] = "userimage";
            metadata["ImageName"] = "userimage";
            metadata["Description"] = "userimage";
            metadata["Tags"] = "userimage";
            properties.Metadata = metadata;
            properties.ContentType = contentType;
            BlobContents imageBlob = new BlobContents(data);
            container.CreateBlob(properties, imageBlob, true);
            
        }

        public void upload1_Click(FileUpload imageFile, string id)
        {
            //if (imageFile.HasFile)
            //{
            //    //status.Text = "Inserted [" + imageFile.FileName + "] - Content Type [" + imageFile.PostedFile.ContentType + "] - Length [" + imageFile.PostedFile.ContentLength + "]";
                //SaveImage(id, imageFile.PostedFile.ContentType, imageFile.FileBytes);
            //    //RefreshGallery();


            //}
           // else
           //     status.Text = "No image file";


            //BlobProperties properties = new BlobProperties(string.Format(CultureInfo.InvariantCulture, "image_{0}", id));
            //NameValueCollection metadata = new NameValueCollection();
            //metadata["Id"] = id;
            //metadata["Filename"] = "userimage";
            //metadata["ImageName"] = "userimage";
            //metadata["Description"] = "userimage";
            //metadata["Tags"] = "userimage";
            //properties.Metadata = metadata;
            //properties.ContentType = contentType;
            //BlobContents imageBlob = new BlobContents(data);
            //container.CreateBlob(properties, imageBlob, true);

        }

        public void AddShoppingTransaction(ShoppingTransaction st)
        {
            _db.ShoppingTransactions.InsertOnSubmit(st);
        
        
        }

        public ShoppingTransaction getGetLatestShoppingTransaction(User id)
        {



            return (from t in _db.ShoppingTransactions
                    where ((t.FromID == id.UserID))
                    orderby t.Timestamp descending
                    select t).First();
            
            
        
        
        }

        public IQueryable<ShoppingTransaction> GetGiftTransactionGrid(int id)
        {          
            return from st in _db.ShoppingTransactions 
                   where st.FromID==id || st.ToID==id
                   orderby st.Timestamp
                   select st;
        }

        public IQueryable<ShoppingTransaction> GetGiftsReceived(int id)
        {
            return from st in _db.ShoppingTransactions
                   where st.FromID != id && st.ToID == id
                   orderby st.Timestamp
                   select st;
        }

        public IQueryable<ShoppingTransaction> GetGiftsSent(int id)
        {
            return from st in _db.ShoppingTransactions
                   where st.FromID == id && st.ToID != id
                   orderby st.Timestamp
                   select st;
        }

        public IQueryable<Transaction> GetCreditTransactionGrid(int id)
        {
            return from st in _db.Transactions
                   where st.Connection.user.UserID == id || st.Connection.User1.UserID == id
                   orderby st.Timestamp
                   select st;
        }

        public IQueryable<Transaction> GetCreditsReceived(int id)
        {
            return from st in _db.Transactions
                   where st.Connection.User1.UserID == id
                   orderby st.Timestamp
                   select st;
        }

        public IQueryable<Transaction> GetCreditsSent(int id)
        {
            return from st in _db.Transactions
                   where st.Connection.user.UserID == id
                   orderby st.Timestamp
                   select st;
        }

        public IQueryable<ScrapBook> GetScraps(int to_id)
        {
            return from s in _db.ScrapBooks
                   where s.ToID == to_id
                   orderby s.Timestamp descending
                   select s;
        
        }


        public ScrapBook GetScrap(int scrapid)
        {
            return _db.ScrapBooks.SingleOrDefault(s => s.ScapID == scrapid);
        
        }

        public void PostScrap(ScrapBook _scrap)
        {

            _db.ScrapBooks.InsertOnSubmit(_scrap);
        
        }
        public void DeleteScrap(int scrapid)
        {
            ScrapBook sb = new ScrapBook();
            sb = GetScrap(scrapid);
                       
            _db.ScrapBooks.DeleteOnSubmit(sb);

        
        }

        public void AddOnlineUser(OnlineUser OLuser)
        {
            _db.OnlineUsers.InsertOnSubmit(OLuser);
        }

        public bool doesOLUserExist(int userID)
        {
            OnlineUser oluser = _db.OnlineUsers.SingleOrDefault(ol => ol.UID == userID);
            if (oluser!=null)
                return true;
            else
                return false;
        }

        public OnlineUser GetOnlineUser(int OLUserID)
        {
            return _db.OnlineUsers.SingleOrDefault(olu => olu.UID == OLUserID);
        }

        public void DeleteOnlineUser(User currOLUser)
        {
            OnlineUser tobedeleted = GetOnlineUser((int)currOLUser.UserID);
            _db.OnlineUsers.DeleteOnSubmit(tobedeleted);
        }


        public Stream CreateThumbnail(Stream input)
        {
            Bitmap orig = new Bitmap(input);

            int width;
            int height;
            if (orig.Width > orig.Height)
            {
                width = 128;
                height = 128 * orig.Height / orig.Width;
            }
            else
            {
                height = 128;
                width = 128 * orig.Width / orig.Height;
            }

            Bitmap thumb = new Bitmap(width, height);
            using (Graphics graphic = Graphics.FromImage(thumb))
            {
                graphic.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
                graphic.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.AntiAlias;
                graphic.PixelOffsetMode = System.Drawing.Drawing2D.PixelOffsetMode.HighQuality;

                graphic.DrawImage(orig, 0, 0, width, height);
                MemoryStream ms = new MemoryStream();
                thumb.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);

                ms.Seek(0, SeekOrigin.Begin);
                return ms;
            }

        }


    }
}
