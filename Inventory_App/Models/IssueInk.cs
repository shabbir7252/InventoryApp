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
    
    public partial class IssueInk
    {
        public int IssueInkId { get; set; }
        public string Employee { get; set; }
        public int InkId { get; set; }
        public System.DateTime date { get; set; }
        public int YearID { get; set; }
        public int Quantity { get; set; }
        public string Attachment { get; set; }
    
        public virtual InkInventory InkInventory { get; set; }
        public virtual Year Year { get; set; }
    }
}
