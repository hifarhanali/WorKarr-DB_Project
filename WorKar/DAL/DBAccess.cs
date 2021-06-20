using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml;
using System.Data.SqlClient;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.SqlTypes;
using WorKar.BLL;


namespace WorKar.DAL
{
    public class DBAccess
    {
        private static ConnectionStringSettings objConnectionStringSettings = ConfigurationManager.ConnectionStrings["SQLDBConnection"];
        private static string strConnectionString = objConnectionStringSettings.ConnectionString;
        private static SqlConnection con = new SqlConnection(strConnectionString);

        public DBAccess()
        {

        }

        // return number of users that are present in database with that username and password 
        public int Match_Users_Count(string StoredProcedureName, string username, string password)
        {
            int returnValue = 0;
            try
            {
                SqlCommand cmd = new SqlCommand(StoredProcedureName.Trim(), con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Username", username.Trim());
                cmd.Parameters.AddWithValue("@Password", password.Trim());

                var outputParameter = cmd.Parameters.Add("@Count", SqlDbType.Int);
                outputParameter.Direction = ParameterDirection.Output;

                con.Open();
                cmd.ExecuteScalar();
                var count = outputParameter.Value;
                returnValue = (int)Convert.ToInt32(count);
            }
            catch
            {
                return 0;
            }
            finally
            {
                con.Close();
            }
            return returnValue;
        }

        // execute input query
        public string Get_Execute_Scalar(string query)
        {
            string result = "";
            try
            {
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                result = cmd.ExecuteScalar().ToString().Trim();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
            }
            return result;
        }

        // to insert new users in database
        public void Insert_User(string storedProcedureName, User user)
        {
            try
            {
                SqlCommand cmd = new SqlCommand(storedProcedureName, con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@fName", user.User_FirstName);
                cmd.Parameters.AddWithValue("@lName", user.User_LastName);
                cmd.Parameters.AddWithValue("@email", user.User_Email);
                cmd.Parameters.AddWithValue("@password", user.User_Password);
                cmd.Parameters.AddWithValue("@username", user.User_Username);
                cmd.Parameters.AddWithValue("@guid", user.User_Guid);
                con.Open();

                cmd.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
            }
        }

        // to execute non query
        public void Execute_Non_Query(string query)
        {
            try
            {
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                cmd.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
            }
        }

        // get all gig details of a specific user
        public DataTable Get_Gigs_Detail(string storedProcedureName, string username, int GigID = -1)
        {
            DataTable table = new DataTable();
            try
            {
                using (SqlCommand cmd = new SqlCommand(storedProcedureName, con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@username", username);
                    if (GigID != -1)
                    {
                        cmd.Parameters.AddWithValue("@GigID", GigID);
                    }

                    con.Open();

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        sda.Fill(table);
                    }
                }
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                con.Close();
            }
            return table;
        }


        // get all job details of a specific user
        public DataTable Get_Jobs_Detail(string storedProcedureName, string username, int JobID = -1)
        {
            DataTable table = new DataTable();
            try
            {
                using (SqlCommand cmd = new SqlCommand(storedProcedureName, con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@username", username);
                    if (JobID != -1)
                    {
                        cmd.Parameters.AddWithValue("@JobID", JobID);
                    }

                    con.Open();

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        sda.Fill(table);
                    }
                }
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                con.Close();
            }
            return table;

        }


        // get all gig details of a specific user
        public DataTable Get_Filtered_Gigs_Detail(string storedProcedureName, string sortBy, string maxPrice, string minPrice, string country, string duration, string categoryID, string seachBoxText)
        {
            DataTable table = new DataTable();
            try
            {
                using (SqlCommand cmd = new SqlCommand(storedProcedureName, con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    // add parameteres
                    cmd.Parameters.AddWithValue("@SortBy", sortBy);
                    cmd.Parameters.AddWithValue("@country", country);
                    if (!String.IsNullOrEmpty(categoryID))
                    {
                        cmd.Parameters.AddWithValue("@CategoryID", (int)Convert.ToInt32(categoryID));
                    }
                    if (!String.IsNullOrEmpty(maxPrice))
                    {
                        cmd.Parameters.AddWithValue("@maxPrice", (int)Convert.ToInt32(maxPrice));
                    }
                    if (!String.IsNullOrEmpty(minPrice))
                    {
                        cmd.Parameters.AddWithValue("@minPrice", (int)Convert.ToInt32(minPrice));
                    }
                    if (!String.IsNullOrEmpty(duration))
                    {
                        cmd.Parameters.AddWithValue("@Duration", (int)Convert.ToInt32(duration));
                    }
                    if (!String.IsNullOrEmpty(seachBoxText))
                    {
                        cmd.Parameters.AddWithValue("@searchText", seachBoxText);
                    }


                    con.Open();
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        sda.Fill(table);
                    }
                }
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                con.Close();
            }
            return table;
        }


        // to get a user detail
        public DataTable Get_User_Detail(string storedProcedureName, string username)
        {
            DataTable table = new DataTable();
            try
            {
                using (SqlCommand cmd = new SqlCommand(storedProcedureName, con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@username", username);

                    con.Open();

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        sda.Fill(table);
                    }
                }
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                con.Close();
            }
            return table;
        }

        // to get detail of reviews of a specific gig
        public DataTable Get_Reviews_Detail(string storedProcedureName, int GigID)
        {
            DataTable table = new DataTable();
            try
            {
                using (SqlCommand cmd = new SqlCommand(storedProcedureName, con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@GigID", GigID);

                    con.Open();

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        sda.Fill(table);
                    }
                }
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                con.Close();
            }
            return table;
        }

        // get table of data using query
        public DataTable GetData(string query)
        {
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    return dt;
                }
            }
        }

        // to insert images of a gig
        public void Insert_Images(string storedProcedureName, int GigUserID, Dictionary<string, string> images)
        {
            try
            {
                SqlCommand cmd = new SqlCommand(storedProcedureName, con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@GigUserID", GigUserID);
                // set parameters
                foreach (KeyValuePair<string, string> image in images)
                {
                    cmd.Parameters.AddWithValue("@" + image.Key, image.Value);
                }
                con.Open();
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (con.State == System.Data.ConnectionState.Open) con.Close();
            }

        }

        // to insert new gig and return GigID
        public int Insert_Gig(string storedProcedureName, BLL.Gig gig)
        {
            int GigID = 0;
            try
            {
                SqlCommand cmd = new SqlCommand(storedProcedureName, con);
                cmd.CommandType = CommandType.StoredProcedure;

                // set parameters
                cmd.Parameters.AddWithValue("@Title", gig.title);
                cmd.Parameters.AddWithValue("@Description", gig.description);
                cmd.Parameters.AddWithValue("@Amount", gig.amount);
                cmd.Parameters.AddWithValue("@CategoryID", gig.categoryID);
                cmd.Parameters.AddWithValue("@PostedDate", gig.postedDate);
                cmd.Parameters.AddWithValue("@Specification1", gig.specifications[0]);
                cmd.Parameters.AddWithValue("@Specification2", gig.specifications[1]);
                cmd.Parameters.AddWithValue("@Specification3", gig.specifications[2]);
                cmd.Parameters.AddWithValue("@Duration", gig.duration);

                con.Open();
                GigID = Convert.ToInt32(cmd.ExecuteScalar());
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (con.State == System.Data.ConnectionState.Open) con.Close();
            }
            return (GigID);
        }

        // to insert new gig_user record and return GigUserID
        public int Insert_Gig_User(string storedProcedureName, int GigID, int UserID)
        {
            int GigUserID = 0;
            try
            {
                SqlCommand cmd = new SqlCommand(storedProcedureName, con);
                cmd.CommandType = CommandType.StoredProcedure;

                // set parameters
                cmd.Parameters.AddWithValue("@GigID", GigID);
                cmd.Parameters.AddWithValue("@UserID", UserID);

                con.Open();
                GigUserID = Convert.ToInt32(cmd.ExecuteScalar());
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (con.State == System.Data.ConnectionState.Open) con.Close();
            }
            return (int)(GigUserID);
        }

        // to insert new job and return JobID
        public int Insert_Job(string storedProcedureName, BLL.Gig job)
        {
            int JobID = 0;
            try
            {
                SqlCommand cmd = new SqlCommand(storedProcedureName, con);
                cmd.CommandType = CommandType.StoredProcedure;

                // set parameters
                cmd.Parameters.AddWithValue("@Title", job.title);
                cmd.Parameters.AddWithValue("@Description", job.description);
                cmd.Parameters.AddWithValue("@Amount", job.amount);
                cmd.Parameters.AddWithValue("@CategoryID", job.categoryID);
                cmd.Parameters.AddWithValue("@PostedDate", job.postedDate);
                cmd.Parameters.AddWithValue("@Duration", job.duration);

                con.Open();
                JobID = Convert.ToInt32(cmd.ExecuteScalar());
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (con.State == System.Data.ConnectionState.Open) con.Close();
            }
            return (JobID);
        }

        // to insert new Job_User record
        public void Insert_Job_User(string storedProcedureName, int JobID, int UserID)
        {
            try
            {
                SqlCommand cmd = new SqlCommand(storedProcedureName, con);
                cmd.CommandType = CommandType.StoredProcedure;

                // set parameters
                cmd.Parameters.AddWithValue("@JobID", JobID);
                cmd.Parameters.AddWithValue("@UserID", UserID);

                con.Open();
                Convert.ToInt32(cmd.ExecuteScalar());
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (con.State == System.Data.ConnectionState.Open) con.Close();
            }
        }

        // top update gig detail
        public void Update_Gig_Detail(string storedProcedureName, int GigID, BLL.Gig gig, Dictionary<string, string> images)
        {
            try
            {
                SqlCommand cmd = new SqlCommand(storedProcedureName, con);
                cmd.CommandType = CommandType.StoredProcedure;

                // Add parameters
                cmd.Parameters.AddWithValue("@GigID", GigID);
                cmd.Parameters.AddWithValue("@Title", gig.title);
                cmd.Parameters.AddWithValue("@Description", gig.description);
                cmd.Parameters.AddWithValue("@Amount", gig.amount);
                cmd.Parameters.AddWithValue("@CategoryID", gig.categoryID);
                cmd.Parameters.AddWithValue("@Specification1", gig.specifications[0]);
                cmd.Parameters.AddWithValue("@Specification2", gig.specifications[1]);
                cmd.Parameters.AddWithValue("@Specification3", gig.specifications[2]);
                cmd.Parameters.AddWithValue("@Duration", gig.duration);

                // add images as parameter
                foreach (KeyValuePair<string, string> image in images)
                {
                    cmd.Parameters.AddWithValue("@" + image.Key, image.Value);
                }
                con.Open();
                cmd.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
            }
        }

        // top update job detail
        public void Update_Job_Detail(string storedProcedureName, int JobID, BLL.Gig job)
        {
            try
            {
                SqlCommand cmd = new SqlCommand(storedProcedureName, con);
                cmd.CommandType = CommandType.StoredProcedure;

                // Add parameters
                cmd.Parameters.AddWithValue("@JobID", JobID);
                cmd.Parameters.AddWithValue("@Title", job.title);
                cmd.Parameters.AddWithValue("@Description", job.description);
                cmd.Parameters.AddWithValue("@Amount", job.amount);
                cmd.Parameters.AddWithValue("@CategoryID", job.categoryID);
                cmd.Parameters.AddWithValue("@Duration", job.duration);
                con.Open();
                cmd.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
            }
        }

        // top update gig detail
        public void Update_User_Detail(string storedProcedureName, BLL.User user)
        {
            try
            {
                SqlCommand cmd = new SqlCommand(storedProcedureName, con);
                cmd.CommandType = CommandType.StoredProcedure;

                // Add parameters
                cmd.Parameters.AddWithValue("@FName", user.User_FirstName);
                cmd.Parameters.AddWithValue("@LName", user.User_LastName);
                cmd.Parameters.AddWithValue("@Username", user.User_Username);
                cmd.Parameters.AddWithValue("@Gender", user.User_Gender);
                cmd.Parameters.AddWithValue("@Description", user.description);
                cmd.Parameters.AddWithValue("@Availability", user.availability);
                cmd.Parameters.AddWithValue("@CategoryID", user.categoryID);
                cmd.Parameters.AddWithValue("@Country", user.User_Country);
                if (String.IsNullOrEmpty(user.User_Password) == false)
                {
                    cmd.Parameters.AddWithValue("@password", user.User_Password);
                }
                if (String.IsNullOrEmpty(user.photo) == false)
                {
                    cmd.Parameters.AddWithValue("@Photo", user.photo);
                }

                con.Open();
                cmd.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
            }
        }

        // get total debit or credit of a user
        public int Get_Total_Credit_Debit(string storedProcedureName, string username)
        {
            int totalAmount = 0;
            try
            {
                SqlCommand cmd = new SqlCommand(storedProcedureName, con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Username", username);

                con.Open();
                totalAmount = (int)Convert.ToInt32(cmd.ExecuteScalar());
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
            }

            return totalAmount;
        }


        // get order history of a user
        public DataTable Get_Order_History(string storedProcedureName, string username, string status = null, int isPostedOrders = -1, int TOTAL_ORDERS = -1)
        {
            DataTable table = new DataTable();
            try
            {
                using (SqlCommand cmd = new SqlCommand(storedProcedureName, con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@username", username);

                    if (!String.IsNullOrEmpty(status))
                    {
                        cmd.Parameters.AddWithValue("@Status", status);

                    }
                    if (isPostedOrders != -1)
                    {
                        cmd.Parameters.AddWithValue("@IsPostedOrders", Convert.ToBoolean(isPostedOrders));
                    }

                    if (TOTAL_ORDERS != -1)
                    {
                        cmd.Parameters.AddWithValue("@TotalOrders", TOTAL_ORDERS);
                    }


                    con.Open();

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        sda.Fill(table);
                    }
                }
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                con.Close();
            }
            return table;

        }


        // get detail of a specific order
        public DataTable Get_Order_Detail(string storedProcedureName, int OrderID)
        {
            DataTable table = new DataTable();
            try
            {
                using (SqlCommand cmd = new SqlCommand(storedProcedureName, con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@OrderID", OrderID);
                    con.Open();

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        sda.Fill(table);
                    }
                }
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                con.Close();
            }
            return table;

        }




        // to find count of match card details
        public int Card_Detail_Match_Count(string storedProcedureName, string nameOnCard, string accountNum, string expiryDate, string cvs)
        {
            int count = 0;
            try
            {
                SqlCommand cmd = new SqlCommand(storedProcedureName, con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@NameOnCard", nameOnCard);
                cmd.Parameters.AddWithValue("@AccountNumber", accountNum);
                cmd.Parameters.AddWithValue("@ExpiryDate", expiryDate);
                cmd.Parameters.AddWithValue("@CVV", cvs);

                con.Open();
                count = (int)Convert.ToInt32(cmd.ExecuteScalar());
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
            }

            return count;
        }

        // to insert detail of new order
        public bool Insert_Order_Detail(string storedProcedureName, int ToUserID, int price, DateTime startingDate, DateTime endingDate, int fromUserID, string description)
        {
            bool returnValue = false;
            try
            {
                SqlCommand cmd = new SqlCommand(storedProcedureName, con);
                cmd.CommandType = CommandType.StoredProcedure;

                // set parameters
                cmd.Parameters.AddWithValue("@Description", description);
                cmd.Parameters.AddWithValue("@FromUserID", fromUserID);
                cmd.Parameters.AddWithValue("@ToUserID", ToUserID);
                cmd.Parameters.AddWithValue("@StartingDate", startingDate);
                cmd.Parameters.AddWithValue("@EndingDate", endingDate);
                cmd.Parameters.AddWithValue("@Amount", price);

                var outputParameter = cmd.Parameters.Add("@ReturnValue", SqlDbType.Bit);
                outputParameter.Direction = ParameterDirection.Output;

                con.Open();
                cmd.ExecuteScalar();
                var temp = outputParameter.Value;
                returnValue = Convert.ToBoolean(temp);

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (con.State == System.Data.ConnectionState.Open) con.Close();
            }
            return returnValue;
        }

        // to insert new gig and return GigID
        public int Insert_Review(string storedProcedureName, int stars, string reviewMsg, int fromUserID, DateTime postedDate)
        {
            int reviewID = 0;
            try
            {
                SqlCommand cmd = new SqlCommand(storedProcedureName, con);
                cmd.CommandType = CommandType.StoredProcedure;

                // set parameters
                cmd.Parameters.AddWithValue("@Stars", stars);
                cmd.Parameters.AddWithValue("@reviewMsg", reviewMsg);
                cmd.Parameters.AddWithValue("@FromUserID", fromUserID);
                cmd.Parameters.AddWithValue("@PostedDate", postedDate);

                con.Open();
                reviewID = Convert.ToInt32(cmd.ExecuteScalar());
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (con.State == System.Data.ConnectionState.Open) con.Close();
            }
            return (reviewID);
        }

        // to insert new user review record
        public void Insert_User_Review(string storedProcedureName, int ReviewID, int GigUserID)
        {
            try
            {
                SqlCommand cmd = new SqlCommand(storedProcedureName, con);
                cmd.CommandType = CommandType.StoredProcedure;

                // set parameters
                cmd.Parameters.AddWithValue("@ReviewID", ReviewID);
                cmd.Parameters.AddWithValue("@GigUserID", GigUserID);

                con.Open();
                cmd.ExecuteScalar();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (con.State == System.Data.ConnectionState.Open) con.Close();
            }
        }


        // to insert new gig and return GigID
        public void Insert_User_Gig_View(string storedProcedureName, int HostUserID, int visitUserID, DateTime visitedDate, int GigID)
        {
            try
            {
                SqlCommand cmd = new SqlCommand(storedProcedureName, con);
                cmd.CommandType = CommandType.StoredProcedure;

                // set parameters
                cmd.Parameters.AddWithValue("@HostUserID", HostUserID);
                cmd.Parameters.AddWithValue("@VisitUserID", visitUserID);
                cmd.Parameters.AddWithValue("@VisitedDate", visitedDate);
                cmd.Parameters.AddWithValue("@GigID", GigID);

                con.Open();
                cmd.ExecuteScalar();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (con.State == System.Data.ConnectionState.Open) con.Close();
            }
        }

        // to get user views week days summary detail
        public DataTable Get_User_View_Week_Days_Summary(string storedProcedureName, int UserID)
        {
            DataTable table = new DataTable();
            try
            {
                using (SqlCommand cmd = new SqlCommand(storedProcedureName, con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@UserID", UserID);

                    con.Open();

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        sda.Fill(table);
                    }
                }
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                con.Close();
            }
            return table;
        }

        // to get user orders week days summary detail
        public DataTable Get_User_Order_Week_Days_Summary(string storedProcedureName, int UserID)
        {
            return this.Get_User_View_Week_Days_Summary(storedProcedureName, UserID);
        }


        // to get user summary
        public DataTable Get_User_Summary(string storedProcedureName, int UserID)
        {
            return this.Get_User_View_Week_Days_Summary(storedProcedureName, UserID);
        }


        // to save messages in ddatabase
        public void Save_MessageDetail_List(string storedProcedureName, List<MessageDetail> messageDetailList)
        {
            try
            {
                con.Open();
                // store message on database
                foreach (MessageDetail message in messageDetailList)
                {
                    SqlCommand cmd = new SqlCommand(storedProcedureName, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@FromUserName", message.FromUserName);
                    cmd.Parameters.AddWithValue("@ToUserName", message.ToUserName);
                    cmd.Parameters.AddWithValue("@message", message.Message.Trim());
                    cmd.Parameters.AddWithValue("@AddedOn", message.AddedOn);
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
            }

        }


        // to load messages from ddatabase
        public DataTable Load_Messages(string storedProcedureName, string fromUserName)
        {
            DataTable table = new DataTable();
            try
            {
                using (SqlCommand cmd = new SqlCommand(storedProcedureName, con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@FromUserName", fromUserName);
                    con.Open();
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        sda.Fill(table);
                    }
                }
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                con.Close();
            }
            return table;
        }


        // to load contacts of a user
        public DataTable Load_Contacts(string storedProcedureName, string username)
        {
            return this.Get_Jobs_Detail(storedProcedureName, username);
        }


        // to save messages in ddatabase
        public void Insert_MessageDetail(string storedProcedureName, MessageDetail message)
        {
            try
            {
                SqlCommand cmd = new SqlCommand(storedProcedureName.Trim(), con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@FromUserName", message.FromUserName);
                cmd.Parameters.AddWithValue("@ToUserName", message.ToUserName);
                cmd.Parameters.AddWithValue("@Message", message.Message.Trim());
                cmd.Parameters.AddWithValue("@AddedOn", message.AddedOn);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
            }

        }


    }
}

