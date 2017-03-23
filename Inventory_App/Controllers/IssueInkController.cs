﻿
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using System.Data.Entity;
using System.IO;
using Inventory_App.Models;

namespace Inventory_App.Controllers
{
    [SessionTimeout]
    public class IssueInkController : BaseController
    {
        // for displaying the list of Issued Ink in Index view of this controller
        public ActionResult _issuedInkList()
        {
            var listview = db.IssueInks.OrderByDescending(a => a.date).ToList(); // Getting the list of Issued Ink
            return PartialView("_issuedInkList", listview);
        }

        [HttpGet]
        public ActionResult Index()
        {
            ViewBag.YearList = new SelectList(db.Years, "YearID", "Year1");

            //---------------- To set the focus after insertion of data ----------------
            if (TempData["focusKeyId"] != null)
            {
                ViewBag.focusKeyId = TempData["focusKeyId"];
            }
            else
            {
                ViewBag.focusKeyId = null;
            }
            //---------------- To set the focus after insertion of data ----------------

            if (TempData["exception"] != null)
            {
                ViewData["exception"] = TempData["exception"];
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

            getModelList();

            return View();
        }

        [HttpPost]
        public ActionResult Index(IssueInk iInk, FormCollection formCollection)
        {
            string employeeName = formCollection["nameList"]; // got the Value of the Employee textbox from the form and stored in variable of type string
            iInk.Employee = employeeName; //Stored Employee Name
            int InkidNumber = int.Parse(formCollection["modelList"]);
            iInk.InkId = InkidNumber;
            updateQuantity(InkidNumber, false, iInk.Quantity);
            iInk.date = DateTime.Now;
            db.IssueInks.Add(iInk); //Adding iInk Model to pass data in database
            db.SaveChanges(); // Saving Changes
            return View();
        }

        [HttpPost]
        public int GetQuantity(int Id)
        {
            int maxvalue = db.AddInktoStores.Single(a => a.InkId == Id).Quantity;
            return maxvalue;
        }

        public ActionResult SearchEmployee(string text)
        {
            List<string> SearchNamesList = new List<string>();
            var DisplayName = text;
            SearchNamesList = SearchEngine(DisplayName, null);
            if (SearchNamesList.Count() > 0)
            {
                TempData["nameList"] = new SelectList(SearchNamesList);
                return RedirectToAction("Index", "IssueInk");
            }
            else
            {
                //TempData["nameList"] = null;
                return RedirectToAction("Index", "IssueInk");
            }
        }

        // Attach function does not upload the file to the server. It is kust to open the modal window for for upload and viewing documents
        public ActionResult Attach(int? id)
        {
            TempData["InkIdforAttachment"] = id;
            var path = Server.MapPath("~/Content/IssueImage/");
            List<string> ListofIssueImages = GetFileList(path);
            TempData["searchFileNamesList"] = new SelectList(ListofIssueImages);
            TempData["focusKeyId"] = id;
            return RedirectToAction("Index", "IssueInk");
        }

        // FileUpload function upload the file to the server in the folder Content>IssueImage
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


        #region Delete_Issue_Ink

        // To delete the issued ink and adding back ink(Quantity) to the store
        public ActionResult DeleteIssueInk(int? id)
        {
            try
            {
                if (id == null)
                {
                    throw new ArgumentNullException();
                }

                string dbAttachmentPath = db.IssueInks.Single(a => a.IssueInkId == id).Attachment;

                if (dbAttachmentPath != null) // if the attachment path is null then delete the issue ink directly
                {
                    int fileCount = db.IssueInks.Where(a => a.Attachment == dbAttachmentPath).Count();
                    if (fileCount >= 2) // if files are more than 1 then only delete the issued Ink. We are not deleting the Attachment as there are more reference to the same file
                    {
                        DropIssueInk(id); // function call to delete the issue ink without deleting attachment
                    }

                    else
                    {
                        var path = Server.MapPath("~/Content/IssueImage/");
                        if (Directory.Exists(path))
                        {
                            string[] fileEntries = Directory.GetFiles(path);
                            foreach (string fileName in fileEntries)
                            {
                                string fileNamePath = Path.GetFileName(fileName);
                                if (fileNamePath == dbAttachmentPath)
                                {
                                    DropIssueInk(id); //function call to delete the issue ink after deleting attachment
                                    System.IO.File.Delete(fileName); // Delete the file from folder
                                }
                            }
                        }

                    }
                }

                else
                {
                    DropIssueInk(id);
                }
            }

            catch (ArgumentNullException e) // catching the null ID exception 
            {
                TempData["exception"] = e.Message + e.StackTrace; //TempData to pass the data from one function to another within controller--- passing to index function
            }

            catch (Exception e)
            {
                TempData["exception"] = e.Message;
            }

            return RedirectToAction("Index", "IssueInk");

        }

        public void DropIssueInk(int? Id)
        {
            IssueInk issueInk = db.IssueInks.Find(Id);
            updateQuantity(issueInk.InkId, true, issueInk.Quantity); // adding the ink back to store - as we are passing true in operations
            db.IssueInks.Remove(issueInk);
            db.SaveChanges();
        } 

        #endregion

    }
}

