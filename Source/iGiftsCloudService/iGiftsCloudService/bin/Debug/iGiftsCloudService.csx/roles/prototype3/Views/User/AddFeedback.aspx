<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/User.Master" Inherits="System.Web.Mvc.ViewPage<prototype3.Models.Feedback>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	AddFeedback
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentMiddle" runat="server">

    <h2>AddFeedback</h2>

    <%= Html.ValidationSummary("Create was unsuccessful. Please correct the errors and try again.") %>

    <% using (Html.BeginForm()) {%>

        <fieldset>
            <legend>Fields</legend>
            <p>
                <%--<label for="FeedbackID">FeedbackID:</label>--%>
                <%= Html.Hidden("FeedbackID") %>
                <%= Html.ValidationMessage("FeedbackID", "*") %>
            </p>
            <p>
                <label for="FeedbackText">FeedbackText:</label>
                <%= Html.TextArea("FeedbackText") %>
                <%= Html.ValidationMessage("FeedbackText", "*") %>
            </p>
            <p>
                <label for="FeedbackEmail">FeedbackEmail:</label>
                <%= Html.TextBox("FeedbackEmail") %>
                <%= Html.ValidationMessage("FeedbackEmail", "*") %>
            </p>
            <p>
                <label for="FeedbackName">FeedbackName:</label>
                <%= Html.TextBox("FeedbackName") %>
                <%= Html.ValidationMessage("FeedbackName", "*") %>
            </p>
            <p>
                <input type="submit" value="Add Feedback" />
            </p>
        </fieldset>

    <% } %>

    

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContentLeft" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContentRight" runat="server">
</asp:Content>

