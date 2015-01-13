<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/User.Master" Inherits="System.Web.Mvc.ViewPage<prototype3.Models.User>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Search
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentMiddle" runat="server">
<script type="text/javascript">
</script>
    <%  prototype3.Models.UserRepository userrep = new prototype3.Models.UserRepository();
        //retrieve list of all the users on search
        var _userlist = userrep.GetSearchResult(ViewData["msg"].ToString());%>        
    <%= Html.Encode(ViewData["msg"]) %>
<%--    <%= Html.TextBox("javatext",ViewData["msg"]) %>    
    <input type="submit" id="sub" />
--%>    
    <fieldset>
        <legend>Search Result</legend>
        <ul>
          <%
              foreach (var item in _userlist)
              {                                        
          %>
          <li><%= Html.ActionLink(item.FirstName + " " + item.LastName, "FriendsPage", new {id=item.UserID})%></li>
          <%  } %>
        </ul>
    </fieldset>
<%--<script type="text/javascript">
    document.write("Hello");
    window.onload = clik;
//    var ans = prompt("Are you tag?", "");
//    if (ans) { alert("You answered " + ans); }
//    else { alert("You refused to answer"); }

    function clik() {
        document.getElementById("sub").onclick = subclick;

        function subclick() {
            alert(javatext.value);
            window.location = "/User/Index";
            return false;
        }
    }
</script>
--%>



</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContentLeft" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContentRight" runat="server">
</asp:Content>
