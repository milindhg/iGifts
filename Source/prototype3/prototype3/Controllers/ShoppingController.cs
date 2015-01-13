using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;
using prototype3.Models;

namespace prototype3.Controllers
{
    public class ShoppingController : Controller
    {
        //
        // GET: /Shopping/
        ShoppingItemRepository _sdb = new ShoppingItemRepository();
        UserRepository userRep = new UserRepository();
        int shop_to_id;
        
        public ActionResult Index()
        {
            shop_to_id = int.Parse(Request.QueryString["to_id"]);
            Session["shop_to_id"] = shop_to_id;
            ViewData["Message"] = "Shopping Cart";

            return View(_sdb.GetItems(1, 1));
        }

        public ActionResult DisplayItems(int CatID, int SubCatID)
        {
            var currentItems = _sdb.GetItems(CatID, SubCatID);
            return View("Index", currentItems);
        }

        public ActionResult BuyItem(int ItemID)
        {
            var currentItem = _sdb.GetCurrentItem(ItemID);
            return View(currentItem);
        
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult BuyItem(FormCollection formValues)
        {
            
            
            
            int from_id = int.Parse(Request.Form["from_id"]);
            int to_id = int.Parse(Session["shop_to_id"].ToString());
            int item_id = int.Parse(Request.Form["item_id"]);
            float item_credits = float.Parse(Request.Form["item_credits"]);
            string shipping_address = Request.Form["shipping_address"];
            DateTime time_stamp = DateTime.Now;
            ShoppingTransaction st = new ShoppingTransaction();
            st.ToID = to_id;
            st.FromID = from_id;
            st.ItemID = item_id;
            st.ItemCredits = item_credits;
            st.ShippingAddress = shipping_address;
            st.Timestamp = time_stamp;



            if ((float)item_credits < ((User)Session["Current"]).Credits)
            {
                User curr_user = userRep.GetUser((int)((User)Session["Current"]).UserID);

                curr_user.Credits -= item_credits; 

                userRep.AddShoppingTransaction(st);
                userRep.Save();
            }

            else
            {
                ViewData["msg"] = "No credits";
            
            }
           
            return View("ShoppingTransaction",st);

        }

        public ActionResult GiftTransactionGrid()
        {
            return View(userRep.GetGiftTransactionGrid((int)((User)Session["Current"]).UserID));
        }

        public ActionResult GiftsReceived()
        {
            return View("GiftTransactionGrid",userRep.GetGiftsReceived((int)((User)Session["Current"]).UserID));
        }

        public ActionResult GiftsSent()
        {
            return View("GiftTransactionGrid", userRep.GetGiftsSent((int)((User)Session["Current"]).UserID));
        }

        public ActionResult CreditTransactionGrid()
        {
            return View(userRep.GetCreditTransactionGrid((int)((User)Session["Current"]).UserID));
        }

        public ActionResult CreditsReceived()
        {
            return View("CreditTransactionGrid", userRep.GetCreditsReceived((int)((User)Session["Current"]).UserID));
        }

        public ActionResult CreditsSent()
        {
            return View("CreditTransactionGrid", userRep.GetCreditsSent((int)((User)Session["Current"]).UserID));
        }
    }
}
