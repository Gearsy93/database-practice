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
    public partial class PricesInsertEdit : Form
    {
        public DateTime PrDate
        {
            get { return dtDate.Value; }
            set { dtDate.Value = value; }
        }

        public string PrPrice
        {
            get { return tbPrice.Text; }
            set { tbPrice.Text = value; }
        }

        public PricesInsertEdit(Mode mode)
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
            if (dtDate.Text == "")
            {
                lbDebug.Text = "Пустое поле \"дата\"";
                return;
            }
            if (tbPrice.Text == "")
            {
                lbDebug.Text = "Пустое поле \"цена\"";
                return;
            }
            double raw;
            if (!Double.TryParse(tbPrice.Text, out raw))
            {
                lbDebug.Text = "Поле \"цена\" не вещ.";
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

        // Помойка
        private void PricesEdit_Load(object sender, EventArgs e)
        {

        }
    }
}
