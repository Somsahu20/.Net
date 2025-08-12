using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;

namespace Ecommerce
{
    public partial class Login : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["Users"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void signin_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(cs);
            string mail = email.Text;
            string pass = password.Text;

            string check = "Select * from UserTable where Email=@Mail";
            SqlCommand checkCmd = new SqlCommand(check, con);
            checkCmd.Parameters.AddWithValue("@Mail", mail);

            con.Open();
            SqlDataReader sda = checkCmd.ExecuteReader();

            if (!sda.HasRows)
            {
                con.Close();
                reset();
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('No User with this email')", true);
            }
            else
            {
                con.Close();
                string query = "Select * from UserTable where Email=@Mail";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Mail", mail);

                con.Open();
                SqlDataReader sda2 = cmd.ExecuteReader();

                sda2.Read();

                if (pass != sda2["Password"].ToString())
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Wrong Password')", true);
                }  
                else
                {
                    Session["username"] = sda2["Name"].ToString();
                    Session["id"] = Convert.ToInt32(sda2["Id"]);
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Login Successful')", true);
                    Response.Redirect("WebForm1.aspx");
                }

                sda.Close();
                con.Close();
            }


        }

        protected void register_Click(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }

        void reset()
        {
            email.Text = "";
            password.Text = "";
        }
    }
}