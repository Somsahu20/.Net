using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace Ecommerce
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["Users"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["username"] == null || Session["id"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                
                 loadProducts();           
                
            }
        }

        void loadProducts(int selected = 0)
        {
            

            try
            {
                SqlConnection con = new SqlConnection(cs);
                string query = null;

                if (selected == 0)
                {
                    query = "Select * from Product";
                }
                else
                {
                    query = "Select * from Product where CategoryID=@Id";
                }
                    

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Id", selected);

                con.Open();
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    rptProducts.DataSource = dt;
                    rptProducts.DataBind();
                    pnlNoProducts.Visible = false;

                }
                else
                {
                    rptProducts.DataSource = dt;
                    rptProducts.DataBind();
                    pnlNoProducts.Visible = true;
                }


            }
            catch (Exception e)
            {
                Response.Write("Error of: " + e.Message);
            }
        }

        protected void selectIndex(object sender, EventArgs e)
        {
            int selected = Convert.ToInt32(ddlCategory.SelectedValue);
            loadProducts(selected);
            
        }

        protected void AddToCart(object source, CommandEventArgs e)
        {
            
            //if (e.CommandName != "AddToCart") return;

            if (Session["id"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            int userId = Convert.ToInt32(Session["id"]);
            int productId = Convert.ToInt32(e.CommandArgument);

            
            SqlConnection con = new SqlConnection(cs);
            try
            {
               
                con.Open();

                
                string checkQuery = "SELECT CartId FROM Cart WHERE UserId = @UID AND ProductId = @PID";
                SqlCommand checkCmd = new SqlCommand(checkQuery, con);
                checkCmd.Parameters.AddWithValue("@UID", userId);
                checkCmd.Parameters.AddWithValue("@PID", productId);

                
                object existingCartItem = checkCmd.ExecuteScalar();

                if (existingCartItem != null)
                {
                    
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('This product is already in your cart.');", true);
                }
                else
                {
                    
                    string insertQuery = "INSERT INTO Cart (UserId, ProductId, Quantity) VALUES (@UID, @PID, @Quantity)";
                    SqlCommand insertCmd = new SqlCommand(insertQuery, con);
                    insertCmd.Parameters.AddWithValue("@UID", userId);
                    insertCmd.Parameters.AddWithValue("@PID", productId);
                    insertCmd.Parameters.AddWithValue("@Quantity", 1);

                    int a = insertCmd.ExecuteNonQuery();

                    if (a > 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Product added to cart!');", true);
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error: Could not add product.');", true);
                    }
                }
            }
            catch (Exception ex)
            {
                
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('An error occurred: " + ex.Message.Replace("'", "") + "');", true);
            }
            finally
            {
                
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
        }
    }
    
}