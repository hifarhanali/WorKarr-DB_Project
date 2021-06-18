<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="job_view.aspx.cs" Inherits="WorKar.WebForm5" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <title>Job View | WorKarr</title>
    <link rel="icon" href="images/logo_square.png"
        type="image/x-icon" />

    <!--my stylesheet-->
    <link href="style/main_background.css" rel="stylesheet" runat="server" />
    <link href="style/glass_background.css" rel="stylesheet" runat="server" />
    <link href="style/circle.css" rel="stylesheet" runat="server" />
    <link href="style/preloader.css" rel="stylesheet" runat="server" />
    <link href="style/gig_view.css" rel="stylesheet" runat="server" />
    <link href="style/input_tag.css" rel="stylesheet" runat="server" />

    <!--Font Awsome linkk-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <script src="https://kit.fontawesome.com/571b8d9aa3.js" crossorigin="anonymous"></script>
    <!--For Fonts-->
    <link rel="preconnect" href="https://fonts.gstatic.com" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet" />

    <style runat="server">
        .card-title {
            border-bottom: 1px solid lightgray;
            background-color: RGBA(1,46,77,0.6);
            color: white;
        }

        .description {
            padding: 20px;
            height: 79%;
            overflow-x: hidden;
            overflow-y: auto;
            -webkit-user-select: none;
            -khtml-user-select: none;
            -moz-user-select: none;
            -o-user-select: none;
            user-select: none;
        }


        ::-webkit-scrollbar {
            width: 8px;
            background: transparent;
        }

        ::-webkit-scrollbar-thumb {
            background-color: #3a4d5f;
        }


        .card-title {
            padding: 30px 0 !important;
            height: auto !important;
            margin: 0% !important;
        }

            .card-title h1 {
                text-align: left !important;
            }

        .button-container {
            margin-top: 30px !important;
            justify-content: space-between !important;
            align-items: center !important;
        }

            .button-container button:first-child {
                width: 47.5% !important;
            }

            .button-container button:last-child {
                width: 47.5% !important;
                background-color: green;
                border-color: green;
            }

                .button-container button:last-child:hover {
                    color: green !important;
                    background-color: white;
                }

        .error_block {
            margin: 0 !important;
            text-align: center;
            background-color: rgba(255, 0, 0, 0.2);
            width: 90%;
            padding: 14px;
            border-radius: 5px;
            display: none;
            color: red;
            animation: showError 1s;
        }

            .error_block span {
                font-size: 14px;
                font-weight: 400;
                color: red;
            }

        #get_job_msg_div {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-content: center;
            position: absolute;
            top: 0%;
            left: 35%;
            height: 6vh;
            width: 30%;
            z-index: 1999999999;
            animation: showMessage 1s;
            transition: all 1s;
            display: none;
        }

        .hide-display {
            display: none;
        }


        @keyframes showMessage {
            0% {
                display: none;
                opacity: 0;
                transform: translateY(-6vh);
            }

            100% {
                display: flex;
                opacity: 1;
                transform: translateY(0vh);
            }
        }
    </style>



    <!--AJAX API-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script type="text/javascript">
        function get_job() {

            let description = $("#job_description").html();
            let amount = $("#Job_Price_HiddenField").val();
            let duration = $("#Job_Duration_HiddenField").val();

            $.ajax({
                type: "POST",
                data: '{"description":"' + description + '","duration":"' + duration + '","amount":"' + amount + '"}',
                url: "job_view.aspx/Get_Job",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                failure: function (response) {
                    alert("Failed");
                }
            });
            function OnSuccess(response) {
                if (response.d) {
                    $("#get_job_msg").html("<strong>Hurray! Job has been assigned to you successfully.</strong>");
                    $("#get_job_msg").css("color", "green");
                    document.getElementById("get_job_msg_div").style.backgroundColor = "rgba(0, 255, 0, 0.2)";
                }
                else {
                    $("#get_job_msg").html("<strong>OOPS! Fail to assign job. Retry!</strong>");
                    $("#get_job_msg").css("color", "red");
                    document.getElementById("get_job_msg_div").style.backgroundColor = "rgba(255, 0, 0, 0.2)";
                }
                $("#get_job_msg_div").css("display", "flex");
                setTimeout(function () {
                    $("#get_job_msg_div").slideUp("slow");
                }, 10000);
            }

            return false;
        }
    </script>

</head>
<body>
    <div id="loading"></div>
    <form id="form1" runat="server" style="width: 100%;">
        <main>
            <div class="error_block" id="get_job_msg_div" runat="server">
                <span id="get_job_msg"></span>
            </div>
            <section class="glass">
                <div class="card-container active-page-no">


                    <div class="left-section">
                        <asp:Repeater ID="rptrJob_DetailID" runat="server">
                            <ItemTemplate>
                                <div class="card-title">
                                    <h1><%# Eval("Title") %></h1>
                                </div>

                                <div class="description">
                                    <h2>Description</h2>
                                    <p><%# Eval("Description") %></p>
                                </div>

                                <input id="Job_Price_HiddenField" hidden="hidden" value="<%# Eval("Amount") %>" />
                                <input id="Job_Duration_HiddenField" hidden="hidden" value="<%# Eval("Duration") %>" />
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>


                    <asp:Repeater ID="rptrUser_DetailID" runat="server">
                        <ItemTemplate>
                            <div class="right-section">
                                <div class="user-bio">
                                    <img src="/<%#Eval(" UserPhoto ") %>" style="width: 80px; height: 80px; border-radius: 50%;" alt="profile-avatar" />
                                    <h5>
                                        <%# Eval("UserFName") + " " + Eval("UserLName") %>
                                    </h5>
                                    <p>
                                        <%#Eval("UserCategory") %>
                                    </p>
                                    <br />

                                    <hr>
                                    <br />

                                    <div class="user-description">
                                        <p id="job_description">
                                            <%#Eval("UserDescription") %>
                                        </p>
                                    </div>
                                    <div class="button-container">
                                        <button>Contact</button>
                                        <button id="get_jobID" onclick="return get_job();">Get Job</button>
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
        <script src="script/preloader.js"></script>
    </form>
</body>
</html>
