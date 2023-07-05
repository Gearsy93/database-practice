using System;
using System.Collections.Generic;

#nullable disable

namespace ORM
{
    public partial class Sex
    {
        public Sex()
        {
            Customers = new HashSet<Customer>();
            Managers = new HashSet<Manager>();
            Suppliers = new HashSet<Supplier>();
        }

        public short SexId { get; set; }
        public string Sex1 { get; set; }

        public virtual ICollection<Customer> Customers { get; set; }
        public virtual ICollection<Manager> Managers { get; set; }
        public virtual ICollection<Supplier> Suppliers { get; set; }
    }
}
