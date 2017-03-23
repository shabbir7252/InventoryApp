
using System;
using System.Net;
using System.Linq;
using System.Web.Mvc;
using System.Data.Entity;
using Inventory_App.Models;
using System.Collections.Generic;
using System.Web.Script.Serialization;

namespace Inventory_App.Controllers
{
    public class ModelController : Controller
    {
        //public List<string> getColors()
        //{
        //    List<string> colorList = new List<string>();

        //    Colors[] ColorNames = (Colors[])Enum.GetValues(typeof(Colors));

        //    foreach (var items in ColorNames)
        //    {
        //        Type type = items.GetType();

        //        string name = Enum.GetName(type, items);

        //        FieldInfo field = type.GetField(name);

        //        DescriptionAttribute attr = Attribute.GetCustomAttribute(field, typeof(DescriptionAttribute)) as DescriptionAttribute;

        //        colorList.Add(attr.Description);
        //    }

        //    return colorList;
        //}

        public List<string> getColors()
        {
            List<string> colorList = new List<string>();

            //get the Json filepath
            string file = Server.MapPath("~/App_Data/colors.json");

            //deserialize JSON from file  
            string Json = System.IO.File.ReadAllText(file);
            JavaScriptSerializer ser = new JavaScriptSerializer();
            var listColor = ser.Deserialize<List<colorList>>(Json);

            foreach (var item in listColor)
                colorList.Add(item.ColorName);

            return colorList;
        }

        InventoryAppEntities db = new InventoryAppEntities();

        public ActionResult _InkModelList()
        {
            var listview = db.Models.Where(a => a.IsDeleted == false).OrderBy(a => a.Model_Name).ToList();
            return PartialView("_InkModelList", listview);
        }

        // ---------------- Add Ink Model ----------------

        #region Add Ink Model

        [HttpGet]
        public ActionResult addInkModel()
        {
            ViewBag.BrandList = new SelectList(db.Brands.Where(a => a.IsDeleted == false), "Brand_Id", "Brand_Name");
            List<string> ColorNames = getColors();
            ViewData["ColorList"] = new SelectList(ColorNames);
            int listview = db.Models.Where(a => a.IsDeleted == true).ToList().Count();
            if (listview != 0)
            {
                ViewBag.InkModelCheck = "DelInkModelexist";
                return View();
            }

            return View();
        }

        [HttpPost]
        public ActionResult addInkModel(Model model, FormCollection formCollection)
        {
            if (model != null)
            {
                ViewBag.BrandList = new SelectList(db.Brands, "Brand_Id", "Brand_Name");
                List<string> ColorNames = getColors();
                ViewData["ColorList"] = new SelectList(ColorNames);

                string ColorName = formCollection["ColorList"];
                var brandName = db.Brands.Where(a => a.Brand_Id == model.Brand_Id).Single().Brand_Name;

                if (db.Models.Where(a => a.Model_Name == model.Model_Name && a.IsDeleted).Count() != 0)
                {
                    ViewBag.alertexistInkModel = MvcHtmlString.Create("<strong>Redundant Data!</strong> The Ink Name <strong>" + model.Model_Name + "</strong> already exist and it was deleted from the system. Please click the Restore button and retrieve the deleted combination.");
                }

                else if (db.Models.Where(a => a.Model_Name == model.Model_Name).Count() != 0)
                {
                    ViewBag.alertexistInkModel = MvcHtmlString.Create("<strong>Redundant Data!</strong> The Ink Name <strong>" + model.Model_Name + "</strong> already exist.Check the List below.");
                }

                else
                {
                    model.ColorName = ColorName;
                    model.Date = DateTime.Now;
                    model.IsDeleted = false;
                    db.Models.Add(model);
                    db.SaveChanges();
                    ModelState.Clear();
                }

            }

            return View();
        }

        #endregion

        // ---------------- Edit Ink Model ----------------

        #region Edit Ink Model

        [HttpGet]
        public ActionResult EditInkModel(int id)
        {
            ViewBag.BrandList = new SelectList(db.Brands.Where(a => a.IsDeleted == false), "Brand_Id", "Brand_Name");
            List<string> ColorNames = getColors();
            ViewData["ColorList"] = new SelectList(ColorNames);

            Model model = db.Models.Find(id);
            if (model == null)
            {
                return HttpNotFound();
            }

            return View(model);
        }

        [HttpPost]
        public ActionResult EditInkModel(Model model, FormCollection formCollection)
        {
            if (ModelState.IsValid)
            {
                model.ColorName = formCollection["ColorList"];
                db.Entry(model).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("addInkModel", "Model");
            }
            return View(model);
        }

        #endregion

        // ---------------- Delete Ink Model ----------------

        #region Delete Ink Model
        public ActionResult Delete(int? id)
        {
            var m = db.Models.Where(e => e.Model_Id == id).FirstOrDefault();
            m.IsDeleted = true;
            db.SaveChanges();
            return RedirectToAction("addInkModel", "Model");
        }

        #endregion

        // ---------------- Restore Ink Model ----------------

        #region Restore Ink Model
        public ActionResult restoreInkModel()
        {
            var listview = db.Models.Where(a => a.IsDeleted == true).ToList().OrderBy(a => a.Model_Name); //getting the list of Deleted Ink Model from the database where the item is deleted
            if (listview != null)
            {
                ViewBag.alertexistInkModel = TempData["wipeout"];
                return View(listview);
            }
            else
                return View();
        }

        public ActionResult restoreDeletedInkModel(int? id)
        {
            var restoreDeletedInkModel = db.Models.Where(e => e.Model_Id == id).FirstOrDefault();

            if (restoreDeletedInkModel != null)
            {
                restoreDeletedInkModel.IsDeleted = false;
                db.SaveChanges();
                return View("restoreInkModel");
            }

            return View("restoreInkModel");
        }

        public ActionResult wipeOutInkModel(int? id)
        {
            int modelCount = db.AddInktoStores.Where(a => a.Model_Id == id).Count();
            if (modelCount > 0)
            {
                ViewBag.alertexistInkModel = MvcHtmlString.Create("Cannot Wipeout as the model is in use in Store. If you cant find the model in Store and still need to delete from here! Contact Administrator");
                TempData["wipeout"] = ViewBag.alertexistInkModel;
                return RedirectToAction("restoreInkModel");
            }
            else
            {
                Model model = db.Models.Find(id);
                db.Models.Remove(model);
                db.SaveChanges();
                return View("restoreInkModel");
            }
        }

        #endregion
    }
}