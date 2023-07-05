
namespace ORM
{
    partial class MealInsertEdit
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
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
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.lbMealName = new System.Windows.Forms.Label();
            this.lbWeight = new System.Windows.Forms.Label();
            this.lbCalories = new System.Windows.Forms.Label();
            this.tbName = new System.Windows.Forms.TextBox();
            this.tbWeight = new System.Windows.Forms.TextBox();
            this.tbCalories = new System.Windows.Forms.TextBox();
            this.btSave = new System.Windows.Forms.Button();
            this.btDiscard = new System.Windows.Forms.Button();
            this.lbDebug = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // lbMealName
            // 
            this.lbMealName.AutoSize = true;
            this.lbMealName.Location = new System.Drawing.Point(12, 9);
            this.lbMealName.Name = "lbMealName";
            this.lbMealName.Size = new System.Drawing.Size(59, 15);
            this.lbMealName.TabIndex = 0;
            this.lbMealName.Text = "Название";
            // 
            // lbWeight
            // 
            this.lbWeight.AutoSize = true;
            this.lbWeight.Location = new System.Drawing.Point(12, 80);
            this.lbWeight.Name = "lbWeight";
            this.lbWeight.Size = new System.Drawing.Size(26, 15);
            this.lbWeight.TabIndex = 1;
            this.lbWeight.Text = "Вес";
            // 
            // lbCalories
            // 
            this.lbCalories.AutoSize = true;
            this.lbCalories.Location = new System.Drawing.Point(12, 149);
            this.lbCalories.Name = "lbCalories";
            this.lbCalories.Size = new System.Drawing.Size(55, 15);
            this.lbCalories.TabIndex = 2;
            this.lbCalories.Text = "Калории";
            // 
            // tbName
            // 
            this.tbName.Location = new System.Drawing.Point(12, 27);
            this.tbName.Name = "tbName";
            this.tbName.Size = new System.Drawing.Size(188, 23);
            this.tbName.TabIndex = 3;
            // 
            // tbWeight
            // 
            this.tbWeight.Location = new System.Drawing.Point(12, 98);
            this.tbWeight.Name = "tbWeight";
            this.tbWeight.Size = new System.Drawing.Size(188, 23);
            this.tbWeight.TabIndex = 4;
            // 
            // tbCalories
            // 
            this.tbCalories.Location = new System.Drawing.Point(12, 167);
            this.tbCalories.Name = "tbCalories";
            this.tbCalories.Size = new System.Drawing.Size(188, 23);
            this.tbCalories.TabIndex = 5;
            // 
            // btSave
            // 
            this.btSave.Location = new System.Drawing.Point(12, 228);
            this.btSave.Name = "btSave";
            this.btSave.Size = new System.Drawing.Size(95, 23);
            this.btSave.TabIndex = 6;
            this.btSave.Text = "Сохранить";
            this.btSave.UseVisualStyleBackColor = true;
            this.btSave.Click += new System.EventHandler(this.btSave_Click);
            // 
            // btDiscard
            // 
            this.btDiscard.Location = new System.Drawing.Point(125, 228);
            this.btDiscard.Name = "btDiscard";
            this.btDiscard.Size = new System.Drawing.Size(75, 23);
            this.btDiscard.TabIndex = 7;
            this.btDiscard.Text = "Отмена";
            this.btDiscard.UseVisualStyleBackColor = true;
            this.btDiscard.Click += new System.EventHandler(this.btDiscard_Click);
            // 
            // lbDebug
            // 
            this.lbDebug.AutoSize = true;
            this.lbDebug.Location = new System.Drawing.Point(33, 210);
            this.lbDebug.Name = "lbDebug";
            this.lbDebug.Size = new System.Drawing.Size(0, 15);
            this.lbDebug.TabIndex = 8;
            this.lbDebug.Click += new System.EventHandler(this.label1_Click);
            // 
            // MealInsertEdit
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(213, 265);
            this.Controls.Add(this.lbDebug);
            this.Controls.Add(this.btDiscard);
            this.Controls.Add(this.btSave);
            this.Controls.Add(this.tbCalories);
            this.Controls.Add(this.tbWeight);
            this.Controls.Add(this.tbName);
            this.Controls.Add(this.lbCalories);
            this.Controls.Add(this.lbWeight);
            this.Controls.Add(this.lbMealName);
            this.Name = "MealInsertEdit";
            this.Text = "Блюдо";
            this.Load += new System.EventHandler(this.MealEdit_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lbMealName;
        private System.Windows.Forms.Label lbWeight;
        private System.Windows.Forms.Label lbCalories;
        private System.Windows.Forms.Button btSave;
        private System.Windows.Forms.Button btDiscard;
        private System.Windows.Forms.Label lbDebug;
        public System.Windows.Forms.TextBox tbName;
        public System.Windows.Forms.TextBox tbWeight;
        public System.Windows.Forms.TextBox tbCalories;
    }
}