<%@ Page Title="" Language="C#" MasterPageFile="~/seller.Master" AutoEventWireup="true" CodeBehind="sjob_creation.aspx.cs" Inherits="WorKar.WebForm7" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="UTF-8">
    <title>Create Job | WorKarr</title>

    <link href="style/job_creation.css" rel="stylesheet" runat="server" />

    <!--Bootstrap link-->
    <link href="Content/bootstrap.min.css" rel="stylesheet" />

    <!--My stylesheets link-->
    <link href="style/main_background.css" rel="stylesheet" runat="server" />
    <link href="style/glass_background.css" rel="stylesheet" runat="server" />
    <link href="style/circle.css" rel="stylesheet" runat="server" />
    <link href="style/sidebar.css" rel="stylesheet" runat="server" />
    <link href="style/gig_creation.css" rel="stylesheet" runat="server" />
    <link href="style/input_tag.css" rel="stylesheet" runat="server" />

    <style runat="server">
        .side-bar ul a li {
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
        }

            .side-bar ul a li p, .transaction p, .order p {
                margin-top: 20px !important;
            }
    </style>


    <!--AJAX API-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script type="text/javascript">
        // to verify card details from the database
        function verify_card_detail() {

            var responseResult = false;

            let amount = document.getElementById("<%=gigPrice.ClientID%>").value;
            let nameOnCard = document.getElementById("<%=nameOnCardID.ClientID %>").value;
            let accountNum = document.getElementById("<%=accountNumID.ClientID%>").value;
            let expiryDate = document.getElementById("<%= expiryDateID.ClientID%>").value;
            let cvs = document.getElementById("<%= cvvID.ClientID%>").value;

            $.ajax({
                async: false,
                type: "POST",
                url: "sjob_creation.aspx/Is_Correct_Card_Details",
                data: '{"nameOnCard":"' + nameOnCard + '","accountNum":"' + accountNum + '","expiryDate":"' + expiryDate + '","cvs":"' + cvs + '","amount":"' + amount + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

                    // display msg accordingly
                    let msg_span = document.getElementById('incorrect_card_error');
                    msg_span.style.color = "red";

                    if (response.d == 0) {
                        msg_span.style.color = "green";
                        msg_span.innerText = "Hurray! Card details are verified."
                        responseResult = true;
                    }
                    else if (response.d == 1) {
                        msg_span.innerText = "Sorry! Your account does not have sufficient balance."
                    }
                    else if (response.d == 2) {
                        msg_span.innerText = "Card details are not correct. Retry!"
                    }

                    if (response.d != 3) {
                        msg_span.style.display = "block";
                    }
                    else {
                        responseResult = true;
                    }

                },
                failure: function (response) {
                    alert("Failed");
                    responseResult = false;
                }
            });

            return responseResult;
        }

        function is_valid_Card_details() {
            // check for client side validation
            if (!Page_ClientValidate()) {
                return false;
            }
            // prevent button click event, if card details are not verified
            if (!verify_card_detail()) {
                event.preventDefault();
                return false;
            }

            return true;
        }

    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="right-section">
        <div class="container-fluid">
            <h2 class="gigCreationHeading align-content-center">Job Creation</h2>

            <!-- Title container-->
            <div class="form-floating mb-4">
                <label for="exampleFormControlFile1" class="mt-3 ml-auto font-weight-bold">Job Title</label>
                <input type="text" class="form-control" id="gigTitle" placeholder="I am looking for a graphic designer . . . ." maxlength="100" runat="server" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" Text="Required*" ValidationGroup="Save_Gig" ControlToValidate="gigTitle" runat="server" />
            </div>

            <!-- Description container-->
            <div class="form-floating mb-4">
                <label for="exampleFormControlFile1" class=" ml-auto font-weight-bold">Job Description</label>
                <textarea class="form-control" placeholder="Services you are looking for . . . ." id="gigDescription" maxlength="1200" rows="7" style="resize: none" runat="server"></textarea>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" Text="Required*" ValidationGroup="Save_Gig" ControlToValidate="gigDescription" runat="server" />
            </div>

            <!-- Price container-->
            <div class="form-floating mb-4">
                <label for="exampleFormControlFile1" class=" ml-auto font-weight-bold">Price in PKR</label>
                <asp:TextBox ID="gigPrice" CssClass="form-control" placeholder="5000" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Text="Required*" ValidationGroup="Save_Gig" ControlToValidate="gigPrice" runat="server" />
                <asp:RegularExpressionValidator ID="GigPrice_RegexValidator"
                    ControlToValidate="gigPrice" runat="server"
                    ErrorMessage="(Inavlid Price)"
                    ValidationExpression="\d+">
                </asp:RegularExpressionValidator>

            </div>

            <!-- Categoriess container-->
            <h6 class="font-weight-bold">Choose Category </h6>
            <div class="dropdown-style mb-4">
                <!-- Category Drop down list -->
                <asp:DropDownList ID="ddlCategories" AppendDataBoundItems="true" DataTextField="category_name"
                    DataValueField="category_id" runat="server">
                    <asp:ListItem Value="0">Select Category</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="reqCategory" Text="Required*" ValidationGroup="Save_Gig" InitialValue="0" ControlToValidate="ddlCategories" runat="server" />
            </div>

            <!-- Duration container-->
            <h6 class="font-weight-bold">In How Many Days/Months/Years You Want The Order?</h6>
            <div class="dropdown-style mb-4">
                <asp:DropDownList ID="ddlDuration" required="required" runat="server">
                    <asp:ListItem Value="0">Please Select Number of Days</asp:ListItem>
                    <asp:ListItem Value="1">1 Day </asp:ListItem>
                    <asp:ListItem Value="2">2 Days</asp:ListItem>
                    <asp:ListItem Value="3">3 Days</asp:ListItem>
                    <asp:ListItem Value="4">4 Days</asp:ListItem>
                    <asp:ListItem Value="7">1 Week </asp:ListItem>
                    <asp:ListItem Value="14">2 Weeks </asp:ListItem>
                    <asp:ListItem Value="21">3 Weeks </asp:ListItem>
                    <asp:ListItem Value="30">1 Month</asp:ListItem>
                    <asp:ListItem Value="60">2 Months</asp:ListItem>
                    <asp:ListItem Value="90">3 Months</asp:ListItem>
                    <asp:ListItem Value="180">6 Months</asp:ListItem>
                    <asp:ListItem Value="365">1 year</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="reqDuration" Text="Required*" ValidationGroup="Save_Gig" InitialValue="0" ControlToValidate="ddlDuration" runat="server" />
            </div>

            <label class=" ml-auto font-weight-bold">Payment Details</label>
            <div class="row">
                <div class="col">
                    <div class="form-group">
                        <label>Name On Card</label>
                        <asp:TextBox MaxLength="200" onfocusout="verify_card_detail()" pattern="[A-Za-z ]{8,200}" ID="nameOnCardID" class="form-control" placeholder="Farhan Ali" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidato_NameOnCard" Text="Required*" ValidationGroup="place_order" ControlToValidate="nameOnCardID" runat="server" />
                    </div>
                </div>
                <div class="col">
                    <div class="form-group">
                        <label>Account Number</label>
                        <input maxlength="20" onfocusout="verify_card_detail()" pattern="[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{4}" id="accountNumID" runat="server" class="form-control" type="text" placeholder="1111-2222-3333-4444">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator_AccountNum" Text="Required*" ValidationGroup="place_order" ControlToValidate="accountNumID" runat="server" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <div class="form-group">
                        <label>Expiry Date</label>
                        <asp:TextBox ID="expiryDateID" CssClass="form-control" onfocusout="verify_card_detail()" TextMode="Date" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator_ExpiryDate" Text="Required*" ValidationGroup="place_order" ControlToValidate="expiryDateID" runat="server" />
                        <span id="incorrect_card_error" style="display: none"></span>

                    </div>
                </div>
                <div class="col">
                    <div class="form-group">
                        <label>CVV/CSV</label>
                        <input id="cvvID" runat="server" pattern="[0-9]{3}" onfocusout="verify_card_detail()" class="form-control" type="text" placeholder="098" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator_CVV" Text="Required*" ValidationGroup="place_order" ControlToValidate="cvvID" runat="server" />

                    </div>
                </div>
            </div>


            <!-- Buttons container-->
            <div class="button-container">
                <asp:Button ID="button_saveID" ValidationGroup="Save_Gig" CausesValidation="true" OnClientClick="return is_valid_Card_details();" OnClick="button_saveID_Click" Text="Save" CssClass=" m-1 button1" runat="server" />
                <asp:Button ID="button_cancelID" OnClick="button_cancelID_Click" CausesValidation="false" runat="server" Text="Cancel" CssClass="m-1 button2" />
            </div>


        </div>

        <div style="height: 100px;"></div>

    </div>
</asp:Content>
