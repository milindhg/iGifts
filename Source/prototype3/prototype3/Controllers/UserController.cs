using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;
using prototype3.Models;
using System.Web.UI.WebControls;
using System.IO;
using System.Web.Services.Description;

namespace prototype3.Controllers
{
    public class UserController : Controller
    {
        UserRepository userRep = new UserRepository();
        ShoppingItemRepository _sdb = new ShoppingItemRepository();
        
        
        //
        // GET: /User/Index

        #region User and Basic Actions

        public ActionResult Index()
        {
            var _users = userRep.ListAll();
            ViewData["Message"] = "User1";
            if (Session["Current"] != null)
                return View(_users);                
            return View(_users);
        }

        //Details of user
        public ActionResult Details(int id)
        {
            User _user = userRep.GetUser(id);       //Get the Profile user ID
            ViewData["ProfileID"] = id.ToString();  //Pass the profile ID to the Details page
            if (_user == null)
                return View("SearchResult");
            else
                return View(_user);
        }

        
        //Get Implementation for reg
        public ActionResult Register()
        {
            User _user = new User();

            return View(_user);

        }

        //POST implementation for Register
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Register(FormCollection formValues)
        {
            User _user = new User();

            
            UpdateModel(_user);
            _user.Credits = 1000;
            userRep.Add(_user);
            userRep.Save();
            Session["Current"] = _user;
            return View("Details",_user);

        }

        public ActionResult Edit(int id)
        {
            prototype3.Models.User _user = userRep.GetUser(id);
            return View(_user);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Edit(int id, FormCollection formValues)
        {
            prototype3.Models.User _user = userRep.GetUser(id);

            UpdateModel(_user);
            userRep.Save();
            return RedirectToAction("Details", new { id = _user.UserID });
        }

        //Get for Login
        public ActionResult Login()
        {
            User _user = new User();
            if(Session["Current"]!=null)
            {
                _user = (User)Session["Current"];
                    return View("Details",_user);
            }

            return View();
        }

        //POST for Login
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Login(FormCollection formValues)
        {
            User _user = userRep.GetUser(Request.Form["Username"], Request.Form["Password"]);
            if (_user == null)
                return View("NotFound");
            else
            {
                Session["Current"] = _user;
                if (!userRep.doesOLUserExist((int)_user.UserID))
                {
                    OnlineUser OLUser = new OnlineUser();
                    OLUser.UID = _user.UserID;
                    OLUser.Timestamp = DateTime.Now;
                    //OLUser.OnlineID = 2;
                    userRep.AddOnlineUser(OLUser);
                    userRep.Save();
                    
                }
                else
                {
                    OnlineUser OLUser = userRep.GetOnlineUser((int)_user.UserID);
                    OLUser.Timestamp = DateTime.Now;
                    userRep.Save();
                }
                return View("Details", _user);
            }
        }

        public ActionResult Logout()
        {
            userRep.DeleteOnlineUser((User)Session["Current"]);
            userRep.Save();
            Session.Clear();
            Response.Redirect("/User/Login");
            return View();
        }

        #endregion

        public ActionResult BlankPage()
        {
            User _user = new User();
            if (Session["Current"] != null)
            {
                _user = (User)Session["Current"];
                ViewData.Model = _user;
                return View(_user);
            }
            else
            {
                return View() ;
            }
        }

        #region FriendsRelatedActions

        public ActionResult FriendsPage(int id)
        {
            //prototype3.Models.User _friend = userRep.GetUser(id);
            User _currentsession = (User)Session["Current"];
            if (id == (int)_currentsession.UserID)
                Response.Redirect("/");

            User _friend = userRep.GetUser(id);       //Get the Profile user ID
            ViewData["ProfileID"] = id.ToString();  //Pass the profile ID to the Friends page
            if (_friend == null)
                return View("NotFound");
            else
                return View(_friend);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult FriendsPage(FormCollection formValues)
        {

            float _amttrans = float.Parse(Request.Form["_amount"]);
            

            //Get Source User (i.e. the current session master)
            prototype3.Models.User _source = userRep.GetUser((int)((User)Session["Current"]).UserID);
            
            //Get destination user
            prototype3.Models.User _dest = userRep.GetUser(int.Parse(Request.Form["_id"]));

            if (_amttrans <= _source.Credits)
            {
                //Perform the transaction of credit transfer
                _source.Credits -= float.Parse(Request.Form["_amount"]);
                _dest.Credits += float.Parse(Request.Form["_amount"]);
                userRep.Save(); //Submit the changes
                //reset the session with changed session master
                Session["Current"] = _source;

                //Record the transaction in to trans table
                Connection cn = userRep.GetFriendConnection(_source, _dest);
                Transaction _trans = new Transaction()
                {
                    AmountTransfered = float.Parse(Request.Form["_amount"]),
                    CID = cn.CID,
                    Timestamp = DateTime.Now
                };
                userRep.addTrans(_trans);
                userRep.Save();

            }
            else {
                _source.Credits -= float.Parse(Request.Form["_amount"]);
                _dest.Credits += float.Parse(Request.Form["_amount"]);
                userRep.Save(); //Submit the changes
                //reset the session with changed session master
                Session["Current"] = _source;

                //Record the transaction in to trans table
                Connection cn = userRep.GetFriendConnection(_source, _dest);
                Transaction _trans = new Transaction()
                {
                    AmountTransfered = float.Parse(Request.Form["_amount"]),
                    CID = cn.CID,
                    Timestamp = DateTime.Now
                };

                ViewData["msg"] = "You Dont Have Enough Credits.";
            
            }            

            return View("TransferCredits",_dest);
        }

        //method to display search
        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult Search()
        {
            ViewData["msg"] = Request.Url;
            ViewData["msg"] = Request.QueryString["searched"];
            return View();
        }


        public ActionResult AddAsFriend(int id)
        {
            //create an entry for connection of session master with profile user
            int id1 = (int)((prototype3.Models.User)Session["Current"]).UserID;      //current session master id
            int id2 = id;   //requested friend user id (passed in parameter)
            userRep.AddFriendRequest(id1, id2);
            userRep.Save();
            //then return to the profile page now as friend
            prototype3.Models.User _user = userRep.GetUser(id);
            Response.Redirect("/User/FriendsPage/" + id);
            return View("FriendsPage", _user);
        }

        public ActionResult AcceptAsFriend(int id)  //id is the passed id of the one whose request is accepted
        {
            //create an entry for connection of session master with profile user
            userRep.AcceptFriendRequest((int)((User)Session["Current"]).UserID, id);
            userRep.Save();
            //then return to the profile page now as friend
            //prototype3.Models.User _user = userRep.GetUser(id);
            Response.Redirect("/");
            return View();
        }

        #endregion

        #region TransactionRelated Actions

        public ActionResult TransferCredits()
        {

            return View();
        }

        #endregion

        #region WishlistRelated Actions

        public ActionResult AddWishItem()
        {
            User _currentuser = (User)Session["Current"];
            IQueryable<Wishlist> _currentwishlist = userRep.GetWishlist((int)_currentuser.UserID);
            Wishlist _wishitem = new Wishlist()
            {
                 Preference=_currentwishlist.Count() + 1,
                 UserID=_currentuser.UserID,   
                 WishItem=Request.QueryString["Item"],
              
            };
            userRep.AddWishItem(_wishitem);
            userRep.Save();
            Response.Redirect("/");
            return View("Login");
        }

        public ActionResult EditWishItem()
        {
            //Get WID and modify it. Thats it
            int WishID = int.Parse(Request.QueryString["ItemID"]);
            Wishlist _currWish = userRep.GetWishItem(WishID);
            _currWish.WishItem = Request.QueryString["Item"];
            UpdateModel(_currWish);
            userRep.Save();
            Response.Redirect("/");
            return View("Login");
        }

        public ActionResult DeleteWishItem(int WishID)
        {

            return View();
        }
        #endregion

        #region EventsRelated Actions

        public ActionResult AddEventItem()
        {
            User _currentuser = (User)Session["Current"];
            IQueryable<Event> _currenteventslist = userRep.GetEvents((int)_currentuser.UserID);
            Event _eventitem = new Event()
            {
                EventName = Request.QueryString["EventName"],
                UserID = _currentuser.UserID,
                EventDate = DateTime.Parse(Request.QueryString["EventDate"])
            };
            userRep.AddEventItem(_eventitem);
            userRep.Save();
            Response.Redirect("/");
            return View("Login");
        }

        public ActionResult EditEventItem()
        {
            ////Get WID and modify it. Thats it
            //int WishID = int.Parse(Request.QueryString["ItemID"]);
            //Wishlist _currWish = userRep.GetWishItem(WishID);
            //_currWish.WishItem = Request.QueryString["Item"];
            //UpdateModel(_currWish);
            //userRep.Save();
            //Response.Redirect("/");
            return View("Login");
        }

        public ActionResult DeleteEventItem(int WishID)
        {

            return View();
        }
        #endregion

        public ActionResult About()
        {

            return View();
        }

        public ActionResult AddFeedback()
        {
            Feedback _feedback = new Feedback();
            return View(_feedback);
        
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult AddFeedback(FormCollection formValues)
        {
            Feedback _feedback = new Feedback();
            UpdateModel(_feedback);

            //UpdateModel(_feedback);
            userRep.AddFeedback(_feedback);
            userRep.Save();
            Response.Redirect("/");
            return View("Login","User");

        }

        public ActionResult GiftItemNow(int itemid,int friendid)
        {

            prototype3.Models.ShoppingItem currentitem = _sdb.GetCurrentItem(itemid);
            prototype3.Models.User _source = userRep.GetUser((int)((User)Session["Current"]).UserID);
            prototype3.Models.User _dest = userRep.GetUser(friendid);

            if (currentitem.ItemPrice <= _source.Credits)
            {
                _source.Credits -= currentitem.ItemPrice;
                Transaction _trans = new Transaction()
                {
                    AmountTransfered = currentitem.ItemPrice,
                    CID = -1,
                    Timestamp = DateTime.Now
                };

                userRep.addTrans(_trans);
                userRep.Save();

            }
            else
            {
                ViewData["msg"] = "You Dont Have Enough Credits.";
            }

            return View("TransferCredits", _dest);
        }

        public ActionResult GiftToFriend(int FrID)
        {

            return View();
        }

        public ActionResult ScrapBook()
        {                   

            int from_id;
            int to_id;
            to_id = int.Parse(Request.QueryString["to_id"]);
            from_id = (int)((User)Session["Current"]).UserID;
            Session["to_id"]= to_id;

            
            IQueryable<ScrapBook> _scrap = userRep.GetScraps(to_id);

                    
            return View(_scrap);
        
        
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult ScrapBook(FormCollection formValues)
        {
            int from_id;
            int to_id;

            to_id = (int)Session["to_id"];            
            from_id = (int)((User)Session["Current"]).UserID;
            string Scrap_Text = Request.Form["PostScrap"];

            ScrapBook _scrap = new ScrapBook();

            _scrap.ToID = to_id;
            _scrap.FromID = from_id;
            _scrap.Scrap = Scrap_Text;
            _scrap.Timestamp = DateTime.Now;

            userRep.PostScrap(_scrap);


            userRep.Save();

            return View("ScrapBook", userRep.GetScraps(to_id));
        }


        public ActionResult DeleteScrap(int scrapid)
        {
            userRep.DeleteScrap(scrapid);
            userRep.Save();
            int to_id = (int)Session["to_id"];
            Response.Redirect("/User/ScrapBook?to_id=" + to_id);
            return View("ScrapBook", userRep.GetScraps(to_id));
        }
      

    }
}
