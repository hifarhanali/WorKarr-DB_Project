using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WorKar.BLL
{
    public class Gig
    {
        public int GigID { get; set; }
        public string title { get; set; }
        public string postedDate { get; set; }
        public int duration { get; set; }
        public float amount { get; set; }
        public string description { get; set; }
        public int categoryID { get; set; }
        public string[] specifications { get; set; }

        public Gig()
        {
            this.specifications = new string[3];
        }
    }
}