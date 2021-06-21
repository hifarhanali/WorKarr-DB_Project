using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;


namespace WorKar
{
    public partial class WebForm4 : System.Web.UI.Page
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
                    Bind_Earning_Detail();
                    Bind_Transaction_Detail();
                    Bind_Order_Detail();
                }
            }
        }

        // load Order history
        private void Bind_Order_Detail()
        {
            DAL.DBAccess db_order_detail = new DAL.DBAccess();
            DataTable orders = db_order_detail.Get_Order_History("Get_Order_History", Session["username"].ToString());
            rptrOrder_detail.DataSource = orders;
            rptrOrder_detail.DataBind();
        }



        // load total credit and total debit
        private void Bind_Earning_Detail()
        {
            DAL.DBAccess db_earning_detail = new DAL.DBAccess();
            TotalCredit.InnerText = db_earning_detail.Get_Total_Credit_Debit("Get_Total_Credit", Session["username"].ToString()).ToString();
            TotalDebit.InnerText = db_earning_detail.Get_Total_Credit_Debit("Get_Total_Debit", Session["username"].ToString()).ToString();

            int userID = (int)Convert.ToInt32(db_earning_detail.Get_Execute_Scalar("SELECT UserID FROM [User] WHERE Username='" + Session["username"].ToString() + "'"));

            int totalEarnings = (int)Convert.ToInt32(db_earning_detail.Get_Execute_Scalar("SELECT SUM(Amount) FROM [Order] WHERE ToUserID=" + userID + " AND LOWER(Status)=LOWER('Completed')"));

            int myNetBalance = totalEarnings + (int)Convert.ToInt32(TotalCredit.InnerText) - (int)Convert.ToInt32(TotalDebit.InnerText);

            netBalance.InnerText = myNetBalance.ToString();
        }

        // load transaction history
        private void Bind_Transaction_Detail()
        {
            DAL.DBAccess db_transaction_detail = new DAL.DBAccess();
            int userID = (int)Convert.ToInt32(db_transaction_detail.Get_Execute_Scalar("SELECT UserID FROM [User] Where Username='" + Session["username"].ToString() + "'"));
            DataTable transactions = db_transaction_detail.GetData("SELECT * FROM [Transaction] Where UserID=" + userID.ToString() + "ORDER BY TransactionDate DESC");

            rptrTransaction_detail.DataSource = transactions;
            rptrTransaction_detail.DataBind();
        }

        public string Get_Transaction_Type(object myValue)
        {
            if (Convert.ToBoolean(myValue) == true)
            {
                return "WithDraw";
            }
            return "Deposit";
        }

        public string Get_Date(object myValue)
        {
            char[] seprator = { ' ' };
            return myValue.ToString().Split(seprator)[0];
        }



        [System.Web.Services.WebMethod]
        public static int Perform_Transaction(string nameOnCard, string accountNum, string expiryDate, string cvv, string amount, string isWithdraw)
        {
            DAL.DBAccess db_card_detail_count = new DAL.DBAccess();

            if (db_card_detail_count.Card_Detail_Match_Count("Card_Detail_Match_Count", nameOnCard, accountNum, expiryDate, cvv) > 0)
            {

                isWithdraw = isWithdraw.Trim();
                int withdrawAmount = (int)Convert.ToInt32(amount.Trim());

                if (isWithdraw == "1")
                {
                    int balance = (int)Convert.ToInt32(db_card_detail_count.Get_Execute_Scalar("SELECT balance FROM Card_Detail WHERE AccountNumber='" + accountNum + "'"));

                    // not sufficient balance
                    if (balance < withdrawAmount)
                    {
                        return 0;
                    }
                }
                int UserID = (int)Convert.ToInt32(db_card_detail_count.Get_Execute_Scalar("SELECT UserID FROM [User] WHERE Username='" + HttpContext.Current.Session["username"].ToString() + "'"));
                DateTime transactionDateDate = DateTime.Now;

                db_card_detail_count.Insert_Transaction_Detail("Insert_Transaction_Detail", UserID, (isWithdraw == "1" ? true : false), withdrawAmount, transactionDateDate);
                return 1;
            }

            return 2;           // card details are not correct
        }

    }
}