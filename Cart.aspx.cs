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
    public partial class Cart : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["Users"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["id"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadItems();
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.Aspx");
        }

        protected void rptCartItems_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (Session["id"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            int cartId = Convert.ToInt32(e.CommandArgument);
            int userId = Convert.ToInt32(Session["id"]);

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();

                    switch (e.CommandName)
                    {
                        case "IncreaseQuantity":
                            UpdateCartQuantity(con, cartId, userId, 1);
                            Response.Write("Error in increasing");
                            break;

                        case "DecreaseQuantity":
                            UpdateCartQuantity(con, cartId, userId, -1);
                            Response.Write("Error in decreasing");
                            break;

                        case "RemoveItem":
                            RemoveCartItem(con, cartId, userId);
                            Response.Write("Error in removing");
                            break;
                    }
                }

                LoadItems();
                Response.Redirect(Request.RawUrl);
            }
            catch (Exception ex)
            {
                Response.Write("Error in ItemCommand: " + ex.Message);
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    "alert('Error updating cart. Please try again.');", true);
            }
        }

        private void UpdateCartQuantity(SqlConnection con, int cartId, int userId, int change)
        {
            
            string quantityQuery = "SELECT Quantity FROM Cart WHERE CartId = @CartId AND UserId = @UserId";
            using (SqlCommand cmd = new SqlCommand(quantityQuery, con))
            {
                cmd.Parameters.AddWithValue("@CartId", cartId);
                cmd.Parameters.AddWithValue("@UserId", userId);

                object result = cmd.ExecuteScalar();
                if (result != null)
                {
                    int currentQuantity = Convert.ToInt32(result);
                    int newQuantity = currentQuantity + change;

                    if (newQuantity <= 0)
                    {
      
                        RemoveCartItem(con, cartId, userId);
                        return;
                    }

                 
                    if (IsStockAvailable(con, cartId, newQuantity))
                    {
                        
                        string updateQuery = "UPDATE Cart SET Quantity = @Quantity WHERE CartId = @CartId AND UserId = @UserId";
                        using (SqlCommand updateCmd = new SqlCommand(updateQuery, con))
                        {
                            updateCmd.Parameters.AddWithValue("@Quantity", newQuantity);
                            updateCmd.Parameters.AddWithValue("@CartId", cartId);
                            updateCmd.Parameters.AddWithValue("@UserId", userId);

                            updateCmd.ExecuteNonQuery();
                        }
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('Sorry, not enough stock available.');", true);
                    }
                }
            }
        }

        private bool IsStockAvailable(SqlConnection con, int cartId, int requestedQuantity)
        {
            string stockQuery = @"
                SELECT p.Stock 
                FROM Cart c 
                INNER JOIN Product p ON c.ProductId = p.Id 
                WHERE c.CartId = @CartId";

            using (SqlCommand cmd = new SqlCommand(stockQuery, con))
            {
                cmd.Parameters.AddWithValue("@CartId", cartId);
                object result = cmd.ExecuteScalar();

                if (result != null)
                {
                    int availableStock = Convert.ToInt32(result);
                    return requestedQuantity <= availableStock;
                }
                return false;
            }
        }

        private void RemoveCartItem(SqlConnection con, int cartId, int userId)
        {
            string deleteQuery = "DELETE FROM Cart WHERE CartId = @CartId AND UserId = @UserId";
            using (SqlCommand cmd = new SqlCommand(deleteQuery, con))
            {
                cmd.Parameters.AddWithValue("@CartId", cartId);
                cmd.Parameters.AddWithValue("@UserId", userId);

                int rowsAffected = cmd.ExecuteNonQuery();
                if (rowsAffected > 0)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "alert('Item removed from cart.');", true);
                }
            }
        }

        private void LoadItems()
        {

            if (Session["id"] == null)
            {
                notLoggedIn();
            }

            int userId = Convert.ToInt32(Session["id"]);
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();
                    string query = "SELECT Cart.CartId, Cart.UserId, Cart.ProductId, Cart.Quantity, Product.ImageURL, Product.Name, Product.description, Product.Price FROM Cart INNER JOIN Product ON Cart.ProductId = Product.Id WHERE Cart.UserId = @ID";

                    SqlCommand cmd = new SqlCommand(query, con);

                    cmd.Parameters.AddWithValue("@ID", userId);

                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        rptCartItems.DataSource = dt;
                        rptCartItems.DataBind();

                        showCartContent();
                        calculate(dt);
                    }
                    else
                    {
                        showEmptyContent();
                    }

                    con.Close();
                }
            }
            catch (Exception e)
            {
                Response.Write("Error at load items" + e.Message);
            }
        }

        private void calculate(DataTable dt)
        {
            int totalCost = 0;
            int totalItems = 0;

            foreach (DataRow items in dt.Rows)
            {
                int price = Convert.ToInt32(items["Price"]);
                int quantity = Convert.ToInt32(items["Quantity"]);

                totalItems += quantity;
                totalCost += (price * quantity);
            }

            int total = 50 + totalCost;

            lblTotalItems.Text = totalItems.ToString();
            lblSubtotal.Text = totalCost.ToString();
            lblTotal.Text = total.ToString();

        }

        protected void btnContinueShopping_Click(object sender, EventArgs e)
        {
            Response.Redirect("WebForm1.aspx");
        }

        private void notLoggedIn()
        {
            pnlNotLoggedIn.Visible = true;
            pnlCartContent.Visible = false;
        }

        private void showCartContent()
        {
            pnlCartContent.Visible = true;
            pnlNotLoggedIn.Visible = false;
            pnlEmptyCart.Visible = false;
            pnlCartSummary.Visible = true;
        }

        private void showEmptyContent()
        {
            pnlNotLoggedIn.Visible = false;
            pnlCartContent.Visible = true;
            pnlEmptyCart.Visible = true;
            pnlCartSummary.Visible = false;
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            if (Session["id"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            
            if (rptCartItems.Items.Count == 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    "alert('Your cart is empty. Please add some items before checkout.');", true);
                return;
            }

            
            //Response.Redirect("Checkout.aspx");
            ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    "alert('Payment will Start');", true);
        }
    }
}