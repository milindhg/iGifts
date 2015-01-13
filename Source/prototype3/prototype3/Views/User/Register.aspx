<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/User.Master" Inherits="System.Web.Mvc.ViewPage<prototype3.Models.User>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Register
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentMiddle" runat="server">

    <h2>Register</h2>

    <%= Html.ValidationSummary("Create was unsuccessful. Please correct the errors and try again.") %>

    <% using (Html.BeginForm()) {%>

        <fieldset>
            <legend>Add All Fields</legend>
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
                <label for="FirstName">FirstName:</label>
                <%= Html.TextBox("FirstName") %>
                <%= Html.ValidationMessage("FirstName", "*") %>
            </p>
            <p>
                <label for="MiddleName">MiddleName:</label>
                <%= Html.TextBox("MiddleName") %>
                <%= Html.ValidationMessage("MiddleName", "*") %>
            </p>
            <p>
                <label for="LastName">LastName:</label>
                <%= Html.TextBox("LastName") %>
                <%= Html.ValidationMessage("LastName", "*") %>
            </p>
            <p>
                <label for="EmailID">EmailID:</label>
                <%= Html.TextBox("EmailID") %>
                <%= Html.ValidationMessage("EmailID", "*") %>
            </p>
            <p>
                <label for="DOB">DOB (mm-dd-yyyy):</label>
                <%= Html.TextBox("DOB") %>
                <%= Html.ValidationMessage("DOB", "*") %>
            </p>
            <p>
                <label for="Sex">Sex:</label>
                <%= Html.TextBox("Sex") %>
                <%= Html.ValidationMessage("Sex", "*") %>
            </p>
            <p>
<%--                <label for="Credits">Credits:</label>--%>
                <%= Html.Hidden("Credits") %>
                <%= Html.ValidationMessage("Credits", "*") %>
            </p>
            <p>
<%--                <label for="Address">Address:</label>--%>
                <%= Html.Hidden("Address") %>
                <%= Html.ValidationMessage("Address", "*") %>
            </p>
            <p>
<%--                <label for="City">City:</label>--%>
                <%= Html.Hidden("City") %>
                <%= Html.ValidationMessage("City", "*") %>
            </p>
            <p>
<%--                <label for="State">State:</label>--%>
                <%= Html.Hidden("State") %>
                <%= Html.ValidationMessage("State", "*") %>
            </p>
            <p>
<%--                <label for="Country">Country:</label>--%>
                <%= Html.Hidden("Country") %>
                <%= Html.ValidationMessage("Country", "*") %>
            </p>
            <p>
<%--                <label for="Zipcode">Zipcode:</label>--%>
                <%= Html.Hidden("Zipcode") %>
                <%= Html.ValidationMessage("Zipcode", "*") %>
            </p>
            <p>
<%--                <label for="ContactNo">ContactNo:</label>--%>
                <%= Html.Hidden("ContactNo") %>
                <%= Html.ValidationMessage("ContactNo", "*") %>
            </p>
            <p>
                <input type="submit" value="Create" />
            </p>
        </fieldset>

    <% } %>

   

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContentLeft" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContentRight" runat="server">
</asp:Content>

