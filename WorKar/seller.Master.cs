using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WorKar.DAL;


namespace WorKar
{
    public partial class seller : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["username"] != null && Session["firstname"] != null)
                {
                    h2_user_firstnameID.InnerText = Session["firstName"].ToString().Trim();
                    // display user photo
                    DAL.DBAccess db_user_photo = new DBAccess();
                    display_user_photo.ImageUrl = db_user_photo.Get_Execute_Scalar("SELECT Photo From [User] Where Username = '" + Session["username"].ToString() + "'");
                }
                else
                {
                    Response.Redirect("~/login.aspx");
                }
            }
        }

        protected void hyperlink_homeID_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Session.RemoveAll();
            Response.Redirect("~/Home.aspx");
        }

        protected void hyperlink_dashboardID_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/sdashboard.aspx");
        }

        protected void hyperlink_mygigsID_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/smy_gigs.aspx");
        }

        protected void hyperlink_myordersID_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/smy_jobs.aspx");
        }

        protected void hyperlink_paymentID_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/stransaction.aspx");
        }

        protected void hyperlink_chatID_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/chat.aspx");
        }

        protected void hyperlink_settingID_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/sprofile_editing.aspx");
        }

        protected void hyperlink_searchGigJobsID_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/sgigs_list.aspx");
        }

        protected void hyperlink_ordersID_Click(object sender, EventArgs e)
        {
            Response.Redirect("sorders_list.aspx");
        }

        protected void hyperlink_logoutID_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Session.RemoveAll();
            Response.Cookies.Clear();
            Response.Cache.SetNoStore();
            Response.Redirect("~/login.aspx");
        }
    }
}