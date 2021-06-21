<%@ Page Title="" Language="C#" MasterPageFile="~/seller.Master" AutoEventWireup="true" CodeBehind="sorders_list.aspx.cs" Inherits="WorKar.WebForm9" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="UTF-8" />
    <title>Jobs | WorKarr</title>

    <%-- My Stylesheet --%>
    <link href="style/jobs_list.css" rel="stylesheet" runat="server" />
    <link href="style/Message_Block.css" rel="stylesheet" runat="server"/>
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
            let orderId = input.id.split('_')[1];
            $.ajax({
                type: "POST",
                url: "sorders_list.aspx/cancel_order",
                data: '{ deleteOrderID :' + orderId + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    // remove order card
                    let orderId = response.d.split('_')[0];

                    // remove order card
                    document.getElementById("card-" + orderId).remove();
                    let msg_block = $("#msg_block");
                    msg_block.css("background-color", "rgba(0, 255, 0, 0.2)");
                    msg_block.children('span').html("Order has been cancelled successfully!");
                    msg_block.children('span').css("color", "green");
                    msg_block.css("display", "flex");
                }

            });
        }
    </script>



    <script>
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

    <script type="text/javascript">
        // to delete a gig without page reloading
        function complete_my_order(order) {

            let orderId = order.id.split('_')[1];

            $.ajax({
                type: "POST",
                url: "sorders_list.aspx/Complete_Order",
                data: '{ completeOrderID :' + orderId + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

                    let orderId = response.d.split('_')[0];
                    let status = response.d.split('_')[1];

                    // remove order card
                    document.getElementById("card-" + orderId).remove();

                    let msg_block = $("#msg_block");
                    if (status == 'Completed') {
                        msg_block.css("background-color", "rgba(0, 255, 0, 0.2)");
                        msg_block.children('span').html("Order has been completed successfully!");
                        msg_block.children('span').css("color", "green");
                    }
                    else {
                        msg_block.css("background-color", "rgba(255, 0, 0, 0.2)");
                        msg_block.children('span').html("Order has not been completed with in due date!");
                        msg_block.children('span').css("color", "red");
                    }

                    msg_block.css("display", "flex");
                }
,
                failure: function () {
                    alert("Order Complete Status Failed");
                }
            });
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="middle-container" style="display: block;">
            <div>
                <h2 class="heading" title="Active orders you have posted">Posted Orders</h2>
                <div class="list-view">
                    <div class="jobs-container" id="sortable1">
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
                                <div style="text-align: center;">
                                    <asp:Label ID="No_Posted_Order_Error" runat="server"
                                        Visible='<%# posted_orders_list.Items.Count == 0 %>' Text="No Posted Order" />
                                </div>
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
                <h2 class="heading" title="Active orders you have to complete">Recieved Orders</h2>
                <div class="list-view">
                    <div class="jobs-container" id="sortable2">
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
                                                <a id="CompleteOrder_<%# Eval("OrderID") %>" onclick="complete_my_order(this)">
                                                    <p>Complete</p>
                                                    <i class="far fa-trash-alt"></i>
                                                </a>
                                                <a href="sorder_view.aspx?OrderID=<%# Eval("OrderID") %>">
                                                    <p>View</p>
                                                    <i class="far fa-eye"></i></a>
                                                <a id="CancelledOrder_<%# Eval("OrderID") %>" onclick="cancel_order(this)">
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
                                <div style="text-align: center;">
                                    <asp:Label ID="No_Posted_Order_Error" runat="server"
                                        Visible='<%# recieved_orders_list.Items.Count == 0 %>' Text="No Recieved Order" />
                                </div>
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
