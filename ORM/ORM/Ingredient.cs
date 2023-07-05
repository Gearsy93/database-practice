using System;
using System.Collections.Generic;

#nullable disable

namespace ORM
{
    public partial class Ingredient
    {
        public Ingredient()
        {
            Orders = new HashSet<Order>();
        }

        public int IngredientId { get; set; }
        public string Ingredient1 { get; set; }
        public string CountryOrigin { get; set; }
        public string Measurement { get; set; }
        public float Weight { get; set; }

        public virtual ICollection<Order> Orders { get; set; }
    }
}
