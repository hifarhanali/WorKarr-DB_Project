using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WorKar.DAL;
using System.Data;
using WorKar.BLL;


namespace WorKar
{
    public partial class gig_view : System.Web.UI.Page
    {
        private static int GigID = 0;

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
                    if (Request.QueryString["GigID"] == null)
                    {
                        Response.Redirect("~/smy_gigs.aspx");
                    }
                    GigID = (int)Convert.ToInt32(Request.QueryString["GigID"]);            // gig id

                    Update_User_Gig_Views();            // to update user gig views
                    Bind_Gig_Detail();                  // load gig detail
                    Bind_User_Detail();                 // load gig user detail
                    Bind_Reviews_Detail();              // load reviews of gig
                }
            }
        }

        // to update user gig views
        private void Update_User_Gig_Views()
        {
            DBAccess db_user_gig_view = new DBAccess();
            int hostUserID = (int)Convert.ToInt32(db_user_gig_view.Get_Execute_Scalar("SELECT UserID FROM Gig_user WHERE GigID=" + GigID));
            int visitUserID = (int)Convert.ToInt32(db_user_gig_view.Get_Execute_Scalar("SELECT UserID FROM [User] WHERE Username='" + Session["username"].ToString() + "'"));

            // if a user views his gig, it will not be counted
            if (visitUserID == hostUserID) return;

            db_user_gig_view.Insert_User_Gig_View("Insert_User_Gig_View", hostUserID, visitUserID, DateTime.Now, GigID);
        }

        // to bind specific gig of a user
        private void Bind_Gig_Detail()
        {
            string storedProcedureName = "Get_Gig_Detail";

            // to load specific gig of a user from the database
            DBAccess loadGig = new DBAccess();
            DataTable gig_detail = new DataTable();

            gig_detail = loadGig.Get_Gigs_Detail(storedProcedureName, null, GigID);

            rptrGig_DetailID.DataSource = gig_detail;
            rptrGig_DetailID.DataBind();
        }

        // to bind detail of user of the gig
        private void Bind_User_Detail()
        {
            string storedProcedureName = "Get_User_Detail";

            // to load specific gig of a user from the database
            DBAccess loadUser = new DBAccess();
            DataTable user_detail = new DataTable();

            int userID = (int)Convert.ToInt32(loadUser.Get_Execute_Scalar("SELECT UserID FROM Gig_user WHERE GigID=" + GigID));
            string username = loadUser.Get_Execute_Scalar("SELECT Username FROM [User] WHERE UserID=" + userID);


            user_detail = loadUser.Get_User_Detail(storedProcedureName, username);

            rptrUser_DetailID.DataSource = user_detail;
            rptrUser_DetailID.DataBind();
        }

        // to bnd reviews of specific gig
        private void Bind_Reviews_Detail()
        {
            string storedProcedureName = "Get_Reviews_Detail";

            // to load specific gig of a user from the database
            DBAccess loadReviews = new DBAccess();
            DataTable reviews_detail = new DataTable();

            reviews_detail = loadReviews.Get_Reviews_Detail(storedProcedureName, GigID);

            rptrReview_DetailID.DataSource = reviews_detail;
            rptrReview_DetailID.DataBind();
        }

        // to show stars
        public string ShowStars(object stars)
        {
            string starsHtml = "";
            Double rating = 0;
            int starsCount = 0;
            if (!String.IsNullOrEmpty(stars.ToString()))
            {
                rating = Convert.ToDouble(stars.ToString().Trim());
                starsCount = (int)Convert.ToDouble(stars.ToString().Trim());
            }

            for (int i = 0; i < starsCount; ++i)
            {
                starsHtml += "<i class=\"fas fa-star\"></i>\n";
            }

            if ((rating - (Double)starsCount) >= 0.5)
            {
                starsHtml += "<i class=\"fas fa-star-half-alt\"></i>\n";
                ++starsCount;
            }

            for (int i = starsCount; i < 5; ++i)
            {
                starsHtml += "<i class=\"far fa-star\"></i>\n";
            }



            return starsHtml;
        }

        [System.Web.Services.WebMethod]
        public static int Is_Review_Sent(string numOfStars, string reviewMessage)
        {
            if (GigID == 0) return 0;

            DAL.DBAccess db_review = new DBAccess();

            int userID = (int)Convert.ToInt32(db_review.Get_Execute_Scalar("SELECT UserID FROM [User] WHERE Username='" + HttpContext.Current.Session["username"].ToString() + "'"));

            int gigUser = (int)Convert.ToInt32(db_review.Get_Execute_Scalar("SELECT UserID FROM Gig_user WHERE GigID=" + GigID));

            if (userID == gigUser) return 3;        // cannot review to 

            int userOrderCount = 0;
            userOrderCount = Convert.ToInt32(db_review.Get_Execute_Scalar("SELECT COUNT(*) FROM [Order] WHERE FromUserID = " + userID));

            // if user has placed order
            if (userOrderCount != 0)
            {
                int GigUserID = (int)Convert.ToInt32(db_review.Get_Execute_Scalar("SELECT GigUserID FROM Gig_user WHERE GigID=" + GigID));

                // do not add review, if user has already give review to that gig
                int userGigReviewCount = 0;
                userGigReviewCount = (int)Convert.ToInt32(db_review.Get_Execute_Scalar("SELECT COUNT(*) FROM User_Review WHERE GigUserID=" + GigUserID));
                if (userGigReviewCount > 0)
                {
                    return 4;
                }

                // give review to user and store review detail in the database
                int reviewID = db_review.Insert_Review("Insert_Review", (int)Convert.ToInt32(numOfStars), reviewMessage, userID, DateTime.Now);
                db_review.Insert_User_Review("Insert_User_Review", reviewID, GigUserID);
                return 1;
            }
            return 2;
        }

        [System.Web.Services.WebMethod]
        public static int Is_Correct_Card_Details(string nameOnCard, string accountNum, string expiryDate, string cvs, string orderDescription, string duration, string amount)
        {
            DAL.DBAccess db_card_detail_count = new DBAccess();
            if (db_card_detail_count.Card_Detail_Match_Count("Card_Detail_Match_Count", nameOnCard, accountNum, expiryDate, cvs) > 0)
            {
                int balance = (int)Convert.ToInt32(db_card_detail_count.Get_Execute_Scalar("SELECT balance FROM Card_Detail WHERE AccountNumber='" + accountNum + "'"));

                // not sufficient balance
                if (balance < (int)Convert.ToInt32(amount))
                {
                    return 3;
                }

                // decrease balance in credit card
                db_card_detail_count.Execute_Non_Query("UPDATE Card_Detail SET Balance=Balance-" + (int)Convert.ToInt32(amount) + " WHERE  AccountNumber='" + accountNum + "'");

                if (GigID != 0)
                {
                    int toUserID = (int)Convert.ToInt32(db_card_detail_count.Get_Execute_Scalar("SELECT UserID FROM Gig_user WHERE GigID=" + GigID));
                    int fromUserID = (int)Convert.ToInt32(db_card_detail_count.Get_Execute_Scalar("SELECT UserID FROM [User] WHERE Username='" + HttpContext.Current.Session["username"].ToString() + "'"));

                    int days = (int)Convert.ToInt32(duration.Trim());
                    DateTime startingDate = DateTime.Now;
                    DateTime endingDate = DateTime.Now.AddDays(days);

                    return (int)Convert.ToInt32(db_card_detail_count.Insert_Order_Detail("Insert_Order_Detail", toUserID, (int)Convert.ToInt32(amount.Trim()), startingDate, endingDate, fromUserID, orderDescription));
                }
            }
            return 2;
        }

    }
}