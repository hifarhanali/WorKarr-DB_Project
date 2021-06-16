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
    public partial class WebForm5 : System.Web.UI.Page
    {
        private static int JobID = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("login.aspx");
            }
            else
            {
                if (Request.QueryString["JobID"] == null)
                {
                    Response.Redirect("~/smy_jobs.aspx");
                }
                JobID = (int)Convert.ToInt32(Request.QueryString["JobID"]);            // job id
                Bind_Job_Detail();
                Bind_User_Detail();
            }
        }

        // to bind specific job of a user
        private void Bind_Job_Detail()
        {
            string storedProcedureName = "Get_Job_Detail";

            // to load specific gig of a user from the database
            DBAccess loadJob = new DBAccess();
            DataTable job_detail = new DataTable();

            job_detail = loadJob.Get_Jobs_Detail(storedProcedureName, null, JobID);

            rptrJob_DetailID.DataSource = job_detail;
            rptrJob_DetailID.DataBind();
        }


        // to bind detail of user of the job
        private void Bind_User_Detail()
        {
            string storedProcedureName = "Get_User_Detail";
            // to load specific gig of a user from the database
            DBAccess loadUser = new DBAccess();
            DataTable user_detail = new DataTable();

            int userID = (int)Convert.ToInt32(loadUser.Get_Execute_Scalar("SELECT UserID FROM Job_User WHERE JobID=" + JobID));
            string username = loadUser.Get_Execute_Scalar("SELECT Username FROM [User] WHERE UserID=" + userID);


            user_detail = loadUser.Get_User_Detail(storedProcedureName, username);

            rptrUser_DetailID.DataSource = user_detail;
            rptrUser_DetailID.DataBind();
        }
    }
}