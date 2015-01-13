<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/User.Master" Inherits="System.Web.Mvc.ViewPage<prototype3.Models.User>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Edit
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentMiddle" runat="server">

    <h2>Edit</h2>

    <%= Html.ValidationSummary("Edit was unsuccessful. Please correct the errors and try again.") %>

    <% using (Html.BeginForm()) {%>

        <fieldset>
            <legend>Fields</legend>
            <p>
                <label for="UserID">UserID:</label>
                <%= Html.TextBox("UserID", Model.UserID) %>
                <%= Html.ValidationMessage("UserID", "*") %>
            </p>
            <p>
                <label for="Username">Username:</label>
                <%= Html.TextBox("Username", Model.Username) %>
                <%= Html.ValidationMessage("Username", "*") %>
            </p>
            <p>
                <label for="Password">Password:</label>
                <%= Html.TextBox("Password", Model.Password) %>
                <%= Html.ValidationMessage("Password", "*") %>
            </p>
            <p>
                <label for="FirstName">FirstName:</label>
                <%= Html.TextBox("FirstName", Model.FirstName) %>
                <%= Html.ValidationMessage("FirstName", "*") %>
            </p>
            <p>
                <label for="MiddleName">MiddleName:</label>
                <%= Html.TextBox("MiddleName", Model.MiddleName) %>
                <%= Html.ValidationMessage("MiddleName", "*") %>
            </p>
            <p>
                <label for="LastName">LastName:</label>
                <%= Html.TextBox("LastName", Model.LastName) %>
                <%= Html.ValidationMessage("LastName", "*") %>
            </p>
            <p>
                <label for="EmailID">EmailID:</label>
                <%= Html.TextBox("EmailID", Model.EmailID) %>
                <%= Html.ValidationMessage("EmailID", "*") %>
            </p>
            <p>
                <label for="DOB">DOB:</label>
                <%= Html.TextBox("DOB", String.Format("{0:g}", Model.DOB)) %>
                <%= Html.ValidationMessage("DOB", "*") %>
            </p>
            <p>
                <label for="Sex">Sex:</label>
                <%= Html.TextBox("Sex", Model.Sex) %>
                <%= Html.ValidationMessage("Sex", "*") %>
            </p>
            <p>
                <label for="Credits">Credits:</label>
                <%= Html.TextBox("Credits", String.Format("{0:F}", Model.Credits)) %>
                <%= Html.ValidationMessage("Credits", "*") %>
            </p>
            <p>
                <label for="Address">Address:</label>
                <%= Html.TextBox("Address", Model.Address) %>
                <%= Html.ValidationMessage("Address", "*") %>
            </p>
            <p>
                <label for="City">City:</label>
                <%= Html.TextBox("City", Model.City) %>
                <%= Html.ValidationMessage("City", "*") %>
            </p>
            <p>
                <label for="State">State:</label>
                <%= Html.TextBox("State", Model.State) %>
                <%= Html.ValidationMessage("State", "*") %>
            </p>
            <p>
                <label for="Country">Country:</label>
                <%= Html.TextBox("Country", Model.Country) %>
                <%= Html.ValidationMessage("Country", "*") %>
            </p>
            <p>
                <label for="Zipcode">Zipcode:</label>
                <%= Html.TextBox("Zipcode", Model.Zipcode) %>
                <%= Html.ValidationMessage("Zipcode", "*") %>
            </p>
            <p>
                <label for="ContactNo">ContactNo:</label>
                <%= Html.TextBox("ContactNo", Model.ContactNo) %>
                <%= Html.ValidationMessage("ContactNo", "*") %>
            </p>
            <p>
                <input type="submit" value="Save" />
            </p>
        </fieldset>

    <% } %>

    <div>
        <%=Html.ActionLink("Back to Profile", "Login","User") %>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContentLeft" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContentRight" runat="server">
</asp:Content>

