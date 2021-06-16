using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WorKar.BLL
{
    public class User
    {
        private string fName;
        private string lName;
        private string gender;
        private string email;
        private string password;
        private string username;
        private string guid;
        public bool availability { get; set; }
        public int categoryID { get; set; }
        public string description { get; set; }

        public string photo { get; set; }

        public string User_FirstName
        {
            get { return fName; }
            set { fName = value; }
        }
        public string User_LastName
        {
            get { return lName; }
            set { lName = value; }
        }
        public string User_Gender
        {
            get { return gender; }
            set { gender = value; }
        }
        public string User_Email
        {
            get { return email; }
            set { email = value; }
        }
        public string User_Password
        {
            get { return password; }
            set { password = value; }
        }
        public string User_Username
        {
            get { return username; }
            set { username = value; }
        }
        public string User_Guid
        {
            get { return guid; }
            set { guid = value; }
        }

    }
}