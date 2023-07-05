using System;
using System.Data.SqlClient;
using System.Windows.Forms;
using System.Xml.Schema;
using static System.Int32;

namespace Data_Grid_View
{
    public partial class FormMain : Form
    {
        private SqlConnection SConn { get; }

        public FormMain()
        {
            SConn = new SqlConnection(
                new SqlConnectionStringBuilder
                {
                    DataSource = ".",
                    InitialCatalog = "Morgue",
                    IntegratedSecurity = true
                }.ConnectionString);

            InitializeComponent();
            InitializeDgv();
        }

        private void InitializeDgv()
        {
            InitializeDgvPatients();
            InitializeDgvStuff();
        }

        private void InitializeDgvPatients()
        {
            dgvPatients.Columns.Add("id", "id");
            dgvPatients.Columns[0].Visible = false;
            dgvPatients.Columns.Add("firstName", "Имя");
            dgvPatients.Columns.Add("secondName", "Фамилия");
            dgvPatients.Columns.Add("age", "Возраст");
            dgvPatients.Columns.Add(new CalendarColumn
            {
                Name = "deathDate",
                HeaderText = @"Дата смерти"
            });
            SConn.Open();
                var sCommand = new SqlCommand
                {
                    Connection = SConn,
                    CommandText = @"SELECT [id], [firstName], [secondName], [age], [deathDate]
                                    FROM [dbo].[Patients]"
                };
                var reader = sCommand.ExecuteReader();
                while (reader.Read())
                {
                    dgvPatients.Rows.Add(reader["id"], reader["firstName"], reader["secondName"], reader["age"],
                        reader["deathDate"]);
                }
            SConn.Close();
        }

        private void InitializeDgvStuff()
        {
            dgvStuff.Columns.Add("id", "id");
            dgvStuff.Columns[0].Visible = false;
            dgvStuff.Columns.Add("firstName", "Имя");
            dgvStuff.Columns.Add("secondName", "Фамилия");
            dgvStuff.Columns.Add("age", "Возраст");
            dgvStuff.Columns.Add(new CalendarColumn
            {
                Name = "employmentDate",
                HeaderText = @"Дата поступления на работу"
            });
            SConn.Open();
                var sCommand = new SqlCommand
                {
                    Connection = SConn,
                    CommandText = @"SELECT [id], [firstName], [secondName], [age], [employmentDate]
                                    FROM [dbo].[Stuff]"
                };
                var reader = sCommand.ExecuteReader();
                while (reader.Read())
                {
                    dgvStuff.Rows.Add(reader["id"], reader["firstName"], reader["secondName"], reader["age"],
                        reader["employmentDate"]);
                }
            SConn.Close();
        }

        private void dgvPatients_CellValueChanged(object sender, DataGridViewCellEventArgs e)
        {
            CellValueChanged(dgvPatients,e);
        }

        private void dgvStuff_CellValueChanged(object sender, DataGridViewCellEventArgs e)
        {
            CellValueChanged(dgvStuff,e);
        }

        private void dgvPatients_UserDeletingRow(object sender, DataGridViewRowCancelEventArgs e)
        {
            DeletingRow(dgvPatients, e);
        }

        private void dgvStuff_UserDeletingRow(object sender, DataGridViewRowCancelEventArgs e)
        {
            DeletingRow(dgvStuff, e);
        }

        private void dgvPatients_RowValidating(object sender, DataGridViewCellCancelEventArgs e)
        {
           UpdateInsertRow(dgvPatients,e);
        }

        private void dgvStuff_RowValidating(object sender, DataGridViewCellCancelEventArgs e)
        {
            UpdateInsertRow(dgvStuff,e);
        }

        private static void CellValueChanged(DataGridView dgv, DataGridViewCellEventArgs e)
        {
            if (!dgv.Rows[e.RowIndex].IsNewRow)
                dgv[e.ColumnIndex, e.RowIndex].ErrorText = "Value is not saved yet";
        }

        private void DeletingRow(Control dgv, DataGridViewRowCancelEventArgs e)
        {
            var dataBase = dgv.Name == "dgvStuff" ? "Stuff" : "Patients";
            var id = (int?)e.Row.Cells["id"].Value;
            if (!id.HasValue) return;
            SConn.Open();
            var sCommand = new SqlCommand
            {
                Connection = SConn,
                CommandText = @"DELETE FROM [dbo].[" + dataBase + "] WHERE id = @id"
            };
            sCommand.Parameters.AddWithValue("@id", id.Value);
            sCommand.ExecuteNonQuery();
            SConn.Close();
        }

        private void UpdateInsertRow(DataGridView dgv, DataGridViewCellCancelEventArgs e)
        {
            var dataBase = dgv.Name == "dgvStuff" ? "Stuff" : "Patients";
            var nameOfDateColumn = dgv.Name == "dgvStuff" ? "employmentDate" : "deathDate";
            var row = dgv.Rows[e.RowIndex];
            if (!dgv.IsCurrentRowDirty) return;
            var dangerousCells = new[]
                { row.Cells["firstName"], row.Cells["secondName"], row.Cells["age"] };
            foreach (var cell in dangerousCells)
            {
                if (cell.OwningColumn.HeaderText == @"Возраст")
                {
                    if (cell.Value == null)
                    {
                        row.ErrorText = "Age must be non-zero";
                        e.Cancel = true;
                        break;
                    }

                    if (cell.Value is int i)
                    {
                        if (i > 0) continue;
                        row.ErrorText = "Age must be positive";
                        e.Cancel = true;
                    }
                    else
                    {
                        foreach (var x in cell.Value.ToString())
                        {
                            if (x <= '9' && x >= '0') continue;
                            row.ErrorText = "Age must contain only numbers";
                            e.Cancel = true;
                            break;
                        }
                        if (e.Cancel) break;
                        try
                        {
                            if (Parse((string) cell.Value) > 0) continue;
                            row.ErrorText = "Age must be positive";
                            e.Cancel = true;
                        }
                        catch (OverflowException)
                        {
                            row.ErrorText = "Person cann't be older that 2147483647 years";
                            e.Cancel = true;
                        }
                    }
                }
                else
                {
                    if (((string)cell.Value).Length > 50)
                    {
                        row.ErrorText = "Value must be shorter than 50 symbols";
                        e.Cancel = true;
                        break;
                    }
                    if (!string.IsNullOrWhiteSpace((string)cell.Value)) continue;
                    row.ErrorText = $"Value in column '{cell.OwningColumn.HeaderText}' mustn't be empty";
                    e.Cancel = true;
                }
            }
            if (e.Cancel) return;

            SConn.Open();
            var sCommand = new SqlCommand { Connection = SConn };
            sCommand.Parameters.AddWithValue("@firstName", row.Cells["firstName"].Value);
            sCommand.Parameters.AddWithValue("@secondName", row.Cells["secondName"].Value);
            sCommand.Parameters.AddWithValue("@age", row.Cells["age"].Value);
            sCommand.Parameters.AddWithValue("@" + nameOfDateColumn, row.Cells[nameOfDateColumn].Value);
            if (row.Cells["id"].Value is int id)
            {
                sCommand.CommandText =
                    $@"UPDATE [dbo].[{dataBase}] SET [firstName] = @firstName,[secondName] = @secondName,[age] = @age,[{nameOfDateColumn}] = @{
                            nameOfDateColumn
                        } WHERE id = @id";
                sCommand.Parameters.AddWithValue("@id", id);
                sCommand.ExecuteNonQuery();
            }
            else
            {
                sCommand.CommandText =
                    $"INSERT INTO [dbo].[{dataBase}] ([firstName], [secondName], [age], [{nameOfDateColumn}]) OUTPUT inserted.id VALUES (@firstName, @secondName, @age, @{nameOfDateColumn})";
                row.Cells["id"].Value = sCommand.ExecuteScalar();
            }
            SConn.Close();

            row.ErrorText = "";
            foreach (var cell in dangerousCells) { cell.ErrorText = ""; }
            row.Cells[nameOfDateColumn].ErrorText = "";
        }

        private void FormMain_Load(object sender, EventArgs e)
        {

        }
    }
}