<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="email_confirmation.aspx.cs" Inherits="WorKar.email_confirmation" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>Email Verification | WorKarr</title>
        <link rel = "icon" href =
        "images/logo_square.png" 
        type = "image/x-icon" />

<meta charset="utf-8">
     <!--Bootstrap link-->
     <link href="Content/bootstrap.css" rel="stylesheet" runat="server" />

     <!-- style sheet link -->
    <link href="style/main_background.css" rel="stylesheet" runat="server"/>
    <link href="style/glass_background.css" rel="stylesheet" runat="server"/>
    <link href="style/circle.css" rel="stylesheet" runat="server"/>
         <link href="Content/bootstrap.min.css" rel="stylesheet" runat="server" />
    <style runat="server">

        main{
            display: flex;
            flex-direction:column;
            align-content: center;
            justify-content: center;
        }

        .glass{
            height: 90vh;
        }

        p{
            font-weight: 200;
        }
        #btn_loginPageID {
    text-align: center;
    padding: 10px;
    color: white;
    -webkit-box-shadow: 1px 1px 5px black;
    box-shadow: 1px 1px 5px rgba(0, 0, 0, 0.2);
    background-color: #004675;
    width: 30%;
    text-transform: uppercase;
    font-weight: 500;
    border-radius: 5px;
    -webkit-border-radius: 5px;
    -moz-border-radius: 5px;
    -ms-border-radius: 5px;
    -o-border-radius: 5px;
    border: 2px solid #004675;
    outline: none;
}

#btn_loginPageID:hover {
    cursor: pointer;
    opacity: 1;
    color: #004675;
    background-color: white;

}

    </style>

</head>
<body>
    <form id="form1" runat="server" style="width:100%;">

        <main>
            <div class="glass">
                <div class="jumbotron text-center">
  <h1 class="display-3">Email Verified!</h1>
  <p class="lead"><strong>Congratulation!</strong> Your email address has been verified. Please check your email for further instructions on how to complete your account setup.</p>
  <hr>
  <p style="margin-top: 20px;">
    Having trouble? <a href="mailto:workarr.contact@gmail.com">Contact us</a>
  </p>
  <p class="lead">
 <asp:Button ID="btn_loginPageID" OnClick="btn_loginPageID_Click" Text="Go To Home Page" runat="server" />
  </p>
</div>

            </div>
        </main>

    </form>
</body>
</html>
