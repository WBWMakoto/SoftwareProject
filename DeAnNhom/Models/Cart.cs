using System.Collections.Generic;
using System.Linq;

namespace DeAnNhom.Models
{
    public class CartItem
    {
        public Product _product { get; set; }
        public int _quantity { get; set; }
        public string _sizes { get; set; }
    }

    public class Cart
    {
        private List<CartItem> items = new List<CartItem>();

        public IEnumerable<CartItem> Items
        {
            get { return items; }
        }

        public void AddProductToCart(Product _pro, string _sizes, int _quan)
        {
            var item = Items.FirstOrDefault(s => s._product.ProductID == _pro.ProductID && s._sizes == _sizes);

            if (item == null)
            {
                _quan = _quan <= _pro.Quantity ? _quan : 1;
                items.Add(new CartItem { _product = _pro, _quantity = _quan, _sizes = _sizes });
            }
            else
            {
                if (item._quantity + _quan <= item._product.Quantity)
                {
                    item._quantity += _quan;
                }
            }
        }

        public int TotalQuantity()
        {
            return items.Count;
        }

        public decimal TotalMoney()
        {
            var total = items.Sum(s => s._quantity * s._product.Price);

            return (decimal)(total);
        }

        public void UpdateQuantity(int id, int _newQuan, string _size)
        {
            var item = items.Find(p => p._product.ProductID == id && p._sizes == _size);
            if (item != null)
            {
                if (item._product.Quantity >= _newQuan)
                {
                    item._quantity = _newQuan;
                }
            }
        }

        public void RemoveCartItem(int id, string size)
        {
            items.RemoveAll(s => s._product.ProductID == id && s._sizes == size);
        }

        public void ClearCart()
        {
            items.Clear();
        }
    }
}