<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/User.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Upload Photo
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentMiddle" runat="server">

    <h2>UploadPhoto</h2>
    
    <form id="form1" runat="server">
    <div>
        <h1>Image Gallery (Windows Azure Blob Storage)</h1>
        <div class="form">
            <ul>
                <%--<li><span>Name</span><asp:TextBox ID="imageName" runat="server"/></li>
                <li><span>Description</span><asp:TextBox ID="imageDescription" runat="server"/></li>
                <li><span>Tags</span><asp:TextBox ID="imageTags" runat="server"/></li>--%>
                
                <li><span>Filename</span><asp:FileUpload ID="imageFile" runat="server" /></li>
            </ul>
            <asp:Button ID="upload1" runat="server" onclick="upload1_Click" Text="Upload Image" />
           
            
            <%= Html.ActionLink("UploadPhoto", "UploadPhoto", new { file = imageFile, id = "12" })%>
        </div>
        <div>
        Status: <asp:Label ID="status" runat="server" />
        </div>
        
      <%--  <asp:ListView ID="images" runat="server" onitemdatabound="OnBlobDataBound">
            <LayoutTemplate>
                <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
            </LayoutTemplate>
            <EmptyDataTemplate>
                <h2>No Data Available</h2>
            </EmptyDataTemplate>            
            <ItemTemplate>            
                <div class="item">
                    <ul style="width:40em;float:left;clear:left" >
                    <asp:Repeater ID="blobMetadata" runat="server">
                    <ItemTemplate>
                        <li><%# Eval("Name") %><span><%# Eval("Value") %></span></li>
                    </ItemTemplate>
                    </asp:Repeater>
                    
                        <li>
                        <asp:LinkButton ID="deleteBlob" 
                                OnClientClick="return confirm('Delete image?');"
                                CommandName="Delete" 
                                CommandArgument='<%# Eval("Name")%>'
                                runat="server" Text="Delete" oncommand="OnDeleteImage" />                
                        </li>
                    </ul>                    
                    <img src="<%# Eval("Uri") %>" alt="<%# Eval("Name") %>" style="float:left"/>
                </div>
            </ItemTemplate>
        </asp:ListView>--%>
        
    </div>
    </form>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContentLeft" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContentRight" runat="server">
</asp:Content>
