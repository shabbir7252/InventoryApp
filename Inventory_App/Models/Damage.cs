//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Inventory_App.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Damage
    {
        public int DamageId { get; set; }
        public int InkId { get; set; }
        public System.DateTime Datetime { get; set; }
        public string Serial { get; set; }
        public bool IsDisposed { get; set; }
        public Nullable<System.DateTime> DisposedDateTime { get; set; }
        public bool IsReplaced { get; set; }
        public Nullable<System.DateTime> ReplacedDateTime { get; set; }
        public string Attachment { get; set; }
    
        public virtual InkInventory InkInventory { get; set; }
    }
}
