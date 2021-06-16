<%@ Page Title="" Language="C#" MasterPageFile="~/seller.Master" AutoEventWireup="true" CodeBehind="stransaction.aspx.cs" Inherits="WorKar.WebForm4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
            <meta charset="UTF-8">
    <title>Transaction | WorKarr</title>
    <link href="style/transaction.css" rel="stylesheet" runat="server" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right-section">

    <div class="whole-container">

    <div class="transaction-list-container">
        <div class="left-inner-section">
            <div id="no-record-msg"></div>

            <asp:Repeater ID="rptrTransaction_detail" runat="server">
                <HeaderTemplate>
                                    <h2 class="heading-margin">Transaction History</h2>

                </HeaderTemplate>

                <ItemTemplate>                    
            <div class="transaction">
                <div class="icon-container">
                    <i class="fas fa-university"></i>
                    <p>Bank</p>
                </div>
                <p>Rs. <span><%# Eval("Amount") %></span></p>
                <p><%# Eval("TransactionDate") %></p>
                <div class="transaction-type">
                    <span class="<%# Get_Transaction_Type(Eval("IsWithDraw"))%>"></span>
                    <p> <%# Get_Transaction_Type(Eval("IsWithDraw"))%></p>
                </div>
            </div>
                </ItemTemplate>
            </asp:Repeater>

            <asp:Repeater ID="rptrOrder_detail" runat="server">

                <HeaderTemplate>

            <h2 class="heading-margin">Order History</h2>

                </HeaderTemplate>

                <ItemTemplate>
            <div class="order">
                <div class="user-info-container">
                    <img id="user_photo" src="<%# Eval("UserPhoto") %>" />
                    <a href="#"><%# Eval("UserFullname") %></a>
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
                                            <div style="height: 100px;"></div>
                </FooterTemplate>

            </asp:Repeater>


        </div>

        <div class="right-inner-section">
                            <h2 class="heading-margin">Payment</h2>
            <div class="container">
                <div class="box1-container box">
                    <div class="flex">
                        <h1>Credit</h1>
                        <div class="icon">
                            <i class="fas fa-dollar-sign"></i>
                        </div>
                    </div>
                    <h1>$ <span id="TotalCredit" runat="server"></span> </h1>
                </div>
                <div class="box2-container box">
                    <div class="flex">
                        <h1>Debit</h1>
                        <div class="icon">
                            <i class="fas fa-dollar-sign"></i>
                        </div>
                    </div>
                    <h1>$ <span id="TotalDebit" runat="server"></span></h1>
                </div>
                <div class="box3-container box">
                    <div class="flex">
                        <h1>Net Balance</h1>
                        <div class="icon">
                            <i class="fas fa-dollar-sign"></i>
                        </div>
                    </div>
                    <h1>$1200</h1>
                    <p>45% This Week</p>
                </div>
            </div>
                        <div style="height: 200px;"></div>

        </div>
    </div>
        </div>

</div>
</asp:Content>
