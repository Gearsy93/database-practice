using System.Windows.Forms;
using Npgsql;

namespace TreeView
{
    public partial class MainForm : Form
    {
        public MainForm()
        {
            InitializeComponent();
            InitializeTreeView();

        }
        private void InitializeTreeView()
        {
            var connStr = new NpgsqlConnectionStringBuilder
            {
                Host = "localhost",
                Port = 5432,
                Username = "postgres",
                Password = "postgres",
                Database = "Database",
                SearchPath = "Scheme"
            }.ConnectionString;

            using (var conn = new NpgsqlConnection(connStr))
            {

                conn.Open();

                var command = new NpgsqlCommand
                {
                    Connection = conn,
                    CommandText = @"select human.name as name, apartments.location as location, room.color as color
                                    from human left outer
                                    join apartments on human.id = apartments.id left outer 
                                    join room on room.apartment_id = apartments.apartment_id
                                    order by name, location, color;"
                };
                using (var reader = command.ExecuteReader())
                {
                    var lastAddednameNode = new TreeNode();
                    var lastAddedlocationNode = new TreeNode();
                    var lastAddedcolorNode = new TreeNode();

                    while (reader.Read())
                    {
                        string name = (string)reader["name"];
                        string location;
                        string color;
                        if (!reader.IsDBNull(reader.GetOrdinal("location")))
                        {
                            location = (string)reader["location"];
                        }
                        else
                            location = null;
                        if (!reader.IsDBNull(reader.GetOrdinal("color")))
                        {
                            color = (string)reader["color"];
                        }
                        else color = null;

                        if (lastAddednameNode.Text != name)
                        {
                            lastAddednameNode = treeView.Nodes.Add(name);
                        }
                        if (location != null)
                        {

                            if (lastAddedlocationNode.Text != location)
                            {
                                lastAddedlocationNode = lastAddednameNode.Nodes.Add(location);
                            }
                            if (color != null) lastAddedcolorNode = lastAddedlocationNode.Nodes.Add(color);
                        }
                    }
                }


            }
        }
        private void MainForm_Load(object sender, System.EventArgs e)
        {

        }
    }
}
