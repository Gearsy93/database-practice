using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Npgsql;
using Microsoft.EntityFrameworkCore;

namespace ORM
{
    public enum Mode
    {
        Insert,
        Update
    }


    public partial class ORM_Pastry : Form
    {
        public ORM_Pastry()
        {
            InitializeComponent();
            InitializeMealListView();
        }

        private void InitializeMealListView()
        {
            //Шапка для вывода блюд
            lvMeal.Clear();
            lvMeal.Columns.Add("Название");
            lvMeal.Columns.Add("Вес");
            lvMeal.Columns.Add("Калории");

            using (var pst = new pastryContext())
            {
                foreach (var ml in pst.Meals)
                {
                    var lvi = new ListViewItem(new[]
                    {
                        ml.Meal1.ToString(),
                        ml.Weight.ToString(),
                        ml.Calories.ToString()
                    })
                    {
                        Tag = ml
                    };
                    lvMeal.Items.Add(lvi);
                }
            }

            lvMeal.AutoResizeColumns(ColumnHeaderAutoResizeStyle.ColumnContent);
            lvMeal.AutoResizeColumns(ColumnHeaderAutoResizeStyle.HeaderSize);
       }

        private void InitializePricesListView(int MealID)
        {
            lvPrices.Clear();
            lvPrices.Columns.Add("Дата заказа");
            lvPrices.Columns.Add("Цена");

            using (var pst = new pastryContext())
            {
                foreach (var pr in pst.MealPrices)
                {
                    if (pr.MealId == MealID)
                    {
                        var lvi = new ListViewItem(new[]
                        {
                            pr.OrderDate.ToString("dd.MM.yyyy"),
                            pr.MealPrice1.ToString()
                        })
                        {
                            Tag = pr
                        };
                        lvPrices.Items.Add(lvi);
                    }
                }
            }

            lvPrices.AutoResizeColumns(ColumnHeaderAutoResizeStyle.ColumnContent);
            lvPrices.AutoResizeColumns(ColumnHeaderAutoResizeStyle.HeaderSize);
        }

        //Добавить блюдо
        private void btAdd_Click(object sender, EventArgs e)
        {
            var MealForm = new MealInsertEdit(Mode.Insert);
            if (MealForm.ShowDialog() == DialogResult.OK)
            {
                
                using (var pst = new pastryContext())
                {
                    var ml = new Meal
                    {
                        MealId = pst.Meals.Max(Meal => Meal.MealId) + 1,
                        Meal1 = MealForm.MlName,
                        Weight = (float)Convert.ToDouble(MealForm.MlWeight),
                        Calories = (float)Convert.ToDouble(MealForm.MlCalories)

                    };

                    pst.Meals.Add(ml);
                    pst.SaveChanges();

                    var lvi = new ListViewItem(new[]
                    {
                        ml.Meal1.ToString(),
                        ml.Weight.ToString(),
                        ml.Calories.ToString()
                    })
                    {
                        Tag = ml
                    };
                    lvMeal.Items.Add(lvi);
                }
                InitializeMealListView();
            }
            
        }

        // Добавить цену
        private void btAddPrice_Click(object sender, EventArgs e)
        {
            var PriceForm = new PricesInsertEdit(Mode.Insert);
            if (PriceForm.ShowDialog() == DialogResult.OK)
            {
                int MealID = ((Meal)lvMeal.SelectedItems[0].Tag).MealId;
                using (var pst = new pastryContext())
                {
                    var pr = new MealPrice
                    {
                        Meal = pst.Meals.Single(m => m.MealId == MealID),
                        MealId = (int)MealID,
                        OrderDate = PriceForm.PrDate,
                        MealPrice1 = (float)Convert.ToDouble(PriceForm.PrPrice)
                    };

                    pst.MealPrices.Add(pr);
                    pst.SaveChanges();

                    var lvi = new ListViewItem(new[]
                    {
                        pr.MealId.ToString(),
                        pr.OrderDate.ToString("dd.MM.yyyy"),
                        pr.MealPrice1.ToString(),

                    })
                    {
                        Tag = pr
                    };
                    lvPrices.Items.Add(lvi);
                }
                InitializePricesListView(MealID);
            }
        }

        private void lvMeal_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (lvMeal.SelectedItems.Count > 0)
            {
                btAddPrice.Enabled = true;

                int MealID = ((Meal)lvMeal.SelectedItems[0].Tag).MealId;
                InitializePricesListView(MealID);
            }
            else
            {
                btAddPrice.Enabled = false;
            }
        }

        private void btEdit_Click(object sender, EventArgs e)
        {

        }

        private void btDelete_Click(object sender, EventArgs e)
        {
            if (lvMeal.SelectedItems.Count > 0)
            {

            }
        }



        // Помойка
        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void richTextBox1_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
