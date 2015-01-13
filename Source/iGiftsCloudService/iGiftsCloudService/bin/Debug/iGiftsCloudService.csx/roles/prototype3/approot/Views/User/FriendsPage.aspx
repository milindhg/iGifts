<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/User.Master" Inherits="System.Web.Mvc.ViewPage<prototype3.Models.User>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	 <%= Html.Encode(Model.FirstName) %>'s Page
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentMiddle" runat="server">


<script type="text/javascript">

    var myTextField = document.getElementById('_amount');
    var myUserCredit = document.getElementById('_credits');
    
    function checkcredits() 
    {
        if (myTextField <= myUserCredit) {
            return true;

        }
        else {
            alert("You Dont Have Enough Credits Available");

        }
        return false;
    }
    

</script>






 <%  
     StringBuilder str_img = new StringBuilder();

      str_img.Append(" <img style=\"height:175px; width:200px;\"  src=\"http://127.0.0.1:10000/devstoreaccount1/igifts/image_"+Model.UserID+"\" />");   
       
           %>
   
   <%= str_img.ToString() %>

  <%   
     
     //declarations and initialisations
    prototype3.Models.UserRepository _urep = new prototype3.Models.UserRepository();
    prototype3.Models.User _user = (prototype3.Models.User)Session["Current"]; //get current session user
    int profileID;
    IQueryable<prototype3.Models.Wishlist> _wishlist;
    //if (ViewData["ProfileID"] == null)      //if profileID viewdata not set then 
    //    profileID = (int)(_user.UserID);    //take current session userid
    //else
    //    //profileID = int.Parse(ViewData["ProfileID"].ToString());  //else get the profileid of passed user
        profileID = (int)Model.UserID;  //else get the profileid of passed user
           
        _wishlist = _urep.GetWishlist(profileID);  //get the wishlist of the profile visited        
%>
 <% if (_urep.IsFriend((int)_user.UserID, (int)Model.UserID) == true)
    {
 %>
            
    <h2> <%= Html.Encode(Model.FirstName)%>'s Page</h2>

    <fieldset>
        <legend>Transfer Credits to <%= Html.Encode(Model.FirstName)%></legend>
        <%--<p>
            UserID:
            <%= Html.Encode(Model.UserID) %>
        </p>
        <p>
            Username:
            <%= Html.Encode(Model.Username) %>
        </p>
        <p>
            Password:
            <%= Html.Encode(Model.Password) %>
        </p>
        <p>
            FirstName:
            <%= Html.Encode(Model.FirstName) %>
        </p>
        <p>
            MiddleName:
            <%= Html.Encode(Model.MiddleName) %>
        </p>
        <p>
            LastName:
            <%= Html.Encode(Model.LastName) %>
        </p>
        <p>
            EmailID:
            <%= Html.Encode(Model.EmailID) %>
        </p>
        <p>
            DOB:
            <%= Html.Encode(String.Format("{0:g}", Model.DOB)) %>
        </p>
        <p>
            Sex:
            <%= Html.Encode(Model.Sex) %>
        </p>
        <p>
            Credits:
            <%= Html.Encode(String.Format("{0:F}", Model.Credits)) %>
        </p>
        <p>
            Address:
            <%= Html.Encode(Model.Address) %>
        </p>
        <p>
            City:
            <%= Html.Encode(Model.City) %>
        </p>
        <p>
            State:
            <%= Html.Encode(Model.State) %>
        </p>
        <p>
            Country:
            <%= Html.Encode(Model.Country) %>
        </p>
        <p>
            Zipcode:
            <%= Html.Encode(Model.Zipcode) %>
        </p>
        <p>
            ContactNo:
            <%= Html.Encode(Model.ContactNo) %>
        </p>--%>
         
         
    <% using (Html.BeginForm())
       { %>
            <p><%= Html.Hidden("_id", Model.UserID)%></p>
            <p><%= Html.Hidden("_credits", ((prototype3.Models.User)Session["Current"]).Credits.ToString())%></p>
            <p>Amount: <%= Html.TextBox("_amount")%>
            <img src="../../Resources/Images/iGiftsCredits.jpg" />
            </p>
            
            <input id="transfer" type="submit" value="Transfer" onclick="checkcredits()" />
    <% } %>
   
           
  <%--  <a href="../ScrapBook">
    Scrap
    </a>       --%>     
    </fieldset>
<% } %>
   
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="MainContentLeft" runat="server">
    <%  //declarations and initialisations
    prototype3.Models.UserRepository _urep = new prototype3.Models.UserRepository();
    prototype3.Models.User _user = (prototype3.Models.User)Session["Current"]; //get current session user
    int profileID;
    IQueryable<prototype3.Models.Wishlist> _wishlist;
    IQueryable<prototype3.Models.Event> _eventlist;
    //if (ViewData["ProfileID"] == null)      //if profileID viewdata not set then 
    //    profileID = (int)(_user.UserID);    //take current session userid
    //else
    //    //profileID = int.Parse(ViewData["ProfileID"].ToString());  //else get the profileid of passed user
        profileID = (int)Model.UserID;  //else get the profileid of passed user

        _wishlist = _urep.GetWishlist(profileID);  //get the wishlist of the profile visited        
        _eventlist = _urep.GetEvents(profileID);  //get the wishlist of the profile visited        
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
                            <li>Credits: <%= Model.Credits %></li>
                       </ul>
                </div>
                <div class="side-bucket-bottom"></div>
            </div>
            <% if (_urep.IsFriend((int)_user.UserID, (int)Model.UserID) == true)
               {
            %>
            <div class="side-bucket">
                <div class="side-bucket-top"></div>
                <div class="side-bucket-content">
                    <div class="side-bucket-heading-top"></div>
                    <div class="side-bucket-heading-content">
                        <h2>Wishlist</h2>
                    </div>
                    <div class="side-bucket-heading-bottom"></div>
                    <ul>
                       <% foreach (var item in _wishlist)
                          { %>
                            <li>
                            <%= Html.Encode(item.WishItem)%>
                            </li>
                       <% } %>
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
                       <% foreach (var item in _eventlist)
                          { %>
                            <li>
                            <%= Html.Encode(item.EventName + " " + item.EventDate.Value.Date.ToShortDateString())%>
                            </li>
                       <% } %>
                    </ul>
                </div>
                <div class="side-bucket-bottom"></div>
            </div>
               
            <%
                }
               else
               {
                   prototype3.Models.Connection _isthereconnection = _urep.GetFriendConnection(_user,Model);
            %>
                    
            <%  if (_isthereconnection == null)
                        {
                    %>
                        <h2 style=" "><%= Html.ActionLink("Add As Friend", "AddAsFriend", new { id = profileID })%> </h2>
                    <%  }
                        else
                        { %>
                        <h2>Request Pending</h2>
                    <%  } %>
            <%
               }
            %>

</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContentRight" runat="server">
        <% prototype3.Models.UserRepository _urep = new prototype3.Models.UserRepository();
              prototype3.Models.User curr = (prototype3.Models.User)Session["Current"];
              int profileID;
              if (ViewData["ProfileID"] == null)      //if profileID viewdata not set then 
                  profileID = (int)(curr.UserID);    //take current session userid
              else
                  profileID = int.Parse(ViewData["ProfileID"].ToString());  //else get the profileid of passed user

              //var _friends = _urep.GetFriends((int)Model.UserID);
              var _common = _urep.GetMututalFriends((int)curr.UserID, profileID);               
           %> 
    <div class="side-bucket">

     <div class="side-bucket-top"></div>
     <div class="side-bucket-content">
        <div class="side-bucket-heading-top"></div>
        <div class="side-bucket-heading-content">
           <h2>Mutual Friends</h2>
        </div>
     <div class="side-bucket-heading-bottom"></div>        
        <ul>
            <% foreach (var item in _common)
               {
                      %>
                      <li> <%= Html.ActionLink(item.FirstName + " " + item.LastName,"FriendsPage", new {id=item.UserID}) %> </li>
            <% } %>
            <li><%= Html.ActionLink("Gift this friend", "GiftToFriend", new { FrID=(int)Model.UserID })%></li>
        </ul>
     </div>
     
     <div class="side-bucket-bottom"></div>
     
     <div class="side-bucket-top"></div>
     <div class="side-bucket-content">
        <div class="side-bucket-heading-top"></div>
        <div class="side-bucket-heading-content">
           <h2>Actions</h2>
        </div>
     <div class="side-bucket-heading-bottom"></div>
     <ul>

        <li>
          <% 
              StringBuilder to_link = new StringBuilder();
                to_link.Append("<a href=\"/Shopping/Index?to_id="  + Model.UserID + "\" >Send Gift</a>");
          %>
                <%= to_link.ToString() %>     
        </li>
        
         <li>
      <% 
              StringBuilder to_link1 = new StringBuilder();
              to_link1.Append("<a href=\"../ScrapBook?to_id=" + Model.UserID + "\" >Scrap</a>");
            %>
     <%= to_link1.ToString() %>
    </li>
        
        </ul>     
     </div>     
     <div class="side-bucket-bottom"></div>
          
</div>

</asp:Content>

