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

        static string toUserName = null;

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
                    if (Request.QueryString["username"] != null)
                    {
                        toUserName = Request.QueryString["username"].ToString();
                    }

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
            DataTable table = db_load_contacts.Load_Contacts("Load_Contacts", Session["username"].ToString());

            string toUserPhoto = null;
            if (toUserName != null)
            {
                if (toUserName != Session["username"].ToString())
                {
                    toUserPhoto = db_load_contacts.Get_Execute_Scalar("SELECT Photo FROM [User] WHERE Username='" + toUserName + "'");

                    if (toUserPhoto != null)
                    {
                        DataRow topRow = table.NewRow();
                        topRow["contactUserName"] = toUserName;
                        topRow["contactUserPhoto"] = toUserPhoto;
                        table.Rows.InsertAt(topRow, 0);
                    }

                }
            }

            // to delete duplicate contacts
            for (int i = table.Rows.Count - 1; i > 0; i--)
            {
                DataRow dr = table.Rows[i];
                if (dr["contactUserName"] != null && dr["contactUserName"].ToString() == toUserName)
                {
                    dr.Delete();
                }
            }
            table.AcceptChanges();

            rptrContacts_list.DataSource = table;
            rptrContacts_list.DataBind();
        }


        [System.Web.Services.WebMethod]
        public static string Load_Messages(string contactUserName)
        {
            if (HttpContext.Current.Session["username"] == null || contactUserName == HttpContext.Current.Session["username"].ToString().Trim())
            {
                return "";
            }

            DataTable table = new DataTable();
            DataSet set = new DataSet();

            DAL.DBAccess db_load_messages = new DAL.DBAccess();
            table = db_load_messages.Load_Messages("Load_Messages", contactUserName, HttpContext.Current.Session["username"].ToString());

            set.Tables.Add(table);
            return set.GetXml();
        }


        [System.Web.Services.WebMethod]
        public static string Send_Private_Message(string toUserName, string message)
        {
            if (HttpContext.Current.Session["username"] == null || toUserName == HttpContext.Current.Session["username"].ToString().Trim())
            {
                return "";
            }

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



        [System.Web.Services.WebMethod]
        public static string Get_Updated_Contacts_Status(string[] contactsUsernames)
        {
            DataSet set = new DataSet();
            DataTable table = new DataTable();

            // add columns
            DataColumn Username = new DataColumn("Username", typeof(string));
            DataColumn UserStatus = new DataColumn("UserStatus", typeof(string));
            table.Columns.Add(Username);
            table.Columns.Add(UserStatus);

            String[] myContactsUsernames = contactsUsernames;

            DAL.DBAccess db_get_contacts_status = new DAL.DBAccess();

            // get status of all users i.e offline/online
            for (int i = 0; i < myContactsUsernames.Length; ++i)
            {
                string status = db_get_contacts_status.Get_Execute_Scalar("SELECT dbo.Get_User_Status('" + myContactsUsernames[i] + "')");

                if (!String.IsNullOrEmpty(status))
                {
                    DataRow row = table.NewRow();
                    row["Username"] = myContactsUsernames[i];
                    row["UserStatus"] = status;
                    table.Rows.Add(row);
                }
            }

            set.Tables.Add(table);
            return set.GetXml();
        }
    }
}