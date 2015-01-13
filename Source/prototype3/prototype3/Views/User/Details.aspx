<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/User.Master" Inherits="System.Web.Mvc.ViewPage<prototype3.Models.User>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Your Profile
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentMiddle" runat="server">
<script src="../../Scripts/jquery-1.3.2.js" type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(
        function() {
            $('#tt1').hide();
            $('#tt2').hide();
            $('#tt3').hide();
            $('#tt4').hide();
       
            
            $('#link1').click(function() {
                $('#tt1').slideToggle('fast');
                $('#link1').css('border-style','inset')
                $('#tt2').slideUp();
                $('#link2').css('border-style', 'outset')
                $('#tt3').slideUp();
                $('#link3').css('border-style', 'outset')
                $('#tt4').slideUp();
                $('#link4').css('border-style', 'outset')

            });
            $('#link2').click(function() {
                $('#tt2').slideToggle('fast');
                $('#link2').css('border-style', 'inset')
                $('#tt1').slideUp();
                $('#link1').css('border-style', 'outset')
                $('#tt3').slideUp();
                $('#link3').css('border-style', 'outset')
                $('#tt4').slideUp();
                $('#link4').css('border-style', 'outset')

            });

            $('#link3').click(function() {
                $('#tt3').slideToggle('fast');
                $('#link3').css('border-style', 'inset')
                $('#tt2').slideUp();
                $('#link2').css('border-style', 'outset')
                $('#tt1').slideUp();
                $('#link1').css('border-style', 'outset')
                $('#tt4').slideUp();
                $('#link4').css('border-style', 'outset')

            });

            $('#link4').click(function() {
                $('#tt4').slideToggle('fast');
                $('#link4').css('border-style', 'inset')
                $('#tt2').slideUp();
                $('#link2').css('border-style', 'outset')
                $('#tt3').slideUp();
                $('#link3').css('border-style', 'outset')
                $('#tt1').slideUp();
                $('#link1').css('border-style', 'outset')

            });
      
            
//            $('#link2').click(function() {
//                $('#tt2').slideToggle('fast');
//                $('#tt1').slideUp();
//                $('#tt3').slideUp();
//                $('#tt4').slideUp();
//                
//            });
//            $('#link3').click(function() {
//                $('#tt3').slideToggle('fast');
//                $('#tt1').slideUp();
//                $('#tt2').slideUp();
//                $('#tt4').slideUp();
//            });
//            $('#link4').click(function() {
//                $('#tt4').slideToggle('fast');
//                $('#tt1').slideUp();
//                $('#tt2').slideUp();
//                $('#tt3').slideUp();
//            });
        }
    );

</script>



     <a  id="link1"                              
        style="padding: 7px; border-style: outset; color: #FFFFFF; text-decoration: underline; font-size: medium; font-weight: bolder;  
        cursor: pointer; background-color: #49A9F5;">Credits</a>

     <a id="link2"                 
        style="padding: 7px; border-style: outset; color: #FFFFFF; text-decoration: underline; font-size: medium; font-weight: bolder;  
        cursor: pointer; background-color: #49A9F5;">Gifts</a> 
     <a id="link3"         
        style="padding: 7px; border-style: outset; color: #FFFFFF; text-decoration: underline; font-size: medium; font-weight: bolder;  
        cursor: pointer; background-color: #49A9F5;">Photos</a> 
     <a id="link4" 
        style="padding: 7px; border-style: outset; color: #FFFFFF; text-decoration: underline; font-size: medium; font-weight: bolder;  
        cursor: pointer; background-color: #49A9F5;">e-Cards</a>

<fieldset>

<legend>Welcome</legend>
<h2> <%= Model.FirstName + " " + Model.LastName %></h2> 

<li>
      <% 
              StringBuilder to_scrap = new StringBuilder();
              to_scrap.Append("<a href=\"/User/ScrapBook?to_id="+Model.UserID+"\">Scrap Book</a>");
            %>
     <%= to_scrap.ToString() %>
 
</li> 
</fieldset>

    <% if (Session["Current"] != null)
   { %>
   
    <% //get pending requests. And if there are any, then show this fieldset for pending requests %>
    <% prototype3.Models.UserRepository userrep = new prototype3.Models.UserRepository();
       IQueryable<prototype3.Models.Connection> _requests =  userrep.GetPendingRequests((prototype3.Models.User)Session["Current"]);
       if(_requests.Count()>0) 
       {           
        %>
    <fieldset>
        <legend style="background-color: #9B004E; background: #EC608E url('../../bg-legend-pendingreq.png') repeat-x center">Pending Requests</legend>
        <% foreach (prototype3.Models.Connection item in _requests)
           {
        %>
            <p> <%= (userrep.GetUser((int)item.UserID)).FirstName + " " + (userrep.GetUser((int)item.UserID)).LastName%> <%= Html.ActionLink("Accept", "AcceptAsFriend", new {id=(int)item.UserID }) %></p> 
        <%
           }
                %>
    </fieldset>
    
    <% } %>
    

    <div id="tt1"> <fieldset>
        <legend>Credits</legend>
        <p>
        <form action="https://www.sandbox.paypal.com/cgi-bin/webscr" method="post">
<input type="hidden" name="cmd" value="_s-xclick">
<input type="hidden" name="hosted_button_id" value="1067854">
<input type="image" src="https://www.sandbox.paypal.com/en_US/i/btn/btn_buynowCC_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
<img alt="" src="https://www.sandbox.paypal.com/en_US/i/scr/pixel.gif" width="1" height="1">
 Buy More Credits

</form>
  
        </p>
        
        
        
        <p style="text-align:center;">
        No of Credits Remaining = <%= Model.Credits  %>
        <img src ="../../Resources/Images/iGiftsCredits.jpg" />
        
        </p>
        
        
    </fieldset>
    </div>
    <div id="tt2">
    <fieldset>
        <legend>Gifts</legend>
    <img src="../../Content/images/Christmas-gifts-1383.jpg" />
     <li><%= Html.ActionLink("Gift Transactions","GiftTransactionGrid","Shopping") %></li>     

    <li><%= Html.ActionLink("Credit Transactions","CreditTransactionGrid","Shopping") %></li>
    
    </fieldset>
    </div>
    
    <div id="tt3">
    <fieldset>
        <legend>Photos</legend>
    <li> 
     <%StringBuilder str_image = new StringBuilder();

       str_image.Append(" <a href=\"../../upload.aspx?id="+Model.UserID+"\">Upload Photo</a>");
            %>
            
            <%= str_image.ToString() %>
     </li>
     
     Upload Albums and Videos Coming Soon....
     </fieldset>
     
     </div>
    
    
    <div id="tt4">
    <fieldset>
        <legend>e-Cards</legend>
    
    Coming Soon...
    
    </fieldset>
    
    </div>
</div>
    
    

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
            $('.slidewlist').slideToggle();
            return false;
        }

        function SlideEventList() {
            //            var gridItem = $(ctr);
            //            var className = gridItem.attr('class');
            //            if (gridItem.hasClass('slidewlist')) {
            //                //grid

            //                gridItem.toggleClass('slidewlist_t');
            //            }
            $('.slideElist').slideToggle();
            return false;
        }
        //=====================Add Event item===========================================================
        function ModalAddEventAlert() {
            ModalPopups.Custom("idCustom1",
        "Enter New Item in Wishlist",
        "<div style='padding: 25px;'>" +
        "<table>" +
        "<tr><td>Enter Event Name: </td><td><input type=text id='inputCustom1EventName' style='width:250px;'></td></tr>" +
        "<tr><td>Enter Event Date: </td><td><input type=text id='inputCustom1EventDate' style='width:250px;'></td></tr>" +
        "</table>" +
        "</div>",
        {
            width: 500,
            buttons: "ok,cancel",
            okButtonText: "Save",
            cancelButtonText: "Cancel",
            onOk: "ModalPopupsCustom1SaveEvent()",
            onCancel: "ModalPopupsCustom1CancelEvent()"
        }
        );

            ModalPopups.GetCustomControl("inputCustom1EventName").focus();
        }
        function ModalPopupsCustom1SaveEvent() {
            var custom1EventName = ModalPopups.GetCustomControl("inputCustom1EventName");
            var custom1EventDate = ModalPopups.GetCustomControl("inputCustom1EventDate");
            if (custom1EventName.value == "") {
                alert(operation);
                alert("Please submit a name to this form");
                custom1EventName.focus();
            }
            else {
                alert("You entered: " + custom1EventName.value);
                ModalPopups.Close("idCustom1");
                window.location = "/user/AddEventItem?EventName=" + custom1EventName.value + "&EventDate=" + custom1EventDate.value;
            }
        }

        function ModalPopupsCustom1CancelEvent() {
            alert('You pressed Cancel');
            ModalPopups.Cancel("idCustom1");
        }

        //=====================Add wishlist item===========================================================
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
    IQueryable<prototype3.Models.Event> _eventslist;
    if (ViewData["ProfileID"] == null)      //if profileID viewdata not set then 
        profileID = (int)(_user.UserID);    //take current session userid
    else
        profileID = int.Parse(ViewData["ProfileID"].ToString());  //else get the profileid of passed user

    _wishlist = _urep.GetWishlist(profileID);  //get the wishlist of the profile visited        
    _eventslist = _urep.GetEvents(profileID);  //get the wishlist of the profile visited        
       
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
                       <li> <% StringBuilder str_img = new StringBuilder();
     //                       str_img.Append(" <img src=\"http://127.0.0.1:10000/devstoreaccount1/igifts/image_"+Model.UserID+"\" />");
                            str_img.Append(" <img src=\"https://davidtododb.blob.core.windows.net/igifts/image_" + Model.UserID + "\" />");              

                           %>
   
                             <%= str_img.ToString() %> </li>
                       
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
                    
                    <li onclick = "SlideWishList()" style = "color:Red; cursor: pointer;">
                     Click Here to Edit/Delete your Wish List Items
                   
                    
                    </li>
                       <% foreach (var item in _wishlist)
                          { %>
                            <li>
                            <%= Html.Encode(item.Preference + " " + item.WishItem)%> 
                            <div style=" text-align:right" class = "slidewlist" >                                                        
                            <a style=" display:inline;" href="javascript:ModalWishlistAlert();">Edit</a> | 
                            <a style=" display:inline;" href="javascript:ModalWishlistAlert();">Delete</a>                                       
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
                    <ul>
                    
                    <li onclick = "SlideEventList()" style = "color:Red; cursor: pointer;">
                     Click Here to Edit/Delete your Special Event/Occasions                                       
                    </li>
                       <% foreach (var item in _eventslist)
                          { %>
                            <li>
                            <%= Html.Encode(item.EventName + " " + item.EventDate.Value.Date.ToShortDateString())%> 
                            <div style=" text-align:right;" class = "slideElist" >                            
                            <a style=" display:inline;" href="javascript:ModalAddEventAlert();">Edit</a> | 
                            <a style=" display:inline;" href="javascript:ModalAddEventAlert();">Delete</a>
                            </div>                            
                    </li>
                   <% } %>
                       <li><p style=" text-align:right;"><a href="javascript:ModalAddEventAlert();">Add Event</a> </p></li>
                    </ul>
                </div>
                <div class="side-bucket-bottom"></div>
            </div>

<% } %>            
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContentRight" runat="server">
    <%  //declarations and initialisations
    prototype3.Models.UserRepository _urep = new prototype3.Models.UserRepository();
    prototype3.Models.User _user = (prototype3.Models.User)Session["Current"]; //get current session user
    int profileID;
    IQueryable<prototype3.Models.Event> _upcomingeventslist;
    if (ViewData["ProfileID"] == null)      //if profileID viewdata not set then 
        profileID = (int)(_user.UserID);    //take current session userid
    else
        profileID = int.Parse(ViewData["ProfileID"].ToString());  //else get the profileid of passed user

    _upcomingeventslist = _urep.GetUpcomingEvents(profileID);  //get the wishlist of the profile visited        
    %>    
    <% if (Session["Current"] != null)
   { %>
        <% prototype3.Models.UserRepository _userrep = new prototype3.Models.UserRepository();
              prototype3.Models.User curr = (prototype3.Models.User)Session["Current"];
              var _friends = _urep.GetFriends((int)curr.UserID);
              var _olfriends = _urep.GetOnlineFriends((int)curr.UserID);                      
        %> 

    <div class="side-bucket">
     <div class="side-bucket-top"></div>
     <div class="side-bucket-content">
        <div class="side-bucket-heading-top"></div>
        <div class="side-bucket-heading-content">
           <h2>Online Friends</h2>
        </div>
     <div class="side-bucket-heading-bottom"></div>
        
        <ul>
            <% foreach (var item in _olfriends)
               {
                      %>
                      <li> <%= Html.ActionLink(item.FirstName + " " + item.LastName,"FriendsPage", new {id=item.UserID}) %> </li>
            <% } %>
     </ul>
     
     </div>
     <div class="side-bucket-bottom"></div>

     <div class="side-bucket-top"></div>
     <div class="side-bucket-content">
        <div class="side-bucket-heading-top"></div>
        <div class="side-bucket-heading-content">
           <h2>Friend's List</h2>
        </div>
     <div class="side-bucket-heading-bottom"></div>

        <ul>
            <% foreach (var item in _friends)
               {
                      %>                                
                 
                 <% StringBuilder str_img = new StringBuilder();

                            //str_img.Append(" <img style=\"height:30px; width:40px;\"  src=\"http://127.0.0.1:10000/devstoreaccount1/igifts/image_"+item.UserID+"\" />");
                            str_img.Append(" <img src=\"https://davidtododb.blob.core.windows.net/igifts/image_" + item.UserID + "\" />");              
      
                           %>
   
<li>
                             <%= str_img.ToString() %> &nbsp
                             
                              <%= Html.ActionLink(item.FirstName + " " + item.LastName, "FriendsPage", new { id = item.UserID })%> 
</li>                   
                
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
     <% StringBuilder to_link = new StringBuilder();
        to_link.Append("<a href=\"/Shopping/Index?to_id="  + curr.UserID + "\" >Shopping Cart</a>");
            %>
     <%= to_link.ToString() %>
     </li>        
    </ul>
     </div>        
     <div class="side-bucket-bottom"></div>   
     
<div class="side-bucket">
                <div class="side-bucket-top"></div>
                <div class="side-bucket-content">
                    <div class="side-bucket-heading-top"></div>
                    <div class="side-bucket-heading-content">
                        <h3>Upcoming Events</h3>
                    </div>
                    <div class="side-bucket-heading-bottom"></div>
                    <ul>                    
                       <% foreach (var item in _upcomingeventslist)
                          { %>
                            <li>
                            <b><%= Html.Encode(item.User.FirstName + ": ")%></b>
                            <%= Html.Encode(item.EventName + " " + item.EventDate.Value.Date.ToShortDateString())%> 
                            </li>
                       <% } %>
                    </ul>
                </div>
                <div class="side-bucket-bottom"></div>
            </div>    
    
</div>

<% } %>        
</asp:Content>

