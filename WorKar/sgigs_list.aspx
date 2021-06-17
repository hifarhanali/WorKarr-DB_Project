<%@ Page Title="" Language="C#" MasterPageFile="~/seller.Master" AutoEventWireup="true" CodeBehind="sgigs_list.aspx.cs" Inherits="WorKar.WebForm2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Gigs | WorKarr</title>
    <%-- My Stylesheet --%>
    <link href="style/jobs_list.css" rel="stylesheet" runat="server" />

    <style runat="server">
        .job:hover {
            box-shadow: 0px 0px 10px lightblue;
            transition: all 0.3s;
            transform: scale(1.01);
        }

        .search-btn-container {
            visibility: visible !important;
        }
    </style>

    <!--AJAX API-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            showGigs();
            $("#search_item_box").keyup(showGigs);
        });


        // add onchange event to radio buttons
        function addOnChangeToRadioBtn(radiobtn_name) {
            $(document).ready(function () {
                $('input[type=radio][name="' + radiobtn_name + '"]').change(function () {
                    showGigs();
                });
            });
        }
        addOnChangeToRadioBtn("sort-by-radio");
        addOnChangeToRadioBtn("search-for-radio");
        addOnChangeToRadioBtn("duration-radio");        // duration radio buttons


        // to show list of filtered gigs 
        function showGigs() {
            var sortBy, maxPrice, minPrice, country, duration, categoryID, searchBoxText, searchFor;
            sortBy = maxPrice = minPrice = country = duration = categoryID = searchBoxText = searchFor = null;

            sortBy = $('input[name="sort-by-radio"]:checked').val();
            searchFor = $('input[name="search-for-radio"]:checked').val();
            maxPrice = $("#maxPrice").val();
            minPrice = $("#minPrice").val();
            country = $("#countryId").find(":selected").val();
            duration = $('input[name="duration-radio"]:checked').val();
            categoryID = $("#<%= ddlCategories.ClientID%>").find(":selected").val();
            searchBoxText = $("#search_item_box").val();

            // to display result accordingly
            var isSearchForGig = (searchFor == "Gigs"); 
            if (isSearchForGig) {
                $("#no-gig-found-error").text("No Gig Found");
            }
            else {
                $("#no-gig-found-error").text("No Job Found");
            }

            
            if (typeof sortBy == "undefined") sortBy = -1;
            if (typeof searchFor == "undefined") searchFor = -1;
            if (typeof maxPrice == "undefined") maxPrice = -1;
            if (typeof minPrice == "undefined") minPrice = -1;
            if (typeof country == "undefined" || country == "none") country = -1;
            if (typeof duration == "undefined") duration = -1;
            if (typeof categoryID == "undefined" || categoryID == 0) categoryID = -1;
            if (typeof searchBoxText == "undefined" || searchBoxText == "") searchBoxText = -1;


            $.ajax({
                type: "POST",
                url: "sgigs_list.aspx/Get_Filtered_Gigs",
                data: '{"sortBy":"' + sortBy + '","maxPrice":"' + maxPrice + '","minPrice":"' + minPrice
                    + '","country":"' + country + '","duration":"' + duration + '","categoryID":"' + categoryID
                    + '","searchBoxText":"' + searchBoxText + '","searchFor":"' + searchFor + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                failure: function (response) {
                    alert("Failed");
                }
            });
            function OnSuccess(response) {
                $("#no-gig-found-error").css("display", "none");
                var xmlDoc = $.parseXML(response.d);
                var xml = $(xmlDoc);
                var gigs = xml.find("Table1");

                $("#divGigs").empty();              // to clear previous data
                for (var i = 0; i < gigs.length; ++i)
                {
                    var template;
                    if (isSearchForGig) {
                        let tempRating = gigs[i].getElementsByTagName("GigRating")[0].childNodes[0].nodeValue;
                        var gig =
                        {
                            GigID: gigs[i].getElementsByTagName("GigID")[0].childNodes[0].nodeValue,
                            Image1: gigs[i].getElementsByTagName("Image1")[0].childNodes[0].nodeValue,
                            UserPhoto: gigs[i].getElementsByTagName("UserPhoto")[0].childNodes[0].nodeValue,
                            Title: gigs[i].getElementsByTagName("Title")[0].childNodes[0].nodeValue,
                            PostedDate: gigs[i].getElementsByTagName("PostedDate")[0].childNodes[0].nodeValue,
                            Description: gigs[i].getElementsByTagName("Description")[0].childNodes[0].nodeValue,
                            Amount: gigs[i].getElementsByTagName("Amount")[0].childNodes[0].nodeValue,
                            Category: gigs[i].getElementsByTagName("Category")[0].childNodes[0].nodeValue,
                            Rating: tempRating == 0 ? "Not Rated" : tempRating
                        };

                        template = get_gig_template(gig);
                    }
                    else {
                        var job =
                        {
                            JobID: gigs[i].getElementsByTagName("JobID")[0].childNodes[0].nodeValue,
                            UserPhoto: gigs[i].getElementsByTagName("UserPhoto")[0].childNodes[0].nodeValue,
                            Title: gigs[i].getElementsByTagName("Title")[0].childNodes[0].nodeValue,
                            PostedDate: gigs[i].getElementsByTagName("PostedDate")[0].childNodes[0].nodeValue,
                            Description: gigs[i].getElementsByTagName("Description")[0].childNodes[0].nodeValue,
                            Amount: gigs[i].getElementsByTagName("Amount")[0].childNodes[0].nodeValue,
                            Category: gigs[i].getElementsByTagName("Category")[0].childNodes[0].nodeValue
                        };
                        template = get_job_template(job);

                    }
                    $("#divGigs").append(template);
                }

                if (gigs.length == 0) {
                    $("#no-gig-found-error").css("display", "block");
                }
                else {
                    $("#divGigs").append('<div style="height:200px;"></div>');
                    $("#divGigs").append('<div style="height:200px;"></div>');
                    $("#divGigs").append('<div style="height:200px;"></div>');
                }

            }


            // return a job template
            function get_job_template(job)
            {
                return "<div class=\"job\" style=\"height:245px;\" id='" + job.JobID + "' > \
                    <a href=\"job_view.aspx?JobID=" + job.JobID + "\"> \
                                             <div class=\"div-content-sec\"> \
                                                 <div class=\"top-sec\"> \
                                                     <div class=\"img-container\"> \
                                                         <img src=\"" + job.UserPhoto + "\" alt=\"user-img\" onerror=\"this.src = 'images/gig_images/image_not_found.png'\" /> \
                                                     </div> \
                                                     <div class=\"job-title\"> \
                                                         <h2>" + job.Title + "</h2> \
                                    <div class=\"posted-time\"> \
                                       <p>" + job.PostedDate + "</p> \
                                    </div> \
                                 </div> \
                                 <p>Rs. " + job.Amount + "</p> \
                              </div> \
                              <div class=\"middle-sec job-description\" style=\"height: 7.7rem;\"> \
                                 <p>" + job.Description + "</p> \
                              </div> \
                        </a> \
                        <div class=\"bottom-sec job-category\"> \
                            <div class=\"category\">" + job.Category + "</div> \
                        </div> \
                        </div> \
                </div>";
            }


            // return a gig template
            function get_gig_template(gig) {
                return "<div class=\"job\" id='" + gig.GigID + "' > \
                    <a href=\"gig_view.aspx?GigID=" + gig.GigID + "\"> \
                                             <div class='gig-img-container'> \
                                                 <img src='"+ gig.Image1 + "' alt=\"gig-display - img\" onerror=\"this.src = 'images/gig_images/image_not_found.png'\" /> \
                                             </div> \
                                             <div class=\"div-content-sec\"> \
                                                 <div class=\"top-sec\"> \
                                                     <div class=\"img-container\"> \
                                                         <img src=\"" + gig.UserPhoto + "\" alt=\"user-img\" onerror=\"this.src = 'images/gig_images/image_not_found.png'\" /> \
                                                     </div> \
                                                     <div class=\"job-title\"> \
                                                         <h2>" + gig.Title + "</h2> \
                                    <div class=\"posted-time\"> \
                                       <p>" + gig.PostedDate + "</p> \
                                    </div> \
                                 </div> \
                                 <p>Rs. " + gig.Amount + "</p> \
                              </div> \
                              <div class=\"middle-sec job-description\"> \
                                 <p>" + gig.Description + "</p> \
                              </div> \
                        </a> \
                        <div class=\"bottom-sec job-category\" style=\"display:flex; justify-content: space-between;\"> \
                            <div class=\"category\">" + gig.Category + "</div> \
                            <div class=\"gig_rating_display\"> \
                                <p>"+ (gig.Rating == "Not Rated" ? "<i class=\"far fa-star\"></i> " : "<i class=\"fas fa-star\"></i> ") + gig.Rating + "</p> \
                            </div> \
                        </div> \
                        </div> \
                </div>";
            }

        }
    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <!--header-->
        <div class="header-container">
            <div class="header-filter">
                <!--Category Dropdown end-->
                <div class="dropdown-style">
                    <!-- Category Drop down list -->
                    <asp:DropDownList CssClass="form-control" onchange="showGigs()" ID="ddlCategories" AppendDataBoundItems="true" DataTextField="category_name"
                        DataValueField="category_id" runat="server">
                        <asp:ListItem Value="0">Select Category</asp:ListItem>

                    </asp:DropDownList>
                </div>

                <!--Countries drop down list-->
                <div class="countries-ddl-container dropdown-style">
                    <select id="countryId" onchange="showGigs()" name="countryId">
                        <option value="none">Country</option>
                        <option value="Afganistan">Afghanistan</option>
                        <option value="Albania">Albania</option>
                        <option value="Algeria">Algeria</option>
                        <option value="American Samoa">American Samoa</option>
                        <option value="Andorra">Andorra</option>
                        <option value="Angola">Angola</option>
                        <option value="Anguilla">Anguilla</option>
                        <option value="Antigua & Barbuda">Antigua & Barbuda</option>
                        <option value="Argentina">Argentina</option>
                        <option value="Armenia">Armenia</option>
                        <option value="Aruba">Aruba</option>
                        <option value="Australia">Australia</option>
                        <option value="Austria">Austria</option>
                        <option value="Azerbaijan">Azerbaijan</option>
                        <option value="Bahamas">Bahamas</option>
                        <option value="Bahrain">Bahrain</option>
                        <option value="Bangladesh">Bangladesh</option>
                        <option value="Barbados">Barbados</option>
                        <option value="Belarus">Belarus</option>
                        <option value="Belgium">Belgium</option>
                        <option value="Belize">Belize</option>
                        <option value="Benin">Benin</option>
                        <option value="Bermuda">Bermuda</option>
                        <option value="Bhutan">Bhutan</option>
                        <option value="Bolivia">Bolivia</option>
                        <option value="Bonaire">Bonaire</option>
                        <option value="Bosnia & Herzegovina">Bosnia & Herzegovina</option>
                        <option value="Botswana">Botswana</option>
                        <option value="Brazil">Brazil</option>
                        <option value="British Indian Ocean Ter">British Indian Ocean Ter</option>
                        <option value="Brunei">Brunei</option>
                        <option value="Bulgaria">Bulgaria</option>
                        <option value="Burkina Faso">Burkina Faso</option>
                        <option value="Burundi">Burundi</option>
                        <option value="Cambodia">Cambodia</option>
                        <option value="Cameroon">Cameroon</option>
                        <option value="Canada">Canada</option>
                        <option value="Canary Islands">Canary Islands</option>
                        <option value="Cape Verde">Cape Verde</option>
                        <option value="Cayman Islands">Cayman Islands</option>
                        <option value="Central African Republic">Central African Republic</option>
                        <option value="Chad">Chad</option>
                        <option value="Channel Islands">Channel Islands</option>
                        <option value="Chile">Chile</option>
                        <option value="China">China</option>
                        <option value="Christmas Island">Christmas Island</option>
                        <option value="Cocos Island">Cocos Island</option>
                        <option value="Colombia">Colombia</option>
                        <option value="Comoros">Comoros</option>
                        <option value="Congo">Congo</option>
                        <option value="Cook Islands">Cook Islands</option>
                        <option value="Costa Rica">Costa Rica</option>
                        <option value="Cote DIvoire">Cote DIvoire</option>
                        <option value="Croatia">Croatia</option>
                        <option value="Cuba">Cuba</option>
                        <option value="Curaco">Curacao</option>
                        <option value="Cyprus">Cyprus</option>
                        <option value="Czech Republic">Czech Republic</option>
                        <option value="Denmark">Denmark</option>
                        <option value="Djibouti">Djibouti</option>
                        <option value="Dominica">Dominica</option>
                        <option value="Dominican Republic">Dominican Republic</option>
                        <option value="East Timor">East Timor</option>
                        <option value="Ecuador">Ecuador</option>
                        <option value="Egypt">Egypt</option>
                        <option value="El Salvador">El Salvador</option>
                        <option value="Equatorial Guinea">Equatorial Guinea</option>
                        <option value="Eritrea">Eritrea</option>
                        <option value="Estonia">Estonia</option>
                        <option value="Ethiopia">Ethiopia</option>
                        <option value="Falkland Islands">Falkland Islands</option>
                        <option value="Faroe Islands">Faroe Islands</option>
                        <option value="Fiji">Fiji</option>
                        <option value="Finland">Finland</option>
                        <option value="France">France</option>
                        <option value="French Guiana">French Guiana</option>
                        <option value="French Polynesia">French Polynesia</option>
                        <option value="French Southern Ter">French Southern Ter</option>
                        <option value="Gabon">Gabon</option>
                        <option value="Gambia">Gambia</option>
                        <option value="Georgia">Georgia</option>
                        <option value="Germany">Germany</option>
                        <option value="Ghana">Ghana</option>
                        <option value="Gibraltar">Gibraltar</option>
                        <option value="Great Britain">Great Britain</option>
                        <option value="Greece">Greece</option>
                        <option value="Greenland">Greenland</option>
                        <option value="Grenada">Grenada</option>
                        <option value="Guadeloupe">Guadeloupe</option>
                        <option value="Guam">Guam</option>
                        <option value="Guatemala">Guatemala</option>
                        <option value="Guinea">Guinea</option>
                        <option value="Guyana">Guyana</option>
                        <option value="Haiti">Haiti</option>
                        <option value="Hawaii">Hawaii</option>
                        <option value="Honduras">Honduras</option>
                        <option value="Hong Kong">Hong Kong</option>
                        <option value="Hungary">Hungary</option>
                        <option value="Iceland">Iceland</option>
                        <option value="Indonesia">Indonesia</option>
                        <option value="India">India</option>
                        <option value="Iran">Iran</option>
                        <option value="Iraq">Iraq</option>
                        <option value="Ireland">Ireland</option>
                        <option value="Isle of Man">Isle of Man</option>
                        <option value="Israel">Israel</option>
                        <option value="Italy">Italy</option>
                        <option value="Jamaica">Jamaica</option>
                        <option value="Japan">Japan</option>
                        <option value="Jordan">Jordan</option>
                        <option value="Kazakhstan">Kazakhstan</option>
                        <option value="Kenya">Kenya</option>
                        <option value="Kiribati">Kiribati</option>
                        <option value="Korea North">Korea North</option>
                        <option value="Korea Sout">Korea South</option>
                        <option value="Kuwait">Kuwait</option>
                        <option value="Kyrgyzstan">Kyrgyzstan</option>
                        <option value="Laos">Laos</option>
                        <option value="Latvia">Latvia</option>
                        <option value="Lebanon">Lebanon</option>
                        <option value="Lesotho">Lesotho</option>
                        <option value="Liberia">Liberia</option>
                        <option value="Libya">Libya</option>
                        <option value="Liechtenstein">Liechtenstein</option>
                        <option value="Lithuania">Lithuania</option>
                        <option value="Luxembourg">Luxembourg</option>
                        <option value="Macau">Macau</option>
                        <option value="Macedonia">Macedonia</option>
                        <option value="Madagascar">Madagascar</option>
                        <option value="Malaysia">Malaysia</option>
                        <option value="Malawi">Malawi</option>
                        <option value="Maldives">Maldives</option>
                        <option value="Mali">Mali</option>
                        <option value="Malta">Malta</option>
                        <option value="Marshall Islands">Marshall Islands</option>
                        <option value="Martinique">Martinique</option>
                        <option value="Mauritania">Mauritania</option>
                        <option value="Mauritius">Mauritius</option>
                        <option value="Mayotte">Mayotte</option>
                        <option value="Mexico">Mexico</option>
                        <option value="Midway Islands">Midway Islands</option>
                        <option value="Moldova">Moldova</option>
                        <option value="Monaco">Monaco</option>
                        <option value="Mongolia">Mongolia</option>
                        <option value="Montserrat">Montserrat</option>
                        <option value="Morocco">Morocco</option>
                        <option value="Mozambique">Mozambique</option>
                        <option value="Myanmar">Myanmar</option>
                        <option value="Nambia">Nambia</option>
                        <option value="Nauru">Nauru</option>
                        <option value="Nepal">Nepal</option>
                        <option value="Netherland Antilles">Netherland Antilles</option>
                        <option value="Netherlands">Netherlands (Holland, Europe)</option>
                        <option value="Nevis">Nevis</option>
                        <option value="New Caledonia">New Caledonia</option>
                        <option value="New Zealand">New Zealand</option>
                        <option value="Nicaragua">Nicaragua</option>
                        <option value="Niger">Niger</option>
                        <option value="Nigeria">Nigeria</option>
                        <option value="Niue">Niue</option>
                        <option value="Norfolk Island">Norfolk Island</option>
                        <option value="Norway">Norway</option>
                        <option value="Oman">Oman</option>
                        <option value="Pakistan">Pakistan</option>
                        <option value="Palau Island">Palau Island</option>
                        <option value="Palestine">Palestine</option>
                        <option value="Panama">Panama</option>
                        <option value="Papua New Guinea">Papua New Guinea</option>
                        <option value="Paraguay">Paraguay</option>
                        <option value="Peru">Peru</option>
                        <option value="Phillipines">Philippines</option>
                        <option value="Pitcairn Island">Pitcairn Island</option>
                        <option value="Poland">Poland</option>
                        <option value="Portugal">Portugal</option>
                        <option value="Puerto Rico">Puerto Rico</option>
                        <option value="Qatar">Qatar</option>
                        <option value="Republic of Montenegro">Republic of Montenegro</option>
                        <option value="Republic of Serbia">Republic of Serbia</option>
                        <option value="Reunion">Reunion</option>
                        <option value="Romania">Romania</option>
                        <option value="Russia">Russia</option>
                        <option value="Rwanda">Rwanda</option>
                        <option value="St Barthelemy">St Barthelemy</option>
                        <option value="St Eustatius">St Eustatius</option>
                        <option value="St Helena">St Helena</option>
                        <option value="St Kitts-Nevis">St Kitts-Nevis</option>
                        <option value="St Lucia">St Lucia</option>
                        <option value="St Maarten">St Maarten</option>
                        <option value="St Pierre & Miquelon">St Pierre & Miquelon</option>
                        <option value="St Vincent & Grenadines">St Vincent & Grenadines</option>
                        <option value="Saipan">Saipan</option>
                        <option value="Samoa">Samoa</option>
                        <option value="Samoa American">Samoa American</option>
                        <option value="San Marino">San Marino</option>
                        <option value="Sao Tome & Principe">Sao Tome & Principe</option>
                        <option value="Saudi Arabia">Saudi Arabia</option>
                        <option value="Senegal">Senegal</option>
                        <option value="Seychelles">Seychelles</option>
                        <option value="Sierra Leone">Sierra Leone</option>
                        <option value="Singapore">Singapore</option>
                        <option value="Slovakia">Slovakia</option>
                        <option value="Slovenia">Slovenia</option>
                        <option value="Solomon Islands">Solomon Islands</option>
                        <option value="Somalia">Somalia</option>
                        <option value="South Africa">South Africa</option>
                        <option value="Spain">Spain</option>
                        <option value="Sri Lanka">Sri Lanka</option>
                        <option value="Sudan">Sudan</option>
                        <option value="Suriname">Suriname</option>
                        <option value="Swaziland">Swaziland</option>
                        <option value="Sweden">Sweden</option>
                        <option value="Switzerland">Switzerland</option>
                        <option value="Syria">Syria</option>
                        <option value="Tahiti">Tahiti</option>
                        <option value="Taiwan">Taiwan</option>
                        <option value="Tajikistan">Tajikistan</option>
                        <option value="Tanzania">Tanzania</option>
                        <option value="Thailand">Thailand</option>
                        <option value="Togo">Togo</option>
                        <option value="Tokelau">Tokelau</option>
                        <option value="Tonga">Tonga</option>
                        <option value="Trinidad & Tobago">Trinidad & Tobago</option>
                        <option value="Tunisia">Tunisia</option>
                        <option value="Turkey">Turkey</option>
                        <option value="Turkmenistan">Turkmenistan</option>
                        <option value="Turks & Caicos Is">Turks & Caicos Is</option>
                        <option value="Tuvalu">Tuvalu</option>
                        <option value="Uganda">Uganda</option>
                        <option value="United Kingdom">United Kingdom</option>
                        <option value="Ukraine">Ukraine</option>
                        <option value="United Arab Erimates">United Arab Emirates</option>
                        <option value="United States of America">United States of America</option>
                        <option value="Uraguay">Uruguay</option>
                        <option value="Uzbekistan">Uzbekistan</option>
                        <option value="Vanuatu">Vanuatu</option>
                        <option value="Vatican City State">Vatican City State</option>
                        <option value="Venezuela">Venezuela</option>
                        <option value="Vietnam">Vietnam</option>
                        <option value="Virgin Islands (Brit)">Virgin Islands (Brit)</option>
                        <option value="Virgin Islands (USA)">Virgin Islands (USA)</option>
                        <option value="Wake Island">Wake Island</option>
                        <option value="Wallis & Futana Is">Wallis & Futana Is</option>
                        <option value="Yemen">Yemen</option>
                        <option value="Zaire">Zaire</option>
                        <option value="Zambia">Zambia</option>
                        <option value="Zimbabwe">Zimbabwe</option>
                    </select>
                </div>

                <!--Delivery time drop down end-->
                <!--Pagination end-->
            </div>
            <div class="pagination-container">
                <ul class="pagination">
                    <li class="page-item active-pg-no"><a class="page-link" href="#">Previous</a></li>
                    <li class="page-item"><a class="page-link" href="#">1</a></li>
                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item"><a class="page-link" href="#">Next</a></li>
                </ul>
            </div>
            <!--header filter end-->
        </div>
        <!--header container end-->
        <div class="middle-container">
            <div class="list-view" id="jobs-list-view-container">
                <span id="no-gig-found-error" style="display: none;">No Gig Found</span>
                <div class="jobs-container" id="divGigs">
                    <!--Jobs Section-->
                </div>
                <!--Jobs contaiber end-->
            </div>
            <!--List view end-->

            <!--Filters Side Bar-->
            <div class="filters-sidebar">

                <div class="filters-sec">

                    <!-- Search For Jobs/Gigs -->
                    <div class="delivery-time-container">
                        <h3>Search For</h3>
                        <div class="delivery-time-options">
                            <label>
                                <input type="radio" id="searchGigs" value="Gigs" name="search-for-radio" checked>
                                Gigs
                            </label>
                            <label>
                                <input type="radio" id="searchJobs" value="Jobs" name="search-for-radio">
                                Jobs
                            </label>
                        </div>
                    </div>

                    <!-- Sort By Rating/Price/Date -->
                    <div class="delivery-time-container">
                        <h3>Sort By</h3>
                        <div class="delivery-time-options">
                            <label for="PriceID">
                                <input type="radio" id="PriceID" value="Price" name="sort-by-radio">
                                Price
                            </label>
                            <label for="RatingID">
                                <input type="radio" id="RatingID" value="Rating" name="sort-by-radio">
                                Rating
                            </label>
                            <label for="DateID">
                                <input type="radio" id="DateID" value="Date" name="sort-by-radio">
                                Date
                            </label>
                        </div>
                    </div>

                    <!-- Delivery Time  -->
                    <div class="delivery-time-container">
                        <h3>Delivery Time</h3>
                        <div class="delivery-time-options">
                            <label>
                                <input type="radio" value="1" name="duration-radio">
                                1 Day
                            </label>
                            <label>
                                <input type="radio" value="2" name="duration-radio">
                                2 Days
                            </label>
                            <label>
                                <input type="radio" value="3" name="duration-radio">
                                3 Days
                            </label>
                            <label>
                                <input type="radio" value="4" name="duration-radio">
                                4 Days
                            </label>
                            <label>
                                <input type="radio" value="7" name="duration-radio">
                                1 Week
                            </label>
                            <label>
                                <input type="radio" value="14" name="duration-radio">
                                2 Weeks
                            </label>
                            <label>
                                <input type="radio" value="21" name="duration-radio">
                                3 Weeks
                            </label>
                            <label>
                                <input type="radio" value="30" name="duration-radio">
                                1 Month
                            </label>
                            <label>
                                <input type="radio" value="60" name="duration-radio">
                                2 Months
                            </label>
                            <label>
                                <input type="radio" value="90" name="duration-radio">
                                3 Months
                            </label>
                            <label>
                                <input type="radio" value="180" name="duration-radio">
                                6 Months
                            </label>
                            <label>
                                <input type="radio" value="365" name="duration-radio">
                                1 year
                            </label>
                        </div>

                    </div>
                    
                    <!-- Min/Max Price -->
                    <div class="price-range-container">
                        <h3>Price Range</h3>
                        <div class="price-range">
                            <div class="min-price-container price">
                                <p>Min.</p>
                                <input type="number" min="0" onchange="showGigs()" placeholder="Rs." name="" id="minPrice">
                            </div>
                            <div class="max-price-container price">
                                <p>Max.</p>
                                <input type="number" min="0" onchange="showGigs()" placeholder="Rs." name="" id="maxPrice">
                            </div>
                        </div>
                    </div>
                </div>
                <!--Price Range end-->
            </div>
            <!--filter side bar end-->
        </div>
        <!--Middle Container End-->
    </div>
    <!--container end-->

</asp:Content>
