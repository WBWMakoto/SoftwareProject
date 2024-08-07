﻿using DeAnNhom.Models;
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

            var model = new ProductPage
            {
                PageProduct = list.ToPagedList(PageNum, PageSize),
                ListProduct = list.ToList(),
                Db = db  // Pass the db object to the view
            };

            return View(model);
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
                    string originalFileName = Path.GetFileNameWithoutExtension(model.UploadImg.FileName);
                    string fileExtension = Path.GetExtension(model.UploadImg.FileName);

                    // Tạo một tên file duy nhất bằng cách sử dụng thời gian và một phần ngẫu nhiên
                    string uniqueFileName = $"{DateTime.Now.Ticks}_{Guid.NewGuid()}{fileExtension}";

                    string imagePath = Path.Combine(Server.MapPath("~/Content/Images/Product"), uniqueFileName);
                    model.UploadImg.SaveAs(imagePath);
                    p.ProductImage = $"~/Content/Images/Product/{uniqueFileName}";
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
            // Retrieve categories from the database
            var categories = db.Categories.ToList();

            // Create a SelectList from the categories
            var categoryList = new SelectList(categories, "CategoryID", "CategoryName");

            // Assign the SelectList to ViewBag.Categories
            ViewBag.Categories = categoryList;

            // Other code...

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
        public async Task<ActionResult> Edit(int name, HttpPostedFileBase ImageFile)
        {
            var product = db.Products.Find(name);

            if (product == null)
            {
                return HttpNotFound();
            }

            if (ModelState.IsValid)
            {
                // Check if a new image was uploaded
                if (ImageFile != null && ImageFile.ContentLength > 0)
                {
                    // Delete old image (if it exists and it's not the default)
                    if (!string.IsNullOrEmpty(product.ProductImage) && !product.ProductImage.Contains("default"))
                    {
                        var oldImagePath = Server.MapPath(product.ProductImage);
                        if (System.IO.File.Exists(oldImagePath))
                        {
                            System.IO.File.Delete(oldImagePath);
                        }
                    }

                    // Save the new image
                    string originalFileName = Path.GetFileNameWithoutExtension(ImageFile.FileName);
                    string fileExtension = Path.GetExtension(ImageFile.FileName);
                    string uniqueFileName = $"{DateTime.Now.Ticks}_{Guid.NewGuid()}{fileExtension}";
                    string imagePath = Path.Combine(Server.MapPath("~/Content/Images/Product"), uniqueFileName);
                    ImageFile.SaveAs(imagePath);

                    // Update the product's image path
                    product.ProductImage = $"~/Content/Images/Product/{uniqueFileName}";
                }

                // Update other properties (using TryUpdateModel is fine)
                TryUpdateModel(product, new string[] { "ProductName", "Decription", "Price", "Quantity", "Sizes", "CategoryName", "CategoryID" });

                await db.SaveChangesAsync();
                return RedirectToAction("Manage");
            }

            // If ModelState is not valid, return to the edit view with errors
            return View(product);
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