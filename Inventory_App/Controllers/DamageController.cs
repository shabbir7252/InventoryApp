using Inventory_App.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Inventory_App.Controllers
{
    [SessionTimeout]
    public class DamageController : BaseController
    {
        public ActionResult _damageInkList()
        {
            var listview = db.Damages.Where(a => a.IsDisposed == false && a.IsReplaced == false).OrderByDescending(a => a.Datetime).ToList();
            return PartialView("_damageInkList", listview);
        }

        public ActionResult _replacedDamagedInkList()
        {
            var listview = db.Damages.Where(a => a.IsDisposed == false && a.IsReplaced == true).OrderByDescending(a => a.Datetime).ToList();
            return PartialView("_replacedDamagedInkList", listview);
        }

        public ActionResult _DisposeDamagedInkList()
        {
            var listview = db.Damages.Where(a => a.IsDisposed == true && a.IsReplaced == false).OrderByDescending(a => a.Datetime).ToList();
            return PartialView("_DisposeDamagedInkList", listview);
        }

        [HttpGet]
        public ActionResult Index()
        {
            if (TempData["focusKeyId"] != null)
                ViewBag.focusKeyId = TempData["focusKeyId"];
            else
                ViewBag.focusKeyId = null;

            if (TempData["searchFileNamesList"] != null)
                ViewData["searchFileNamesList"] = TempData["searchFileNamesList"];

            if (TempData["DamageIdforAttachment"] != null)
                ViewBag.id = TempData["DamageIdforAttachment"];

            if (TempData["ImageExist"] != null)
                ViewBag.ImageExist = TempData["ImageExist"];

            getModelList();
            return View();
        }

        [HttpPost]
        public ActionResult Index(FormCollection formcollection, Damage damage)
        {
            getModelList();

            int Inkid = int.Parse(formcollection["ModelList"]);
            DateTime datetime = DateTime.Parse(formcollection["datetimepicker"]);

            updateQuantity(Inkid, false, 1);

            damage.IsDisposed = false;
            damage.IsReplaced = false;
            damage.InkId = Inkid;
            damage.Datetime = datetime;
            db.Damages.Add(damage);
            db.SaveChanges();

            return RedirectToAction("Index");
        }

        public ActionResult deleteDamagedInk(int id)
        {
            Damage damageInk = db.Damages.Find(id);
            updateQuantity(damageInk.InkId, true, 1);
            db.Damages.Remove(damageInk);
            db.SaveChanges();


            return RedirectToAction("Index");
        }

        public ActionResult disposeDamagedInk(int id)
        {
            Damage damageInk = db.Damages.Find(id);
            damageInk.DisposedDateTime = DateTime.Now;
            damageInk.IsDisposed = true;
            damageInk.IsReplaced = false;
            db.Entry(damageInk).State = EntityState.Modified;
            db.SaveChanges(); //Saving Changes
            return RedirectToAction("Index");
        }

        public ActionResult Attach(int id)
        {
            TempData["DamageIdforAttachment"] = id;
            var path = Server.MapPath("~/Content/damageInkImage/");
            List<string> ListofDamageImages = GetFileList(path);
            TempData["searchFileNamesList"] = new SelectList(ListofDamageImages);
            TempData["focusKeyId"] = id;
            return RedirectToAction("Index", "Damage");
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
                    var path = Path.Combine(Server.MapPath("~/Content/damageInkImage/"), fileName);

                    if (System.IO.File.Exists(path))
                    {
                        TempData["ImageExist"] = "ImageExist";
                        return RedirectToAction("Index", "Damage");
                    }
                    else
                    {

                        file.SaveAs(path);
                        Damage damage = db.Damages.Find(InkId);
                        damage.Attachment = fileName;
                        damage.IsReplaced = true;
                        damage.IsDisposed = false;
                        damage.ReplacedDateTime = DateTime.Now;
                        int StoreInkId = db.Damages.Single(a => a.DamageId == InkId).InkId;
                        updateQuantity(StoreInkId, true, 1);
                        db.Entry(damage).State = EntityState.Modified;
                        db.SaveChanges(); //Saving Changes
                    }

                }
            }

            return RedirectToAction("Index", "Damage");
        }

        public ActionResult LinkUpdate(FormCollection formCollection)
        {
            int InkId = int.Parse(formCollection["linkAttachmentID"]);
            var imgName = formCollection["searchFileNamesList"];
            Damage damage = db.Damages.Find(InkId);
            damage.Attachment = imgName;
            damage.IsReplaced = true;
            damage.IsDisposed = false;
            damage.ReplacedDateTime = DateTime.Now;
            int StoreInkId = db.Damages.Single(a => a.DamageId == InkId).InkId;
            updateQuantity(StoreInkId, true, 1);
            db.Entry(damage).State = EntityState.Modified;
            db.SaveChanges(); //Saving Changes
            return RedirectToAction("Index", "Damage");
        }

        public ActionResult replacedDamagedInk()
        {
            return View();
        }

        public ActionResult disposedDamagedInk()
        {
            return View();
        }
    }
}