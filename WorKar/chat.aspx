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
    

    <!--AJAX API-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script type="text/javascript">
        function load_contacts_list() {
            $.ajax({
                type: "POST",
                url: "chat.aspx/Load_Contacts",
                data: '{"passwordToCompare":"' + passToCompare + '","newPassword":"' + newPassword + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                },
                failure: function (response) {
                    alert("Failed");
                }
            });
        };

    </script>


</head>
<body>
    <form id="form1" runat="server" style="width:100%;">
       <main>
        <section class="glass">
            <div class="sidepanel">
                <div class="wrap profile-head-wrap">
                    <asp:Repeater ID="rptrUser_DetailID" runat="server">
                        <ItemTemplate>
                            <img id="profile-img" src='<%# Eval("UserPhoto") %>' alt="" />
                            <div>
                                <p id="currUserFirstName" runat="server"><%# Eval("UserFName") %></p>
                                <span>@<span id="currUserName" runat="server"><%# Eval("Username") %></span></span>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <div class="search-container">
                    <label for=""><i class="fa fa-search" aria-hidden="true"></i></label>
                    <input type="text" placeholder="Search contacts..." />
                </div>
                <div class="contacts" id="contacts-container">
                    <ul id="contactsListID">
                        <!-- all contacts div -->

                        <asp:Repeater ID="rptrContacts_list" runat="server">
                            <ItemTemplate>
                                <li id="<%# Eval("contactUserName") %>" class="contact">
                                    <div class="wrap">
                                        <span class="contact-status"></span>
                                        <img src="<%# Eval("contactUserPhoto") %>" width="60px" />
                                        <div class="meta">
                                            <p class="name"><%# Eval("contactUserName") %> </p>
<%--                                            <p class="preview"><%# Eval("contactUserName") %></p>--%>
                                        </div>
                                    </div>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
            <div class="content" id="chat_windowID">

                <ul id="messagesListID">
                    <!--all messages-->
                </ul>
                <div class="message-input" id="message-input-containerID">
                    <div class="wrapper">
                        <input id="message_inputID" type="text" placeholder="Write your message... " />
                        <i class="fa fa-paperclip attachment " aria-hidden="true "></i>
                    </div>
                    <button type="button" class="submit" id="send_msgID"><i class="fa fa-paper-plane " aria-hidden="true "></i></button>
                </div>
            </div>
        </section>
    </main>
    </form>

    <script type="text/javascript">
        // add enter key event
        var input = document.getElementById("message_inputID");
        input.addEventListener("keyup", function (event) {
            if (event.keyCode === 13) {
                event.preventDefault();
                document.getElementById("send_msgID").click();
            }
        });
    </script>

    <!-- For emojis -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/emojionearea/3.4.2/emojionearea.min.js" integrity="sha512-hkvXFLlESjeYENO4CNi69z3A1puvONQV5Uh+G4TUDayZxSLyic5Kba9hhuiNLbHqdnKNMk2PxXKm0v7KDnWkYA==" crossorigin="anonymous"></script>
    <script type="text/javascript">
        $(document).ready(function ()
        {
            $("#message_inputID").emojioneArea({
                pickerPosition: 'top',
                events: {
                    keyup: function (editor, event) {
                        if (event.keyCode === 13)
                        {
                            event.preventDefault();
                            document.getElementById("send_msgID").click();
                       }
                    }
                }
            });
        });
    </script>
</body>
</html>
