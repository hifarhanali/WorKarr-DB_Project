<%@ Page Title="" Language="C#" MasterPageFile="~/seller.Master" AutoEventWireup="true" CodeBehind="sdashboard.aspx.cs" Inherits="WorKar.WebForm3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Dashboard | WorKarr</title>

    <!--Chart.js scripts cdn-->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>


    <!--AJAX API-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>


    <!--My Style Sheets-->
    <link href="style/seller_dashboard.css" rel="stylesheet" runat="server" />
    <link href="style/transaction.css" rel="stylesheet" runat="server"/>

    <style runat="server">
        .order .order-type {
            width: 60% !important;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right-section">
        <div class="inner-glass">
            <div class="container">

                <!-- HEADER OF Right Section-->
                <div class="header-container">
                    <h2>Dashboard</h2>
                </div>

                <!-- mid upper Container -->
                <div class="mid-upper-container">
                    <div class="box1-container box">
                        <div class="flex">
                            <h1>Debit</h1>
                            <div class="icon">
                                <i class="fas fa-dollar-sign"></i>
                            </div>
                        </div>
                        <h1>$1200</h1>
                        <p>45% This Week</p>
                    </div>
                    <div class="box2-container box">
                        <div class="flex">
                            <h1>Debit</h1>
                            <div class="icon">
                                <i class="fas fa-dollar-sign"></i>
                            </div>
                        </div>
                        <h1>$1200</h1>
                        <p>45% This Week</p>
                    </div>
                    <div class="box3-container box">
                        <div class="flex">
                            <h1>Debit</h1>
                            <div class="icon">
                                <i class="fas fa-dollar-sign"></i>
                            </div>
                        </div>
                        <h1>$1200</h1>
                        <p>45% This Week</p>
                    </div>
                    <div class="box4-container box">
                        <div class="flex">
                            <h1>Debit</h1>
                            <div class="icon">
                                <i class="fas fa-dollar-sign"></i>
                            </div>
                        </div>
                        <h1>$1200</h1>
                        <p>45% This Week</p>
                    </div>
                </div>

                <div class="chart-card-container">

                    <!-- mid lower Container -->
                    <div class="mid-lower-container">
                        <h3>Profile Overview</h3>
                        <div class="chart-container">
                            <canvas id="line-chart"></canvas>
                        </div>
                    </div>

                    <div class="independent-card">
                        <h3>Earnings</h3>
                        <asp:Repeater ID="rptr_user_summary" runat="server">
                            <ItemTemplate>
                                <table>
                                    <tr>
                                        <td class="left">Personal balance</td>
                                        <td class="right"><%# Handle_SQL_NULL(Eval("Earnings")) %></td>
                                    </tr>
                                    <tr>
                                        <td class="left">Earning in <span class="month"><%# Eval("CurrMonth") %> Months</span></td>
                                        <td class="right"><%# Handle_SQL_NULL(Eval("CurrentMonthIncome")) %></td>
                                    </tr>
                                    <tr>
                                        <td class="left">Avg. selling price</td>
                                        <td class="right"><%# Handle_SQL_NULL(Eval("AvgSellingPrice")) %></td>
                                    </tr>
                                    <tr>
                                        <td class="left">Active orders</td>
                                        <td class="right"><%# Handle_SQL_NULL(Eval("ActiveOrders")) %></td>
                                    </tr>
                                    <tr>
                                        <td class="left">Total Orders</td>
                                        <td class="right"><%# Handle_SQL_NULL(Eval("TotalOrders")) %></td>
                                    </tr>
                                    <tr>
                                        <td class="left">Completed Orders</td>
                                        <td class="right"><%# Handle_SQL_NULL(Eval("CompletedOrders")) %></td>
                                    </tr>
                                    <tr>
                                        <td class="left">Cancelled Orders</td>
                                        <td class="right"><%# Handle_SQL_NULL(Eval("CancelledOrders")) %></td>
                                    </tr>
                                </table>

                            </ItemTemplate>
                        </asp:Repeater>

                    </div>

                </div>

                <div class="container2">
                    <!-- left inner container for jobs and chart-->
                    <div class="left-inner-container">
                        <!--chart/statistics-->
                        <div class="chart-outer-container">
                            <h3>Orders Statistics</h3>
                            <div class="chart-container">
                                <canvas id="bar-chart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>


                <!-- mid lower Container -->
                <div class="most-bottom-container">
                    <asp:Repeater ID="rptrOrder_detail" runat="server">
                        <HeaderTemplate>
                            <h2 class="heading-margin">Recent Activities</h2>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <div class="order">
                                <div class="user-info-container">
                                    <img id="user_photo" src="<%# Eval("UserPhoto") %>" />
                                    <a href="chat.aspx?Username=<%# Eval("Username") %>"><%# Eval("UserFullname") %>
                                    </a>
                                </div>
                                <div class="order-type <%# Eval("OrderType") %>">
                                    <%# Eval("OrderType") %>
                                </div>

                                <p>Rs. <%# Eval("Amount") %></p>
                                <p><%# Get_Date(Eval("StartingDate")) %></p>
                                <div class="order-status-container">
                                    <span class="status <%# Eval("Status") %>"></span>
                                    <p><%# Eval("Status") %></p>
                                </div>

                            </div>
                        </ItemTemplate>
                        <FooterTemplate>
                            <div style="text-align: center;">
                                <asp:Label ID="No_Order_History_Error" runat="server"
                                    Visible='<%# rptrOrder_detail.Items.Count == 0 %>' Text="No Order History" />
                            </div>
                            <div style="height: 100px;"></div>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </div>
    <script src="/script/buyer_bar_chart.js"></script>
    <script src="script/seller_chart.js"></script>
</asp:Content>
