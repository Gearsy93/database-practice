using System;
using System.Collections.Generic;

#nullable disable

namespace ORM
{
    public partial class Cheque
    {
        public int OrderId { get; set; }
        public int OrderNumber { get; set; }
        public int ManagerId { get; set; }
        public int CustomerId { get; set; }
        public int DeliveryAddressId { get; set; }

        public virtual Customer Customer { get; set; }
        public virtual DeliveryAddress DeliveryAddress { get; set; }
        public virtual Manager Manager { get; set; }
        public virtual Order Order { get; set; }
    }
}
