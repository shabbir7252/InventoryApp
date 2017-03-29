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
    public class InkInventoryController : BaseController
    {
        // ------------- Ink Inventory List -------------

        #region Ink Inventory List Partial Class

        public ActionResult _InkInventoryList()
        {
            var InkInventorylist = db.InkInventories.Where(a => a.Quantity > 0).OrderByDescending(a => a.Date).ToList();
            return PartialView("_InkInventoryList", InkInventorylist);
        }

        #endregion

        // ---------------- Add Added Ink ----------------

        #region Add Ink

        [HttpGet]
        public ActionResult AddInk()
        {
            getStoreNames();
            ViewData["storeList"] = new SelectList(storeNamesList);
            ViewBag.BrandList = new SelectList(db.Brands.Where(a => a.IsDeleted == false), "Brand_Id", "Brand_Name");
            ViewBag.ModelList = new SelectList(db.Models.Where(a => a.IsDeleted == false), "Model_Id", "Model_Name");
            ViewBag.YearList = new SelectList(db.Years, "YearID", "Year1");
            return View();
        }

        [HttpPost]
        public ActionResult AddInk(InkInventory OInkInventory, FormCollection oformCollection)
        {

            //we are getting the Store Name Instead of Store ID as from the httpGet view of this Form.
            // So we are storing the name of the Store in the variable storeName of type string below.
            string storeName = oformCollection["storeList"];
            int storeId = db.Stores.Single(a => a.Store1 == storeName).Store_Id; //matching the storeName with the names in the store and getting the Id of the same.
            OInkInventory.Store_Id = storeId; // Assigning the Store ID in the Object addInk

            // We want to check whether it is new Ink to add in Inventory or just to update quantity
            // so we are assigning the model ID to the Variable below.
            int ModelID = OInkInventory.Model_Id;
            int inkCount = db.InkInventories.Where(a => a.Model_Id == ModelID).Count(); // to check that the model is already there in inventory or not by checking its count

            //if count is more than Zero(!=0) then add the quantity to the existing
            if (inkCount != 0)
            {
                // the Ink in the inventory of the same model can be stored across all the stores with different quantity
                // We are getting the list of all the model in the inventory below
                List<InkInventory> OlistInkInventory = db.InkInventories.Where(a => a.Model_Id == ModelID).ToList();
                int count = OlistInkInventory.Count();
                foreach (var item in OlistInkInventory)
                {
                    if (item.Store_Id == storeId)
                        updateQuantity(item.InkId, true, OInkInventory.Quantity);
                    else
                        count -= 1;
                }

                if (count == 0)
                    _addInk(OInkInventory);
            }

            else
                _addInk(OInkInventory);

            TempData["AddedItemId"] = OInkInventory.InkId;
            getStoreNames();
            ViewData["storeList"] = new SelectList(storeNamesList);
            ViewBag.BrandList = new SelectList(db.Brands, "Brand_Id", "Brand_Name");
            ViewBag.ModelList = new SelectList(db.Models, "Model_Id", "Model_Name");
            ViewBag.YearList = new SelectList(db.Years, "YearID", "Year1");
            return View();
        }

        public void _addInk(InkInventory OinkInventory)
        {
            OinkInventory.Date = DateTime.Now;
            db.InkInventories.Add(OinkInventory);
            db.SaveChanges();
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
        public ActionResult editInk(int id, FormCollection oformCollection)
        {
            int fcQuantity = int.Parse(oformCollection["Quantity"]);
            updateQuantity(id, false, fcQuantity);
            return RedirectToAction("AddInk", "InkInventory");
        }

        #endregion

        // ---------------- Delete Ink ----------------

        #region Delete Ink

        public ActionResult Delete(int? id)
        {
            InkInventory OinkInventory = db.InkInventories.Find(id);
            db.InkInventories.Remove(OinkInventory);
            db.SaveChanges();
            return RedirectToAction("AddInk");
        }

        #endregion

    }
}