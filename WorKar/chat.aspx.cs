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


        [System.Web.Services.WebMethod]
        public static string Load_Messages(string contactUserName)
        {
            DataTable table = new DataTable();
            DataSet set = new DataSet();

            DAL.DBAccess db_load_messages = new DAL.DBAccess();
            table = db_load_messages.Load_Messages("Load_Messages", contactUserName);

            set.Tables.Add(table);
            return set.GetXml();
        }


        [System.Web.Services.WebMethod]
        public static string Send_Private_Message(string toUserName, string message)
        {
            try
            {
                BLL.MessageDetail messageObject = new BLL.MessageDetail();
                messageObject.AddedOn = DateTime.Now;
                messageObject.FromUserName = HttpContext.Current.Session["username"].ToString();
                messageObject.ToUserName = toUserName;
                messageObject.Message = message;

                DAL.DBAccess db_send_message = new DAL.DBAccess();
                db_send_message.Insert_MessageDetail("Insert_MessageDetail", messageObject);
                return message + "-" + messageObject.AddedOn.ToString();
            }
            catch
            {
                return message;
            }
        }
    }
}