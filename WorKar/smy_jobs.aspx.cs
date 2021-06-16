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
    public partial class WebForm6 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("login.aspx");
            }
            else
            {
                Bind_Jobs();
            }
        }



        // list all posted jobs of the current user
        private void Bind_Jobs()
        {
            string username = Session["username"].ToString();
            string storedProcedureName = "Get_Jobs_Detail";

            // to load jobs of user from the database
            DBAccess loadJobs = new DBAccess();
            DataTable table = new DataTable();      // to store jobs detail

            table = loadJobs.Get_Jobs_Detail(storedProcedureName, username);
            my_jobs_list.DataSource = table;
            my_jobs_list.DataBind();
        }


        // delete job
        [System.Web.Services.WebMethod]
        public static string delete_job(string deleteJobID)
        {
            int JobID = (int)Convert.ToInt32(deleteJobID);
            int JobUserID = 0;

            DAL.DBAccess deleteJob = new DBAccess();
            JobUserID = (int)Convert.ToInt32(deleteJob.Get_Execute_Scalar("SELECT JobUserID FROM Job_User WHERE JobID=" + JobID));


            // delete gig_user entry
            deleteJob.Execute_Non_Query("DELETE FROM Job_user WHERE JobUserID=" + JobUserID.ToString());
            // delete gig itself
            deleteJob.Execute_Non_Query("DELETE FROM Job Where JobID=" + JobID.ToString());

            return JobID.ToString();
        }

    }
}