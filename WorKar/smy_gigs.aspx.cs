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
    public partial class WebForm12 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("login.aspx");
            }
            else
            {
                Bind_Gigs();
            }
        }

        // list all gigs of the current user
        private void Bind_Gigs()
        {
            string username = Session["username"].ToString();
            string storedProcedureName = "Get_Gigs_Detail";

            // to load gigs of user from the database
            DBAccess loadGigs = new DBAccess();
            DataTable table = new DataTable();      // to store gigs detail

            table = loadGigs.Get_Gigs_Detail(storedProcedureName, username);
            my_gigs_list.DataSource = table;
            my_gigs_list.DataBind();
        }
        

        [System.Web.Services.WebMethod]
        public static string delete_gig(string deleteGigID)
        {
            int GigID = (int)Convert.ToInt32(deleteGigID);
            int GigUserID = 0;

            DAL.DBAccess deleteGig = new DBAccess();
            GigUserID = (int)Convert.ToInt32(deleteGig.Get_Execute_Scalar("SELECT GigUserID FROM Gig_user WHERE GigID=" + GigID));


            // delete images
            deleteGig.Execute_Non_Query("DELETE FROM GigImages WHERE GigUserID=" + GigUserID.ToString());
            // delete gig_user entry
            deleteGig.Execute_Non_Query("DELETE FROM Gig_user WHERE GigUserID=" + GigUserID.ToString());
            // delete gig itself
            deleteGig.Execute_Non_Query("DELETE FROM Gig Where GigID=" + GigID.ToString());

            // delete images folder
            try
            {
                string imagesFolder = HttpContext.Current.Server.MapPath("~/images/gig_images/" + GigUserID + "/"); ;
                bool isFolderExist = System.IO.Directory.Exists(imagesFolder);
                if (isFolderExist)
                {
                    System.IO.Directory.Delete(imagesFolder, true);
                }
            }
            catch (Exception e)
            {
                throw e;
            }
            return GigID.ToString();
        }

    }
}