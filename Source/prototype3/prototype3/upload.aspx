<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="upload.aspx.cs" Inherits="MvcApplication1.upload" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Upload Photo</title>
    <style type="text/css">
        body { font-family: Verdana; font-size: 12px; }
        h1 { font-size:x-large; font-weight:bold; }
        h2 { font-size:large; font-weight:bold; }
        img { width:200px; height:175px; margin:2em;}
        li { list-style: none; }
        ul { padding:1em; }
        
        .form { width:50em; }
        .form li span {width:30%; float:left; font-weight:bold; }
        .form li input { width:70%; float:left; }
        .form input { float:right; }
        
        .item { font-size:smaller; font-weight:bold; }
        .item ul li { padding:0.25em; background-color:#ffeecc; }
        .item ul li span { padding:0.25em; background-color:#ffffff; display:block; font-style:italic; font-weight:normal; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h1>Upload your Profile Photo here [iGifts]</h1>
        <a href="/"> 
                    Home
         </a>           
        <div class="form">
            <ul>
                <li><span></span><asp:HiddenField ID="imageName" runat="server"/></li>
                <li><span></span><asp:HiddenField ID="imageDescription" runat="server" /></li>
                
                <li><span></span><asp:HiddenField ID="imageTags" runat="server"/></li>
                <li><span>Filename</span><asp:FileUpload ID="imageFile" runat="server" /></li>
            </ul>
            <asp:Button ID="upload1" runat="server" onclick="upload1_Click" Text="Upload Image" />
        </div>
        <div>
        Status: <asp:Label ID="status" runat="server" />
        </div>
        <asp:ListView ID="images" runat="server" onitemdatabound="OnBlobDataBound">
            <LayoutTemplate>
                <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
            </LayoutTemplate>
            <EmptyDataTemplate>
                <h2>No Photo Uploaded</h2>
            </EmptyDataTemplate>            
            <ItemTemplate>            
                <div class="item">
                    <ul style="width:40em;float:left;clear:left" >
                    <asp:Repeater ID="blobMetadata" runat="server">
                    <ItemTemplate>
                        <li><%# Eval("Name") %><span><%# Eval("Value") %></span></li>
                    </ItemTemplate>
                    </asp:Repeater>
                    <%-- UNCOMMENT THE FOLLOWING LINES FOR DELETE FUNCTIONALITY --%>
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
        </asp:ListView>
    </div>
    
    <div>
     
    </div>
    </form>
    
    
</body>
</html>
