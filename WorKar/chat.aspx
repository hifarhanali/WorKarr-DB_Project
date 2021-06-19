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
        function load_messages(input)
        {
            let contactUsername = input.split('_')[1];
            let contactUserPhoto = $("#photo_" + contactUsername).attr('src');

            $.ajax({
                type: "POST",
                url: "chat.aspx/Load_Messages",
                data: '{"contactUserName":"' + contactUsername + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var xmlDoc = $.parseXML(response.d);
                    var xml = $(xmlDoc);
                    var messages = xml.find("Table1");
                    load_chat_window_header(contactUsername, contactUserPhoto);
                    make_messages_list(messages);
                    $("#message-input-containerID").css("display", "flex");
                    $("#message_inputID").focus();
                },
                failure: function (response) {
                    alert("Failed");
                }
            });
            return false;
        };


        // function to load chat window header
        function load_chat_window_header(userName, userPhoto) {
            $("#chat_windowID").prepend(get_chat_window_template(userName, userPhoto));
        }

        // remove all previous profile headers
        function remove_all_previous_profiel_header() {
            $(".contact-profile").remove();
        }

        function get_chat_window_template(userName, userPhoto) {
            this.remove_all_previous_profiel_header();
            return " \
                <div class=\"contact-profile\" id=\"profileHeader_" + userName + "\"> \
                    <img class=\"contact-profile-photo\" src = \"" + userPhoto + "\" width = \"60px\" /> \
                    <p>" + userName + "</p> \
                </div > \
            ";

        }

        // this function will return message template
        // messageType --> sent/replies
        function get_message_template(message)
        {
            var msg_code = " \
                <li class=\"" + message.MsgType + "\"> \
                    <div> \
                    <p>" + message.Msg + "</p> \
                    <p id=\"msg_timeID\">"+ formatAMPM(new Date(message.MsgTime)) + "</p> \
                    </div> \
                </li>\
            ";
            var parser = new DOMParser();
            msg_code = parser.parseFromString(msg_code, "text/html").body;
            return msg_code;
        }

        function AddMessage(message) {
            var messageTemplate = get_message_template(message);
            // append messages to the messageList div
            $("#messagesListID").append(messageTemplate);
            $("#messagesListID-container").animate({ scrollTop: 9999 }, 'slow');
        }

        // this function will attach messages in the message list container
        function make_messages_list(messagesList)
        {
            $("#messagesListID").empty();
            for (var i = 0; i < messagesList.length; i++)
            {
                var message =
                {
                    Msg: messagesList[i].getElementsByTagName("Message")[0].childNodes[0].nodeValue,
                    MsgTime: messagesList[i].getElementsByTagName("AddedOn")[0].childNodes[0].nodeValue,
                    MsgType: messagesList[i].getElementsByTagName("MessageType")[0].childNodes[0].nodeValue
                };

                AddMessage(message);            // append msg to messageListID
            }
            $("#messagesListID").css("display", "initial");
        }

        function formatAMPM(date)
        {
            var hours = date.getHours();
            var minutes = date.getMinutes();
            var ampm = hours >= 12 ? 'pm' : 'am';
            hours = hours % 12;
            hours = hours ? hours : 12; // the hour '0' should be '12'
            minutes = minutes < 10 ? '0' + minutes : minutes;
            var strTime = hours + ':' + minutes + ' ' + ampm;
            return strTime;
        }
    </script>


    <!--to send private message-->
    <script type="text/javascript">

        function send_msg_btn_click() {
            let message = $("#message_inputID").val();
            if (message.length > 0) {
                let toUsername = $(".contact-profile").attr('id').split('_')[1];
                send_private_message(toUsername, message);

                $("#message_inputID").val("");
                $("#message_inputID").focus();
            }

            return false;
        }


        // to save provate msg in database
        function send_private_message(toUsername, message)
        {
            $.ajax({
                type: "POST",
                url: "chat.aspx/Send_Private_Message",
                data: '{"toUserName":"' + toUsername + '","message":"' + message + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

                    let returnValue = response.d.toString().split("-");

                    var messageObject = {
                        Msg: returnValue[0],
                        MsgType: "Send",
                        MsgTime: returnValue[1]
                    };
                    AddMessage(messageObject);
                },
                failure: function (response) {
                    alert("Failed to send message. Retry!");
                }
            });
            return false;
        };
    </script>

    <!--set interval-->
    <script type="text/javascript">
        setInterval(function ()
        {
            let profile_header = $(".contact-profile");
            if (profile_header.length > 0) {
                let contactUserName = profile_header.attr('id').split('_')[1];
                let contact_tag_id = "contact_" + contactUserName.trim();

                load_messages(contact_tag_id);
            }
        }, 5000);
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
                                <li id="contact_<%# Eval("contactUserName") %>" class="contact" ondblclick="return load_messages(this.id);">
                                    <div class="wrap">
                                        <span class="contact-status"></span>
                                        <img id="photo_<%# Eval("contactUserName") %>" src="<%# Eval("contactUserPhoto") %>" width="60px" />
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

                <div class="messages" id="messagesListID-container">
                    <!-- messages container -->
                    <ul id="messagesListID">
                        <!--all messages-->
                    </ul>
                </div>

                <div class="message-input" id="message-input-containerID">
                    <div class="wrapper">
                        <input id="message_inputID" type="text" placeholder="Write your message... " />
                        <i class="fa fa-paperclip attachment " aria-hidden="true "></i>
                    </div>
                    <button type="button" onclick="return send_msg_btn_click();" class="submit" id="send_msgID"><i class="fa fa-paper-plane " aria-hidden="true "></i></button>
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
</body>
</html>
