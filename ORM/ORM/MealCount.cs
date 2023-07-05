using System;
using System.Collections.Generic;

#nullable disable

namespace ORM
{
    public partial class MealCount
    {
        public int OrderId { get; set; }
        public int MealId { get; set; }
        public int MealCount1 { get; set; }

        public virtual Meal Meal { get; set; }
        public virtual Order Order { get; set; }
    }
}
