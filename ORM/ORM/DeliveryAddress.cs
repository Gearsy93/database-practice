using System;
using System.Collections.Generic;

#nullable disable

namespace ORM
{
    public partial class DeliveryAddress
    {
        public int DeliveryAddressId { get; set; }
        public string City { get; set; }
        public string Address { get; set; }
        public int Index { get; set; }
    }
}
