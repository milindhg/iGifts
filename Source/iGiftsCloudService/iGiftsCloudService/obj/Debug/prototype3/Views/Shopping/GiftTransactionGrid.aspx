<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/User.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<prototype3.Models.ShoppingTransaction>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	GiftTransactionGrid
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentMiddle" runat="server">

    <h2>GiftTransactionGrid</h2>
    <p>&nbsp;</p>
    <%= Html.ActionLink("Gifts Received","GiftsReceived") %> | 
    <%= Html.ActionLink("Gifts Sent","GiftsSent") %> | 
    <%= Html.ActionLink("Items Shopped","GiftTransactionGrid") %>
    <table border="1">
        <tr>
            <th>
                ShoppingID
            </th>
            <th>
                From
            </th>
            <th>
                To
            </th>
            <th>
                Item
            </th>
            <th>
                ItemCredits
            </th>
            <th>
                Timestamp
            </th>
            <th>
                ShippingAddress
            </th>
        </tr>

    <% foreach (var item in Model) { %>
    
        <tr>
            <td>
                <%= Html.Encode(item.ShoppingID) %>
            </td>
            <td>
                <%= Html.Encode(item.User.FirstName) %>
            </td>
            <td>
                <%= Html.Encode(item.User1.FirstName) %>
            </td>
            <td>
                <%= Html.Encode(item.ShoppingItem.ItemName) %>
            </td>
            <td>
                <%= Html.Encode(String.Format("{0:F}", item.ItemCredits)) %>
            </td>
            <td>
                <%= Html.Encode(String.Format("{0:g}", item.Timestamp)) %>
            </td>
            <td>
                <%= Html.Encode(item.ShippingAddress) %>
            </td>
        </tr>
    
    <% } %>

    </table>


</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContentLeft" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContentRight" runat="server">
</asp:Content>

