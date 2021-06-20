<%@ Page Title="" Language="C#" MasterPageFile="~/seller.Master" AutoEventWireup="true" CodeBehind="smy_jobs.aspx.cs" Inherits="WorKar.WebForm6" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="UTF-8" />
    <title>Jobs | WorKarr</title>

    <%-- My Stylesheet --%>
    <link href="style/jobs_list.css" rel="stylesheet" runat="server" />

    <style runat="server">
        .list-view {
            width: 100%;
        }

            .list-view .jobs-container {
                grid-template-columns: 1fr 1fr 1fr;
            }

        .job {
            transition-delay: 0 !important;
        }

            .job .bottom-sec {
                justify-content: space-between;
            }

        .heading {
            margin-bottom: 10px;
        }

        .job, .create_job_container{
            height: 245px;
        }
        .job .middle-sec p{
            height: 7.7rem;
    }
    </style>

    <!--AJAX API-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script type="text/javascript">

        // to delete a gig without page reloading
        function delete_my_job(input) {
            $.ajax({
                type: "POST",
                url: "smy_jobs.aspx/delete_job",
                data: '{ deleteJobID :' + input.id.toString() + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess
            });
        }
        function OnSuccess(response) {
            // remove job card
            document.getElementById("card-" + response.d).remove();
        }
    </script>

    <!--CDN To drag jobs-->
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script>
        // to drag gigs
        $(function () {
            $("#sortable").sortable();
            $("#sortable").disableSelection();
        });

        // to display dot menu on click
        function display_dotMenu(icon) {
            var JobID = icon.id;
            JobID = "dot_menu-" + JobID.split("-")[1];
            document.getElementById(JobID).classList.toggle("hide-menu");
        }

        $(document).ready(function () {
            // to handle click event anywhere on screen
            document.body.addEventListener('click', function () {
                var dot_menu_list = document.getElementsByClassName("gig-dots-menu");
                for (var i = 0; i < dot_menu_list.length; ++i) {
                    if (dot_menu_list[i].classList.contains("hide-menu") == false) {
                        dot_menu_list[i].classList.add("hide-menu");
                    }
                }
            }, true);
        });
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">
        <div class="middle-container" style="display: block;">
            <div>
                <h2 class="heading">My Jobs</h2>
                <div class="list-view">
                    <div class="jobs-container" id="sortable">
                        <asp:Repeater ID="my_jobs_list" runat="server">
                            <HeaderTemplate>
                                <div class="create_job_container" onclick="window.location.href='sjob_creation.aspx'">
                                    <div class="plus-sign-container">
                                        <img src='<%=ResolveUrl("~/images/gig_plus.png") %>' alt="gig-plus-sign-icon">
                                    </div>
                                    <h3>Create Job</h3>
                                </div>
                            </HeaderTemplate>

                            <ItemTemplate>

                                <div class="job" id="card-<%# Eval("JobID") %>">
                                    <a href="job_view.aspx?JobID=<%# Eval("JobID") %>">
                                        <div class="div-content-sec">
                                            <div class="top-sec">
                                                <div class="img-container">
                                                    <img src="<%# Eval("UserPhoto") %>" alt="user-img" onerror="this.src = 'images/gig_images/image_not_found.png'" />
                                                </div>
                                                <div class="job-title">
                                                    <h2><%# Eval("Title") %></h2>
                                                    <div class="posted-time">
                                                        <p><%# Eval("PostedDate") %></p>
                                                    </div>
                                                </div>
                                                <p>Rs. <%# Eval("Amount") %></p>
                                            </div>
                                            <div class="middle-sec job-description">
                                                <p><%# Eval("Description") %></p>
                                            </div>
                                    </a>

                                    <div class="bottom-sec job-category">

                                        <div class="category"><%# Eval("Category") %></div>

                                        <!-- display job view/edit/delete menu--->
                                        <div class="gig-dots-menu hide-menu" id="dot_menu-<%# Eval("JobID") %>">
                                            <ul>
                                                <a href="job_view.aspx?JobID=<%# Eval("JobID") %>">
                                                    <p>Preview</p>
                                                    <i class="far fa-eye"></i></a>
                                                <a href="sjob_creation.aspx?JobID=<%# Eval("JobID") %>">
                                                    <p>Edit</p>
                                                    <i class="far fa-pencil-alt"></i></a>
                                                <a id="<%# Eval("JobID") %>" onclick="delete_my_job(this)">
                                                    <p id="JobID=<%# Eval("JobID") %>">Delete</p>
                                                    <i class="far fa-trash-alt"></i>
                                                </a>

                                            </ul>
                                        </div>
                                        <div class="icon-container">
                                            <i id="icon-<%# Eval("JobID") %>" onclick="display_dotMenu(this)" class="fas fa-ellipsis-v"></i>
                                        </div>
                                    </div>
                                </div>

                                </div>
                            </ItemTemplate>
                            <FooterTemplate>
                                <div style="height: 100px;"></div>
                                <div style="height: 100px;"></div>
                                <div style="height: 100px;"></div>
                            </FooterTemplate>
                        </asp:Repeater>

                        <!--Job end-->
                    </div>
                    <!--Jobs contaiber end-->
                </div>
                <!--List view end-->
            </div>
        </div>
        <!--Middle Container End-->
    </div>
    <!--container end-->
</asp:Content>
