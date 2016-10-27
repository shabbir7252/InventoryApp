using Inventory_App.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Inventory_App.Controllers
{
    public class StoreController : Controller
    {
        InventoryAppEntities db = new InventoryAppEntities();

        // ---------------- Add Brand ----------------

        public ActionResult _StoreList()
        {
            var listview = db.Stores.Where(a => a.IsDeleted == false).OrderBy(a => a.Store1).ToList();
            return PartialView("_StoreList", listview);
        }

        [HttpGet]
        public ActionResult AddStore()
        {
            ViewBag.CountryList = new SelectList(db.Countries, "CountryID", "CountryName");
            ViewBag.YearList = new SelectList(db.Years, "YearID", "Year1");
            return View();
        }

        [HttpPost]
        public ActionResult AddStore(Store store)
        {
            if (ModelState.IsValid)
            {
                store.IsDeleted = false;
                db.Stores.Add(store);
                db.SaveChanges();
                ModelState.Clear();
            }
            ViewBag.CountryList = new SelectList(db.Countries, "CountryID", "CountryName");
            ViewBag.YearList = new SelectList(db.Years, "YearID", "Year1");
            return View();
        }

        [HttpPost]
        public ActionResult SelectStore(Store store)
        {
            Session["SelectedStore"] = store.Store1;
            int storeID = int.Parse(store.Store1);
            string storeName = db.Stores.Single(a => a.Store_Id == storeID).Store1;
            Session["StoreName"] = storeName;
            return RedirectToAction("Index", "Default");
        }
    }
}