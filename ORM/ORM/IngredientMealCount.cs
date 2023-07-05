using System;
using System.Collections.Generic;

#nullable disable

namespace ORM
{
    public partial class IngredientMealCount
    {
        public int MealId { get; set; }
        public int IngredientId { get; set; }
        public int IngredientMealCount1 { get; set; }

        public virtual Ingredient Ingredient { get; set; }
        public virtual Meal Meal { get; set; }
    }
}
