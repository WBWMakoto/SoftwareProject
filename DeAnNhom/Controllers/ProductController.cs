using DeAnNhom.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using PagedList;
using System;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using Microsoft.AspNet.Identity.EntityFramework;

namespace DeAnNhom.Controllers
{
    [Authorize(Roles = "Seller")]
    public class ProductController : Controller
    {
        private DeAnNhomDatabaseEntities db = new DeAnNhomDatabaseEntities();

        private ApplicationUserManager _userManager;
        private ApplicationRoleManager _roleManager;

        public ApplicationUserManager UserManager
        {
            get
            {
                return _userManager ?? HttpContext.GetOwinContext().GetUserManager<ApplicationUserManager>();
            }
            private set
            {
                _userManager = value;
            }
        }

        public ApplicationRoleManager RoleManager
        {
            get
            {
                return _roleManager ?? HttpContext.GetOwinContext().Get<ApplicationRoleManager>();
            }
            private set
            {
                _roleManager = value;
            }
        }

        [AllowAnonymous]
        public ActionResult Index(int? page, string sellerID, string category, string name, int max = int.MaxValue, int min = int.MinValue)
        {
            int PageNum = page ?? 1;
            int PageSize = 54;

            var list = db.Products.Where(p => p.Price >= min && p.Price <= max);
            if (category != null)
            {
                list = list.Where(p => p.Category.CategoryName == category);
            }

            if (sellerID != null)
            {
                list = list.Where(p => p.SellerID == sellerID);
            }

            if (name != null)
            {
                list = list.Where(p => p.ProductName.Contains(name));
            }

            list = list.OrderBy(p => p.ProductID);

            return View(new ProductPage { PageProduct = list.ToPagedList(PageNum, PageSize), ListProduct = list.ToList() });
        }

        [AllowAnonymous]
        public ActionResult Details(int name)
        {
            Product p = db.Products.Where(_p => _p.ProductID == name).FirstOrDefault();

            if (p == null)
            {
                return RedirectToAction("Index", "Home");
            }

            return View(new ProductAddToCartViewModel { product = p });
        }

        [AllowAnonymous]
        public PartialViewResult TotalProduct(string sellerID)
        {
            ViewBag.Count = db.Products.Where(p => p.SellerID == sellerID).Count();
            return PartialView();
        }

        public ActionResult Create()
        {
            return View();
        }

        // POST: Product/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Create(ProductCreateViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }

            try
            {
                Product p = new Product
                {
                    Quantity = model.Quantity,
                    Price = model.ProductPrice > 0 ? model.ProductPrice : -model.ProductPrice,
                    ProductName = model.ProductName,
                    Decription = model.ProductDescription,
                    Sizes = model.ProductSizes,
                    SellerID = model.SellerID,
                    CategoryID = model.CategoryID,
                    CreatedAt = DateTime.Now
                };
                db.Products.Add(p);

                if (model.UploadImg != null)
                {
                    string fileName = p.ProductID.ToString();
                    string extent = Path.GetExtension(model.UploadImg.FileName);

                    fileName = Guid.NewGuid().ToString() + extent; // Tạo một tên duy nhất để tránh việc lưu đè

                    model.UploadImg.SaveAs(Path.Combine(Server.MapPath("~/Content/Images/Product"), fileName));
                    p.ProductImage = $"~/Content/Images/Product/{fileName}";
                }

                await db.SaveChangesAsync();







                return RedirectToAction("Details", new { name = p.ProductID });
            }
            catch
            {
                return View();
            }
        }

        public ActionResult GenRandomProduct(int? quantity)
        {
            int Quantity = quantity ?? 200;
            Random rnd = new Random();

            for (int i = 0; i < Quantity; i++)
            {
                Product p = new Product
                {
                    Quantity = rnd.Next(1, 1000),
                    Price = rnd.Next(10000, 1000000),
                    ProductName = $"Product {i}",
                    Decription = $"Product {i} description",
                    Sizes = "S;M;L;XL;XXL",
                    SellerID = UserManager.FindById(User.Identity.GetUserId()).Id,
                    ProductImage = $"~/Content/Images/Product/{rnd.Next(1, 100)}.jpg",
                    CreatedAt = DateTime.Now,
                    CategoryID = "Test",
                };
                db.Products.Add(p);
            }
            db.SaveChanges();

            return RedirectToAction("Index");
        }

        public ActionResult Manage(int? page)
        {
            int PageNum = page ?? 1;
            int PageSize = 10;

            string userID = User.Identity.GetUserId();
            var list = db.Products.Where(p => p.SellerID == userID).ToList().ToPagedList(PageNum, PageSize);

            return View(list);
        }

        public ActionResult Edit(int name)
        {
            var product = db.Products.Where(p => p.ProductID == name).FirstOrDefault();

            if (product == null)
            {
                return RedirectToAction("Index");
            }

            return View(product);
        }

        // POST: Product/Edit
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(int name, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // POST: Product/Delete
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Delete(FormCollection form)
        {
            int ProductID = Convert.ToInt32(form["ProductID"]);
            string UserID = User.Identity.GetUserId();

            var product = db.Products.Where(p => p.ProductID == ProductID && p.SellerID == UserID).FirstOrDefault();

            if (product == null)
            {
                return RedirectToAction("Manage");
            }

            var orderDetails = db.OrderDetails.Where(od => od.ProductID == product.ProductID).ToList();
            foreach (var order in orderDetails)
            {
                db.OrderDetails.Remove(order);
            }

            db.Products.Remove(product);
            await db.SaveChangesAsync();

            return RedirectToAction("Manage");
        }

        #region Partial Views

        public PartialViewResult SelectCate()
        {
            return PartialView(db.Categories.ToList());
        }

        #endregion Partial Views
    }
}