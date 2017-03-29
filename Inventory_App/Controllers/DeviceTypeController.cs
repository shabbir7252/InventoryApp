using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using Inventory_App.Models;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.IO;

namespace Inventory_App.Controllers
{
    public class DeviceTypeController : Controller
    {
        // GET: DeviceType
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public void Index(FormCollection oformCollection)
        {
            string TypeName = oformCollection["DeviceTypeName"];

            //deviceTypeList odeviceTypeList = new deviceTypeList() {
            //    DeviceTypeName = TypeName
            //};

            //using (StreamWriter file =  System.IO.File.CreateText(Server.MapPath("~/App_Data/deviceType.json")))
            //    {
            //        JsonSerializer serializer = new JsonSerializer();
            //        serializer.Serialize(file, odeviceTypeList);
            //    }

            var jsonPath = Server.MapPath("~/App_Data/deviceType.json");
            string file = System.IO.File.ReadAllText(jsonPath);
            var list = JsonConvert.DeserializeObject<List<deviceTypeList>>(file);
            list.Add(new deviceTypeList(TypeName));
            var convertedJson = JsonConvert.SerializeObject(list, Formatting.Indented);
            System.IO.File.WriteAllText(jsonPath, convertedJson);
        }
    }
}