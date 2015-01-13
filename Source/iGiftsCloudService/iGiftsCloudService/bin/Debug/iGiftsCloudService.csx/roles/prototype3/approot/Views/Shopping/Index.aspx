﻿<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Shopping.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<prototype3.Models.ShoppingItem>>" %>
<asp:Content ID="indexContent" ContentPlaceHolderID="MainContent" runat="server">

    <script type="text/javascript">
        $(document).ready(function(){
                 LoadBanner('banners');
            });
        function enlarge(ctr)
        {
            var gridItem = $(ctr);
//            var gridItem = $('.' + ctr);
            var className = gridItem.attr('class');
            
            
            if(gridItem.hasClass('gridItem'))
            {
                //grid
                
                gridItem.toggleClass('gridItem_on');
            }
            else
            {
                //list
                gridItem.toggleClass('gridItem_v_on');
            }
        }
        function displaySwitch(type)
        {
            var grid = $(".topic .grid");
            var list = $(".topic .list");
            if(type == 'grid')
            {
                if(grid.hasClass('grid_on'))
                    grid.removeClass('grid_on');
                else
                    grid.addClass('grid_on');
            }
            else
            {
                if(list.hasClass('list_on'))
                    list.removeClass('list_on');
                else
                    list.addClass('list_on');   
            }
        }
        function changeDisplay(ctr, id)
        {
            var source = $('#' + ctr.id);
            if(source.hasClass('listview'))
            {
                $('#' + id + ' .gridItem').removeClass('gridItem').addClass('gridItem_v');
            }
            else
            {
                $('#' + id + ' .gridItem_v').removeClass('gridItem_v').addClass('gridItem');
            }
        }
        function LoadBanner(ctr)
        {
            $('#' + ctr + ' .banner:gt(0) ').css("display","none");
            $('#' + ctr + ' ul li a').mouseover(function(){
                var index = $('#' + ctr + ' ul li a').index(this);
                $('#' + ctr + ' .banner').css("display","none");
                $('#' + ctr + ' .banner:eq(' + index+ ') ').fadeIn('slow');
            });
        }
    </script>
        <div id="gridTopic" class="topic">
            <h2>iGift Products</h2>
            <div class="display">
                <div id="gridTopic_grid" class="gridview" onmouseover="displaySwitch('grid')" onmouseout="displaySwitch('grid')" onclick="changeDisplay(this, 'grid')"></div>
                <div id="gridTopic_list" class="listview" onmouseover="displaySwitch('list')" onmouseout="displaySwitch('list')" onclick="changeDisplay(this, 'grid')"></div>
            </div>
        </div>
             

        <div id="grid" class="grid">

        <% prototype3.Models.ShoppingItemRepository shoprep = new prototype3.Models.ShoppingItemRepository();
           var itemsretrived = Model;
           foreach (var item in itemsretrived)
           {

               StringBuilder sb = new StringBuilder();
               //sb.Append("<img src=\"../../Content/Shopping/images/items/" + item.Image + ".jpg\" />");

               sb.Append("<img src=\"../../Resources/images/" + item.Image + ".jpg\" />");

               
             %>
            <div id="id" class="gridItem" onmouseover="enlarge(this);" onmouseout="enlarge(this);">
                <div class="frame">
                    <%= sb.ToString() %>
                </div>                
                <div class="content">
                    <div class="price"><%= item.ItemPrice %></div>
                    <div class="addtocart"><a href="#"> &nbsp;</a></div>
                    <div class="name"><%= Html.ActionLink(item.ItemName, "BuyItem" , new {ItemID=item.ItemID}) %>  </div>
                    <div class="desc"><%= item.ItemInfo %></div>
                </div>
            </div>
            <% } %>

        </div>
        
</asp:Content>
