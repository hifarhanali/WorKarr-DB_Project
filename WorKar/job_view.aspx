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

        .card-title{
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
    </style>

</head>
<body>
    <div id="loading"></div>
    <form id="form1" runat="server" style="width: 100%;">
        <main>
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
                                        <p>
                                            <%#Eval("UserDescription") %>
                                        </p>
                                    </div>
                                    <div class="button-container">
                                        <button>Contact</button>
                                        <button>Get Job</button>
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
