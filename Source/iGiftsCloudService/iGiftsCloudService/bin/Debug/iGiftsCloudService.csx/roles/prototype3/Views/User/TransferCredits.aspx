<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/User.Master" Inherits="System.Web.Mvc.ViewPage<prototype3.Models.User>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	TransferCredits
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentMiddle" runat="server">
<%
    //get current session user
    prototype3.Models.User _source = (prototype3.Models.User)Session["Current"];
    
     %>
    <h2>TransferCredits</h2>
                    <fieldset>
                        <legend>Transaction Details</legend>
                      <% if (ViewData["msg"] != null)
                         { 
                                                  
                          %>
                          
                          <p>
                            You Dont Have Enough Credits.
                          </p>
                          
                          <%} %>
                          
                          <% else
                          {

                              prototype3.Models.UserRepository userrep = new prototype3.Models.UserRepository();
                              prototype3.Models.Transaction _currentTrans = userrep.GetLatestTransaction(_source, Model); %>
                            
                       <p>Transaction Id: <%= Html.Encode(_currentTrans.TID)%></p>
                       <p>From: <%= Html.Encode(_source.FirstName + " " + _source.LastName)%></p>
                       <p>To: <%= Html.Encode(Model.FirstName + " " + Model.LastName)%> </p>
                       <p>No. of Credits transfered: <%= _currentTrans.AmountTransfered%></p>
                       <p>Date and Time: <%= _currentTrans.Timestamp%> </p>
                       <% }%>
                    </fieldset>
    
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContentLeft" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContentRight" runat="server">
</asp:Content>
