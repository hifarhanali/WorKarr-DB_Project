using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Web.UI.HtmlControls;

namespace WorKar
{
    public partial class WebForm10 : System.Web.UI.Page
    {
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
                    // load categories in catgeory drop down menu
                    DAL.DBAccess loadCategoryList = new DAL.DBAccess();
                    ddlCategories.DataSource = loadCategoryList.GetData("SELECT [Name] AS category_name, CategoryID AS category_id FROM Category");
                    ddlCategories.DataBind();

                    // load gig detail from the database for editing
                    Load_Gig();
                }
            }
        }

        // load gig
        protected void Load_Gig()
        {
            int GigID = 0;
            GigID = (int)Convert.ToInt64(Request.QueryString["GigID"]);            // gig id

            if (GigID == 0)
            {
                return;
            }

            Image1_ReqFieldValidator.Enabled = false;

            DAL.DBAccess get_gig_detail_db = new DAL.DBAccess();
            DataTable gig_detail_table = get_gig_detail_db.Get_Gigs_Detail("Get_Gig_Detail", Session["username"].ToString(), GigID);

            if (gig_detail_table != null)
            {
                DataRow gig_detail_row = gig_detail_table.Rows[0];
                if (gig_detail_row != null)
                {
                    gigTitle.Value = gig_detail_row["Title"].ToString();
                    gigDescription.Value = gig_detail_row["Description"].ToString();
                    specification1.Value = gig_detail_row["Specification1"].ToString();
                    specification2.Value = gig_detail_row["Specification2"].ToString();
                    specification3.Value = gig_detail_row["Specification3"].ToString();

                    Gig_Image1.ImageUrl = gig_detail_row["Image1"].ToString();

                    if (!DBNull.Value.Equals(gig_detail_row["Image2"]))
                    {
                        Gig_Image2.ImageUrl = gig_detail_row["Image2"].ToString();
                    }
                    if (!DBNull.Value.Equals(gig_detail_row["Image3"]))
                    {
                        Gig_Image3.ImageUrl = gig_detail_row["Image3"].ToString();
                    }
                    gigPrice.Text = gig_detail_row["Amount"].ToString();

                    string categoryName = gig_detail_row["Category"].ToString();
                    ListItem selectedListItem = ddlCategories.Items.FindByText(categoryName);
                    if (selectedListItem != null)
                    {
                        selectedListItem.Selected = true;
                    }

                    string duration = gig_detail_row["Duration"].ToString();
                    selectedListItem = ddlDuration.Items.FindByValue(duration);
                    if (selectedListItem != null)
                    {
                        selectedListItem.Selected = true;
                    }
                }
            }
        }

        protected void Save_Images_In_Folder(int Gig_UserID, ref Dictionary<string, string> imagesPath)
        {
            string folderPath = Server.MapPath("~/images/gig_images/" + Gig_UserID + "/");

            //Check whether Directory (Folder) exists.
            if (!Directory.Exists(folderPath))
            {
                //If Directory (Folder) does not exists. Create it.
                Directory.CreateDirectory(folderPath);
            }

            string relativeFolderPath = "images/gig_images/" + Gig_UserID + "/";

            //Save the File to the Directory (Folder).
            if (img_gig1ID.HasFile)
            {
                imagesPath.Add("Image1", relativeFolderPath + "1" + Path.GetFileName(img_gig1ID.FileName));
                img_gig1ID.SaveAs(folderPath + "1" + Path.GetFileName(img_gig1ID.FileName));
            }
            if (img_gig2ID.HasFile)
            {
                imagesPath.Add("Image2", relativeFolderPath + "2" + Path.GetFileName(img_gig2ID.FileName));
                img_gig2ID.SaveAs(folderPath + "2" + Path.GetFileName(img_gig2ID.FileName));
            }
            if (img_gig3ID.HasFile)
            {
                imagesPath.Add("Image3", relativeFolderPath + "3" + Path.GetFileName(img_gig3ID.FileName));
                img_gig3ID.SaveAs(folderPath + "3" + Path.GetFileName(img_gig3ID.FileName));
            }
        }

        // to delete already exist files
        protected void Delete_Images_From_Folder(int Gig_UserID)
        {
            DAL.DBAccess get_image = new DAL.DBAccess();
            DataRow images_row = get_image.GetData("SELECT Image1, Image2, Image3 FROM GigImages WHERE GigUserID=" + Gig_UserID).Rows[0];

            if (img_gig1ID.HasFile)
            {
                if (!DBNull.Value.Equals(images_row["Image1"]))
                {
                    string folderPath = Server.MapPath("~/" + images_row["Image1"].ToString());

                    if (File.Exists(folderPath))
                    {
                        File.Delete(folderPath);
                    }
                }
            }
            if (img_gig2ID.HasFile)
            {
                if (!DBNull.Value.Equals(images_row["Image2"]))
                {
                    string folderPath = Server.MapPath("~/" + images_row["Image2"].ToString());
                    File.Delete(folderPath);
                }
            }
            if (img_gig3ID.HasFile)
            {
                if (!DBNull.Value.Equals(images_row["Image3"]))
                {
                    string folderPath = Server.MapPath("~/" + images_row["Image3"].ToString());
                    File.Delete(folderPath);
                }
            }
        }


        // to insert a new gig and save images in a folder
        protected void button_saveID_Click(object sender, EventArgs e)
        {
            int existGigID = 0;
            existGigID = (int)Convert.ToInt64(Request.QueryString["GigID"]);            // gig id

            // create and insert a new gig
            BLL.Gig gig = new BLL.Gig();
            // set gig values
            gig.title = gigTitle.Value.ToString().Trim();
            gig.description = gigDescription.Value.ToString().Trim();
            gig.amount = (int)Convert.ToInt32(gigPrice.Text.ToString().Trim());
            gig.categoryID = (int)Convert.ToInt32(ddlCategories.SelectedValue.ToString().Trim());
            gig.postedDate = Convert.ToString(DateTime.Now);
            gig.specifications[0] = specification1.Value.ToString().Trim();
            gig.specifications[1] = specification2.Value.ToString().Trim();
            gig.specifications[2] = specification3.Value.ToString().Trim();
            gig.duration = (int)Convert.ToInt32(ddlDuration.SelectedValue.ToString().Trim());

            if (existGigID != 0)
            {
                Update_Gig(existGigID, gig);
            }
            else
            {
                Insert_Gig(gig);
            }

            //Response.Redirect("~/smy_gigs.aspx", false);              [Not Working]
            Response.Write("<script>window.location = 'smy_gigs.aspx'</script>");

        }

        // to update gig
        private void Update_Gig(int GigID, BLL.Gig gig)
        {
            //insert gig detail
            DAL.DBAccess updateGig = new DAL.DBAccess();
            int GigUserID = (int)Convert.ToInt32(updateGig.Get_Execute_Scalar("SELECT GigUserID FROM Gig_user WHERE GigID=" + GigID));

            // delete old images
            Delete_Images_From_Folder(GigUserID);

            // save images
            Dictionary<string, string> imagesPath = new Dictionary<string, string>();
            Save_Images_In_Folder(GigUserID, ref imagesPath);

            updateGig.Update_Gig_Detail("Update_Gig_Detail", GigID, gig, imagesPath);
        }

        // to insert a new gig
        private void Insert_Gig(BLL.Gig gig)
        {
            //insert gig detail
            DAL.DBAccess addGig = new DAL.DBAccess();
            int GigID = addGig.Insert_Gig("Insert_Gig", gig);
            // get gig user id
            int userID = Convert.ToInt32(addGig.Get_Execute_Scalar("SELECT UserID From [User] WHERE Username ='" + Session["username"].ToString() + "'"));

            int GigUserID = addGig.Insert_Gig_User("Insert_GigUser", GigID, userID);

            // save images
            Dictionary<string, string> imagesPath = new Dictionary<string, string>();
            this.Save_Images_In_Folder(GigUserID, ref imagesPath);

            // save path of images to database
            addGig.Insert_Images("Insert_Gig_Images", GigUserID, imagesPath);
        }

        protected void button_cancelID_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/smy_gigs.aspx");
        }
    }
}