<%@ Page Title="" Language="C#" MasterPageFile="~/seller.Master" AutoEventWireup="true" CodeBehind="stransaction.aspx.cs" Inherits="WorKar.WebForm4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="UTF-8">
    <title>Transaction | WorKarr</title>

    <!--Bootstrap link-->
    <link href="Content/bootstrap.css" rel="stylesheet" runat="server" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" runat="server" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">

    
    <!--CDNs For Bootstrap Modal-->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>


    <!-- style sheet link -->
    <link href="style/input_tag.css" rel="stylesheet" runat="server"/>
    <link href="style/transaction.css" rel="stylesheet" runat="server" />


    <style>
        .side-bar ul a li {
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
        }

            .side-bar ul a li p, .transaction p, .order p {
                margin-top: 20px !important;
            }

            .transaction p, .order p{
                font-weight: 300 !important;
            }

    </style>

    <!--AJAX API-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script type="text/javascript">
        // append contact modal on page load
        $(document).ready(function () {

            var myDiv = document.createElement("div");
            myDiv.innerHTML = modal_template();
            document.getElementById("form1").appendChild(myDiv);
        });

        // to hide required field error msg
        function reset_required_field_error(inp, error_msg_id) {
            if (inp.value.length > 0) {
                $("#" + error_msg_id).css("display", "none");
            }
        }



        // contatc modal template
        function modal_template() {
            return '<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true"> \
                <div class="modal-dialog modal-dialog-centered" role = "document" > \
                    <div class="modal-content"> \
                        <div class="modal-header"> \
                            <h5 class="modal-title" id="exampleModalLongTitle">Payment</h5> \
                            <button type="button" id="cross-btn" class="close" data-dismiss="modal" aria-label="Close"> \
                                <span aria-hidden="true">&times;</span> \
                            </button> \
                        </div> \
                        <div class="modal-body"> \
                            <label class=" ml-auto font-weight-bold">Payment Details</label> \
                            <div class="row"> \
                                <div class="form-group"> \
                                    <label>Name On Card</label> \
                                    <input id="card_nameID" class="form-control" onfocusout="reset_required_field_error(this, \'RequiredField_CardName_Error\')" placeholder="Farhan Ali"/> \
                                    <span id="RequiredField_CardName_Error" style="display:none; color: red;">Required*</span> \
                                </div> \
                            </div> \
                            <div class="row"> \
                                <div class="form-group"> \
                                    <label>Account Number</label> \
                                    <input id="card_accountNumID" maxlength="20" pattern="[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{4}" class="form-control" type="text" onfocusout="reset_required_field_error(this, \'RequiredField_CardAccountNum_Error\')"  placeholder="4444-4444-4444-4444" /> \
                                    <span id="RequiredField_CardAccountNum_Error" style="display:none; color: red;">Required*</span> \
                                </div> \
                            </div> \
                            <div class="row"> \
                                <div class="col">\
                                <div class="form-group"> \
                                    <label>Expiry Date</label> \
                                    <input id="card_expDateID" class="form-control" type="date" onfocusout="reset_required_field_error(this, \'RequiredField_CardExpDate_Error\')" /> \
                                     <span id="RequiredField_CardExpDate_Error" style="display:none; color: red;">Required*</span> \
                                </div> \
                                </div > \
                                <div class="col">\
                                    <div class="form-group"> \
                                    <label>CVV</label> \
                                    <input id="card_cvvID" pattern="[0-9]{3}" class="form-control" type="text" placeholder="098"  onfocusout="reset_required_field_error(this, \'RequiredField_CardCvv_Error\')" />\
                                    <span id="RequiredField_CardCvv_Error" style="display:none; color: red;">Required*</span> \
                                </div > \
                                </div > \
                            </div > \
                            <div class="row"> \
                                <div class="col">\
                                    <label>Transaction Type</label> \
                                    <select id="transactionType" class="form-control">\
                                        <option value=1 checked="true">Withdraw</option>\
                                        <option value=0>Deposit</option>\
                                    </select>\
                                </div > \
                                <div class="col">\
                                <div class="form-group"> \
                                    <label>Amount In PKR</label> \
                                    <input id="card_amountID" class="form-control" type="number" min=0 max="2147483647" placeholder="500"  onfocusout="reset_required_field_error(this, \'RequiredField_CardAmount_Error\')" />\
                                    <span id="RequiredField_CardAmount_Error" style="display:none; color: red;">Required*</span> \
                                </div > \
                                </div > \
                            </div > \
                            <span id="incorrect_card_error" style="display:none; color: red;"></span> \
                        </div> \
                        <div class="modal-footer"> \
                            <button type="button" class="button1" data-dismiss="modal">Close</button> \
                            <button id="contact_send_btnID" onclick="return perform_transaction();" class="button2">Continue</button> \
                        </div> \
                    </div> \
                </div> \
            </div>';
        }

        function format_num_to_currency(currencyType, number) {
            // Create our number formatter.
            var formatter = new Intl.NumberFormat('en-US', {
                style: 'currency',
                currency: currencyType,

                // These options are needed to round to whole numbers if that's what you want.
                minimumFractionDigits: 0, // (this suffices for whole numbers, but will print 2500.10 as $2,500.1)
                maximumFractionDigits: 0, // (causes 2500.99 to be printed as $2,501)
            });
            return formatter.format(number);
        }




        // send message of user to WorKarr
        function perform_transaction()
        {
            // to get input field values
            let nameOnCard = document.getElementById('card_nameID').value;
            let accountNum = document.getElementById('card_accountNumID').value;            
            let expDate = document.getElementById('card_expDateID').value;
            let cvv = document.getElementById('card_cvvID').value;
            let amount = document.getElementById('card_amountID').value;
            let isWithdraw = $("#transactionType").find(":selected").val();

            $("#RequiredField_CardName_Error").css("display", "none");
            $("#RequiredField_CardAccountNum_Error").css("display", "none");
            $("#RequiredField_CardExpDate_Error").css("display", "none");
            $("#RequiredField_CardCvv_Error").css("display", "none");
            $("#RequiredField_CardAmount_Error").css("display", "none");

            // front-end checks
            let isValidMessage = true;

            if (nameOnCard.length <= 0) {
                $("#RequiredField_CardName_Error").css("display", "block");
                isValidMessage = false;
            }
            if (accountNum.length <= 0) {
                $("#RequiredField_CardAccountNum_Error").css("display", "block");
                isValidMessage = false;
            }
            if (cvv.length <= 0) {
                $("#RequiredField_CardCvv_Error").css("display", "block");
                isValidMessage = false;
            }
            if (expDate.length <= 0) {
                $("#RequiredField_CardExpDate_Error").css("display", "block");
                isValidMessage = false;
            }
            if (amount <= 0) {
                $("#RequiredField_CardAmount_Error").text("Withdraw amount should be greater than 0.");
                $("#RequiredField_CardAmount_Error").css("display", "block");
                isValidMessage = false;
            }

            const MAX_AMOUTNT = 2147483647;
            if (amount > MAX_AMOUTNT) {
                $("#RequiredField_CardAmount_Error").text("Withdraw amount should be less than " + MAX_AMOUTNT + ".");
                $("#RequiredField_CardAmount_Error").css("display", "block");
                isValidMessage = false;
            }

            if (!isValidMessage) return false;

            let responseResult = false;
            $.ajax({
                type: "POST",
                url: "stransaction.aspx/Perform_Transaction",
                data: '{"nameOnCard":"' + nameOnCard + '","accountNum":"' + accountNum + '","expiryDate":"' + expDate + '","cvv":"' + cvv + '","amount":"' + amount + '","isWithdraw":"' + isWithdraw + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

                    // display msg accordingly
                    let msg_span = document.getElementById('incorrect_card_error');

                    msg_span.style.color = "red";
                    if (response.d == 0) {
                        msg_span.innerText = "Sorry! Your account does not have sufficient balance.";
                    }
                    else if (response.d == 1) {
                        msg_span.style.color = "green";
                        msg_span.innerText = "Transaction has been place successfully!";
                        responseResult = true;
                    }
                    else if (response.d == 2) {
                        msg_span.innerText = "Card details are not correct. Retry!";
                    }
                    msg_span.style.display = "block";

                },
                failure: function (response) {
                    alert("Transaction Failed");
                }
            });

            return responseResult;
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
                        <button type="button" title="Add Transaction" data-toggle="modal" data-target="#exampleModalCenter" data-backdrop='static' data-keyboard='false'><i class="fas fa-plus"></i></button>
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
