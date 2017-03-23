using Inventory_App.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;

namespace Inventory_App.Controllers
{
    [SessionTimeout]
    public class AddInkController : BaseController
    {

        public ActionResult _AddInkToStoreList()
        {
            var listview = db.AddInktoStores.Where(a => a.Quantity > 0).OrderByDescending(a => a.Date).ToList();
            return PartialView("_AddInkToStoreList", listview);
        }

        // ---------------- Add Added Ink ----------------

        #region Add Ink

        [HttpGet]
        public ActionResult AddInkPlus()
        {
            getStoreNames();
            ViewData["storeList"] = new SelectList(storeNamesList);
            ViewBag.BrandList = new SelectList(db.Brands.Where(a => a.IsDeleted == false), "Brand_Id", "Brand_Name");
            ViewBag.ModelList = new SelectList(db.Models.Where(a => a.IsDeleted == false), "Model_Id", "Model_Name");
            ViewBag.YearList = new SelectList(db.Years, "YearID", "Year1");
            return View();
        }

        [HttpPost]
        public ActionResult AddInkPlus(AddInktoStore addInk, FormCollection formCollection)
        {

            //we are getting the Store Name Instead of Store ID as from the httpGet view of this Form.
            // So we are storing the name of the Store in the variable storeName of type string below.
            string storeName = formCollection["storeList"];
            int storeId = db.Stores.Single(a => a.Store1 == storeName).Store_Id; //matching the storeName with the names in the store and getting the Id of the same.
            addInk.Store_Id = storeId; // Assigning the Store ID in the Object addInk

            //we want to check whether the this is new Ink to add in store or just an update on quantity of old Ink in store
            // so we are assigning the model ID to the Variable below.
            int ModelID = addInk.Model_Id;
            int countInkPresent = db.AddInktoStores.Where(a => a.Model_Id == ModelID).Count(); // getting the count of object by comparing the model ID and variable value

            //if count is more than Zero(!=0) then add the quantity to the existing
            if (countInkPresent != 0)
            {
                List<AddInktoStore> StoreIDPresent = db.AddInktoStores.Where(a => a.Model_Id == ModelID).ToList();
                int count = StoreIDPresent.Count();
                foreach (var item in StoreIDPresent)
                {
                    if (item.Store_Id == storeId)
                    {
                        updateQuantity(item.InkId, true, addInk.Quantity);
                    }
                    else
                    {
                        count = count - 1;
                    }
                }

                if (count == 0)
                {
                    addInk.Date = DateTime.Now;
                    db.AddInktoStores.Add(addInk);
                    db.SaveChanges();
                }
            }
            else
            {
                addInk.Date = DateTime.Now;
                db.AddInktoStores.Add(addInk);
                db.SaveChanges();
            }

            TempData["AddedItemId"] = addInk.InkId;
            getStoreNames();
            ViewData["storeList"] = new SelectList(storeNamesList);
            ViewBag.BrandList = new SelectList(db.Brands, "Brand_Id", "Brand_Name");
            ViewBag.ModelList = new SelectList(db.Models, "Model_Id", "Model_Name");
            ViewBag.YearList = new SelectList(db.Years, "YearID", "Year1");
            return View();
        }

        #endregion

        // ---------------- Edit Added Ink ----------------

        #region Edit Ink

        [HttpGet]
        public ActionResult editInk()
        {
            return View();
        }

        [HttpPost]
        public ActionResult editInk(int id, FormCollection formCollection)
        {
            int frmQuantity = int.Parse(formCollection["Quantity"]);
            updateQuantity(id, false, frmQuantity);
            return RedirectToAction("AddInkPlus", "AddInk");
        }

        #endregion

        // ---------------- Delete Added Ink ----------------

        #region Delete Added Ink

        public ActionResult Delete(int? id)
        {
            AddInktoStore AITS = db.AddInktoStores.Find(id);
            db.AddInktoStores.Remove(AITS);
            db.SaveChanges();
            return RedirectToAction("AddInkPlus");
        }

        #endregion

    }
}