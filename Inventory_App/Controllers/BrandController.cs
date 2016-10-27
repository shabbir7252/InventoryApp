using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Inventory_App.Models;

namespace Inventory_App.Controllers
{
    public class BrandController : Controller
    {

        InventoryAppEntities db = new InventoryAppEntities();

        // ------------------------------------------------------------------------- Add Brand -------------------------------------------------------------------------

        public ActionResult _BrandList()
        {
            var listview = db.Brands.Where(a => a.IsDeleted == false).OrderBy(a => a.Brand_Name).ToList();
            return PartialView("_BrandList", listview);
        }

        [HttpGet]
        public ActionResult AddBrand()
        {
            if (Session["LoggedUserFullname"] == null)
            {
                Session.Abandon();
                return RedirectToAction("Index", "Login");
            }

            ViewBag.YearList = new SelectList(db.Years, "YearID", "Year1");

            //List<Brand> brands = db.Brands.ToList();
            return View();
        }

        [HttpPost]
        public ActionResult AddBrand(Brand brand)
        {
            ViewBag.YearList = new SelectList(db.Years, "YearID", "Year1");
            if (brand != null)
            {
                Brand oneBrand = new Brand();

                if (db.Brands.Where(a => a.Brand_Name == brand.Brand_Name).Count() != 0)
                {
                    oneBrand = db.Brands.Where(a => a.Brand_Name == brand.Brand_Name).Single();
                    if (oneBrand.IsDeleted == true)
                    {
                        ViewBag.BrandExist = "BrandExistButDeleted";
                        return View();
                    }
                    else
                    {
                        ViewBag.BrandExist = "BrandExist";
                        return View();
                    }
                }

                else
                {
                    brand.IsDeleted = false;
                    db.Brands.Add(brand);
                    db.SaveChanges();
                    return View();
                }
            }
            else
            {
                ViewBag.BrandExist = "BrandExist";
                return View();
            }













            //if (ModelState.IsValid)
            //{
            //    brand.IsDeleted = false;
            //    db.Brands.Add(brand);
            //    db.SaveChanges();
            //    ModelState.Clear();
            //}
            //ViewBag.YearList = new SelectList(db.Years, "YearID", "Year1");
            //return View();
        }

        // ------------------------------------------------------------------------- Edit Brand -------------------------------------------------------------------------

        [HttpGet]
        public ActionResult EditBrand(int id)
        {
            Brand brand = db.Brands.Find(id);
            if (brand == null)
            {
                return HttpNotFound();
            }

            ViewBag.YearList = new SelectList(db.Years, "YearID", "Year1");
            return View(brand);
        }

        [HttpPost]
        public ActionResult EditBrand(Brand brand)
        {
            ViewBag.YearList = new SelectList(db.Years, "YearID", "Year1");
            if (ModelState.IsValid)
            {


                db.Entry(brand).State = EntityState.Modified;
                brand.IsDeleted = false;
                db.SaveChanges();
                return RedirectToAction("AddBrand", "Brand");
            }
            return View(brand);
        }

        // ---------------- Delete Brands ----------------

        #region Delete Brand
        public ActionResult Delete(int? id)
        {
            try
            {
                if (id == null)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
                }

                else
                {
                    var m = db.Brands.Where(e => e.Brand_Id == id).FirstOrDefault();
                    m.IsDeleted = true;
                    db.SaveChanges();
                    return RedirectToAction("AddBrand");
                }
            }
            catch (Exception ex)
            {
                throw ex;

            }
        }

        #endregion

        // ---------------- Restore Brands ----------------

        #region Restore Brand
        public ActionResult restoreBrands()
        {
            ViewBag.alertexistInkModel = TempData["wipeout"];
            if (TempData["restoreempty"] != null)
            {
                ViewBag.restoreempty = "false";
                if (TempData["restoreempty"] != null)
                {
                    ViewBag.Brandname = TempData["Brandname"];
                }
            }
            var listview = db.Brands.Where(a => a.IsDeleted == true).ToList().OrderBy(a => a.Brand_Name); //getting the list of Deleted Brands from the database where the item is deleted
            if (listview.Count() > 0)
            {
                return View(listview);
            }
            else
                return RedirectToAction("AddBrand");
        }

        public ActionResult restoreDeletedBrand(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            else
            {

                var restoreBrand = db.Brands.Where(e => e.Brand_Id == id).FirstOrDefault();

                if (restoreBrand != null)
                {
                    restoreBrand.IsDeleted = false;
                    db.SaveChanges();
                    return RedirectToAction("restoreBrands");
                }
            }

            return View("restoreBrands");
        }

        public ActionResult wipeOutBrand(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            else
            {
                int ModelCount = db.Models.Where(a => a.Brand_Id == id).Count();
                if (ModelCount > 0)
                {
                    ViewBag.alertexistInkModel = MvcHtmlString.Create("Cannot Wipeout as the Brand is in use in Model Master. Delete the Related model which uses this brand");
                    TempData["wipeout"] = ViewBag.alertexistInkModel;
                    return RedirectToAction("restoreBrands");
                }
                else
                {
                    TempData["Brandname"] = db.Brands.Single(a => a.Brand_Id == id).Brand_Name;
                    Brand brand = db.Brands.Find(id);
                    db.Brands.Remove(brand);
                    db.SaveChanges();
                }
                var restoreBrand = db.Brands.Where(e => e.IsDeleted == true).Count();
                if (restoreBrand > 0)
                {
                    TempData["restoreempty"] = "true";
                    return RedirectToAction("restoreBrands");
                }
                else

                {
                    TempData["restoreempty"] = "true";
                    return RedirectToAction("addBrand");
                }
            }
        }

        #endregion

    }
}
