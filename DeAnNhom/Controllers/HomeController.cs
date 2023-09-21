using DeAnNhom.Models;
using System;
using System.Linq;
using System.Web.Mvc;

namespace DeAnNhom.Controllers
{
    public class HomeController : Controller
    {
        private DeAnNhomDatabaseEntities db = new DeAnNhomDatabaseEntities();

        public ActionResult Index()
        {
            Random rnd = new Random();
            var list = db.Products.OrderByDescending(p => p.Sold).Take(54).ToList();

            return View(list.OrderBy(p => rnd.Next()));
        }

        public PartialViewResult Ads()
        {
            return PartialView();
        }

       public PartialViewResult Categories()
        {
            var list = db.Categories.ToList(); 

             return PartialView(list);
        }
    }
}