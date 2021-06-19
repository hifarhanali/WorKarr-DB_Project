using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;


namespace WorKar
{
    public partial class chat : System.Web.UI.Page
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
                    Load_Contacts();            // load contatcs list
                }
            }
        }

        // to load user contacts list
        private void Load_User_Detail()
        {
            DAL.DBAccess db_load_user_detail = new DAL.DBAccess();
            
            rptrUser_DetailID.DataSource = db_load_user_detail.Get_User_Detail("Get_User_Detail", Session["username"].ToString()); ;
            rptrUser_DetailID.DataBind();
        }

        // to load user contacts list
        private void Load_Contacts()
        {
            DAL.DBAccess db_load_contacts = new DAL.DBAccess();
            rptrContacts_list.DataSource = db_load_contacts.Load_Contacts("Load_Contacts", Session["username"].ToString());
            rptrContacts_list.DataBind();
        }
    }
}