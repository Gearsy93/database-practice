using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

#nullable disable

namespace ORM
{
    public partial class MealPrice
    {
        public int MealId { get; set; }
        public DateTime OrderDate { get; set; }
        public float MealPrice1 { get; set; }

        public virtual Meal Meal { get; set; }
    }
}
