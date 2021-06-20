<%@ Page Title="" Language="C#" MasterPageFile="~/seller.Master" AutoEventWireup="true" CodeBehind="stransaction.aspx.cs" Inherits="WorKar.WebForm4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="UTF-8">
    <title>Transaction | WorKarr</title>

    <!--Bootstrap link-->
    <link href="Content/bootstrap.css" rel="stylesheet" runat="server" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" runat="server" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">


    <!-- style sheet link -->
    <link href="style/input_tag.css" rel="stylesheet" runat="server"/>
    <link href="style/transaction.css" rel="stylesheet" runat="server" />


    <!--CDNs For Bootstrap Modal-->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>


    <script type="text/javascript">
        // append contact modal on page load
        $(document).ready(function () {

            var myDiv = document.createElement("div");
            myDiv.innerHTML = modal_template();
            document.getElementById("form1").appendChild(myDiv);
        });

        // contatc modal template
        function modal_template() {
            return '<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true"> \
                <div class="modal-dialog modal-dialog-centered" role = "document" > \
                    <div class="modal-content"> \
                        <div class="modal-header"> \
                            <h5 class="modal-title" id="exampleModalLongTitle">Contact US</h5> \
                            <button type="button" id="cross-btn" class="close" data-dismiss="modal" aria-label="Close"> \
                                <span aria-hidden="true">&times;</span> \
                            </button> \
                        </div> \
                        <div class="modal-body"> \
                            <label class=" ml-auto font-weight-bold">Payment Details</label> \
                            <div class="row"> \
                                <div class="form-group"> \
                                    <label>Name</label> \
                                    <input id="contact_nameID" class="form-control" onfocusout="reset_required_field_error(this, \'RequiredField_Name_Error\')" placeholder="Farhan Ali"/> \
                                    <span id="RequiredField_Name_Error" style="display:none;">Required*</span> \
                                </div> \
                            </div> \
                            <div class="row"> \
                                <div class="form-group"> \
                                    <label>Email</label> \
                                    <input id="contact_emailID" class="form-control" type="email" onfocusout="reset_required_field_error(this, \'RequiredField_Email_Error\')"  placeholder="example@gmail.com" /> \
                                    <span id="RequiredField_Email_Error" style="display:none;">Required*</span> \
                                </div> \
                            </div> \
                            <div class="row"> \
                                <div class="form-group"> \
                                    <label>Password</label> \
                                    <input id="contact_passwordID" class="form-control" type="password" onfocusout="reset_required_field_error(this, \'RequiredField_Password_Error\')"  placeholder="&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;" /> \
                                     <span id="RequiredField_Password_Error" style="display:none;">Required*</span> \
                                </div > \
                            </div> \
                            <div class="row"> \
                                <div class="form-group"> \
                                    <label>Message</label> \
                                    <textarea class="form-control" placeholder="Type your message here . . . " id="contact_messageID" onfocusout="reset_required_field_error(this, \'RequiredField_Message_Error\')"  rows="5" style="resize: none"></textarea> \
                                    <span id="RequiredField_Message_Error" style="display:none;">Required*</span> \
                                </div > \
                            </div > \
                            <span id="email_send_message" style="display:none;">Required*</span> \
                        </div> \
                        <div class="modal-footer"> \
                            <button type="button" class="button1" data-dismiss="modal">Close</button> \
                            <button id="contact_send_btnID" onclick="return send_message();" class="button2">Send</button> \
                        </div> \
                    </div> \
                </div> \
            </div>';
        }

    </script>

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
                                    <p><%# Get_Transaction_Type(Eval("IsWithDraw"))%></p>
                                </div>
                            </div>
                        </ItemTemplate>
                        <FooterTemplate>
                            <div style="text-align: center;">
                            <asp:Label ID="No_Transaction_History_Error" runat="server"
                                Visible='<%# rptrTransaction_detail.Items.Count == 0 %>' Text="No Transaction History" />
                            </div>
                        </FooterTemplate>
                    </asp:Repeater>

                    <asp:Repeater ID="rptrOrder_detail" runat="server">
                        <HeaderTemplate>
                            <h2 class="heading-margin">Order History</h2>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <div class="order">
                                <div class="user-info-container">
                                    <img id="user_photo" src="<%# Eval("UserPhoto") %>" />
                                    <a href="chat.aspx?Username=<%# Eval("Username") %>"><%# Eval("UserFullname") %></a>
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

                <div class="right-inner-section">
                    <div class="payment-header">
                        <h2>Payment</h2>
                        <button type="button" data-toggle="modal" data-target="#exampleModalCenter" data-backdrop='static' data-keyboard='false'><i class="fas fa-plus"></i></button>
                    </div>
                    <div class="container">
                        <div class="box1-container box">
                            <div class="flex">
                                <h1>Credit</h1>
                                <div class="icon">
                                    <i class="fas fa-dollar-sign"></i>
                                </div>
                            </div>
                            <h1>Rs. <span id="TotalCredit" runat="server"></span></h1>
                        </div>
                        <div class="box2-container box">
                            <div class="flex">
                                <h1>Debit</h1>
                                <div class="icon">
                                    <i class="fas fa-dollar-sign"></i>
                                </div>
                            </div>
                            <h1>Rs. <span id="TotalDebit" runat="server"></span></h1>
                        </div>
                        <div class="box3-container box">
                            <div class="flex">
                                <h1>Net Balance</h1>
                                <div class="icon">
                                    <i class="fas fa-dollar-sign"></i>
                                </div>
                            </div>
                            <h1>Rs. <span id="netBalance" runat="server"></span></h1>
                        </div>
                    </div>
                    <div style="height: 200px;"></div>

                </div>
            </div>
        </div>

    </div>
</asp:Content>
