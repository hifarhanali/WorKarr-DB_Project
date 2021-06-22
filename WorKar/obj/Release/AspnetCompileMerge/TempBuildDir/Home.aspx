<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="WorKar.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />


    <title>Home | WorKarr</title>
    <link rel="icon" href="images/logo_square.png" type="image/x-icon" />

    <!--Poppins font link-->
    <link rel="preconnect" href="https://fonts.gstatic.com" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet" />

    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!--my stylesheet-->
    <link href="style/main_background.css" rel="stylesheet" runat="server" />
    <link href="style/glass_background.css" rel="stylesheet" runat="server" />
    <link href="style/circle.css" rel="stylesheet" runat="server" />
    <link href="style/preloader.css" rel="stylesheet" runat="server" />
    <link href="style/home.css" rel="stylesheet" runat="server" />
    <link href="style/footer.css" rel="stylesheet" runat="server" />
    <link href="style/navbar.css" rel="stylesheet" runat="server" />
    <link href="style/login_signup_home_responsive.css" rel="stylesheet" runat="server" />
</head>


<body>
    <div id="loading"></div>
    <form id="form1" style="width: 100%;" runat="server">
        <main>
            <div class="mega-container">
                <div class="header">
                    <img src='<%=ResolveUrl("~/images/WorKarr_logo2.png") %>' onclick="window.location.href='Home.aspx'" class="workarr_logo_img" />
                    <nav class="nav-bar">
                        <ul class="ul right-navbar">
                            <li class="active-page">
                                <asp:HyperLink ID="hyperlink_homeID" runat="server" NavigateUrl="Home.aspx">Home</asp:HyperLink>
                            </li>
                            <li>
                                <asp:HyperLink ID="hyperlink_loginID" NavigateUrl="login.aspx" runat="server">Login</asp:HyperLink>
                            </li>
                            <li>
                                <asp:HyperLink ID="hyperlink_signupID" NavigateUrl="signup.aspx" runat="server">Signup</asp:HyperLink>
                            </li>
                            <li>
                                <asp:HyperLink ID="hyperlink_faqID" runat="server" NavigateUrl="FAQ.html">FAQ</asp:HyperLink>
                            </li>
                        </ul>
                    </nav>

                </div>


                <section class="glass">
                    <!--Left Section-->

                    <div class="container">
                        <div class="left-sec">
                            <div class="content-section">
                                <div id="home-content">
                                    <h1>Get it done with a freelancer!</h1>
                                    <p>We have expert freelancers who work in every technical, professional, and creative field imaginable.</p>
                                </div>
                                <div class="btn-container">
                                    <asp:Button ID="btn_get_startedID" CssClass="button" runat="server" Text="Get Started" PostBackUrl="~/signup.aspx" />
                                </div>
                            </div>
                        </div>

                        <!--Right Section-->
                        <div class="right-sec">
                        </div>
                    </div>

                    <!--Bubbles for animation-->
                    <div class="bubbles">
                        <img src='<%=ResolveUrl("~/images/bubble.png") %>' alt="bubble-img" />
                        <img src='<%=ResolveUrl("~/images/bubble.png") %>' alt="bubble-img" />
                        <img src='<%=ResolveUrl("~/images/bubble.png") %>' alt="bubble-img" />
                        <img src='<%=ResolveUrl("~/images/bubble.png") %>' alt="bubble-img" />
                        <img src='<%=ResolveUrl("~/images/bubble.png") %>' alt="bubble-img" />
                    </div>
                </section>

                <footer class="footer-distributed">

                    <div class="footer-left">
                        <h3>Wor<span>Karr</span></h3>
                        <p class="footer-links">
                            <a href="Home.aspx">Home</a> ·
                               
                            <a href="login.aspx">Login</a> ·
                               
                            <a href="signup.aspx">Signup</a> ·
                               
                            <a href="faq.aspx">FAQ</a>
                        </p>
                        <p class="footer-company-name">WorKarr Inc. &copy; 2021</p>
                    </div>

                    <div class="footer-center">
                        <div>
                            <i class="fa fa-map-marker"></i>
                            <p><span>Street Address</span> Lahore, Pakistan</p>
                        </div>

                        <div>
                            <i class="fa fa-phone"></i>
                            <p>+92 311 55 61420</p>
                        </div>

                        <div>
                            <i class="fa fa-envelope"></i>
                            <p><a href="mailto:workarr.contact@gmail.com">workarr.contact@gmail.com</a></p>
                        </div>
                    </div>

                    <div class="footer-right">
                        <p class="footer-company-about">
                            <span>About Us</span>
                            Workarr is a Pakistani online marketplace for freelance services founded by a team of Three individuals at the Fast NUCES Lahore. The website provides a platform for freelancers to offer services to customers worldwide.                           
                        </p>

                        <div class="footer-icons">

                            <a href="https://web.facebook.com/frhan.ali.1671897"><i class="fa fa-facebook"></i></a>
                            <a href="https://twitter.com/farhan_a1i"><i class="fa fa-twitter"></i></a>
                            <a href="https://www.linkedin.com/in/farhan-a1i/"><i class="fa fa-linkedin"></i></a>
                            <a href="https://github.com/farhana1i"><i class="fa fa-github"></i></a>
                        </div>
                    </div>

                </footer>
            </div>
        </main>

        <!--For slider-->
        <div class="slider"></div>
        <!--For animation-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/latest/TimelineMax.min.js" integrity="sha512-lJDBw/vKlGO8aIZB8/6CY4lV+EMAL3qzViHid6wXjH/uDrqUl+uvfCROHXAEL0T/bgdAQHSuE68vRlcFHUdrUw==" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/latest/TweenMax.min.js" integrity="sha512-8Wy4KH0O+AuzjMm1w5QfZ5j5/y8Q/kcUktK9mPUVaUoBvh3QPUZB822W/vy7ULqri3yR8daH3F58+Y8Z08qzeg==" crossorigin="anonymous"></script>
        <script src="script/preloader.js"></script>
    </form>
</body>

</html>
