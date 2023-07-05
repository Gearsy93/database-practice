using System;
using System.Collections.Generic;

#nullable disable

namespace ORM
{
    public partial class Order
    {
        public int OrderId { get; set; }
        public int ProcurementId { get; set; }
        public int MealId { get; set; }
        public int IngredientId { get; set; }
        public DateTime OrderDate { get; set; }

        public virtual Ingredient Ingredient { get; set; }
        public virtual Meal Meal { get; set; }
        public virtual Procurement Procurement { get; set; }
    }
}
