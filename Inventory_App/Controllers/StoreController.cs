
using Inventory_App.Models;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web.Mvc;

namespace Inventory_App.Controllers
{
    [SessionTimeout]
    public class StoreController : Controller
    {
        InventoryAppEntities db = new InventoryAppEntities();

        // ---------------- Add Brand ----------------

        public ActionResult _StoreList()
        {
            var listview = db.Stores.Where(a => a.IsDeleted == false).OrderBy(a => a.Store1).ToList();
            return PartialView("_StoreList", listview);
        }

        public ActionResult _StoreUserList()
        {
            var listview = db.StoreUsers.ToList();
            return PartialView("_StoreUserList", listview);
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

        //[HttpPost]
        //public ActionResult SelectStore(Store store)
        //{
        //    //Session["SelectedStore"] = store.Store1;
        //    int storeID = int.Parse(store.Store1);
        //    string storeName = db.Stores.Single(a => a.Store_Id == storeID).Store1;
        //    Session["StoreName"] = storeName;
        //    return RedirectToAction("Index", "Default");
        //}

        [HttpGet]
        public ActionResult SetStorePermission()
        {
            var storeUsersList = db.StoreUsers.ToList();
            ViewBag.Usernames = new SelectList(db.Users, "UserId", "UserName");
            return View();
        }


        [HttpPost]
        public ActionResult SetStorePermission(StoreUser storeuser)
        {
            ViewBag.Usernames = new SelectList(db.Users, "UserId", "UserName");
            ViewBag.UserName = db.Users.Single(a => a.UserId == storeuser.UserId).UserName;
            ViewBag.user_id = storeuser.UserId;
            List<Store> store = db.Stores.ToList();
            return View("SelectPermission", store);

        }

        public ActionResult SavePermission(FormCollection formcollection)
        {
            var storeList = db.Stores.ToList();
            int formUserId = int.Parse(formcollection["UserId"]);
            foreach (var store in storeList)
            {
                bool check = formcollection[store.Store1].Contains("true");
                int count = db.StoreUsers.Where(a => a.Store_Id == store.Store_Id && a.UserId == formUserId).Count();
                if (count > 0)
                {
                    bool checkIsPermitted = db.StoreUsers.Single(a => a.Store_Id == store.Store_Id && a.UserId == formUserId).IsPermitted;
                    if (checkIsPermitted != check)
                    {
                        StoreUser storeuser = db.StoreUsers.Single(a => a.Store_Id == store.Store_Id && a.UserId == formUserId);

                        if (check == true && checkIsPermitted == false)
                        {
                            storeuser.IsPermitted = true;
                        }
                        else
                        {
                            storeuser.IsPermitted = false;
                        }
                        db.Entry(storeuser).State = EntityState.Modified; // Storing changes in Store Table
                        db.SaveChanges(); //Saving Changes
                    }

                }
                else
                {
                    StoreUser storeuser = new StoreUser();
                    storeuser.Store_Id = store.Store_Id;
                    storeuser.UserId = formUserId;
                    if (check)
                    {
                        storeuser.IsPermitted = true;
                    }
                    else
                    {
                        storeuser.IsPermitted = false;
                    }
                    db.StoreUsers.Add(storeuser);
                    db.SaveChanges();
                }
            }

            return RedirectToAction("SetStorePermission");
        }
    }
}