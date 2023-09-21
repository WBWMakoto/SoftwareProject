using DeAnNhom.Models;
using Microsoft.AspNet.Identity;
using System;
using System.Linq;
using System.Web.Mvc;

namespace DeAnNhom.Controllers
{
    public class CartController : Controller
    {
        private DeAnNhomDatabaseEntities db = new DeAnNhomDatabaseEntities();

        // GET: /ShoppingCart
        public ActionResult Index()
        {
            return RedirectToAction("ShowCart");
        }

        public ActionResult ShowCart()
        {
            Cart _cart = GetCart();

            return View(_cart);
        }

        public ActionResult CheckOut()
        {
            if (!Request.IsAuthenticated)
            {
                return RedirectToAction("Login", "Account", new { returnUrl = "/Cart/ShowCart" });
            }
            string userID = User.Identity.GetUserId();
            var currentUser = db.Users.Where(u => u.UserID == userID).FirstOrDefault();
            try
            {
                Cart _cart = GetCart();
                if (_cart.Items.Count() == 0)
                {
                    return RedirectToAction("ShowCart");
                }

                OrderPro _order = new OrderPro
                {
                    CustomerID = currentUser.UserID,
                    DateOrder = DateTime.Now,
                };
                db.OrderProes.Add(_order);

                foreach (var item in _cart.Items)
                {
                    OrderDetail _orderDetail = new OrderDetail
                    {
                        OrderID = _order.OrderID,
                        ProductID = item._product.ProductID,
                        UnitPrice = (double)item._product.Price,
                        Quantity = item._quantity,
                        Sizes = item._sizes
                    };
                    db.OrderDetails.Add(_orderDetail);

                    foreach (var p in db.Products.Where(s => s.ProductID == _orderDetail.ProductID))
                    {
                        p.Quantity -= item._quantity;
                        p.Sold += item._quantity;
                    }
                }

                db.SaveChanges();
                _cart.ClearCart();

                ViewBag.Title = "Checkout Successfully";
                ViewBag.IsSuccess = true;
            }
            catch
            {
                ViewBag.Title = "Checkout Failed";
                ViewBag.IsSuccess = false;
            }

            return View();
        }

        public PartialViewResult CheckoutFailed()
        {
            return PartialView();
        }

        public PartialViewResult CheckOutSuccess()
        {
            return PartialView();
        }

        [HttpPost]
        public ActionResult AddToCart(int proID, string size, int quantity)
        {
            var _pro = db.Products.SingleOrDefault(s => s.ProductID == proID);
            if (_pro != null)
            {
                GetCart().AddProductToCart(_pro, size, quantity);
            }

            return RedirectToAction("Details", "Product", new { name = proID });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult BuyNow(ProductAddToCartViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return RedirectToAction("Details", "Product", new { name = model.ProductID });
            }

            var _pro = db.Products.SingleOrDefault(s => s.ProductID == model.ProductID);
            if (_pro != null)
            {
                GetCart().AddProductToCart(_pro, model.Size, model.Quantity);
            }

            return RedirectToAction("ShowCart");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult UpdateItemQuantity(FormCollection form)
        {
            Cart _cart = GetCart();

            int ProductID = Convert.ToInt32(form["ProID"]);
            int _quantity = Convert.ToInt32(form["Quantity"]);
            string _pSize = form["Size"];

            _cart.UpdateQuantity(ProductID, _quantity, _pSize);

            return RedirectToAction("ShowCart");
        }

        public ActionResult RemoveItem(int id, string size)
        {
            Cart _cart = GetCart();
            _cart.RemoveCartItem(id, size);

            return RedirectToAction("ShowCart");
        }

        public PartialViewResult BadgeCart()
        {
            int totalQuantityItem = 0;
            Cart _cart = GetCart();

            if (_cart != null)
            {
                totalQuantityItem = _cart.TotalQuantity();
            }

            ViewBag.QuantityCart = totalQuantityItem;

            return PartialView("BadgeCart");
        }

        #region Helpers

        public Cart GetCart()
        {
            Cart cart = Session["Cart"] as Cart;
            if (cart == null || Session["Cart"] == null)
            {
                cart = new Cart();
                Session["Cart"] = cart;
            }

            return cart;
        }

        #endregion Helpers
    }
}