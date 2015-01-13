<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/User.Master" Inherits="System.Web.Mvc.ViewPage<prototype3.Models.User>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Login
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentMiddle" runat="server">

    <h2>Login</h2>
    <%= Html.ValidationSummary("Create was unsuccessful. Please correct the errors and try again.") %>

    <% using (Html.BeginForm()) {%>

        <fieldset>
            <legend>Fields</legend>
            <p>
<%--                <label for="UserID">UserID:</label>--%>
                <%= Html.Hidden("UserID") %>
                <%= Html.ValidationMessage("UserID", "*") %>
            </p>
            <p>
                <label for="Username">Username:</label>
                <%= Html.TextBox("Username") %>
                <%= Html.ValidationMessage("Username", "*") %>
            </p>
            <p>
                <label for="Password">Password:</label>
                <%= Html.TextBox("Password") %>
                <%= Html.ValidationMessage("Password", "*") %>
            </p>
            <p>
<%--                <label for="FirstName">FirstName:</label>--%>
                <%= Html.Hidden("FirstName") %>
                <%= Html.ValidationMessage("FirstName", "*") %>
            </p>
            <p>
<%--                <label for="MiddleName">MiddleName:</label>--%>
                <%= Html.Hidden("MiddleName") %>
                <%= Html.ValidationMessage("MiddleName", "*") %>
            </p>
            <p>
<%--                <label for="LastName">LastName:</label>--%>
                <%= Html.Hidden("LastName") %>
                <%= Html.ValidationMessage("LastName", "*") %>
            </p>
            <p>
                <input type="submit" value="Login" />
            </p>
            
         
    </a>    
    
        </fieldset>

    <% } %>

   
</asp:Content>
