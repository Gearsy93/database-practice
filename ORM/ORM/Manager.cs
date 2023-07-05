using System;
using System.Collections.Generic;

#nullable disable

namespace ORM
{
    public partial class Manager
    {
        public int ManagerId { get; set; }
        public string Manager1 { get; set; }
        public long Phone { get; set; }
        public short SexId { get; set; }

        public virtual Sex Sex { get; set; }
    }
}
