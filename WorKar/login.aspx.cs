using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WorKar.DAL;
using WorKar.BLL;

namespace WorKar
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                print_email_error_msg("", "2px solid white", "none");
                print_password_error_msg("", "2px solid white", "none");

                // to display verify email error
                if(Application["isDisplayError"] != null && Convert.ToBoolean(Application["isDisplayError"]) == true)
                {
                    // display error if mail is not verified
                    not_verify_email_error.Style.Add("display", "flex");
                    Application.Remove("isDisplayError");
                }

                // use cookies to fill boxes
                if (Request.Cookies["username"] != null)
                    textbox_emailID.Text = Request.Cookies["username"].Value.ToString();
                if (Request.Cookies["password"] != null)
                    textbox_passwordID.Attributes.Add("value", Helper.DecodeFrom64(Request.Cookies["password"].Value.ToString()));
                if (Request.Cookies["username"] != null && Request.Cookies["password"] != null)
                    chkbox_remember_meID.Checked = true;
            }
        }

        protected void button_loginID_Click(object sender, EventArgs e)
        {
            DBAccess login_dal = new DBAccess();
            int login_count = login_dal.Match_Users_Count("Match_Users_Count", textbox_emailID.Text.ToString().Trim(), Helper.EncodePasswordToBase64(textbox_passwordID.Text.Trim()));
            if (login_count == 1)
            {
                // check for is alid email flag
                string query = "SELECT IsValidEmail FROM [User] WHERE [User].Username='" + Convert.ToString(textbox_emailID.Text.Trim()) + "'";
                bool isValidEmail = false;
                string query_result = login_dal.Get_Execute_Scalar(query);
                
                if(query_result != null)
                {
                    isValidEmail = Convert.ToBoolean(query_result);
                }

                if (isValidEmail)
                {
                    // cookies
                    if(chkbox_remember_meID.Checked == true)
                    {
                        Response.Cookies["username"].Value = textbox_emailID.Text.ToString().Trim();
                        Response.Cookies["password"].Value = Helper.EncodePasswordToBase64(textbox_passwordID.Text.Trim());
                        Response.Cookies["username"].Expires = DateTime.Now.AddDays(15);
                        Response.Cookies["password"].Expires = DateTime.Now.AddDays(15);
                    }
                    else
                    {
                        Response.Cookies["username"].Expires = DateTime.Now.AddDays(-1);
                        Response.Cookies["password"].Expires = DateTime.Now.AddDays(-1);
                    }
                    // to get first name of user
                    string fName_query = @"SELECT [User].Fname FROM [User] WHERE [User].Username='" +  textbox_emailID.Text.Trim() + "'";
                    string firstname = login_dal.Get_Execute_Scalar(fName_query);
                    Session["username"] = textbox_emailID.Text.Trim();
                    Session["firstname"] = firstname.Trim();
                    Response.Redirect("sdashboard.aspx");
                }
                else
                {
                    not_verify_email_error.Style.Add("display", "flex");
                }
            }
            else
            {
                string username_query = "SELECT COUNT(*) FROM [User] WHERE [User].Username='" + Convert.ToString(textbox_emailID.Text.Trim()) + "'";
                int username_count = 0;

                string query_result = login_dal.Get_Execute_Scalar(username_query);

                if(query_result != null && int.TryParse(query_result, out username_count))
                {
                    username_count = Convert.ToInt32(query_result);
                }
                // username is not correct
                if (username_count == 0)
                {
                    print_email_error_msg("This username does not exist", "2px solid red", "block");
                    email_containerID.Focus();
                }
                // password is not correct
                else
                {
                    print_password_error_msg("Kindly enter correct password", "2px solid red", "block");
                    pass_containerID.Focus();
                }
            }

        }

        // incorrect email
        protected void print_password_error_msg(string msg, string border, string display)
        {
            label_pass_errorID.Text = msg;
            pass_containerID.Style.Add("border", border);
            pass_error_block.Style.Add("display", display);
        }

        // incorrect email
        protected void print_email_error_msg(string msg, string border, string display)
        {
            label_email_errorID.Text = msg;
            email_containerID.Style.Add("border", border);
            email_error_block.Style.Add("display", display);
        }

    }
}