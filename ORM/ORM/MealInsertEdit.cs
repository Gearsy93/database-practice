using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ORM
{
    public partial class MealInsertEdit : Form
    {
        public string MlName
        {
            get { return tbName.Text; }
            set { tbName.Text = value; }
        }

        public string MlWeight
        {
            get { return tbWeight.Text; }
            set { tbName.Text = value; }
        }

        public string MlCalories
        {
            get { return tbCalories.Text; }
            set { tbName.Text = value; }
        }

        public MealInsertEdit(Mode mode)
        {
            InitializeComponent();
            switch (mode)
            {
                case Mode.Insert:
                {
                    btSave.Text = "Вставить";
                    break;
                }
                case Mode.Update:
                {
                    btSave.Text = "Обновить";
                    break;
                }
            }

        }

        private void btSave_Click(object sender, EventArgs e)
        {
            if (tbName.Text == "")
            {
                lbDebug.Text = "Пустое поле \"название\"";
                return;
            }
            if (tbWeight.Text == "")
            {
                lbDebug.Text = "Пустое поле \"вес\"";
                return;
            }
            if (tbCalories.Text == "")
            {
                lbDebug.Text = "Пустое поле \"калории\"";
                return;
            }
            double raw;
            if (!Double.TryParse(tbWeight.Text, out raw))
            {
                lbDebug.Text = "Поле \"вес\" не вещ.";
                return;
            }
            if (!Double.TryParse(tbCalories.Text, out raw))
            {
                lbDebug.Text = "Поле \"калории\" не вещ.";
                return;
            }
            this.DialogResult = DialogResult.OK;
            this.Close();
        }

        private void btDiscard_Click(object sender, EventArgs e)
        {
            this.DialogResult = DialogResult.Cancel;
            this.Close();
        }

        //Помойка
        private void MealEdit_Load(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }
    }
}
