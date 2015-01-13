<%@ Page Title="" Language="C#" Debug="true" MasterPageFile="~/Views/Shared/User.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<prototype3.Models.User>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Index
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentMiddle" runat="server">
   <div class="side-bucket">
      <div class="side-bucket-top"></div>
        <div class="side-bucket-content">
           <div class="side-bucket-heading-top"></div>
           <div class="side-bucket-heading-content">
                <h2>Index</h2>
           </div>
           <div class="side-bucket-heading-bottom"></div>
           <%        
            if (Session["Current"] != null)
            {
           %>
            <table>
                <tr>
                    <th></th>
                    <th>
                        UserID
                    </th>
                    <th>
                        Username
                    </th>
                    <th>
                        Password
                    </th>
                    <th>
                        FirstName
                    </th>
                    <th>
                        MiddleName
                    </th>
                    <th>
                        LastName
                    </th>
                    <th>
                        EmailID
                    </th>
                    <th>
                        DOB
                    </th>
                    <th>
                        Sex
                    </th>
                    <th>
                        Credits
                    </th>
                    <th>
                        Address
                    </th>
                    <th>
                        City
                    </th>
                    <th>
                        State
                    </th>
                    <th>
                        Country
                    </th>
                    <th>
                        Zipcode
                    </th>
                    <th>
                        ContactNo
                    </th>
                </tr>
        
    
            <%           
             foreach (var item in Model)
                { %>
    
                <tr>
                    <td>
                        <%= Html.ActionLink("Edit", "Edit", new { id = item.UserID })%> |
                        <%= Html.ActionLink("Details", "Details", new { id = item.UserID })%>
                    </td>
                    <td>
                        <%= Html.Encode(item.UserID)%>
                    </td>
                    <td>
                        <%= Html.Encode(item.Username)%>
                    </td>
                    <td>
                        <%= Html.Encode(item.Password)%>
                    </td>
                    <td>
                        <%= Html.Encode(item.FirstName)%>
                    </td>
                    <td>
                        <%= Html.Encode(item.MiddleName)%>
                    </td>
                    <td>
                        <%= Html.Encode(item.LastName)%>
                    </td>
                    <td>
                        <%= Html.Encode(item.EmailID)%>
                    </td>
                    <td>
                        <%= Html.Encode(String.Format("{0:g}", item.DOB))%>
                    </td>
                    <td>
                        <%= Html.Encode(item.Sex)%>
                    </td>
                    <td>
                        <%= Html.Encode(String.Format("{0:F}", item.Credits))%>
                    </td>
                    <td>
                        <%= Html.Encode(item.Address)%>
                    </td>
                    <td>
                        <%= Html.Encode(item.City)%>
                    </td>
                    <td>
                        <%= Html.Encode(item.State)%>
                    </td>
                    <td>
                        <%= Html.Encode(item.Country)%>
                    </td>
                    <td>
                        <%= Html.Encode(item.Zipcode)%>
                    </td>
                    <td>
                        <%= Html.Encode(item.ContactNo)%>
                    </td>
                </tr>
    
            <% }
            } %>

        </table>

        <p>
            <%= Html.ActionLink("Create New", "Create") %>
        </p>

      </div>
      <div class="side-bucket-bottom"></div>
   </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContentLeft" runat="server">
<h2>Profile</h2>
<h2>Wishlist</h2>
<h2>Updates and Upcoming events</h2>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContentRight" runat="server">
</asp:Content>