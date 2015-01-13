using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using prototype3.Models;

namespace prototype3.Models
{
    public class ShoppingItemRepository
    {
        iGiftDBDataContext _sdb = new iGiftDBDataContext();

        public IQueryable<ShoppingItem> GetItems(int categoryID,int subCategoryID)
        {
            return (from s in _sdb.ShoppingItems
                    where s.CategoryID==categoryID && s.SubCategoryID==subCategoryID
                    select s);
        }

        public ShoppingItem GetCurrentItem(int ItemID)
        {
            return _sdb.ShoppingItems.SingleOrDefault(s => s.ItemID == ItemID);
        
        }
    }
}
