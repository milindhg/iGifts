<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Shopping.Master" Inherits="System.Web.Mvc.ViewPage<prototype3.Models.ShoppingTransaction>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Buy Credits</h2>

    <fieldset>
        
        
          <% if (ViewData["msg"] != null)
                { 
                 
                  %>              
              
                 
                 <legend>Buy Credits</legend>
              <%
                                                  
                          %>
                          
                          <p>
                            You dont have enough Credits in your account.
                          </p>
                          
                          <%} %>
                          
                          <% else
              {
                 %>
                 <legend>Shopping Transaction Details</legend>
        <p>
            ShoppingID:
            <%= Html.Encode(Model.ShoppingID)%> 
            
                      
        </p>
        <p>
            From:
            <%= Html.Encode(Model.User.FirstName + Model.User.LastName)%>
            
        </p>
        <p>
            To:
            <%= Html.Encode(Model.User1.FirstName + Model.User1.LastName)%>
        </p>
        <p>
            ItemID:
            <%= Html.Encode(Model.ItemID)%>
        </p>
         <p>
            Item Name:
             <%= Html.Encode(Model.ShoppingItem.ItemName)%>
            
        </p>
        <p>
            Credits:
            <%= Html.Encode(Model.ItemCredits)%>
        </p>
        
        <p>
        Item Image:
        
        <%StringBuilder str_img = new StringBuilder();

          str_img.Append("<img src=\"../../Resources/Images/" + Model.ShoppingItem.Image + ".jpg\"  />");
              
               
                  
                 %>
                 
                 <%=  str_img.ToString()%>
        </p>
        <p>
            Date:
            <%= Html.Encode(String.Format("{0:g}", Model.Timestamp))%>
        </p>
        <p>
            ShippingAddress:
            <%= Html.Encode(Model.ShippingAddress)%>
        </p>
        
       <%} %>
    </fieldset>
    <%--<p>

        <%=Html.ActionLink("Edit", "Edit", new { id=Model.ShoppingID }) %> |
        <%=Html.ActionLink("Back to List", "Index") %>
    </p>--%>

</asp:Content>

