
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Inventory_App.Models;
using System.DirectoryServices.AccountManagement;

namespace Inventory_App.Controllers
{
    [SessionTimeout]
    public class UserController : BaseController
    {

        public ActionResult _UserList()
        {
            var listview = db.Users.OrderByDescending(a => a.UserName).ToList();
            return PartialView("_UserList", listview);
        }

        [HttpGet]
        public ActionResult Index()
        {
            if (TempData["nameList"] != null)
            {
                ViewData["nameList"] = TempData["nameList"];
            }

            if (TempData["Userexist"] != null)
            {
                ViewBag.Userexist = TempData["Userexist"];
            }

            return View();
        }

        public ActionResult SearchEmployee(string text)
        {
            List<string> SearchNamesList = new List<string>();
            var username = text;
            SearchNamesList = SearchEngine(null, username);
            if (SearchNamesList.Count() > 0)
            {
                TempData["nameList"] = new SelectList(SearchNamesList);
                return RedirectToAction("Index", "user");
            }
            else
            {
                TempData["nameList"] = null;
                return RedirectToAction("Index", "user");
            }
        }

        [HttpPost]
        public ActionResult addUser(User user, FormCollection formCollection)
        {

            string employeeUsername = formCollection["nameList"];
            int usernamecount = db.Users.Where(a => a.UserName == employeeUsername).Count();
            if (usernamecount == 0)
            {
                bool isAdmin = formCollection["checkadmin"].Contains("true");

                user.IsAdmin = isAdmin;
                user.UserName = employeeUsername;
                user.date = DateTime.Now; //Stored current Date
                db.Users.Add(user);
                db.SaveChanges(); // Saving Changes

                return RedirectToAction("Index", "user");
            }

            else
            {
                TempData["Userexist"] = "User already exist";
                return RedirectToAction("Index", "user");
            }
        }

        public ActionResult Deleteuser(int? id)
        {
            db.Users.Remove(db.Users.Find(id));
            db.SaveChanges();
            return RedirectToAction("Index", "user");
        }

    }
}