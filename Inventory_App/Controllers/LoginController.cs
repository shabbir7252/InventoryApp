using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Inventory_App.Models;
using System.DirectoryServices;
using System.DirectoryServices.AccountManagement;

namespace Inventory_App.Controllers
{
    public class LoginController : Controller
    {

        InventoryAppEntities db = new InventoryAppEntities();

        [HttpGet]
        public ActionResult Index()
        {
            if(Session["Sessiontimeout"] != null)
            {
                ViewBag.SessionExpire = Session["Sessiontimeout"].ToString();
                Session.Abandon();
            }
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Index(User user, FormCollection formcollection)
        {
            string UserName = user.UserName;
            string Pass = formcollection["password"];

            using (PrincipalContext pc = new PrincipalContext(ContextType.Domain, "PSC"))
            {
                if (UserName != "" || Pass != "")
                {
                    if (pc.ValidateCredentials(UserName, Pass))
                    {
                        UserPrincipal qbeUser = new UserPrincipal(pc);
                        qbeUser.UserPrincipalName = UserName + "*";

                        using (PrincipalSearcher srch = new PrincipalSearcher(qbeUser))
                        {
                            foreach (Principal found in srch.FindAll())
                            {
                                if (found != null)
                                {
                                    int search = db.Users.Where(a => a.UserName == found.SamAccountName).Count();

                                    if (search > 0)
                                    {
                                        Session["LoggedUserFullname"] = found.DisplayName;
                                        Session["IsAdmin"] = db.Users.Single(a => a.UserName == found.SamAccountName).IsAdmin.ToString();
                                        Session["IsSuperAdmin"] = db.Users.Single(a => a.UserName == found.SamAccountName).IsSuperAdmin.ToString();
                                        Session["UserID"] = db.Users.Single(a => a.UserName == found.SamAccountName).UserId;
                                        return RedirectToAction("Index", "Default");
                                    }
                                    else
                                        return View();
                                }
                            }
                        }

                    }

                    else
                    {
                        return View();
                    }
                }

                return View();
            }

            //using (InventoryAppEntities db = new InventoryAppEntities())
            //{

            //    var v = db.Users.Where(a => a.UserName.Equals(user.UserName) && a.IsDeleted == false).FirstOrDefault();

            //    if (v != null)
            //    {
            //        if (v.IsSuperAdmin == true)
            //        {
            //            Session["LoggedUserID"] = v.UserId.ToString();
            //            Session["LoggedUserFullname"] = v.UserName.ToString();
            //            //Session["IsAdmin"] = v.IsAdmin.ToString();
            //            Session["SuperAdmin"] = v.IsSuperAdmin.ToString();
            //            return RedirectToAction("Index", "Default");
            //        }
            //    }

            //    return View();
            //}

        }
    }
}
















//[HttpPost]
//[ValidateAntiForgeryToken]
//public ActionResult Index(User user)
//{

//    string UserName = user.UserName;
//    string Pass = user.Password;

//    using (PrincipalContext pc = new PrincipalContext(ContextType.Domain, null))
//    {
//        if (UserName != "" || Pass != "")
//        {
//            if (pc.ValidateCredentials(UserName, Pass))
//            {
//                Session["LoggedUserFullname"] = UserName;

//                UserPrincipal qbeUser = new UserPrincipal(pc);
//                qbeUser.UserPrincipalName = UserName + "*";

//                using (PrincipalSearcher srch = new PrincipalSearcher(qbeUser))
//                {
//                    foreach (Principal found in srch.FindAll())
//                    {
//                        if (found.DisplayName != null)
//                        {
//                            Session["LoggedUserFullname"] = found.DisplayName;

//                        }
//                    }
//                }

//                return RedirectToAction("Index", "Default");
//            }

//            else
//            {
//                return View();
//            }
//        }

//        return View();
//    }

//}