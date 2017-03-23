
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using Inventory_App.Models;

namespace Inventory_App.Controllers
{
    [SessionTimeout]
    public class DefaultController : Controller
    {
        InventoryAppEntities db = new InventoryAppEntities();

        // ----------------------------- Dashboard -----------------------------
        public ActionResult Index()
        {
            List<AddInktoStore> allInkQuantity = db.AddInktoStores.ToList();
            ViewBag.Total = allInkQuantity.Sum(x => x.Quantity);
            return View();
        }

        public ActionResult logout()
        {
            Session.Abandon();
            return RedirectToAction("Index", "Login");
        }

    }

}