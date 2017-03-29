using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Inventory_App.Models
{
    public class deviceTypeList
    {
        public deviceTypeList(string v)
        {
            this.DeviceTypeName = v;
        }

        public string DeviceTypeName { get; set; }
    }
}