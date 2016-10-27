using System;
using System.Net;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Inventory_App.Models;
using System.Data.Entity;

namespace Inventory_App.Controllers
{
    public class ColorController : Controller
    {
        InventoryAppEntities db = new InventoryAppEntities();

        // ---------------- List of colors in partial view ----------------

        public ActionResult _colorList()
        {
            var listview = db.Colors.Where(a => a.IsDeleted == false).ToList().OrderBy(a => a.Color_Name); //getting the list of colors from the database where the item is not deleted
            return PartialView("_colorList", listview);
        }

        // ---------------- Add color ----------------

        #region Add Color

        [HttpGet]
        public ActionResult addColor()
        {
            if (Session["LoggedUserFullname"] == null)
            {
                Session.Abandon();
                return RedirectToAction("Index", "Login");
            }

            if (TempData["restoreempty"] != null)
            {
                ViewBag.restoreempty = "true";
            }

            int listview = db.Colors.Where(a => a.IsDeleted == true).ToList().Count();
            if (listview != 0)
            {
                ViewBag.colorCheck = "DelColorexist";
                return View();
            }

            else
            {
                return View();
            }

        }

        [HttpPost]
        public ActionResult addColor(Color color)
        {
            if (color != null)
            {
                Color oneColor = new Color();
                
                    if (db.Colors.Where(a => a.Color_Name == color.Color_Name).Count() != 0)
                    {
                        oneColor = db.Colors.Where(a => a.Color_Name == color.Color_Name).Single();
                        if (oneColor.IsDeleted)
                        {
                            ViewBag.ColorExist = "ColorExistButDeleted";
                            ViewBag.colorCheck = "DelColorexist";
                            return View();
                        }
                        else
                        {
                            ViewBag.ColorExist = "ColorExist";
                            return View();
                        }
                    }

                    else
                    {
                        color.IsDeleted = false;
                        color.Date = System.DateTime.Now;
                        db.Colors.Add(color);
                        db.SaveChanges();
                        ModelState.Clear();
                        return View();
                    }
            }
            else
            {
                ViewBag.ColorExist = "ColorExist";
                return View();
            }
        }

        #endregion

        // ---------------- Edit Color ----------------

        #region Edit Color

        [HttpGet]
        public ActionResult Editcolor(int id)
        {
            Color color = db.Colors.Find(id);
            if (color == null)
            {
                return HttpNotFound();
            }

            return View(color);
        }

        [HttpPost]
        public ActionResult EditColor(Color color)
        {
            if (ModelState.IsValid)
            {
                db.Entry(color).State = EntityState.Modified;
                color.Date = DateTime.Now;
                color.IsDeleted = false;
                db.SaveChanges();
                return RedirectToAction("addColor", "Color");
            }
            return View(color);
        }

        #endregion

        // ---------------- Delete Color ----------------

        #region Delete Color
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
                    var m = db.Colors.Where(e => e.Color_Id == id).FirstOrDefault();
                    m.IsDeleted = true;
                    db.SaveChanges();
                    return RedirectToAction("addColor", "Color");
                }
            }
            catch (Exception ex)
            {
                throw ex;

            }
        }

        #endregion

        // ---------------- Restore Color ----------------

        #region Restore Color
        public ActionResult restoreColor()
        {
            if (TempData["restoreempty"] != null)
            {
                ViewBag.restoreempty = "false";
                if (TempData["restoreempty"] != null)
                {
                    ViewBag.Colorname = TempData["Colorname"];
                }
            }
            var listview = db.Colors.Where(a => a.IsDeleted == true).ToList().OrderBy(a => a.Color_Name); //getting the list of Deleted colors from the database where the item is deleted
            if (listview != null)
            {
                return View(listview);
            }
            else
                return View();
        }

        public ActionResult restoreDeletedColor(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            else
            {

                var restoreColor = db.Colors.Where(e => e.Color_Id == id).FirstOrDefault();

                if (restoreColor != null)
                {
                    restoreColor.IsDeleted = false;
                    db.SaveChanges();
                    return View("restoreColor");
                }
            }

            return View("restoreColor");
        }

        public ActionResult wipeOutColor(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            else
            {
                TempData["Colorname"] = db.Colors.Single(a => a.Color_Id == id).Color_Name;
                Color color = db.Colors.Find(id);
                db.Colors.Remove(color);
                db.SaveChanges();
                var restoreColor = db.Colors.Where(e => e.IsDeleted == true).Count();
                if (restoreColor > 0)
                {
                    TempData["restoreempty"] = "true";
                    return RedirectToAction("restoreColor");
                }
                else

                {
                    TempData["restoreempty"] = "true";
                    return RedirectToAction("addColor");
                }
            }
        }

        #endregion
    }
}