using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WorKar.DAL;


namespace WorKar
{
    public partial class email_confirmation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Set_Valid_Email_Flag();
        }

        // set isValidEmail flag of email in database to true
        protected void Set_Valid_Email_Flag()
        {
            string host = Request.Url.ToString();     // format: guid=<guid_number> 
            string[] parseHost = host.Split('=');

            if (parseHost != null && parseHost.Length > 1)
            {
                string guid = parseHost[1];             // guid
                if (guid != null)
                {
                    guid = guid.Replace("'", "");

                    DBAccess db = new DBAccess();
                    //set valid email flag
                    string query = @"UPDATE [User] SET IsValidEmail=1 WHERE [guid] LIKE '%" + guid + "%'";
                    db.Execute_Non_Query(query);
                }

            }
        }

        protected void btn_loginPageID_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
            signup send_mail = new signup();
        }

    }
}