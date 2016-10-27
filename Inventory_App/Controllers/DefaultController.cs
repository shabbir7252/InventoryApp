using Inventory_App.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace Inventory_App.Controllers
{
    public class DefaultController : Controller
    {
        InventoryAppEntities db = new InventoryAppEntities();

        // ------------------------------------------------------------------------- Dashboard -------------------------------------------------------------------------
        public ActionResult Index()
        {
            if (Session["LoggedUserFullname"] == null)
            {
                Session.Abandon();
                return RedirectToAction("Index", "Login");
            }
            return View();
        }


        public ActionResult logout()
        {
            Session.Abandon();
            return RedirectToAction("Index", "Login");
        }

    }

}