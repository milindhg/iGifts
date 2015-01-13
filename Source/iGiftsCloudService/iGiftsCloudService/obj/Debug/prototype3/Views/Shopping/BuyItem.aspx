<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Shopping.Master" Inherits="System.Web.Mvc.ViewPage<prototype3.Models.ShoppingItem>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <h2>BuyItem</h2>

    <fieldset>
        <legend>Buy Item</legend>
        <p>
            ItemID:
            <%= Html.Encode(Model.ItemID) %>
        </p>
        
        <p>
            ItemName:
            <%= Html.Encode(Model.ItemName) %>
        </p>
        <p>
            ItemPrice:
            <%= Html.Encode(String.Format("{0:F}", Model.ItemPrice)) %>
        </p>
        <p>
            ItemInfo:
            <%= Html.Encode(Model.ItemInfo) %>
        </p>
        <p>
            Image:
            <%= Html.Encode(Model.Image) %>
            
            <% StringBuilder sb = new StringBuilder();  
                sb.Append("<img src=\"../../Resources/images/" + Model.Image + ".jpg\" />");

                %>
            <%= sb.ToString() %>
            
        </p>
        
        
    </fieldset>
     <% using (Html.BeginForm())
       { %>
            <%= Html.Hidden("from_id", ((prototype3.Models.User)Session["Current"]).UserID.ToString())%>
            <%= Html.Hidden("to_id", ((prototype3.Models.User)Session["Current"]).UserID.ToString())%>
            <%= Html.Hidden("item_id", Model.ItemID) %>
            <%= Html.Hidden("item_credits", Model.ItemPrice) %>
            <%= Html.TextArea("shipping_address")%>                     
               
            
            <input id="Buy" type="submit" value="Buy"  />
    <% } %>

        
    
   <%-- <p>

        <%=Html.ActionLink("Edit", "Edit", new { id=Model.ItemID }) %> |
        <%=Html.ActionLink("Back to List", "Index") %>
    </p>
--%>
</asp:Content>

