using DeAnNhom.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Logging;
using Microsoft.Owin.Security;
using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

using System.Data.Entity; // Add this for Include()



namespace DeAnNhom.Controllers
{
    public class AdminController : Controller
    {
        private ApplicationSignInManager _signInManager;
        private ApplicationUserManager _userManager;
        private ApplicationRoleManager _roleManager;

        private DeAnNhomDatabaseEntities db = new DeAnNhomDatabaseEntities();

        public AdminController()
        { }

        public AdminController(ApplicationUserManager userManager, ApplicationSignInManager signInManager, ApplicationRoleManager rolesManager)
        {
            UserManager = userManager;
            SignInManager = signInManager;
            RoleManager = rolesManager;
        }

        public ApplicationSignInManager SignInManager
        {
            get
            {
                return _signInManager ?? HttpContext.GetOwinContext().Get<ApplicationSignInManager>();
            }

            private set
            {
                _signInManager = value;
            }
        }

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

        private IAuthenticationManager AuthenticationManager
        {
            get
            {
                return HttpContext.GetOwinContext().Authentication;
            }
        }

        [Authorize(Roles = "Customer")]
        public async Task<ActionResult> BecomeAdmin()
        {
            var user = UserManager.FindById(User.Identity.GetUserId());

            if (user.Email.ToLower() == "adminmakoto@gmail.com" || user.Email.ToLower() == "admin@admin.com")
            {
                db.Sellers.Add(new Seller { SellerID = user.Id, ShopName = user.Customer.Name });

                await Task.WhenAll(
                    UserManager.AddToRolesAsync(user.Id, "Admin", "Seller"),
                    db.SaveChangesAsync()
                );

                return RedirectToAction("CreateCategory", "Admin");
            }
            return RedirectToAction("Unauthorization", "Errors");
        }

        [Authorize(Roles = "Admin")]
        public ActionResult DeleteCategory(int? CategoryId)
        {
            try
            {
                ViewBag.Categories = db.Categories.ToList();

                if (CategoryId.HasValue)
                {
                    var category = db.Categories.Find(CategoryId);
                    if (category == null)
                    {
                        return HttpNotFound();
                    }
                    return View(category);
                }
                else
                {
                    return View(); // Return the view to select a category
                }
            }
            catch (Exception)
            {
                // Log the error
                return View("Error");
            }

        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteCategoryConfirmed(int id)
        {
            var category = db.Categories.Find(id);
            if (category == null)
            {
                return HttpNotFound();
            }

            db.Categories.Remove(category);
            db.SaveChanges();

            return RedirectToAction("Categories");
        }

        [Authorize(Roles = "Admin")]
        public ActionResult CreateCategory()
        {
            return View();
        }

        [Authorize(Roles = "Admin")]
        public ActionResult AdminDashboard()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateCategory(CreateCategoryViewModel model)
        {
            if (ModelState.IsValid)
            {
                string fileName = model.CategoryName.Replace(' ', '-');
                string extent = Path.GetExtension(model.CategoryImage.FileName);
                fileName += extent;

                model.CategoryImage.SaveAs(Path.Combine(Server.MapPath("~/Content/Images/Category"), fileName));

                var cate = new Category
                {
                    CategoryID = model.CategoryName,
                    CategoryName = model.CategoryName,
                    CategoryImage = $"~/Content/Images/Category/{fileName}"
                };
                db.Categories.Add(cate);
                db.SaveChanges();

                ViewBag.IsSuccess = true;

                return View();
            }
            return View();
        }
    }
}