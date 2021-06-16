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
    public partial class WebForm7 : System.Web.UI.Page
    {

        static int JobID = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["username"] == null)
                {
                    Response.Redirect("login.aspx");
                }
                else
                {
                    JobID = (int)Convert.ToInt64(Request.QueryString["JobID"]);            // job id
                    if(JobID != 0)
                    {
                        disable_validators();
                    }

                    // load categories in catgeory drop down menu
                    DAL.DBAccess loadCategoryList = new DAL.DBAccess();
                    ddlCategories.DataSource = loadCategoryList.GetData("SELECT [Name] AS category_name, CategoryID AS category_id FROM Category");
                    ddlCategories.DataBind();

                    // load a job detail from the database for editing
                    Load_Job();
                }

            }
        }

        private void disable_validators()
        {
            RequiredFieldValidator_AccountNum.Enabled = RequiredFieldValidato_NameOnCard.Enabled
                = RequiredFieldValidator_ExpiryDate.Enabled = RequiredFieldValidator_CVV.Enabled = false;
        }

        // load job detail
        protected void Load_Job()
        {
            if (JobID == 0)
            {
                return;
            }

            DAL.DBAccess get_job_detail_db = new DAL.DBAccess();
            DataTable job_detail_table = get_job_detail_db.Get_Jobs_Detail("Get_Job_Detail", Session["username"].ToString(), JobID);

            if (job_detail_table != null)
            {
                DataRow job_detail_row = job_detail_table.Rows[0];
                if (job_detail_row != null)
                {
                    gigTitle.Value = job_detail_row["Title"].ToString();
                    gigDescription.Value = job_detail_row["Description"].ToString();
                    gigPrice.Text = job_detail_row["Amount"].ToString();

                    string categoryName = job_detail_row["Category"].ToString();
                    ListItem selectedListItem = ddlCategories.Items.FindByText(categoryName);
                    if (selectedListItem != null)
                    {
                        selectedListItem.Selected = true;
                    }

                    string duration = job_detail_row["Duration"].ToString();
                    selectedListItem = ddlDuration.Items.FindByValue(duration);
                    if (selectedListItem != null)
                    {
                        selectedListItem.Selected = true;
                    }
                }
            }
        }

        // insert/update job in database on button click
        protected void button_saveID_Click(object sender, EventArgs e)
        {
            int existJobID = JobID;            // Job id

            // create and insert a newjob
            BLL.Gig job = new BLL.Gig();
            // set job values
            job.title = gigTitle.Value.ToString().Trim();
            job.description = gigDescription.Value.ToString().Trim();
            job.amount = (int)Convert.ToInt32(gigPrice.Text.ToString().Trim());
            job.categoryID = (int)Convert.ToInt32(ddlCategories.SelectedValue.ToString().Trim());
            job.postedDate = Convert.ToString(DateTime.Now);
            job.duration = (int)Convert.ToInt32(ddlDuration.SelectedValue.ToString().Trim());

            if (existJobID != 0)
            {
                Update_Job(job);
            }
            else
            {
                Insert_Job(job);
            }

            Response.Write("<script>window.location = 'smy_jobs.aspx'</script>");

        }

        // to update a job detail
        private void Update_Job(BLL.Gig job)
        {
            //insert Job detail
            DAL.DBAccess updateJob = new DAL.DBAccess();
            int JobUserID = (int)Convert.ToInt32(updateJob.Get_Execute_Scalar("SELECT JobUserID FROM Job_User WHERE JobID=" + JobID));

            updateJob.Update_Job_Detail("Update_Job_Detail", JobID, job);
        }

        // to insert a new Job
        private void Insert_Job(BLL.Gig job)
        {
            //insert Job detail
            DAL.DBAccess addJob = new DAL.DBAccess();
            int JobID = addJob.Insert_Job("Insert_Job", job);
            // get Job user id
            int userID = Convert.ToInt32(addJob.Get_Execute_Scalar("SELECT UserID From [User] WHERE Username ='" + Session["username"].ToString() + "'"));

            addJob.Insert_Job_User("Insert_JobUser", JobID, userID);
        }

        protected void button_cancelID_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/smy_jobs.aspx");
        }

        [System.Web.Services.WebMethod]
        public static int Is_Correct_Card_Details(string nameOnCard, string accountNum, string expiryDate, string cvs, string amount)
        {
            DAL.DBAccess db_card_detail_count = new DBAccess();
            int prevAmount = 0;
            // user is updating job
            if (JobID != 0)
            {
                prevAmount = (int)Convert.ToInt32(db_card_detail_count.Get_Execute_Scalar("SELECT Amount FROM Job WHERE JobID=" + JobID));
                if (prevAmount == (int)Convert.ToInt32(amount)) return 3;
            }

            if(db_card_detail_count.Card_Detail_Match_Count("Card_Detail_Match_Count", nameOnCard, accountNum, expiryDate, cvs) > 0)
            {
                // add deducted amount to card
                if (JobID != 0)
                {
                    db_card_detail_count.Execute_Non_Query("UPDATE Card_Detail SET Balance=Balance+" + prevAmount + " WHERE  AccountNumber='" + accountNum + "'");
                }

                int balance = (int)Convert.ToInt32(db_card_detail_count.Get_Execute_Scalar("SELECT balance FROM Card_Detail WHERE AccountNumber='" + accountNum + "'"));
                // not sufficient balance
                if(balance < (int)Convert.ToInt32(amount))
                {
                    return 1;
                }
                // decrease balance in credit card
                db_card_detail_count.Execute_Non_Query("UPDATE Card_Detail SET Balance=Balance-" + (int)Convert.ToInt32(amount) + " WHERE  AccountNumber='" + accountNum + "'");
                return 0;
            }
            return 2;
        }
    }
}