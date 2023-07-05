
namespace ORM
{
    partial class ORM_Pastry
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.lvMeal = new System.Windows.Forms.ListView();
            this.lvPrices = new System.Windows.Forms.ListView();
            this.lbMeal = new System.Windows.Forms.Label();
            this.lbPrices = new System.Windows.Forms.Label();
            this.btEdit = new System.Windows.Forms.Button();
            this.btDelete = new System.Windows.Forms.Button();
            this.btAddMeal = new System.Windows.Forms.Button();
            this.debug = new System.Windows.Forms.TextBox();
            this.btAddPrice = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // lvMeal
            // 
            this.lvMeal.FullRowSelect = true;
            this.lvMeal.HideSelection = false;
            this.lvMeal.Location = new System.Drawing.Point(12, 38);
            this.lvMeal.Name = "lvMeal";
            this.lvMeal.Size = new System.Drawing.Size(510, 160);
            this.lvMeal.TabIndex = 0;
            this.lvMeal.UseCompatibleStateImageBehavior = false;
            this.lvMeal.View = System.Windows.Forms.View.Details;
            this.lvMeal.SelectedIndexChanged += new System.EventHandler(this.lvMeal_SelectedIndexChanged);
            // 
            // lvPrices
            // 
            this.lvPrices.FullRowSelect = true;
            this.lvPrices.HideSelection = false;
            this.lvPrices.Location = new System.Drawing.Point(12, 241);
            this.lvPrices.Name = "lvPrices";
            this.lvPrices.Size = new System.Drawing.Size(510, 151);
            this.lvPrices.TabIndex = 1;
            this.lvPrices.UseCompatibleStateImageBehavior = false;
            this.lvPrices.View = System.Windows.Forms.View.Details;
            // 
            // lbMeal
            // 
            this.lbMeal.AutoSize = true;
            this.lbMeal.Location = new System.Drawing.Point(248, 20);
            this.lbMeal.Name = "lbMeal";
            this.lbMeal.Size = new System.Drawing.Size(44, 15);
            this.lbMeal.TabIndex = 3;
            this.lbMeal.Text = "Блюдо";
            // 
            // lbPrices
            // 
            this.lbPrices.AutoSize = true;
            this.lbPrices.Location = new System.Drawing.Point(223, 223);
            this.lbPrices.Name = "lbPrices";
            this.lbPrices.Size = new System.Drawing.Size(94, 15);
            this.lbPrices.TabIndex = 4;
            this.lbPrices.Text = "Цены на блюдо";
            // 
            // btEdit
            // 
            this.btEdit.Location = new System.Drawing.Point(309, 413);
            this.btEdit.Name = "btEdit";
            this.btEdit.Size = new System.Drawing.Size(109, 23);
            this.btEdit.TabIndex = 5;
            this.btEdit.Text = "Редактировать";
            this.btEdit.UseVisualStyleBackColor = true;
            this.btEdit.Click += new System.EventHandler(this.btEdit_Click);
            // 
            // btDelete
            // 
            this.btDelete.Location = new System.Drawing.Point(447, 413);
            this.btDelete.Name = "btDelete";
            this.btDelete.Size = new System.Drawing.Size(75, 23);
            this.btDelete.TabIndex = 6;
            this.btDelete.Text = "Удалить";
            this.btDelete.UseVisualStyleBackColor = true;
            this.btDelete.Click += new System.EventHandler(this.btDelete_Click);
            // 
            // btAddMeal
            // 
            this.btAddMeal.Location = new System.Drawing.Point(12, 413);
            this.btAddMeal.Name = "btAddMeal";
            this.btAddMeal.Size = new System.Drawing.Size(114, 23);
            this.btAddMeal.TabIndex = 2;
            this.btAddMeal.Text = "Добавить Блюдо";
            this.btAddMeal.UseVisualStyleBackColor = true;
            this.btAddMeal.Click += new System.EventHandler(this.btAdd_Click);
            // 
            // debug
            // 
            this.debug.Location = new System.Drawing.Point(12, 451);
            this.debug.Name = "debug";
            this.debug.Size = new System.Drawing.Size(100, 23);
            this.debug.TabIndex = 7;
            // 
            // btAddPrice
            // 
            this.btAddPrice.Enabled = false;
            this.btAddPrice.Location = new System.Drawing.Point(155, 413);
            this.btAddPrice.Name = "btAddPrice";
            this.btAddPrice.Size = new System.Drawing.Size(120, 23);
            this.btAddPrice.TabIndex = 8;
            this.btAddPrice.Text = "Добавить цену";
            this.btAddPrice.UseVisualStyleBackColor = true;
            this.btAddPrice.Click += new System.EventHandler(this.btAddPrice_Click);
            // 
            // ORM_Pastry
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(534, 486);
            this.Controls.Add(this.btAddPrice);
            this.Controls.Add(this.debug);
            this.Controls.Add(this.btDelete);
            this.Controls.Add(this.btEdit);
            this.Controls.Add(this.lbPrices);
            this.Controls.Add(this.lbMeal);
            this.Controls.Add(this.btAddMeal);
            this.Controls.Add(this.lvPrices);
            this.Controls.Add(this.lvMeal);
            this.Name = "ORM_Pastry";
            this.Text = "ORM";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ListView lvMeal;
        private System.Windows.Forms.ListView lvPrices;
        private System.Windows.Forms.Label lbMeal;
        private System.Windows.Forms.Label lbPrices;
        private System.Windows.Forms.Button btEdit;
        private System.Windows.Forms.Button btDelete;
        private System.Windows.Forms.Button btAddMeal;
        private System.Windows.Forms.TextBox debug;
        private System.Windows.Forms.Button btAddPrice;
    }
}

