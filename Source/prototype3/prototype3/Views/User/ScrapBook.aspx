<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/User.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<prototype3.Models.ScrapBook>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	ScrapBook
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentMiddle" runat="server">

<% int to = int.Parse(Request.QueryString["to_id"]); %>
       <% prototype3.Models.UserRepository userrep = new prototype3.Models.UserRepository(); %>
       <%= userrep.GetUser(to).FirstName + " "  + userrep.GetUser(to).LastName + "'s Scrapbook" %>

      <%using (Html.BeginForm())
    {

        Style st = new Style();
    
        %>
        <p> 
        <%= Html.TextArea("PostScrap")%></p>
       
        <%--<textarea id="PostScrap" style="height: 60px; width: 640px" runat="server">  </textarea>--%>
      
        <p>  <input id="post" type="submit" value="Post Scrap" /> </p>       
                
        <%} %>
    
   
  
    

    <% foreach (var item in Model)
       { %>     
     <fieldset style="width:800px">
               <legend style="text-align: left">
               
                <%--<%= Html.Encode(item.FromID) %>--%>
                <%= Html.Encode(item.User.FirstName)%> &nbsp;
                <%= Html.Encode(item.User.LastName)%> : 
                </legend>       
                
                <%= Html.Encode(item.Scrap)%>
                
                    
              
      </fieldset>
      
      <table style="width:800px" >
      <tr>
      
      <td style="text-align:left"> <%= Html.ActionLink("Delete Scrap", "DeleteScrap", new { scrapid = (int)item.ScapID })%></td>
      <td style="text-align:right"> <%= Html.Encode(String.Format("{0:g}", item.Timestamp))%></td>
         
          
      </tr>
 
      
      </table>
 
    
    <% } %>  


    
    
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContentLeft" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContentRight" runat="server">
</asp:Content>

