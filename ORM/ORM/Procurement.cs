using System;
using System.Collections.Generic;

#nullable disable

namespace ORM
{
    public partial class Procurement
    {
        public Procurement()
        {
            Orders = new HashSet<Order>();
        }

        public int ProcurementId { get; set; }
        public DateTime Date { get; set; }
        public int SupplierId { get; set; }

        public virtual Supplier Supplier { get; set; }
        public virtual ICollection<Order> Orders { get; set; }
    }
}
