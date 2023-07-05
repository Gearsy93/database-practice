using System;
using System.Collections.Generic;

#nullable disable

namespace ORM
{
    public partial class Supplier
    {
        public Supplier()
        {
            Procurements = new HashSet<Procurement>();
        }

        public int SupplierId { get; set; }
        public string Supplier1 { get; set; }
        public long Phone { get; set; }
        public short SexId { get; set; }

        public virtual Sex Sex { get; set; }
        public virtual ICollection<Procurement> Procurements { get; set; }
    }
}
