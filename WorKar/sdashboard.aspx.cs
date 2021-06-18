﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using WorKar.DAL;


namespace WorKar
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("login.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    Load_user_Summary();
                    Bind_Order_Detail();
                }
            }
        }


        // load user summary report
        private void Load_user_Summary()
        {
            DAL.DBAccess db_user_summary = new DBAccess();

            // get user id 
            int UserID = (int)Convert.ToInt32(db_user_summary.Get_Execute_Scalar("SELECT UserID FROM [User] WHERE Username='" + HttpContext.Current.Session["username"].ToString() + "'"));

            rptr_user_summary.DataSource = db_user_summary.Get_User_Summary("Get_User_Summary", UserID);
            rptr_user_summary.DataBind();
        }


        // to get user views week days summary detail
        [System.Web.Services.WebMethod]
        public static string Get_User_Week_Days_Summary()
        {
            DataSet set = new DataSet();
            DAL.DBAccess db_user_views_summary = new DBAccess();

            // get user id 
            int UserID = (int)Convert.ToInt32(db_user_views_summary.Get_Execute_Scalar("SELECT UserID FROM [User] WHERE Username='" + HttpContext.Current.Session["username"].ToString() + "'"));

            // get user views week days summary 
            DataTable table = db_user_views_summary.Get_User_View_Week_Days_Summary("Get_User_View_Week_Days_Summary", UserID);
            set.Tables.Add(table);

            // get user orders week days summary 
            table = db_user_views_summary.Get_User_Order_Week_Days_Summary("Get_User_Order_Week_Days_Summary", UserID);
            set.Tables.Add(table);

            // return data in xml form
            return set.GetXml();
        }


        // to handle null values
        public string Handle_SQL_NULL(object myObject)
        {
            if (DBNull.Value.Equals(myObject))
            {
                return "0";
            }
            return myObject.ToString();
        }

        // load Order history
        private void Bind_Order_Detail()
        {
            DAL.DBAccess db_order_detail = new DAL.DBAccess();
            DataTable orders = db_order_detail.Get_Order_History("Get_Order_History", Session["username"].ToString());
            rptrOrder_detail.DataSource = orders;
            rptrOrder_detail.DataBind();
        }



        public string Get_Date(object myValue)
        {
            char[] seprator = { ' ' };
            return myValue.ToString().Split(seprator)[0];
        }
    }
}