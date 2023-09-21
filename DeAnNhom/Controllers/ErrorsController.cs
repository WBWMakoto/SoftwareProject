using System.Web.Mvc;

namespace DeAnNhom.Controllers
{
    public class ErrorsController : Controller
    {
        // GET: Errors
        public ActionResult Index()
        {
            return RedirectToAction("Index", "Home");
        }

        public ActionResult Unauthorization()
        {
            return View();
        }
    }
}