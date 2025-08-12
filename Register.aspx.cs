using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace Ecommerce
{
    public partial class Register : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["Users"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

            }
        }

        protected void btnSignUp_Click(object sender, EventArgs e)
        {
            
            if (Page.IsValid)
            {
                
                SqlConnection con = new SqlConnection(cs);
                   
                string name = txtName.Text;
                int age = Convert.ToInt32(txtAge.Text);
                string email = txtEmail.Text;
                string gender = ddlGender.SelectedValue;
                string password = txtPassword.Text;

                string checkQuery = "Select * from UserTable where Email=@Email";
                SqlCommand checkCmd = new SqlCommand(checkQuery, con);
                checkCmd.Parameters.AddWithValue("@Email", email);

                con.Open();
                SqlDataReader sda = checkCmd.ExecuteReader();

                if (sda.HasRows)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('User already exists');", true);
                    ClearForm();
                    con.Close();
                }
                else
                {
                    con.Close();
                    string query = "Insert into UserTable values(@Name, @Email, @Age, @Gender, @Password); SELECT SCOPE_IDENTITY()";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@Age", age);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Gender", gender);
                    cmd.Parameters.AddWithValue("@Password", password);

                    con.Open();
                    object a = cmd.ExecuteScalar();

                    if (a != null)
                    {
                        //Session["username"] = name;
                        int newId = Convert.ToInt32(a);
                        Session["username"] = name;
                        Session["id"] = newId;

                        Response.Redirect("WebForm1.aspx");

                        
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Can't register')", true);
                    }
                    con.Close();
                }
                 
                   
               
            }
        }

        void ClearForm()
        {
            txtName.Text = "";
            txtAge.Text = "";
            txtEmail.Text = "";
            ddlGender.SelectedIndex = 0;
            txtPassword.Text = "";
            txtConfirmPassword.Text = "";
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
    }
}