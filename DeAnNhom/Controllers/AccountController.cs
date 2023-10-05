using DeAnNhom.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace DeAnNhom.Controllers
{
    [Authorize]
    public class AccountController : Controller
    {
        private ApplicationSignInManager _signInManager;
        private ApplicationUserManager _userManager;
        private ApplicationRoleManager _roleManager;

        private DeAnNhomDatabaseEntities db = new DeAnNhomDatabaseEntities();

        public AccountController()
        { }

        public AccountController(ApplicationUserManager userManager, ApplicationSignInManager signInManager, ApplicationRoleManager rolesManager)
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

        //
        // GET: /Account
        [AllowAnonymous]
        public ActionResult Index()
        {
            if (Request.IsAuthenticated)
            {
                return RedirectToAction("Profile");
            }
            return RedirectToAction("Login", new { ReturnUrl = "/Account/Profile" });
        }

        //
        // GET: /Account/Login
        [AllowAnonymous]
        public ActionResult Login(string returnUrl)
        {
            if (Request.IsAuthenticated)
            {
                return RedirectToAction("Index", "Home");
            }

            ViewBag.ReturnUrl = returnUrl;
            return View();
        }

        //
        // POST: /Account/Login
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Login(LoginViewModel model, string returnUrl)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }

            // This doesn't count login failures towards account lockout
            // To enable password failures to trigger account lockout, change to shouldLockout: true
            var result = await SignInManager.PasswordSignInAsync(model.Email, model.Password, false, shouldLockout: false);
            switch (result)
            {
                case SignInStatus.Success:
                    return RedirectToLocal(returnUrl);

                case SignInStatus.LockedOut:
                    return View("Lockout");

                case SignInStatus.RequiresVerification:
                    return RedirectToAction("SendCode", new { ReturnUrl = returnUrl });

                case SignInStatus.Failure:
                default:
                    ViewBag.Error = "Invalid login attempt.";
                    return View(model);
            }
        }

        //
        // GET: /Account/Register
        [AllowAnonymous]
        public ActionResult Register(string returnUrl)
        {
            if (Request.IsAuthenticated)
            {
                return RedirectToAction("Index", "Home");
            }

            ViewBag.ReturnUrl = returnUrl;
            return View();
        }

        //
        // POST: /Account/Register
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Register(RegisterViewModel model)
        {
            if (ModelState.IsValid)
            {
                var user = new ApplicationUser { Email = model.Email, UserName = model.Email };
                var result = await UserManager.CreateAsync(user, model.Password);

                if (result.Succeeded)
                {
                    var cus = new Customer { Name = model.Email, CustomerID = user.Id, };
                    db.Customers.Add(cus);
                    await Task.WhenAll(
                        UserManager.AddToRoleAsync(user.Id, "Customer"),
                        db.SaveChangesAsync()
                    );

                    await SignInManager.SignInAsync(user, isPersistent: false, rememberBrowser: false);

                    // For more information on how to enable account confirmation and password reset please visit https://go.microsoft.com/fwlink/?LinkID=320771
                    // Send an email with this link
                    // string code = await UserManager.GenerateEmailConfirmationTokenAsync(user.Id);
                    // var callbackUrl = Url.Action("ConfirmEmail", "Account", new { userId = user.Id, code = code }, protocol: Request.Url.Scheme);
                    // await UserManager.SendEmailAsync(user.Id, "Confirm your account", "Please confirm your account by clicking <a href=\"" + callbackUrl + "\">here</a>");

                    return RedirectToAction("Login");
                }

                //ViewBag.Error = result.Errors.FirstOrDefault();
            }

            return View(model);
        }

        public ActionResult Logout()
        {
            AuthenticationManager.SignOut(DefaultAuthenticationTypes.ApplicationCookie);
            Session.Abandon();
            return RedirectToAction("Index", "Home");
        }

        public ActionResult Logoff()
        {
            AuthenticationManager.SignOut(DefaultAuthenticationTypes.ApplicationCookie);
            Session.Abandon();
            return RedirectToAction("Index", "Home");
        }

        //
        // POST: /Account/LogOff
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult LogOff()
        {
            AuthenticationManager.SignOut(DefaultAuthenticationTypes.ApplicationCookie);
            Session.Abandon();
            return RedirectToAction("Index", "Home");
        }

        //
        // GET: /Account/Profile
        public new ActionResult Profile()
        {
            return View();
        }

        //
        // POST: /Account/Profile
        [HttpPost]
        [ValidateAntiForgeryToken]
        public new async Task<ActionResult> Profile(ProfileViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }

            var user = await UserManager.FindByIdAsync(model.Id);
            bool? gender = null;

            switch (model.Gender)
            {
                case "Men":
                    gender = true;
                    break;

                case "Women":
                    gender = false;
                    break;
            }

            user.Genders = gender;
            user.Customer.Name = model.UserName;
            user.Customer.BirthDay = model.BirthDay;

            if (user.Seller != null)
            {
                user.Seller.ShopName = model.ShopName;
            }

            if (model.UploadImg != null)
            {
                string fileName = user.Id;
                string extent = Path.GetExtension(model.UploadImg.FileName);

                fileName += extent;

                model.UploadImg.SaveAs(Path.Combine(Server.MapPath("~/Content/Images/User"), fileName));
                user.ProfileImg = $"~/Content/Images/User/{fileName}";
            }

            await Task.WhenAll(UserManager.UpdateAsync(user), user.SaveChangesAsync());

            return View();
        }


        //
        // GET: /Account/BecomeSeller
        public ActionResult BecomeSeller()
        {
            var user = UserManager.FindById(User.Identity.GetUserId());
            var role = RoleManager.FindByName("Seller");
            if (!UserManager.GetRoles(user.Id).Contains(role.Name))
            {
                return View();
            }
            return RedirectToAction("Profile");
        }

        //
        // POST: /Account/BecomeSeller
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> BecomeSeller(BecomeSellerViewModel model)
        {
            if (ModelState.IsValid)
            {
                var user = await UserManager.FindByIdAsync(User.Identity.GetUserId());

                db.Sellers.Add(new Seller { SellerID = user.Id, ShopName = model.ShopName });
                UserManager.AddToRole(user.Id, "Seller");

                // Manually update the user's claims to reflect the updated roles
                var identity = await UserManager.CreateIdentityAsync(user, DefaultAuthenticationTypes.ApplicationCookie);
                AuthenticationManager.SignIn(new AuthenticationProperties { IsPersistent = false }, identity);

                await db.SaveChangesAsync();

               
                return RedirectToAction("Index", "Home");
            }
            return View(model);
        }

        public ActionResult Update(string name)
        {
            if (name == null)
            {
                return RedirectToAction("Profile");
            }

            ViewBag.Update = name;
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Update(UpdateInfoViewModel model)
        {
            var user = UserManager.FindById(User.Identity.GetUserId());
            if (model.NewEmail != null)
            {
                UserManager.SetEmail(user.Id, model.NewEmail);
            }
            else if (model.NewPassword != null)
            {
                UserManager.ChangePassword(user.Id, model.CurrentPassword, model.NewPassword);
            }
            else if (model.NewPhone != null)
            {
                var token = UserManager.GenerateChangePhoneNumberToken(user.Id, model.NewPhone);
                UserManager.ChangePhoneNumber(user.Id, model.NewPhone, token);
            }

            return RedirectToAction("Profile");
        }

        public ActionResult Purchase()
        {
            string userID = User.Identity.GetUserId();

            var orders = db.OrderProes.Where(o => o.CustomerID == userID).OrderByDescending(o => o.DateOrder).ToList();

            return View(orders);
        }

        public PartialViewResult SideBar()
        {
            var user = UserManager.FindById(User.Identity.GetUserId());

            return PartialView(user);
        }

        private ActionResult RedirectToLocal(string returnUrl)
        {
            if (Url.IsLocalUrl(returnUrl))
            {
                return Redirect(returnUrl);
            }
            return RedirectToAction("Index", "Home");
        }
    }
}