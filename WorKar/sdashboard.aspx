<%@ Page Title="" Language="C#" MasterPageFile="~/seller.Master" AutoEventWireup="true" CodeBehind="sdashboard.aspx.cs" Inherits="WorKar.WebForm3" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <title>Dashboard | WorKarr</title>

        <!--Chart.js scripts cdn-->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>

    <!--AJAX API-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

    <link href="style/seller_dashboard.css" rel="stylesheet" runat="server" />
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
                        <h3>Overview</h3>
                        <div class="chart-container">
                            <canvas id="line-chart"></canvas>
                        </div>
                    </div>

                                <div class="independent-card">

            <h3>Earnings</h3>

            <table>
                <tr>
                    <td class="left">Personal balance</td>
                    <td class="right">100$</td>
                </tr>
                <tr>
                    <td class="left">Earning in <span class="month">month</span></td>
                    <td class="right">50$</td>
                </tr>
                <tr>
                    <td class="left">Avg. selling price</td>
                    <td class="right">30$</td>
                </tr>
                <tr>
                    <td class="left">Pending CLearance</td>
                    <td class="right">40$</td>
                </tr>
                <tr>
                    <td class="left">Active orders</td>
                    <td class="right">03</td>
                </tr>
                <tr>
                    <td class="left">Total Orders</td>
                    <td class="right">105</td>
                </tr>

                <tr>
                    <td class="left">Completed Orders</td>
                    <td class="right">100</td>
                </tr>
                <tr>
                    <td class="left">Cancelled Orders</td>
                    <td class="right">05</td>
                </tr>
            </table>
        </div>

                    </div>

                    <div class="container2">
                        <!-- left inner container for jobs and chart-->
                        <div class="left-inner-container">
                            <!--chart/statistics-->
                                <div class="chart-outer-container">
                                    <h3>Spending Activity</h3>
                                    <div class="chart-container">
                                        <canvas id="bar-chart"></canvas>
                                    </div>
                            </div>
                        </div>

<%--                        <div class="right-inner-container">
                            <div class="monthly-activity-container">
                                <h3>Monthly Activity</h3>
                                <div class="pie-chart-container">
                                    <div class="pie-chart-container">
                                        <canvas id="pie-chart"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>--%>
                    </div>


                                        <!-- mid lower Container -->
                    <div class="most-bottom-container">
                        <h3>Recent Activities</h3>
                        <div class="recent-activity-container">
                            <div class="activity">
                                <div class="icon">
                                    <i class="far fa-arrow-alt-up"></i>
                                </div>
                                <p>2021-09-12</p>
                                <p>7564829</p>
                                <p>Debit</p>
                                <p>Mohsin Ali</p>
                                <p>50000</p>
                            </div>
                            <div class="activity">
                                <div class="icon">
                                    <i class="far fa-arrow-alt-down"></i>
                                </div>
                                <p>2021-09-12</p>
                                <p>7564829</p>
                                <p>Debit</p>
                                <p>Mohsin Ali</p>
                                <p>50000</p>
                            </div>
                            <div class="activity">
                                <div class="icon">
                                    <i class="far fa-arrow-alt-down"></i>
                                </div>
                                <p>2021-09-12</p>
                                <p>7564829</p>
                                <p>Debit</p>
                                <p>Mohsin Ali</p>
                                <p>50000</p>
                            </div>
                            <div class="activity">
                                <div class="icon">
                                    <i class="far fa-arrow-alt-down"></i>
                                </div>
                                <p>2021-09-12</p>
                                <p>7564829</p>
                                <p>Debit</p>
                                <p>Mohsin Ali</p>
                                <p>50000</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="/script/buyer_bar_chart.js"></script>
        <script src="script/seller_chart.js"></script>
    </asp:Content>