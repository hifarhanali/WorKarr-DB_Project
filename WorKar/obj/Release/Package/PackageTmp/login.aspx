﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="WorKar.login" EnableEventValidation="false" %>

    <!DOCTYPE html>

    <html xmlns="http://www.w3.org/1999/xhtml">

    <head runat="server">
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        
        
        <title>Login in | WorKarr</title>
        <link rel = "icon" href =
        "images/logo_square.png" 
        type = "image/x-icon" />
         <!--font awsome link-->
        <script src="https://kit.fontawesome.com/571b8d9aa3.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />

        <!--poppins font link-->
        <link rel="preconnect" href="https://fonts.gstatic.com" />
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet" />

        <!--my stylesheet-->
        <link href="style/main_background.css" rel="stylesheet" runat="server"/>
        <link href="style/glass_background.css" rel="stylesheet" runat="server"/>
        <link href="style/preloader.css" rel="stylesheet" runat="server"/>
        <link href="style/login.css" rel="stylesheet" runat="server"/>
        <link href="style/navbar.css" rel="stylesheet" runat="server"/>
        <link href="style/login_signup_home_responsive.css" rel="stylesheet" runat="server"/>
        <!--Jquery link -->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

        <script>
            // animation to hide error block
            $(document).ready(function () {
                setTimeout(function () {
                    $("#not_verify_email_error").slideUp("slow");
                }, 5000);
            });
        </script>
    </head>

    <body>
        <div id="loading"></div>
        <form id="form1" style="width:100%;" runat="server">
            <main>
                <div class="error_block" ID="not_verify_email_error" runat="server"><p>Your email address is not verified. <strong>Check your inbox</strong> and verify your account.</p></div>
                                <div class="mega-container">
                                            <div class="header">
                                <img src='<%=ResolveUrl("~/images/WorKarr_logo2.png") %>'  onclick="window.location.href='Home.aspx'" class="workarr_logo_img" />
                                                            <nav class="nav-bar">
                                    <ul class="ul right-navbar">
                                       <li>
                                            <asp:HyperLink ID="hyperlink_homeID" runat="server" NavigateUrl="Home.aspx">Home</asp:HyperLink>
                                        </li>
                                        <li  class="active-page">
                                            <asp:HyperLink ID="hyperlink_loginID" NavigateUrl="login.aspx" runat="server">Login</asp:HyperLink>
                                        </li>
                                        <li>
                                            <asp:HyperLink ID="hyperlink_signupID" NavigateUrl="signup.aspx" runat="server">Signup</asp:HyperLink>
                                        </li>
                                        <li>
                                            <asp:HyperLink ID="hyperlink_faqID" runat="server" NavigateUrl="FAQ.aspx">FAQ</asp:HyperLink>
                                        </li>

                                    </ul>
                                </nav>

                        </div>

                <section class="glass">
                    <!-- Right Column-->
                    <div class="left-col">
                        <div class="right-col-container">
                            <h1>Login</h1>
                            <asp:HyperLink ID="hyperlink_forgetID" runat="server" NavigateUrl="#">Forget username/password?</asp:HyperLink>
                            <br/><br/>
                            <!-- email and passoword input -->
                            <div class="form-container">
                                <form method="get" autocomplete="off" >
                                    <div class="email-container" id="email_containerID" runat="server">
                                        <i class="fas fa-envelope icon"></i>
                                        <asp:TextBox ID="textbox_emailID" runat="server" TextMode="SingleLine" MaxLength="30" Placeholder="@username"></asp:TextBox>
                                    </div>
                                    <div class="error_block" ID="email_error_block" runat="server">
                                        <asp:Label ID="label_email_errorID" runat="server" Text=""></asp:Label>
                                    </div>
                                    <div class="password-container" id="pass_containerID" runat="server">
                                        <i class="fas fa-key icon"></i>
                                        <asp:TextBox ID="textbox_passwordID" runat="server" TextMode="Password" MaxLength="30" placeholder="&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;"></asp:TextBox>
                                        <i class="far fa-eye icon"></i>
                                    </div>
                                    <div class="error_block" ID="pass_error_block" runat="server">
                                        <asp:Label ID="label_pass_errorID" runat="server" Text=""></asp:Label>
                                    </div>
                                    <div class="login-btn-container">
                                            <label for="chkbox_remember_meID" style="display:flex; align-content:center; margin: 0;">
                                                <asp:CheckBox ID="chkbox_remember_meID" runat="server"></asp:CheckBox>
                                                <div>
                                                   &nbsp;&nbsp;  Remember me
                                                </div>                                          
                                           </label>
                                            <asp:Button ID="button_loginID" OnClick="button_loginID_Click"  CssClass="login button" runat="server" Text="Login" ></asp:Button>
                                    </div>
                                </form><br />
                            </div>
                            <div class="signup_hyperlink_container center">

                                <p>Don't have an account?</p>
                                <asp:HyperLink ID="signup_hyperlink" runat="server" NavigateUrl="signup.aspx">
                                    <h2>Sign up</h2>
                                </asp:HyperLink>
                            </div>
                        </div>
                    </div>
                    <!-- Left Column-->
                    <div class="right-col">
                        <div class="right-inner-container">
                            <img src='<%=ResolveUrl("~/images/signup_bg.png") %>' alt="signup-page-img"/>
                        </div>
                    </div>
                </section>
                                    </div>

            </main>
            <div class="slider"></div>
<%--            <!--For animation-->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/latest/TimelineMax.min.js" integrity="sha512-lJDBw/vKlGO8aIZB8/6CY4lV+EMAL3qzViHid6wXjH/uDrqUl+uvfCROHXAEL0T/bgdAQHSuE68vRlcFHUdrUw==" crossorigin="anonymous"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/latest/TweenMax.min.js" integrity="sha512-8Wy4KH0O+AuzjMm1w5QfZ5j5/y8Q/kcUktK9mPUVaUoBvh3QPUZB822W/vy7ULqri3yR8daH3F58+Y8Z08qzeg==" crossorigin="anonymous"></script>--%>

            <!--Password eye icon togggling-->
            <script>
                $("#textbox_passwordID").on("change keyup paste click", function () {
                    pass_verify();
                });
                $("#textbox_emailID").on("change keyup paste click", function () {
                    email_verify("Username");
                });
            </script>

            <script src="script/login_validation.js"></script>
            <script src="./script/password-eye.js"></script>
            <script src="script/preloader.js"></script>
        </form>
    </body>
    </html>