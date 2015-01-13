<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/User.Master" Inherits="System.Web.Mvc.ViewPage<prototype3.Models.User>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Details
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentMiddle" runat="server">



    <% if (Session["Current"] != null)
   { %>
   
   <% StringBuilder str_img = new StringBuilder();

      str_img.Append(" <img style=\"height:175px; width:200px;\"  src=\"http://127.0.0.1:10000/devstoreaccount1/igifts/image_"+Model.UserID+"\" />");   
           
           
           
           %>
   
   <%= str_img.ToString() %>

   

    
    <% //get pending requests. And if there are any, then show this fieldset for pending requests %>
    <% prototype3.Models.UserRepository userrep = new prototype3.Models.UserRepository();
       IQueryable<prototype3.Models.Connection> _requests =  userrep.GetPendingRequests((prototype3.Models.User)Session["Current"]);
       if(_requests.Count()>0) 
       {           
        %>
    <fieldset>
        <legend>Pending Requests</legend>
        <% foreach (prototype3.Models.Connection item in _requests)
           {
        %>
            <p> <%= (userrep.GetUser((int)item.UserID)).FirstName + " " + (userrep.GetUser((int)item.UserID)).LastName%> <%= Html.ActionLink("Accept", "AcceptAsFriend", new {id=(int)item.UserID }) %></p> 
        <%
           }
                %>
    </fieldset>
    
    <% } %>
    
    <h2> <%= Model.FirstName + " " + Model.LastName %></h2>    
    <fieldset>
        <legend>Credits</legend>
        <p>
        <form action="https://www.sandbox.paypal.com/cgi-bin/webscr" method="post">
<input type="hidden" name="cmd" value="_s-xclick">
<input type="hidden" name="hosted_button_id" value="1067854">
<input type="image" src="https://www.sandbox.paypal.com/en_US/i/btn/btn_buynowCC_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
<img alt="" border="0" src="https://www.sandbox.paypal.com/en_US/i/scr/pixel.gif" width="1" height="1">
 Buy More Credits

</form>
  
        </p>
        
        
        
        <p style="text-align:center;">
        No of Credits Remaining = <%= Model.Credits  %>
        <img src ="../../Resources/Images/iGiftsCredits.jpg" />
        
        </p>
        
        
    </fieldset>
    

<% } %>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContentLeft" runat="server">

    <script src="../../Scripts/jquery-1.3.2.js"></script>
    <script type="text/javascript">

    
    
 $(document).ready(
      function() {
        $('.slidewlist').hide();
      }
      );

      function SlideWishList() {
        
               

//            var gridItem = $(ctr);
//            var className = gridItem.attr('class');
//            if (gridItem.hasClass('slidewlist')) {
//                //grid

//                gridItem.toggleClass('slidewlist_t');
//            }
          $('.slidewlist').toggle();

          return false;

        }

     
    
    function ModalWishlistAlert() {
    ModalPopups.Custom("idCustom1",
        "Enter New Item in Wishlist",
        "<div style='padding: 25px;'>" +    
        "<table>" +    
        "<tr><td>Enter Your Wish here: </td><td><input type=text id='inputCustom1Wish' style='width:250px;'></td></tr>" +    
        "</table>" +    
        "</div>",    
        {
            width: 500,   
            buttons: "ok,cancel",   
            okButtonText: "Save",   
            cancelButtonText: "Cancel",   
            onOk: "ModalPopupsCustom1Save()",   
            onCancel: "ModalPopupsCustom1Cancel()"  
        }   
    );   
               
    ModalPopups.GetCustomControl("inputCustom1Wish").focus();    
}   
function ModalPopupsCustom1Save() {   
    var custom1Name = ModalPopups.GetCustomControl("inputCustom1Wish");
    if (custom1Name.value == "") {
        alert(operation);
        alert("Please submit a name to this form");
        custom1Name.focus();        
    }   
    else {
        alert("You entered: " + custom1Name.value);
        ModalPopups.Close("idCustom1");
        window.location = "/user/AddWishItem?Item=" + custom1Name.value;
    }   
}   
  
function ModalPopupsCustom1Cancel() {   
    alert('You pressed Cancel');   
    ModalPopups.Cancel("idCustom1");   
}

function ModalWishlistEditAlert() {
    ModalPopups.Custom("idCustom1",
        "Edit Item in Wishlist",
        "<div style='padding: 25px;'>" +
        "<table>" +
        "<tr><td>Enter Your Wish here: </td><td><input type=text id='inputCustom1Wish' style='width:250px;'></td></tr>" +
        "</table>" +
        "</div>",
        {
            width: 500,
            buttons: "ok,cancel",
            okButtonText: "Save",
            cancelButtonText: "Cancel",
            onOk: "ModalPopupsCustom1Save()",
            onCancel: "ModalPopupsCustom1Cancel()"
        }
    );

    ModalPopups.GetCustomControl("inputCustom1Wish").focus();
}
function ModalPopupsCustom1EditSave() {
    var custom1Name = ModalPopups.GetCustomControl("inputCustom1Wish");
    if (custom1Name.value == "") {
        alert("Please submit a name to this form");
        custom1Name.focus();
    }
    else {
        alert("You entered: " + custom1Name.value);
        ModalPopups.Close("idCustom1");
        window.location = "/user/AddWishItem?Item=" + custom1Name.value;
    }
}

function ModalPopupsCustom1EditCancel() {
    alert('You pressed Cancel');
    ModalPopups.Cancel("idCustom1");

    function change(f) {
        alert(f);
        
    }
}  

</script>

<% if (Session["Current"] != null)
   { %>

    <%  //declarations and initialisations
    prototype3.Models.UserRepository _urep = new prototype3.Models.UserRepository();
    prototype3.Models.User _user = (prototype3.Models.User)Session["Current"]; //get current session user
    int profileID;
    IQueryable<prototype3.Models.Wishlist> _wishlist;
    if (ViewData["ProfileID"] == null)      //if profileID viewdata not set then 
        profileID = (int)(_user.UserID);    //take current session userid
    else
        profileID = int.Parse(ViewData["ProfileID"].ToString());  //else get the profileid of passed user

    _wishlist = _urep.GetWishlist(profileID);  //get the wishlist of the profile visited        
       
%>
    
            <div class="side-bucket">
                <div class="side-bucket-top"></div>
                <div class="side-bucket-content">
                    <div class="side-bucket-heading-top"></div>
                    <div class="side-bucket-heading-content">
                        <h2>Profile</h2>
                    </div>
                    <div class="side-bucket-heading-bottom"></div>
                       <ul>
                            <li>Name: <%= Model.FirstName + " " + Model.LastName %></li>
                            <li>Sex: <%= Model.Sex %></li>
                            <li>City: <%= Model.City %></li>
                            <li>State: <%= Model.State %></li>
                            <li>Country: <%= Model.Country %></li>
                            <li><p style=" text-align:right;"><%=Html.ActionLink("Edit", "Edit", new { id = Model.UserID })%></p></li>
                       </ul>
                </div>
                <div class="side-bucket-bottom"></div>
            </div>
            <div class="side-bucket">
                <div class="side-bucket-top"></div>
                <div class="side-bucket-content">
                    <div class="side-bucket-heading-top"></div>
                    <div class="side-bucket-heading-content">
                        <h2>Wishlist</h2>
                    </div>
                    <div class="side-bucket-heading-bottom"></div>
                    <ul>
                    
                    <li onclick = "SlideWishList()" style = "color:Red">
                     Click Here to Edit/Delete your Wish List Items
                   
                    
                    </li>
                       <% foreach (var item in _wishlist)
                          { %>
                            <li>
                            <%= Html.Encode(item.Preference + " " + item.WishItem)%> 
                            <div class = "slidewlist" >
                            
                            <p style="text-align:right;"><a style=" display:inline;" href="javascript:ModalWishlistAlert();">Edit</a> | 
                            <a style=" display:inline;" href="javascript:ModalWishlistAlert();">Delete</a> </p>
           
                            
                            </div>
                            
                 </li>
                       <% } %>
                       <li><p style=" text-align:right;"><a href="javascript:ModalWishlistAlert();">Add Item in Wishlist</a> </p></li>
                    </ul>

                </div>
                <div class="side-bucket-bottom"></div>
            </div>

            <div class="side-bucket">
                <div class="side-bucket-top"></div>
                <div class="side-bucket-content">
                    <div class="side-bucket-heading-top"></div>
                    <div class="side-bucket-heading-content">
                        <h2>Upcoming Events</h2>
                    </div>
                    <div class="side-bucket-heading-bottom"></div>
                        <h5>After this here i'll put the Upcoming birthdays</h5>
                </div>
                <div class="side-bucket-bottom"></div>
            </div>

<% } %>            
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContentRight" runat="server">
    <% if (Session["Current"] != null)
   { %>

    <div class="side-bucket">
     <div class="side-bucket-top"></div>
     <div class="side-bucket-content">
        <div class="side-bucket-heading-top"></div>
        <div class="side-bucket-heading-content">
           <h2>Friend's List</h2>
        </div>
     <div class="side-bucket-heading-bottom"></div>
        <p><% prototype3.Models.UserRepository _urep = new prototype3.Models.UserRepository();
              prototype3.Models.User curr = (prototype3.Models.User)Session["Current"];
              var _friends = _urep.GetFriends((int)curr.UserID);                      
           %> 
        </p>
        <ul>
            <% foreach (var item in _friends)
               {
                      %>
                      <li> <%= Html.ActionLink(item.FirstName + " " + item.LastName, "FriendsPage", new { id = item.UserID })%> </li>
            <% } %>
        </ul>
     </div>
     <div class="side-bucket-bottom"></div>
     
<div class="side-bucket-top"></div>
     <div class="side-bucket-content">
        <div class="side-bucket-heading-top"></div>
        <div class="side-bucket-heading-content">
           <h2> Shopping Cart</h2>
           
           
        </div>
     <div class="side-bucket-heading-bottom"></div>
     <ul>
     
     <li>
           <%= Html.ActionLink("Shopping Cart", "Index", "Shopping") %>
     </li>
     <li> 
     <%StringBuilder str_img = new StringBuilder();

       str_img.Append(" <a href=\"../../upload.aspx?id="+Model.UserID+"\">Upload Photo</a>");
            %>
            
            <%= str_img.ToString() %>
     
    
     </li>
     
           </ul>
     </div>
        
     <div class="side-bucket-bottom"></div>     
</div>

<% } %>        
</asp:Content>

