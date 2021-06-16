using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WorKar.DAL;
using System.Data;
using WorKar.BLL;

namespace WorKar
{
    public partial class sorder_view : System.Web.UI.Page
    {
        private static int OrderID = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("login.aspx");
            }
            else
            {
                if (Request.QueryString["OrderID"] == null)
                {
                    Response.Redirect("~/sorders_list.aspx");
                }
                OrderID = (int)Convert.ToInt32(Request.QueryString["OrderID"]);            // order id
                Bind_Order_Detail();
            }
        }

        // to bind specific order of a user
        private void Bind_Order_Detail()
        {
            string storedProcedureName = "Get_Order_Detail";

            //to load specific gig of a user from the database
            DBAccess loadOrder = new DBAccess();
            DataTable order_detail = new DataTable();

            order_detail = loadOrder.Get_Order_Detail(storedProcedureName, OrderID);

            rptrOrder_DetailID.DataSource = order_detail;
            rptrOrder_DetailID.DataBind();


            if(order_detail.Rows.Count > 0)
            {
                int fromUserID = (int)Convert.ToInt32(order_detail.Rows[0]["FromUserID"].ToString());
                Bind_User_Detail(fromUserID);
            }
        }


        // to bind detail of user of the order
        private void Bind_User_Detail(int UserID)
        {
            string storedProcedureName = "Get_User_Detail";
            // to load specific gig of a user from the database
            DBAccess loadUser = new DBAccess();
            DataTable user_detail = new DataTable();

            string username = loadUser.Get_Execute_Scalar("SELECT Username FROM [User] WHERE UserID=" + UserID);
            user_detail = loadUser.Get_User_Detail(storedProcedureName, username);

            rptrUser_DetailID.DataSource = user_detail;
            rptrUser_DetailID.DataBind();
        }
    }
}