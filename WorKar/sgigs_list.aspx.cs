using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace WorKar
{
    public partial class WebForm2 : System.Web.UI.Page
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
                    // load categories in catgeory drop down menu
                    DAL.DBAccess loadCategoryList = new DAL.DBAccess();
                    ddlCategories.DataSource = loadCategoryList.GetData("SELECT [Name] AS category_name, CategoryID AS category_id FROM Category");
                    ddlCategories.DataBind();
                }
            }
        }

        // to get all filtered gigs
        [System.Web.Services.WebMethod]
        public static string Get_Filtered_Gigs(string sortBy, string maxPrice, string minPrice, string country, string duration, string categoryID, string searchBoxText, string searchFor)
        {
            searchFor = searchFor == "-1" ? null : searchFor;
            sortBy = sortBy == "-1" ? null : sortBy;
            maxPrice = maxPrice == "-1" ? null : maxPrice.Trim();
            minPrice = minPrice == "-1" ? null : minPrice.Trim();
            country = country == "-1" ? null : country;
            duration = duration == "-1" ? null : duration;
            categoryID = categoryID == "-1" ? null : categoryID;
            searchBoxText = searchBoxText.Trim() == "-1" ? null : searchBoxText.Trim();

            DAL.DBAccess db_gigs_detail = new DAL.DBAccess();
            DataSet set = new DataSet();
            DataTable table = null;

            if(!String.IsNullOrEmpty(searchFor) && searchFor == "Gigs")
            {
                table = db_gigs_detail.Get_Filtered_Gigs_Detail("Get_Filtered_Gigs_Detail", sortBy, maxPrice, minPrice, country, duration, categoryID, searchBoxText);
            }
            else if(!String.IsNullOrEmpty(searchFor) && searchFor == "Jobs")
            {
                table = db_gigs_detail.Get_Filtered_Gigs_Detail("Get_Filtered_Jobs_Detail", sortBy, maxPrice, minPrice, country, duration, categoryID, searchBoxText);
            }

            set.Tables.Add(table);
            // return data in xml form
            return set.GetXml();
        }

    }
}