<%@ Page Title="" Language="C#" MasterPageFile="~/seller.Master" AutoEventWireup="true" CodeBehind="sorders_list.aspx.cs" Inherits="WorKar.WebForm9" %>

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

        .job, .create_job_container {
            height: 240px;
        }

            .job .middle-sec p {
                height: 7.7rem;
            }
    </style>

        <!--AJAX API-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script type="text/javascript">

        // to delete a gig without page reloading
        function cancel_order(input) {
            $.ajax({
                type: "POST",
                url: "sorders_list.aspx/cancel_order",
                data: '{ deleteOrderID :' + input.id.toString() + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess
            });
        }
        function OnSuccess(response) {
            // remove order card
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
                <h2 class="heading" title="Active orders you have posted">Posted Orders</h2>
                <div class="list-view">
                    <div class="jobs-container" id="sortable">
                        <asp:Repeater ID="posted_orders_list" runat="server">
                            <ItemTemplate>
                                <div class="job" id="card-<%# Eval("OrderID") %>">
                                    <a href="sorder_view.aspx?OrderID=<%# Eval("OrderID") %>">
                                        <div class="div-content-sec">
                                            <div class="top-sec">
                                                <div class="img-container">
                                                    <img src="<%# Eval("UserPhoto") %>" alt="user-img" onerror="this.src = 'images/gig_images/image_not_found.png'" />
                                                </div>
                                                <div class="job-title">
                                                    <h2><%# Eval("Username") %></h2>
                                                    <div class="posted-time">
                                                        <p><%# Get_Date(Eval("EndingDate")) %></p>
                                                    </div>
                                                </div>
                                                <p>Rs. <%# Eval("Amount") %></p>
                                            </div>
                                            <div class="middle-sec job-description">
                                                <p><%# Eval("Description") %></p>
                                            </div>
                                    </a>

                                    <div class="bottom-sec job-category">
                                        <div></div>
                                        <!-- display job view/edit/delete menu--->
                                        <div class="gig-dots-menu hide-menu" id="dot_menu-<%# Eval("OrderID") %>">
                                            <ul>
                                                <a href="sorder_view.aspx?OrderID=<%# Eval("OrderID") %>">
                                                    <p>View</p>
                                                    <i class="far fa-eye"></i></a>
                                                <a id="<%# Eval("OrderID") %>" onclick="cancel_order(this)">
                                                    <p id="OrderID=<%# Eval("OrderID") %>">Cancel</p>
                                                    <i class="far fa-trash-alt"></i>
                                                </a>

                                            </ul>
                                        </div>
                                        <div class="icon-container">
                                            <i id="icon-<%# Eval("OrderID") %>" onclick="display_dotMenu(this)" class="fas fa-ellipsis-v"></i>
                                        </div>
                                    </div>
                                </div>

                                </div>

                            </ItemTemplate>
                            <FooterTemplate>
                                <div style="height: 50px;"></div>
                                <div style="height: 50px;"></div>
                                <div style="height: 50px;"></div>
                            </FooterTemplate>
                        </asp:Repeater>

                        <!--Job end-->
                    </div>
                    <!--Jobs contaiber end-->
                </div>
                <!--List view end-->
            </div>


                        <div>
                <h2 class="heading"  title="Active orders you have to complete">Recieved Orders</h2>
                <div class="list-view">
                    <div class="jobs-container" id="sortable">
                        <asp:Repeater ID="recieved_orders_list" runat="server">
                            <ItemTemplate>
                                <div class="job" id="card-<%# Eval("OrderID") %>">
                                    <a href="sorder_view.aspx?OrderID=<%# Eval("OrderID") %>">
                                        <div class="div-content-sec">
                                            <div class="top-sec">
                                                <div class="img-container">
                                                    <img src="<%# Eval("UserPhoto") %>" alt="user-img" onerror="this.src = 'images/gig_images/image_not_found.png'" />
                                                </div>
                                                <div class="job-title">
                                                    <h2><%# Eval("Username") %></h2>
                                                    <div class="posted-time">
                                                        <p><%# Get_Date(Eval("EndingDate")) %></p>
                                                    </div>
                                                </div>
                                                <p>Rs. <%# Eval("Amount") %></p>
                                            </div>
                                            <div class="middle-sec job-description">
                                                <p><%# Eval("Description") %></p>
                                            </div>
                                    </a>

                                    <div class="bottom-sec job-category">
                                        <div></div>
                                        <!-- display job view/edit/delete menu--->
                                        <div class="gig-dots-menu hide-menu" id="dot_menu-<%# Eval("OrderID") %>">
                                            <ul>
                                                <a href="sorder_view.aspx?OrderID=<%# Eval("OrderID") %>">
                                                    <p>View</p>
                                                    <i class="far fa-eye"></i></a>
                                                <a id="<%# Eval("OrderID") %>" onclick="cancel_order(this)">
                                                    <p id="OrderID=<%# Eval("OrderID") %>">Cancel</p>
                                                    <i class="far fa-trash-alt"></i>
                                                </a>

                                            </ul>
                                        </div>
                                        <div class="icon-container">
                                            <i id="icon-<%# Eval("OrderID") %>" onclick="display_dotMenu(this)" class="fas fa-ellipsis-v"></i>
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
