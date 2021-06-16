using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WorKar.DAL;
using WorKar.BLL;
using System.Configuration;
using System.Text;
using System.Net;
using System.Net.Mail;
using System.Runtime.InteropServices;


namespace WorKar
{
    [Guid("9245fe4a-d402-451c-b9ed-9c1a04247482")]
    public partial class signup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                print_email_error_msg("", "2px solid white", "none");
                print_password_error_msg("", "2px solid white", "none");
            }
        }

        protected void button_signupID_Click(object sender, EventArgs e)
        {
            DBAccess insertUser = new DBAccess();
            string email_query = "SELECT COUNT(*) FROM [User] WHERE [User].Email='" + Convert.ToString(textbox_emailID.Text.Trim()) + "'";
            string query_result = insertUser.Get_Execute_Scalar(email_query);

            int email_count = 0;
            if (query_result != null && int.TryParse(query_result, out email_count))
            {
                email_count = Convert.ToInt32(query_result);
            }

            if (email_count != 0)
            {
                print_email_error_msg("This email address is already being used", "2px solid red", "block");
            }
            else
            {
                User user = new User();
                user.User_FirstName = textbox_firstnameID.Text.Trim();
                user.User_LastName = textbox_lastnameID.Text.Trim();
                user.User_Email = textbox_emailID.Text.Trim();

                string encoded = Helper.EncodePasswordToBase64(textbox_passwordID.Text.ToString().Trim());
                user.User_Password = encoded.Length > 50 ? encoded.Substring(0, 50) : encoded;
                query_result = insertUser.Get_Execute_Scalar("SELECT MAX([User].UserID) FROM [User]");

                int max_user_id = 1;

                if (query_result != null && int.TryParse(query_result, out max_user_id))
                {
                    max_user_id = Convert.ToInt32(query_result);
                }

                user.User_Username = user.User_FirstName + user.User_LastName + Convert.ToString(max_user_id + 1);
                Guid guidObj = Guid.NewGuid();
                user.User_Guid = guidObj.ToString();
                insertUser.Insert_User("Insert_User", user);

                // update email verification page
                string filename = Server.MapPath("Email_Verification.html");
                string findText = @"<span id='userfirstname'></span>";
                string replaceText = @"<span id='userfirstname'>" + user.User_FirstName + "</span>";        // replace firstname

                //find and replace content in file
                string content = Helper.find_and_replace(filename, replaceText, findText);

                content = content.Replace("--login-username--", user.User_Username.Trim());         // replace username

                // replace website link
                string link = "https://workarr.azurewebsites.net/email_confirmation.aspx";
                replaceText = "<a href=" + link + "?custid=" + user.User_Guid;
                findText = "<a id='email_confirmationLink' href='#'";
                string mailbody = content.Replace(findText, replaceText);

                send_confirmation_email(user, mailbody);

                Application["isDisplayError"] = true;
                Response.Redirect("login.aspx");
            }
        }

        protected static void send_successful_registration_mail(User user, string mailbody)
        {
            MailMessage message = new MailMessage();
            message.To.Add(new MailAddress(user.User_Email.ToString().Trim(), "Request for Email Verification"));
            message.Subject = "WorKarr Successful Registration Email";
            message.Body = mailbody;
            message.BodyEncoding = Encoding.UTF8;
            message.IsBodyHtml = true;

            Helper.send_email(message);
        }


        protected static void send_confirmation_email(User user, string mailbody)
        {
            MailMessage message = new MailMessage();
            message.To.Add(new MailAddress(user.User_Email.ToString().Trim(), "Request for Email Verification"));
            message.Subject = "Email Verification";
            message.Body = mailbody;
            message.BodyEncoding = Encoding.UTF8;
            message.IsBodyHtml = true;

            Helper.send_email(message);
        }


        // incorrect email
        protected void print_password_error_msg(string msg, string border, string display)
        {
            label_pass_errorID.Text = msg;
            pass_containerID.Style.Add("border", border);
            pass_error_block.Style.Add("display", display);
            pass_containerID.Focus();
        }

        // incorrect email
        protected void print_email_error_msg(string msg, string border, string display)
        {
            label_email_errorID.Text = msg;
            email_containerID.Style.Add("border", border);
            email_error_block.Style.Add("display", display);
            email_containerID.Focus();
        }


    }
}