using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using WorKar.BLL;
using WorKar.DAL;
using System.Configuration;
using System.Text;
using System.Net;
using System.Net.Mail;
using System.Runtime.InteropServices;
using System.Net.Configuration;


namespace WorKar
{
    public partial class WebForm8 : System.Web.UI.Page
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
                    Load_User_Detail();
                }
            }
        }

        // load user information from the database
        private void Load_User_Detail()
        {
            DAL.DBAccess db_user_info = new DAL.DBAccess();
            DataRow user_info = db_user_info.GetData("SELECT * FROM [User] WHERE Username = '" + Session["username"].ToString() + "'").Rows[0];

            if (!DBNull.Value.Equals(user_info["Photo"]))
            {
                my_photo_display.ImageUrl = user_info["Photo"].ToString();
            }
            display_userFullName.InnerText = user_info["FName"].ToString() + " " + user_info["LName"].ToString();
            display_username.InnerText = "@" + Session["username"].ToString();
            edit_firstname.Text = user_info["FName"].ToString();
            edit_lastname.Value = user_info["LName"].ToString();
            edit_email.Value = user_info["Email"].ToString();
            edit_description.Value = user_info["Description"].ToString();
            edit_username.Value = "@" + Session["username"].ToString();

            flexSwitchCheckDefault.Checked = Convert.ToBoolean(user_info["Availability"].ToString());

            ddlCategories.Items.Clear();
            // load categories in catgeory drop down menu
            DAL.DBAccess loadCategoryList = new DAL.DBAccess();
            ddlCategories.DataSource = loadCategoryList.GetData("SELECT [Name] AS category_name, CategoryID AS category_id FROM Category");
            ddlCategories.DataBind();

            string categoryID = user_info["CategoryID"].ToString();
            ListItem selectedListItem = ddlCategories.Items.FindByValue(categoryID);
            if (selectedListItem != null)
            {
                selectedListItem.Selected = true;
            }

            // to select country
            string countryName = user_info["country"].ToString();
            if (String.IsNullOrEmpty(countryName))
            {
                countryId.Items.FindByValue("none").Selected = true;
            }
            else
            {
                selectedListItem = countryId.Items.FindByValue(countryName);
                if (selectedListItem != null)
                {
                    selectedListItem.Selected = true;
                }
                else
                {
                    countryId.Items.FindByValue("none").Selected = true;
                }
            }


            // select gender
            if (!DBNull.Value.Equals(user_info["Gender"]))
            {
                string gender = user_info["Gender"].ToString();
                if (String.Equals(gender, "Male"))
                {
                    Male_radioBtn.Checked = true;
                }
                else if (String.Equals(gender, "Female"))
                {
                    Female_radioBtn.Checked = true;
                }
                else
                {
                    Others_radioBtn.Checked = true;
                }
            }
        }

        // to delete already exist files
        protected void Delete_Images_From_Folder()
        {
            if (my_photo.HasFile)
            {
                DAL.DBAccess get_image = new DAL.DBAccess();
                DataRow images_row = get_image.GetData("SELECT Photo FROM [User] WHERE Username='" + Session["username"].ToString() + "'").Rows[0];
                if (!DBNull.Value.Equals(images_row["Photo"]))
                {
                    string folderPath = Server.MapPath("~/" + images_row["Photo"].ToString());
                    System.IO.File.Delete(folderPath);
                }
            }
        }

        // save user profile image to folder
        protected void Save_Images_In_Folder(ref string image)
        {
            DAL.DBAccess db_getUserID = new DAL.DBAccess();
            int userID = (int)Convert.ToInt32(db_getUserID.Get_Execute_Scalar("SELECT UserID FROM [User] WHERE Username='" + Session["username"].ToString() + "'"));
            string folderPath = Server.MapPath("~/images/user_images/" + userID.ToString() + "/");

            //Check whether Directory (Folder) exists.
            if (!System.IO.Directory.Exists(folderPath))
            {
                //If Directory (Folder) does not exists. Create it.
                System.IO.Directory.CreateDirectory(folderPath);
            }

            string relativeFolderPath = "images/user_images/" + userID.ToString() + "/";

            //Save the File to the Directory (Folder).
            if (my_photo.HasFile)
            {
                image = relativeFolderPath + System.IO.Path.GetFileName(my_photo.FileName);
                my_photo.SaveAs(folderPath + System.IO.Path.GetFileName(my_photo.FileName));
            }
        }

        [System.Web.Services.WebMethod]
        public static bool Is_Password_Correct(string passwordToCompare, string newPassword)
        {
            DAL.DBAccess db_user_passowrd = new DAL.DBAccess();
            string oldPassword = BLL.Helper.DecodeFrom64(db_user_passowrd.Get_Execute_Scalar("SELECT Password FROM [User] WHERE Username='" + HttpContext.Current.Session["username"].ToString() + "'"));

            newPassword = BLL.Helper.EncodePasswordToBase64(newPassword);
            newPassword = newPassword.Length > 50 ? newPassword.Substring(0, 50) : newPassword;

            if (String.Equals(oldPassword, passwordToCompare))
            {
                db_user_passowrd.Execute_Non_Query("UPDATE [User] SET Password = '" + newPassword + "' WHERE Username = '" + HttpContext.Current.Session["username"].ToString() + "'");
                return true;
            }
            return false;
        }

        // update user detail
        private void Save_User_Detail()
        {
            BLL.User user = new BLL.User();
            user.User_FirstName = edit_firstname.Text.ToString().Trim();
            user.User_LastName = edit_lastname.Value.ToString().Trim();
            user.availability = Convert.ToBoolean(flexSwitchCheckDefault.Checked);
            user.categoryID = (int)Convert.ToInt32(ddlCategories.SelectedValue.ToString().Trim());
            user.User_Country = countryId.Items[countryId.SelectedIndex].Value.ToString().Trim();
            user.description = edit_description.Value;
            user.User_Username = Session["username"].ToString();
            if (Male_radioBtn.Checked == true)
            {
                user.User_Gender = Male_radioBtn.Value.ToString().Trim();
            }
            else if (Female_radioBtn.Checked == true)
            {
                user.User_Gender = Female_radioBtn.Value.ToString().Trim();
            }
            else
            {
                user.User_Gender = Others_radioBtn.Value.ToString().Trim();
            }

            DAL.DBAccess db_update_user = new DAL.DBAccess();

            user.User_Password = null;
            string image = null;
            this.Delete_Images_From_Folder();
            this.Save_Images_In_Folder(ref image);
            user.photo = image;
            db_update_user.Update_User_Detail("Update_User_Detail", user);
        }

        // logout session
        protected void button_logoutID_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Session.RemoveAll();
            Response.Cookies.Clear();
            Response.Cache.SetNoStore();
            Response.Redirect("Home.aspx");
        }


        protected void save_btn_Click(object sender, EventArgs e)
        {
            this.Save_User_Detail();
            Response.Redirect("~/sprofile_editing.aspx");
        }


        // send user email to our website email
        [System.Web.Services.WebMethod]
        public static bool Send_Contact_Message(string fromEmail, string contactPassword, string fromName ,string contactMessage)
        {
            try
            {
                SmtpSection smtpSection = (SmtpSection)ConfigurationManager.GetSection("system.net/mailSettings/smtp");
                MailMessage message = new MailMessage();
                //Sender e-mail address.
                message.From = new MailAddress(fromEmail);
                //Recipient e-mail address.
                message.To.Add(smtpSection.From);

                string subject = "WorKarr Contact Email";
                message.BodyEncoding = Encoding.UTF8;
                var client = new SmtpClient(smtpSection.Network.Host, smtpSection.Network.Port)
                {
                    UseDefaultCredentials = false,
                    Credentials = new NetworkCredential(fromEmail, contactPassword),
                    EnableSsl = true
                };

                client.Send(fromEmail, smtpSection.From, subject, contactMessage);
                client.Dispose();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

    }
}