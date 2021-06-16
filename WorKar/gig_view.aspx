<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="gig_view.aspx.cs" Inherits="WorKar.gig_view" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <title>Gig View | WorKarr</title>

    <!--Font Awsome linkk-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <script src="https://kit.fontawesome.com/571b8d9aa3.js" crossorigin="anonymous"></script>

    <!--For Fonts-->
    <link rel="preconnect" href="https://fonts.gstatic.com" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet" />

    <!--Bootstrap CSS Link-->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous" runat="server" />

    <!--Bootstrap JS Link-->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    <!--AJAX API-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script type="text/javascript">
        const { type } = require("jquery");

        // to verify card details from the database
        function verify_card_detail() {
            var responseResult = false;

            let duration = document.getElementById("duration_days").innerText;
            let amount = document.getElementById("gig_amount").innerText;

            let orderDescription = document.getElementById("orderDescriptionID").value;
            let nameOnCard = document.getElementById("<%= nameOnCardID.ClientID%>").value;
            let accountNum = document.getElementById("accountNumID").value;
            let expiryDate = document.getElementById("<%= expiryDateID.ClientID%>").value;
            let cvs = document.getElementById("cvvID").value;


            $.ajax({
                async: false,
                type: "POST",
                url: "gig_view.aspx/Is_Correct_Card_Details",
                data: '{"nameOnCard":"' + nameOnCard + '","accountNum":"' + accountNum + '","expiryDate":"' + expiryDate + '","cvs":"' + cvs + '","orderDescription":"' + orderDescription + '","duration":"' + duration + '","amount":"' + amount + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

                    // display msg accordingly
                    let msg_span = document.getElementById('incorrect_card_error');

                    msg_span.style.color = "red";
                    if (response.d == 0) {
                        msg_span.innerText = "Sorry! You cannot place order to yourself.";
                    }
                    else if (response.d == 1) {
                        msg_span.style.color = "green";
                        msg_span.innerText = "Order has been placed successfully!";
                        responseResult = true;
                    }
                    else if (response.d == 2) {
                        msg_span.innerText = "Card details are not correct. Retry!";
                    }
                    else if (response.d == 3) {
                        msg_span.innerText = "Sorry! Your account does not have sufficient balance.";
                    }
                    msg_span.style.display = "block";

                },
                failure: function (response) {
                    alert("Failed");
                    responseResult = false;
                }
            });

            return responseResult;
        }
        //stop btn click event, if card details are not verified
        function is_valid_Card_details() {

            if (!Page_ClientValidate()) {
                return false;
            }

            if (!verify_card_detail()) {
                event.preventDefault();
                return false;
            }
            return true;
        }

        // front end checks for user review and add review to the database
        function is_review_sent() {
            let reviewMessage = document.getElementById("<%=review_msg.ClientID%>").value;
            let numOfStars = $('input[name="rating"]:checked').val();

            let isStarsNotFilled = (typeof numOfStars == "undefined" || numOfStars == "");
            let isReviewMessageEmpty = (typeof reviewMessage == "undefined" || reviewMessage == "" || reviewMessage.length <= 0);

            if (isStarsNotFilled || isReviewMessageEmpty) {

                if (isStarsNotFilled) {
                    document.getElementById("review_error").innerText = "Please rate user!";
                }
                else if (isReviewMessageEmpty) {
                    document.getElementById("review_error").innerText = "Review message is required!";
                }
                document.getElementById("review_error").style.display = "block";
                return false;
            }

            let responseResult = false;

            $.ajax({
                type: "POST",
                url: "gig_view.aspx/Is_Review_Sent",
                data: '{"numOfStars":"' + numOfStars + '","reviewMessage":"' + reviewMessage + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    // display msg accordingly
                    let msg_span = document.getElementById('review_error');
                    msg_span.style.color = "red";
                    if (response.d == 1) {
                        msg_span.style.color = "green";
                        msg_span.innerText = "Review has been sent successfully!";
                        responseResult = true;

                    }

                    else if (response.d == 2) {
                        msg_span.innerText = "Review fails. You have not placed any order to this user. Retry!";
                    }

                    else if (response.d == 3) {
                        msg_span.innerText = "Sorry, you cannot review yourself.";
                    }
                    else if (response.d == 4) {
                        msg_span.innerText = "OOPS! You have already review to this gig.";
                    }
                    msg_span.style.display = "block";

                },
                failure: function (response) {
                    alert("Failed");
                }
            });
            return responseResult;
        }

        function verify_review() {
            if (!is_review_sent()) {
                event.preventDefault();
                return false;
            }
            return true;
        }

    </script>


    <!--my stylesheet-->
    <link href="style/main_background.css" rel="stylesheet" runat="server" />
    <link href="style/glass_background.css" rel="stylesheet" runat="server" />
    <link href="style/circle.css" rel="stylesheet" runat="server" />
    <link href="style/preloader.css" rel="stylesheet" runat="server" />
    <link href="style/gig_view.css" rel="stylesheet" runat="server" />
    <link href="style/input_tag.css" rel="stylesheet" />

</head>

<body>
    <div id="loading"></div>
    <form id="form1" runat="server" style="width: 100%;">

        <div class="modal fade" id="form" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="formTitle">Review</h5>
                        <button type="button" id="review-cross-btn" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="card-body text-center">
                        <img src=" https://i.imgur.com/d2dKtI7.png" height="100" width="100" />
                        <div class="comment-box text-center">
                            <h4>Add a comment</h4>
                            <div class="rating">
                                <input type="radio" name="rating" value="5" id="5" /><label for="5">☆</label>
                                <input type="radio" name="rating" value="4" id="4" /><label for="4">☆</label>
                                <input type="radio" name="rating" value="3" id="3" /><label for="3">☆</label>
                                <input type="radio" name="rating" value="2" id="2" /><label for="2">☆</label>
                                <input type="radio" name="rating" value="1" id="1" /><label for="1">☆</label>
                            </div>

                            <div class="comment-area">
                                <textarea class="form-control" resize="none" id="review_msg" placeholder="what is your view?" rows="7" runat="server"></textarea>
                            </div>

                            <div>
                                <span id="review_error" style="display: none;"></span>
                            </div>

                            <div class="text-center mt-4">
                                <asp:Button ID="btn_send_review" class="btn send px-5" OnClientClick="return verify_review();" runat="server" Text="Send Review" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Place Order Modal -->
        <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">Order</h5>
                        <button type="button" id="cross-btn" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-floating mb-4">
                            <label for="exampleFormControlFile1" class=" ml-auto font-weight-bold">Order Description</label>
                            <textarea class="form-control" placeholder="Services you want . . . ." id="orderDescriptionID" maxlength="1200" rows="7" style="resize: none" runat="server"></textarea>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator_OrderDescription" Text="Required*" ValidationGroup="place_order" ControlToValidate="orderDescriptionID" runat="server" />
                        </div>

                        <label class=" ml-auto font-weight-bold">Payment Details</label>
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label>Name On Card</label>
                                    <asp:TextBox MaxLength="200" pattern="[A-Za-z ]{8,200}" ID="nameOnCardID" class="form-control" placeholder="Farhan Ali" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidato_NameOnCard" Text="Required*" ValidationGroup="place_order" ControlToValidate="nameOnCardID" runat="server" />
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label>Account Number</label>
                                    <input maxlength="20" pattern="[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{4}" id="accountNumID" runat="server" class="form-control" type="text" placeholder="1111-2222-3333-4444">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator_AccountNum" Text="Required*" ValidationGroup="place_order" ControlToValidate="accountNumID" runat="server" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label>Expiry Date</label>
                                    <asp:TextBox ID="expiryDateID" CssClass="form-control" TextMode="Date" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator_ExpiryDate" Text="Required*" ValidationGroup="place_order" ControlToValidate="expiryDateID" runat="server" />
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label>CVV/CSV</label>
                                    <input id="cvvID" runat="server" pattern="[0-9]{3}" class="form-control" type="text" placeholder="098" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator_CVV" Text="Required*" ValidationGroup="place_order" ControlToValidate="cvvID" runat="server" />
                                </div>
                            </div>
                        </div>
                        <span id="incorrect_card_error" style="display: none"></span>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="button1" data-dismiss="modal">Close</button>
                        <asp:Button ID="place_orderID" ValidationGroup="place_order" CausesValidation="true" OnClientClick="return is_valid_Card_details();" class="button2" runat="server" Text="Place Order" />
                    </div>
                </div>
            </div>

        </div>



        <main>
            <section class="glass">

                <button type="button" class="prev">
                    <i class="fas fa-chevron-left"></i>
                </button>
                <button type="button" class="next">
                    <i class="fas fa-chevron-right"></i>
                </button>
                <asp:Repeater ID="rptrGig_DetailID" runat="server">
                    <ItemTemplate>
                        <div class="card1-container card-container active-page-no">

                            <div class="left-section">
                                <div class="img-container">
                                    <!-- Slider Code Start-->
                                    <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
                                        <div class="carousel-inner">
                                            <div class="carousel-item active">
                                                <img class="d-block w-100" src="<%# Eval( "Image1") %>" alt="gig-image1">
                                            </div>
                                            <div class="carousel-item">
                                                <img class="d-block w-100" src="<%# Eval( "Image2")%>" alt="gig-image2">
                                            </div>
                                            <div class="carousel-item">
                                                <img class="d-block w-100" src="<%# Eval( "Image3")%>" alt="gig-image3">
                                            </div>

                                        </div>
                                        <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                            <span class="sr-only">Previous</span>
                                        </a>
                                        <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                            <span class="sr-only">Next</span>
                                        </a>
                                    </div>

                                </div>
                                <div class="card-title">
                                    <h3>
                                        <%# Eval("Title") %>
                                    </h3>
                                </div>
                            </div>
                            <div class="right-section">
                                <h2>Package</h2>
                                <div class="package-container">
                                    <div class="package-price-name">
                                        <p>Price</p>
                                        <p>
                                            Rs. <strong id="gig_amount"><%# Eval("Amount") %></strong>
                                        </p>
                                    </div>

                                    <div class="package-description-container">
                                        <p>
                                            <%# Eval("Description") %>
                                        </p>
                                    </div>

                                    <div class="duration-container">
                                        <i class="fas fa-clock"></i>
                                        <p>
                                            Delivery in
                                              
                                            <strong id="duration_days"><%# Eval("Duration") %></strong> Days
                                       
                                        </p>
                                    </div>

                                    <div class="package-features-container">
                                        <ul>
                                            <li>
                                                <p><%# Eval("Specification1") %></p>
                                                <i class="fas fa-check"></i></li>
                                            <li>
                                                <p><%# Eval("Specification2") %></p>
                                                <i class="fas fa-check"></i></li>
                                            <li>
                                                <p><%# Eval("Specification3") %></p>
                                                <i class="fas fa-check"></i></li>
                                        </ul>
                                    </div>

                                    <div class="button-container">
                                        <!-- Button trigger modal -->
                                        <button type="button" data-toggle="modal" data-target="#exampleModalCenter" data-backdrop='static' data-keyboard='false'>Place Order</button>

                                    </div>
                                </div>
                            </div>
                        </div>
                        </div>
                                </div>
                            </div>

                        </div>


                       


                        <div class="card2-container card-container">
                            <div class="left-section">
                                <div class="description1 description">
                                    <h3>Description</h3>
                                    <p>
                                        <%#Eval("Description") %>
                                    </p>
                                </div>
                                <div class="description2 description">
                                    <h3>Why You Should Hire Me?</h3>

                                    <ul>
                                        <li>
                                            <%#Eval("Specification1") %>
                                        </li>
                                        <li>
                                            <%#Eval("Specification2") %>
                                        </li>
                                        <li>
                                            <%#Eval("Specification3") %>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                    </ItemTemplate>
                </asp:Repeater>


                <asp:Repeater ID="rptrUser_DetailID" runat="server">
                    <ItemTemplate>
                        <div class="right-section">
                            <div class="user-bio">
                                <img src="/<%#Eval(" UserPhoto ") %>" style="width: 80px; height: 80px; border-radius: 50%;" alt="profile-avatar" />
                                <h5>
                                    <%# Eval(
"UserFName") + " " + Eval("UserLName") %>
                                </h5>
                                <p>
                                    <%#Eval("UserCategory") %>
                                </p>

                                <hr>
                                <div class="user-description">
                                    <p>
                                        <%#Eval("UserDescription") %>
                                    </p>
                                </div>
                                <div class="button-container" id="review-contact-btn">
                                    <button class="button2">Contact</button>
                                    <!-- button trigger for review modal -->
                                    <button type="button" class="button1" data-toggle="modal" data-target="#form">Review </button>

                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>


                <!-- Reviews-->
                <div class="review-section card-container card3-container">
                    <div class="comment-heading">
                        <h1>Reviews</h1>
                    </div>
                    <asp:Repeater ID="rptrReview_DetailID" runat="server">
                        <ItemTemplate>
                            <div class="review-container">
                                <div class="review1 review">
                                    <div class="top-sec">
                                        <div class="img-container">
                                            <img src='<%# Eval("UserPhoto") %>' alt="user-img">
                                        </div>
                                        <div class="review-client-username">
                                            <h6><%# Eval("UserFullName") %></h6>
                                            <p>@<%# Eval("Username") %></p>
                                        </div>
                                        <div class="stars-container">

                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="far fa-star"></i>
                                        </div>
                                    </div>
                                    <div class="review-message">
                                        <p><%# Eval("ReviewMsg") %></p>
                                        <span id="review_time"><%# Eval("PostedDate") %></span>
                                    </div>
                                </div>
                            </div>

                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </section>
            <div class="circle1 circle "></div>
            <div class="circle2 circle "></div>
            <div class="circle3 circle "></div>
        </main>
        <script src="/script/left_right.js" type="text/javascript" charset="utf-8"></script>
        <script src="script/preloader.js"></script>
    </form>

    <script>
        //to display gig image, if not null 
        $(document).ready(function () {
            var carousel_items = document.getElementsByClassName("carousel-item");
            var len = carousel_items.length;
            for (var i = 0; i < len; ++i) {
                var img_name = carousel_items[i].getElementsByTagName("img")[0].getAttribute("src");

                if (img_name === "") {
                    carousel_items[i].remove();
                    --i;
                }
            }
        });

    </script>
</body>

</html>
