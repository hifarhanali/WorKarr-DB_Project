<%@ Page Title="" Language="C#" MasterPageFile="~/seller.Master" AutoEventWireup="true" CodeBehind="sjobs_list.aspx.cs" Inherits="WorKar.WebForm14" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <title>Jobs | WorKarr</title>
   <%-- My Stylesheet --%>
    <link href="style/jobs_list.css" rel="stylesheet" runat="server"/>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
            <div class="container">
                    <!--header-->
                <div class="header-container">

                    <div class="header-filter">
                        <div class="sortby-container dropdown-style">
                            <select name="sortby" id="sortbyId">
                                <option value="Sort By" selected disabled hidden>Sort By</option>
                                <option value="Price">Price</option>
                                <option value="Popularity">Popilarity</option>
                                <option value="Rating">Rating</option>
                            </select>
                        </div>
                        <div class="categories-container dropdown-style">
                            <select name="categories" id="categoriesId">
                                <option value="Category" selected  disabled hidden>
                                    <div class="head-row-category-container category-option-container">
                                        <p>Services</p>
                                        <i class="fa fa-arrow-down"></i>
                                    </div>
                                </option>
                                <option value="Category">
                                    <div class="head-row-category-container category-option-container">
                                        <p>All Categories</p>
                                        <span class="category-occurences">(5130)</span>
                                    </div>
                                </option>
                                <option value="Category">
                                    <div class="head-row-category-container category-option-container">
                                        <p>All Categories</p>
                                        <span class="category-occurences">(5130)</span>
                                    </div>
                                </option>
                                <option value="Category">
                                    <div class="head-row-category-container category-option-container">
                                        <p>All Categories</p>
                                        <span class="category-occurences">(5130)</span>
                                    </div>
                                </option>
                                <option value="Category">
                                    <div class="head-row-category-container category-option-container">
                                        <p>All Categories</p>
                                        <span class="category-occurences">(5130)</span>
                                    </div>
                                </option>
                                <option value="Category">
                                    <div class="head-row-category-container category-option-container">
                                        <p>All Categories</p>
                                        <span class="category-occurences">(5130)</span>
                                    </div>
                                </option>
                            </select>
                        </div>
                        <!--Category Dropdown end-->

                        <div class="categories-container dropdown-style">
                            <select name="categories" id="categoriesId">
                                <option value="Category" selected  disabled hidden>
                                    <div class="head-row-category-container category-option-container">
                                        <p>Category</p>
                                        <i class="fa fa-arrow-down"></i>
                                    </div>
                                </option>
                                <option value="Category">
                                    <div class="head-row-category-container category-option-container">
                                        <p>All Categories</p>
                                        <span class="category-occurences">(5130)</span>
                                    </div>
                                </option>
                                <option value="Category">
                                    <div class="head-row-category-container category-option-container">
                                        <p>Computer Science</p>
                                        <span class="category-occurences">(5130)</span>
                                    </div>
                                </option>
                                <option value="Category">
                                    <div class="head-row-category-container category-option-container">
                                        <p>Web Development</p>
                                        <span class="category-occurences">(5130)</span>
                                    </div>
                                </option>
                                <option value="Category">
                                    <div class="head-row-category-container category-option-container">
                                        <p>Graphic Designing</p>
                                        <span class="category-occurences">(5130)</span>
                                    </div>
                                </option>
                                <option value="Category">
                                    <div class="head-row-category-container category-option-container">
                                        <p>All Categories</p>
                                        <span class="category-occurences">(5130)</span>
                                    </div>
                                </option>
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
                    <div class="list-view">
                        <div class="jobs-container">
                            <div class="job1 job  card-container" onclick="window.location.href='job_view.aspx'">
                                <div class="top-sec">
                                    <div class="img-container">
                                        <img src='<%=ResolveUrl("~/icons/avatar.png") %>' width="40px" alt="job-img">
                                    </div>
                                    <div class="job-title">
                                        <h2>Design UI untuk halaman Webflow</h2>
                                        <div class="posted-time">
                                            <p> 23-March-2020</p>
                                        </div>
                                    </div>
                                    <p>Rs. 15000</p>
                                </div>
                                <div class="middle-sec job-description">
                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Ullam, esse quam sit, laborum consectetur laudantiumre.</p>
                                </div>
                                <div class="bottom-sec job-category">
                                    <div class="category">Design</div>
                                    <div class="category">UI/UX</div>
                                    <div class="category">Photoshop</div>
                                </div>
                            </div>
                                                        <div class="job1 job  card-container" onclick="window.location.href='job_view.aspx'">
                                <div class="top-sec">
                                    <div class="img-container">
                                        <img src='<%=ResolveUrl("~/icons/avatar.png") %>' width="40px" alt="job-img">
                                    </div>
                                    <div class="job-title">
                                        <h2>Design UI untuk halaman Webflow</h2>
                                        <div class="posted-time">
                                            <p> 23-March-2020</p>
                                        </div>
                                    </div>
                                    <p>Rs. 15000</p>
                                </div>
                                <div class="middle-sec job-description">
                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Ullam, esse quam sit, laborum consectetur laudantiumre.</p>
                                </div>
                                <div class="bottom-sec job-category">
                                    <div class="category">Design</div>
                                    <div class="category">UI/UX</div>
                                    <div class="category">Photoshop</div>
                                </div>
                            </div>

                                                        <div class="job1 job  card-container" onclick="window.location.href='job_view.aspx'">
                                <div class="top-sec">
                                    <div class="img-container">
                                        <img src='<%=ResolveUrl("~/icons/avatar.png") %>' width="40px" alt="job-img">
                                    </div>
                                    <div class="job-title">
                                        <h2>Design UI untuk halaman Webflow</h2>
                                        <div class="posted-time">
                                            <p> 23-March-2020</p>
                                        </div>
                                    </div>
                                    <p>Rs. 15000</p>
                                </div>
                                <div class="middle-sec job-description">
                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Ullam, esse quam sit, laborum consectetur laudantiumre.</p>
                                </div>
                                <div class="bottom-sec job-category">
                                    <div class="category">Design</div>
                                    <div class="category">UI/UX</div>
                                    <div class="category">Photoshop</div>
                                </div>
                            </div>

                                                        <div class="job1 job  card-container" onclick="window.location.href='job_view.aspx'">
                                <div class="top-sec">
                                    <div class="img-container">
                                        <img src='<%=ResolveUrl("~/icons/avatar.png") %>' width="40px" alt="job-img">
                                    </div>
                                    <div class="job-title">
                                        <h2>Design UI untuk halaman Webflow</h2>
                                        <div class="posted-time">
                                            <p> 23-March-2020</p>
                                        </div>
                                    </div>
                                    <p>Rs. 15000</p>
                                </div>
                                <div class="middle-sec job-description">
                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Ullam, esse quam sit, laborum consectetur laudantiumre.</p>
                                </div>
                                <div class="bottom-sec job-category">
                                    <div class="category">Design</div>
                                    <div class="category">UI/UX</div>
                                    <div class="category">Photoshop</div>
                                </div>
                            </div>

                                                        <div class="job1 job  card-container" onclick="window.location.href='job_view.aspx'">
                                <div class="top-sec">
                                    <div class="img-container">
                                        <img src='<%=ResolveUrl("~/icons/avatar.png") %>' width="40px" alt="job-img">
                                    </div>
                                    <div class="job-title">
                                        <h2>Design UI untuk halaman Webflow</h2>
                                        <div class="posted-time">
                                            <p> 23-March-2020</p>
                                        </div>
                                    </div>
                                    <p>Rs. 15000</p>
                                </div>
                                <div class="middle-sec job-description">
                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Ullam, esse quam sit, laborum consectetur laudantiumre.</p>
                                </div>
                                <div class="bottom-sec job-category">
                                    <div class="category">Design</div>
                                    <div class="category">UI/UX</div>
                                    <div class="category">Photoshop</div>
                                </div>
                            </div>

                                                        <div class="job1 job  card-container" onclick="window.location.href='job_view.aspx'">
                                <div class="top-sec">
                                    <div class="img-container">
                                        <img src='<%=ResolveUrl("~/icons/avatar.png") %>' width="40px" alt="job-img">
                                    </div>
                                    <div class="job-title">
                                        <h2>Design UI untuk halaman Webflow</h2>
                                        <div class="posted-time">
                                            <p> 23-March-2020</p>
                                        </div>
                                    </div>
                                    <p>Rs. 15000</p>
                                </div>
                                <div class="middle-sec job-description">
                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Ullam, esse quam sit, laborum consectetur laudantiumre.</p>
                                </div>
                                <div class="bottom-sec job-category">
                                    <div class="category">Design</div>
                                    <div class="category">UI/UX</div>
                                    <div class="category">Photoshop</div>
                                </div>
                            </div>
                            <div class="job1 job  card-container" onclick="window.location.href='job_view.aspx'">
                                <div class="top-sec">
                                    <div class="img-container">
                                        <img src='<%=ResolveUrl("~/icons/avatar.png") %>' width="40px" alt="job-img">
                                    </div>
                                    <div class="job-title">
                                        <h2>Design UI untuk halaman Webflow</h2>
                                        <div class="posted-time">
                                            <p> 23-March-2020</p>
                                        </div>
                                    </div>
                                    <p>Rs. 15000</p>
                                </div>
                                <div class="middle-sec job-description">
                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Ullam, esse quam sit, laborum consectetur laudantiumre.</p>
                                </div>
                                <div class="bottom-sec job-category">
                                    <div class="category">Design</div>
                                    <div class="category">UI/UX</div>
                                    <div class="category">Photoshop</div>
                                </div>
                            </div>

                            <div class="job1 job  card-container" onclick="window.location.href='job_view.aspx'">
                                <div class="top-sec">
                                    <div class="img-container">
                                        <img src='<%=ResolveUrl("~/icons/avatar.png") %>' width="40px" alt="job-img">
                                    </div>
                                    <div class="job-title">
                                        <h2>Design UI untuk halaman Webflow</h2>
                                        <div class="posted-time">
                                            <p> 23-March-2020</p>
                                        </div>
                                    </div>
                                    <p>Rs. 15000</p>
                                </div>
                                <div class="middle-sec job-description">
                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Ullam, esse quam sit, laborum consectetur laudantiumre.</p>
                                </div>
                                <div class="bottom-sec job-category">
                                    <div class="category">Design</div>
                                    <div class="category">UI/UX</div>
                                    <div class="category">Photoshop</div>
                                </div>
                            </div>

                            <div class="job1 job  card-container" onclick="window.location.href='job_view.aspx'">
                                <div class="top-sec">
                                    <div class="img-container">
                                        <img src='<%=ResolveUrl("~/icons/avatar.png") %>' width="40px" alt="job-img">
                                    </div>
                                    <div class="job-title">
                                        <h2>Design UI untuk halaman Webflow</h2>
                                        <div class="posted-time">
                                            <p> 23-March-2020</p>
                                        </div>
                                    </div>
                                    <p>Rs. 15000</p>
                                </div>
                                <div class="middle-sec job-description">
                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Ullam, esse quam sit, laborum consectetur laudantiumre.</p>
                                </div>
                                <div class="bottom-sec job-category">
                                    <div class="category">Design</div>
                                    <div class="category">UI/UX</div>
                                    <div class="category">Photoshop</div>
                                </div>
                            </div>

                            <div class="job1 job  card-container" onclick="window.location.href='job_view.aspx'">
                                <div class="top-sec">
                                    <div class="img-container">
                                        <img src='<%=ResolveUrl("~/icons/avatar.png") %>' width="40px" alt="job-img">
                                    </div>
                                    <div class="job-title">
                                        <h2>Design UI untuk halaman Webflow</h2>
                                        <div class="posted-time">
                                            <p> 23-March-2020</p>
                                        </div>
                                    </div>
                                    <p>Rs. 15000</p>
                                </div>
                                <div class="middle-sec job-description">
                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Ullam, esse quam sit, laborum consectetur laudantiumre.</p>
                                </div>
                                <div class="bottom-sec job-category">
                                    <div class="category">Design</div>
                                    <div class="category">UI/UX</div>
                                    <div class="category">Photoshop</div>
                                </div>
                            </div>
                            <div class="job1 job  card-container" onclick="window.location.href='job_view.aspx'">
                                <div class="top-sec">
                                    <div class="img-container">
                                        <img src='<%=ResolveUrl("~/icons/avatar.png") %>' width="40px" alt="job-img">
                                    </div>
                                    <div class="job-title">
                                        <h2>Design UI untuk halaman Webflow</h2>
                                        <div class="posted-time">
                                            <p> 23-March-2020</p>
                                        </div>
                                    </div>
                                    <p>Rs. 15000</p>
                                </div>
                                <div class="middle-sec job-description">
                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Ullam, esse quam sit, laborum consectetur laudantiumre.</p>
                                </div>
                                <div class="bottom-sec job-category">
                                    <div class="category">Design</div>
                                    <div class="category">UI/UX</div>
                                    <div class="category">Photoshop</div>
                                </div>
                            </div>
                            <div class="job1 job  card-container" onclick="window.location.href='job_view.aspx'">
                                <div class="top-sec">
                                    <div class="img-container">
                                        <img src='<%=ResolveUrl("~/icons/avatar.png") %>' width="40px" alt="job-img">
                                    </div>
                                    <div class="job-title">
                                        <h2>Design UI untuk halaman Webflow</h2>
                                        <div class="posted-time">
                                            <p> 23-March-2020</p>
                                        </div>
                                    </div>
                                    <p>Rs. 15000</p>
                                </div>
                                <div class="middle-sec job-description">
                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Ullam, esse quam sit, laborum consectetur laudantiumre.</p>
                                </div>
                                <div class="bottom-sec job-category">
                                    <div class="category">Design</div>
                                    <div class="category">UI/UX</div>
                                    <div class="category">Photoshop</div>
                                </div>
                            </div>
                                                                <div style="height: 100px;"></div>
                            <!--Job end-->
                        </div>
                        <!--Jobs contaiber end-->
                    </div>
                    <!--List view end-->

                                        <!--Filters Side Bar-->
                    <div class="filters-sidebar">
                        <div class="btn-container">
                            <button type="button" id="reset-btn-container">Reset</button>
                            <button type="button" id="apply-btn-container">Apply</button>
                        </div>
                        <div class="delivery-time-container">
                            <h3>Delivery Time</h3>
                            <div class="delivery-time-options">
                                <label for="1Day">
                                <input type="radio" id="1Day" name="delivery-time-radio">
                                Express 24H
                            </label>
                                <label for="3Day">
                                <input type="radio" id="3Day" name="delivery-time-radio">
                                3 Days
                            </label>
                                <label for="7Day">
                                <input type="radio" id="7Day" name="delivery-time-radio">
                                7 Days
                            </label>
                                <label for="anytime">
                                <input type="radio" id="anytime" name="delivery-time-radio">
                                Anytime
                            </label>
                            </div>
                        </div>
                        <!--Delivery time end-->
                        <div class="price-range-container">
                            <h3>Price Range</h3>
                            <div class="price-range">
                                <div class="min-price-container price">
                                    <p>Min.</p>
                                    <input type="number" min="0" placeholder="Rs." name="" id="min-price">
                                </div>
                                <div class="max-price-container price">
                                    <p>Max.</p>
                                    <input type="number" min="0" placeholder="Rs." name="" id="max-price">
                                </div>
                            </div>
                        </div>
                        <!--Price Range end-->
                        <div class="company-location-container">
                            <h3>Company Location</h3>
                            <div class="company-location-options">
                                <label for="lahore">
                                <input type="checkbox" id="lahore">
                                Lahore
                            </label>
                                <label for="islamabad">
                                <input type="checkbox" id="islamabad">
                                Islamabad
                            </label>
                                <label for="faisalabad">
                                <input type="checkbox" id="faisalabad">
                                Faisalabad
                            </label>
                                <label for="karachi">
                                <input type="checkbox" id="karachi">
                                Karachi
                            </label>
                                <label for="rawalpindi">
                                <input type="checkbox" id="rawalpindi">
                                Rawalpindi
                            </label>
                            </div>
                        </div>
                        <!--Company Location End-->
                    </div>
                    <!--filter side bar end-->
                </div>
                <!--Middle Container End-->
            </div>
            <!--container end-->
</asp:Content>
