<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="chat.aspx.cs" Inherits="WorKar.chat" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Chat | WorKarr</title>
        <link rel = "icon" href =
        "images/logo_square.png" 
        type = "image/x-icon" />

    <!--Font Awsome link-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <script src="https://kit.fontawesome.com/571b8d9aa3.js" crossorigin="anonymous"></script>


    <!-- For emojis -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/emojionearea/3.4.2/emojionearea.min.css" integrity="sha512-vEia6TQGr3FqC6h55/NdU3QSM5XR6HSl5fW71QTKrgeER98LIMGwymBVM867C1XHIkYD9nMTfWK2A0xcodKHNA==" crossorigin="anonymous" />

    <!--My stylesheet-->
    <link href="style/main_background.css" rel="stylesheet" runat="server"/>
    <link href="style/glass_background.css" rel="stylesheet" runat="server"/>
    <link href="style/circle.css" rel="stylesheet" runat="server"/>
    <link href="style/chat.css" rel="stylesheet" runat="server"/>
        
</head>
<body>
    <form id="form1" runat="server" style="width:100%;">
       <main>
        <section class="glass">
            <div class="sidepanel">
                <div class="wrap profile-head-wrap">
                    <img id="profile-img" src='<%=ResolveUrl("~/images/member1.JPEG") %>' alt="" />

                    <div>
                        <p id="hdname" runat="server">Farhan</p>
                        <input id="hdId" type="hidden" />
                        <span id="hdUserName">@farhan_a1i</span>
                    </div>

                    <i class="fa fa-chevron-down expand-button" aria-hidden="true"></i>
                </div>

                <div class="search-container">
                    <label for=""><i class="fa fa-search" aria-hidden="true"></i></label>
                    <input type="text" placeholder="Search contacts..." />
                </div>
                <div class="contacts" id="contacts-container">
                    <ul id="contactsListID">
                        
                    </ul>
                </div>
            </div>
            <div class="content" id="chat_windowID">
                <div class="message-input" id="message-input-containerID">
                    <div class="wrapper">
                        <input id="message_inputID" type="text" placeholder="Write your message... " />
                        <i class="fa fa-paperclip attachment " aria-hidden="true "></i>
                    </div>
                    <button type="button" class="submit" id="send_msgID"><i class="fa fa-paper-plane " aria-hidden="true "></i></button>
                </div>

                <asp:HiddenField ID="hdnCurrentUserName" runat="server" />
                <asp:HiddenField ID="hdnCurrentUserID" runat="server" />
       
            </div>
        </section>
    </main>
    </form>
</body>
</html>

