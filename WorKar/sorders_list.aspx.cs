using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WorKar.DAL;
using System.Data;


namespace WorKar
{
    public partial class WebForm9 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("login.aspx");
            }
            else
            {
                Bind_Orders();
            }
        }

        // list all orders of the current user
        private void Bind_Orders()
        {
            string username = Session["username"].ToString();
            string storedProcedureName = "Get_Orders_Detail";

            // to load jobs of user from the database
            DBAccess loadOrders = new DBAccess();
            DataTable table = new DataTable();      // to store orders detail

            table = loadOrders.Get_Order_History(storedProcedureName, username, "progressing", 1);
            posted_orders_list.DataSource = table;
            posted_orders_list.DataBind();

            table = loadOrders.Get_Order_History(storedProcedureName, username, "progressing", 0);
            recieved_orders_list.DataSource = table;
            recieved_orders_list.DataBind();
        }

        // delete an order
        [System.Web.Services.WebMethod]
        public static string cancel_order(string deleteOrderID)
        {
            int OrderID = (int)Convert.ToInt32(deleteOrderID);
            DAL.DBAccess deleteOrder = new DBAccess();
            deleteOrder.Execute_Non_Query("DELETE FROM [Order] WHERE OrderID=" + OrderID);

            return OrderID.ToString();
        }


        public string Get_Date(object myValue)
        {
            char[] seprator = { ' ' };
            return myValue.ToString().Split(seprator)[0];
        }

    }
}