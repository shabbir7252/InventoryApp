using System;
using System.Collections.Generic;
using System.DirectoryServices.AccountManagement;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Inventory_App.Models;
using System.Data.Entity;
using System.IO;
using System.Net;
using System.Net.Sockets;

namespace Inventory_App.Controllers
{

    [SessionTimeout]
    public class BaseController : Controller
    {

        protected InventoryAppEntities db = new InventoryAppEntities();

        protected List<string> storeNamesList = new List<string>();

        public List<string> SearchEngine(string name, string username)
        {
            List<string> SearchNamesList = new List<string>();

            //SearchNamesList = db.Users.Select(a => a.UserName).ToList();

            using (PrincipalContext ctx = new PrincipalContext(ContextType.Domain, null))
            {
                UserPrincipal qbeUser = new UserPrincipal(ctx);
                if (name != null)
                {
                    qbeUser.Name = name + "*";

                    using (PrincipalSearcher srch = new PrincipalSearcher(qbeUser))
                    {
                        foreach (Principal found in srch.FindAll())
                        {
                            if (found.DisplayName != null)
                            {
                                SearchNamesList.Add(found.DisplayName);
                            }
                        }
                    }
                }

                else
                {
                    qbeUser.SamAccountName = username + "*";

                    using (PrincipalSearcher srch = new PrincipalSearcher(qbeUser))
                    {
                        foreach (Principal found in srch.FindAll())
                        {
                            if (found.SamAccountName != null)
                            {
                                SearchNamesList.Add(found.SamAccountName);
                            }
                        }
                    }
                }
            }
            return SearchNamesList;
        }

        protected void getStoreNames()
        {
            int UserSessionId = int.Parse(Session["UserID"].ToString());
            List<int> userStoreListID = db.StoreUsers.Where(a => a.UserId == UserSessionId && a.IsPermitted == true).Select(a => a.Store_Id).ToList();
            foreach (var items in userStoreListID)
            {
                string StoreName = db.Stores.Single(a => a.Store_Id == items).Store1;
                storeNamesList.Add(StoreName);
            }
        }

        protected void getModelList()
        {
            int UserSessionId = int.Parse(Session["UserID"].ToString());
            List<int> StoreIdList = db.StoreUsers.Where(a => a.UserId == UserSessionId && a.IsPermitted == true).Select(a => a.Store_Id).ToList();
            ViewBag.ModelList = new SelectList(db.InkInventories.Where(a => StoreIdList.Contains(a.Store_Id) && a.Quantity > 0), "InkId", "Model.Model_Name");
        }

        protected void updateQuantity(int inkId, bool action, int quantity)
        {
            InkInventory AddInktoInventory = db.InkInventories.Find(inkId);
            if (action)
                AddInktoInventory.Quantity = AddInktoInventory.Quantity + quantity;
            else
                AddInktoInventory.Quantity = AddInktoInventory.Quantity - quantity;
            db.Entry(AddInktoInventory).State = EntityState.Modified;
            db.SaveChanges(); //Saving Changes
        }

        [HttpPost]
        public int GetQuantity(int Id)
        {
            int maxvalue = db.InkInventories.Single(a => a.InkId == Id).Quantity;
            return maxvalue;
        }

        [HttpPost]
        public JsonResult GetStore(int Id)
        {
            string storeName = db.InkInventories.Single(a => a.InkId == Id).Store.Store1;
            return Json(storeName);
        }

        [HttpPost]
        public JsonResult GetColor(int Id)
        {
            string colorName = db.InkInventories.Single(a => a.InkId == Id).Model.ColorName;
            return Json(colorName);
        }

        public List<string> GetFileList(string pathName)
        {
            List<string> searchFileNamesList = new List<string>();
            if (Directory.Exists(pathName))
            {
                string[] fileEntries = Directory.GetFiles(pathName);
                foreach (string fileName in fileEntries)
                {
                    string fileNamefromPath = Path.GetFileName(fileName);
                    searchFileNamesList.Add(fileNamefromPath);
                }
            }

            return searchFileNamesList;
        }

        //public static string GetLocalIPAddress()
        //{
        //    if (System.Net.NetworkInformation.NetworkInterface.GetIsNetworkAvailable())
        //    {
        //        var host = Dns.GetHostEntry(Dns.GetHostName());
        //        foreach (var ip in host.AddressList)
        //        {
        //            if (ip.AddressFamily == AddressFamily.InterNetwork)
        //            {
        //                return ip.ToString();
        //            }
        //        }
        //        return "Local IP Address Not Found!";
        //    }

        //    return "Network Not Available";
        //}

        protected void updateActivity(string user, DateTime datetime, string activity, string controller, string function)
        {

        }

        protected bool deleteFileName(string AttachmentPath)
        {
            var path = Server.MapPath("~/Content/IssueImage/");
            if (Directory.Exists(path))
            {
                string[] fileEntries = Directory.GetFiles(path);
                foreach (string fileName in fileEntries)
                {
                    string fileNamefromPath = Path.GetFileName(fileName);
                    if (fileNamefromPath == AttachmentPath)
                        System.IO.File.Delete(fileName);
                    else
                        return false;
                }
            }

            return true;
        }
    }

}