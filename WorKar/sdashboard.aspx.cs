using System;
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

    }
}