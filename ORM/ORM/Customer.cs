using System;
using System.Collections.Generic;

#nullable disable

namespace ORM
{
    public partial class Customer
    {
        public int CustomerId { get; set; }
        public long Phone { get; set; }
        public short SexId { get; set; }
        public string Customer1 { get; set; }

        public virtual Sex Sex { get; set; }
    }
}
