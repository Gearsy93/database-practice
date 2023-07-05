using System;
using System.Collections.Generic;

#nullable disable

namespace ORM
{
    public partial class Meal
    {
        public Meal()
        {
            Orders = new HashSet<Order>();
            MealPrices = new HashSet<MealPrice>();
        }


        public int MealId { get; set; }
        public string Meal1 { get; set; }
        public float Weight { get; set; }
        public float Calories { get; set; }

        public virtual ICollection<Order> Orders { get; set; }
        public virtual ICollection<MealPrice> MealPrices { get; set; }
    }
}
