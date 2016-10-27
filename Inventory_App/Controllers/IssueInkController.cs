using Inventory_App.Models;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.DirectoryServices;
using System.DirectoryServices.AccountManagement;
using System.Data.Entity;
using System.Net;
using System.IO;

namespace Inventory_App.Controllers
{
    public class IssueInkController : Controller
    {

        InventoryAppEntities db = new InventoryAppEntities();

        public ActionResult _issuedInkList()
        {
            var listview = db.IssueInks.OrderByDescending(a => a.date).ToList();
            return PartialView("_issuedInkList", listview);
        }

        [HttpGet]
        public ActionResult Index()
        {

            ViewBag.YearList = new SelectList(db.Years, "YearID", "Year1");


            if (TempData["focusKeyId"] != null)
            {
                ViewBag.focusKeyId = TempData["focusKeyId"];
            }

            else
            {
                ViewBag.focusKeyId = null;
            }

            if (TempData["NullExist"] != null)
            {
                ViewData["NullExist"] = TempData["NullExist"];
            }

            if (TempData["searchFileNamesList"] != null)
            {
                ViewData["searchFileNamesList"] = TempData["searchFileNamesList"];
            }

            if (TempData["ImageExist"] != null)
            {
                ViewBag.ImageExist = TempData["ImageExist"];
            }

            if (TempData["InkIdforAttachment"] != null)
            {
                ViewBag.id = TempData["InkIdforAttachment"];
            }

            if (TempData["nameList"] != null)
            {
                ViewData["nameList"] = TempData["nameList"];
            }

            List<AddInktoStore> AITS = db.AddInktoStores.Where(a => a.Quantity > 0).ToList();

            List<Model> mdels = AITS.Select(s => s.Model).ToList();

            List<string> modelNames = mdels.Select(m => m.Model_Name).ToList();

            ViewData["InkList"] = new SelectList(modelNames);

            return View();
        }

        [HttpPost]
        public ActionResult Index(IssueInk iInk, FormCollection formCollection)
        {
            string employeeName = formCollection["nameList"]; // got the Value of the Employee textbox from the form and stored in variable of type string
            iInk.Employee = employeeName; //Stored Employee Name

            string inkModelName = formCollection["InkList"]; // got the value of Model Name TextBox from the form and stored in variable of type string

            //ViewBag.modelName = inkModelName; // Getting the Model Name in viewbag for display List in View 

            int modelNumber = db.Models.Single(a => a.Model_Name == inkModelName).Model_Id; // got the model Id by Matching the Model Name from the Database value and inkModelName variable Above line

            //ViewBag.modelColor = db.Models.Single(a => a.Model_Name == inkModelName).Color.Color_Name; // Getting the Color Name of This Model in viewbag for display List in View 
            //ViewBag.modelBrand = db.Models.Single(a => a.Model_Name == inkModelName).Brand.Brand_Name; // Getting the Color Name of This Model in viewbag for display List in View 

            int InkidNumber = db.AddInktoStores.Single(a => a.Model_Id == modelNumber).InkId; // got the InkId from the Ink Store by matching the Model ID we got from above Line
            iInk.InkId = InkidNumber; //Stored InkID

            //Stored Issue quantity Directly as from the iInk.Quantity
            //and Now we update the Store quantity by subtracting its total quantity by Issued Quantity
            updateQuantity(InkidNumber, iInk.Quantity); // Seprate Method Call to Update Quantity

            iInk.date = DateTime.Now; //Stored current Date

            //Stored Year Directly as from the iInk.YearId
            db.IssueInks.Add(iInk); //Adding iInk Model to pass data in database
            db.SaveChanges(); // Saving Changes

            return View();
        }

        private void updateQuantity(int InkId, int IssueQuantity)
        {
            AddInktoStore AddInktoStore = db.AddInktoStores.Find(InkId); // finding the row which matches the InkId which we found above
            AddInktoStore.Quantity = AddInktoStore.Quantity - IssueQuantity; // Substracting the Quantity in store as we are issuing the Ink(Quantity)
            db.Entry(AddInktoStore).State = EntityState.Modified; // Storing changes in Store Table
            db.SaveChanges(); //Saving Changes
        }

        [HttpPost]
        public int GetQuantity(string text)
        {
            if (text != "")
            {
                List<Model> mdl = db.Models.Where(a => a.Model_Name == text).ToList();
                int modelID = int.Parse(mdl.Single().Model_Id.ToString());
                AddInktoStore AITS = db.AddInktoStores.Single(a => a.Model_Id == modelID);
                int maxvalue = int.Parse(AITS.Quantity.ToString());
                return maxvalue;
            }

            return 0;
        }


        public ActionResult SearchEmployee(string text)
        {
            List<string> SearchNamesList = new List<string>();
            var DisplayName = text;
            SearchNamesList = SearchEngine(DisplayName);
            //ViewBag.data = SearchNamesList;
            if (SearchNamesList.Count() > 0)
            {
                TempData["nameList"] = new SelectList(SearchNamesList);
                return RedirectToAction("Index", "IssueInk");
            }
            else
            {
                TempData["nameList"] = null;
                return RedirectToAction("Index", "IssueInk");
            }
        }

        public List<string> SearchEngine(string name)
        {
            List<string> SearchNamesList = new List<string>();

            //SearchNamesList = db.Users.Select(a => a.UserName).ToList();

            using (PrincipalContext ctx = new PrincipalContext(ContextType.Domain, "psc"))
            {
                UserPrincipal qbeUser = new UserPrincipal(ctx);
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
            return SearchNamesList;
        }


        public ActionResult LinkUpdate(FormCollection formCollection)
        {
            int InkId = int.Parse(formCollection["linkAttachmentID"]);
            var imgName = formCollection["searchFileNamesList"];
            IssueInk issueInk = db.IssueInks.Find(InkId);
            issueInk.Attachment = imgName;
            db.Entry(issueInk).State = EntityState.Modified;
            db.SaveChanges(); //Saving Changes
            return RedirectToAction("Index", "IssueInk");
        }

        [HttpPost]
        public ActionResult fileUpload(FormCollection formCollection)
        {
            int InkId = int.Parse(formCollection["AttachmentID"]);
            if (Request.Files.Count > 0)
            {
                var file = Request.Files[0];

                if (file != null && file.ContentLength > 0)
                {
                    var fileName = Path.GetFileName(file.FileName);
                    var path = Path.Combine(Server.MapPath("~/Content/IssueImage/"), fileName);

                    if (System.IO.File.Exists(path))
                    {
                        TempData["ImageExist"] = "ImageExist";
                        return RedirectToAction("Index", "IssueInk");
                    }
                    else
                    {

                        file.SaveAs(path);
                        IssueInk issueInk = db.IssueInks.Find(InkId);
                        issueInk.Attachment = fileName;
                        db.Entry(issueInk).State = EntityState.Modified;
                        db.SaveChanges(); //Saving Changes
                    }

                }
            }

            return RedirectToAction("Index", "IssueInk");
        }

        public ActionResult Attach(int? id)
        {
            TempData["InkIdforAttachment"] = id;
            var path = Server.MapPath("~/Content/IssueImage/");
            List<string> ListofIssueImages = GetFileList(path);
            TempData["searchFileNamesList"] = new SelectList(ListofIssueImages);
            TempData["focusKeyId"] = id;
            return RedirectToAction("Index", "IssueInk");
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


        public ActionResult deleteFile(int id)
        {
            string dbfileName = db.IssueInks.Single(a => a.IssueInkId == id).Attachment;
            int fileCount = db.IssueInks.Where(a => a.Attachment == dbfileName).Count();

            if (fileCount > 1)
            {
                IssueInk issueInk = db.IssueInks.Find(id);
                issueInk.Attachment = null;
                db.Entry(issueInk).State = EntityState.Modified;
                db.SaveChanges(); //Saving Changes
            }
            else
            {
                var path = Server.MapPath("~/Content/IssueImage/");
                if (Directory.Exists(path))
                {
                    string[] fileEntries = Directory.GetFiles(path);
                    foreach (string fileName in fileEntries)
                    {
                        string fileNamefromPath = Path.GetFileName(fileName);
                        if (fileNamefromPath == dbfileName)
                        {
                            System.IO.File.Delete(fileName);
                            IssueInk issueInk = db.IssueInks.Find(id);
                            issueInk.Attachment = null;
                            db.Entry(issueInk).State = EntityState.Modified;
                            db.SaveChanges(); //Saving Changes
                        }
                    }
                }
            }

            TempData["focusKeyId"] = id;
            return RedirectToAction("Index", "IssueInk");
        }

        public ActionResult DeleteIssueInk(int? id)
        {

            if (id == null)
            {
                TempData["NullExist"] = "NullExist";
                return RedirectToAction("Index", "IssueInk");
            }

            else
            {
                string dbfileName = db.IssueInks.Single(a => a.IssueInkId == id).Attachment;
                if (dbfileName != null)
                {
                    int fileCount = db.IssueInks.Where(a => a.Attachment == dbfileName).Count();
                    if (fileCount >= 2)
                    {
                        DeleteInkfromStoreProcedure(id);
                    }

                    else
                    {
                        var path = Server.MapPath("~/Content/IssueImage/");
                        if (Directory.Exists(path))
                        {
                            string[] fileEntries = Directory.GetFiles(path);
                            foreach (string fileName in fileEntries)
                            {
                                string fileNamefromPath = Path.GetFileName(fileName);
                                if (fileNamefromPath == dbfileName)
                                {
                                    DeleteInkfromStoreProcedure(id);
                                    System.IO.File.Delete(fileName);
                                }
                            }
                        }

                    }
                }

                else
                {
                    DeleteInkfromStoreProcedure(id);
                }
            }

            return RedirectToAction("Index", "IssueInk");
        }

        public void DeleteInkfromStoreProcedure(int? Id)
        {
            IssueInk issueInk = db.IssueInks.Find(Id);
            int InkId = issueInk.InkId;
            int issueQuantity = issueInk.Quantity;

            AddInktoStore AddInktoStore = db.AddInktoStores.Find(InkId); // finding the row which matches the InkId which we found above
            AddInktoStore.Quantity = AddInktoStore.Quantity + issueQuantity; // Substracting the Quantity in store as we are issuing the Ink(Quantity)
            db.Entry(AddInktoStore).State = EntityState.Modified; // Storing changes in Store Table
            db.SaveChanges(); //Saving Changes

            db.IssueInks.Remove(issueInk);
            db.SaveChanges();
        }

    }
}

