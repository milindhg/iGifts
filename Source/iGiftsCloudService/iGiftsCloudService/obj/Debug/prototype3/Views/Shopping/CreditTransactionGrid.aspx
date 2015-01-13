<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/User.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<prototype3.Models.Transaction>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	CreditTransactionGrid
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentMiddle" runat="server">

    <h2>CreditTransactionGrid</h2>
    <p>&nbsp;</p>
    <%= Html.ActionLink("Credits Received","CreditsReceived") %> | 
    <%= Html.ActionLink("Credits Sent","CreditsSent") %> | 
    <%= Html.ActionLink("All Credit Transactions","CreditTransactionGrid") %>
    <table border="1">
        <tr>
            <th>
                <p>
                TID
                </p>
            </th>
            <th>
                <p>
                From
                </p>
            </th>            
            <th>
                <p>
                To
                </p>
            </th>
            <th>
                <p>
                AmountTransfered
                </p>
            </th>
            <th>
                <p>
                Timestamp
                </p>
            </th>
        </tr>

    <% foreach (var item in Model) { %>
    
        <tr>
            <td>
                <p style="text-align: center">
                <%= Html.Encode(item.TID) %>
                </p>
            </td>
            <td>
                <p style="text-align: center">
                <%= Html.Encode(item.Connection.user.FirstName) %>
                </p>
            </td>            
            <td>
                <p style="text-align: center">
                <%= Html.Encode(item.Connection.User1.FirstName) %>
                </p>
            </td>
            <td>
                <p style="text-align: center">
                <%= Html.Encode(String.Format("{0:F}", item.AmountTransfered)) %>
                </p>
            </td>
            <td>
                <p style="text-align: center">
                <%= Html.Encode(String.Format("{0:g}", item.Timestamp)) %>
                </p>
            </td>
        </tr>
    
    <% } %>

    </table>


</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContentLeft" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContentRight" runat="server">
</asp:Content>

