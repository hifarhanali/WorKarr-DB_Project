<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="team.aspx.cs" Inherits="WorKar.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <meta charset="UTF-8" />

    <title>Team | WorKarr</title>
    <link rel="icon" href="images/logo_square.png"
        type="image/x-icon" />

    <!-- Load font awesome icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />

    <!--my stylesheet-->
    <link href="style/main_background.css" rel="stylesheet" runat="server" />
    <link href="style/glass_background.css" rel="stylesheet" runat="server" />
    <link href="style/circle.css" rel="stylesheet" runat="server" />
    <link href="style/preloader.css" rel="stylesheet" runat="server" />
    <link href="style/team.css" rel="stylesheet" runat="server" />
</head>

<body>
    <div id="loading"></div>
    <form id="form1" style="width: 100%;" runat="server">
        <main>
            <section class="glass">
                <div class="container">
                    <h1>Our Team</h1>

                    <!--Member 1-->
                    <div class="member1 member">
                        <div class="img-container">
                            <img src='<%=ResolveUrl("~/images/member1.JPEG") %>' alt="member1-photo">
                        </div>

                        <div class="content">
                            <h2>Farhan Ali</h2>
                            <h4>Student at FAST-NUCES</h4>
                        </div>

                        <ul>
                            <a href="https://web.facebook.com/frhan.ali.1671897/">
                                <li style="--i: 1"><i class="fa fa-facebook"></i></li>
                            </a>
                            <a href="https://www.instagram.com/farhan.a1i/">
                                <li style="--i: 2"><i class="fa fa-instagram"></i></li>
                            </a>
                            <a href="https://www.linkedin.com/in/farhana1i/">
                                <li style="--i: 3"><i class="fa fa-linkedin"></i></li>
                            </a>
                        </ul>
                    </div>

                    <!--Member 2-->
                    <div class="member2 member">
                        <div class="img-container">
                            <img src='<%=ResolveUrl("~/icons/avatar.png") %>' alt="member2-photo">
                        </div>
                        <div class="content">
                            <h2>Umar Khatab</h2>
                            <h4>Student at FAST-NUCES</h4>
                        </div>
                        <ul>
                            <a href="#">
                                <li style="--i: 1"><i class="fa fa-facebook"></i></li>
                            </a>
                            <a href="#">
                                <li style="--i: 2"><i class="fa fa-instagram"></i></li>
                            </a>
                            <a href="#">
                                <li style="--i: 3"><i class="fa fa-linkedin"></i></li>
                            </a>
                        </ul>
                    </div>

                    <!--Member 3-->
                    <div class="member3 member">
                        <div class="img-container">
                            <img src='<%=ResolveUrl("~/icons/avatar.png") %>' alt="member3-photo">
                        </div>

                        <div class="content">
                            <h2>Muhammad Shmoon</h2>
                            <h4>Student at FAST-NUCES</h4>
                        </div>

                        <ul>
                            <a href="#">
                                <li style="--i: 1"><i class="fa fa-facebook"></i></li>
                            </a>
                            <a href="#">
                                <li style="--i: 2"><i class="fa fa-instagram"></i></li>
                            </a>
                            <a href="#">
                                <li style="--i: 3"><i class="fa fa-linkedin"></i></li>
                            </a>
                        </ul>
                    </div>
                </div>
            </section>
            <div class="circle1 circle"></div>
            <div class="circle2 circle"></div>
        </main>
        <script src="script/preloader.js"></script>
    </form>
</body>
</html>
