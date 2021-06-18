<%@ Page Title="" Language="C#" MasterPageFile="~/seller.Master" AutoEventWireup="true" CodeBehind="sprofile_editing.aspx.cs" Inherits="WorKar.WebForm8" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="utf-8" />
    <title>Profile Edit | WorKarr</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />


    <!--Bootstrap link-->
    <link href="Content/bootstrap.css" rel="stylesheet" runat="server" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" runat="server" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">


    <!-- style sheet link -->
    <link href="style/main_background.css" rel="stylesheet" runat="server" />
    <link href="style/glass_background.css" rel="stylesheet" runat="server" />
    <link href="style/circle.css" rel="stylesheet" runat="server" />
    <link href="style/input_tag.css" rel="stylesheet" runat="server" />
    <link href="style/sidebar.css" rel="stylesheet" runat="server" />
    <link href="style/profile_editing.css" rel="stylesheet" runat="server" />

    <script>
        // click file upload buttons on click on image
        function click_fileUplaod() {
            document.getElementById('<%= my_photo.ClientID%>').click();
        }

        // to toggle availiablity switch
        function turn_off_check(availability_switch) {
            if (availability_switch.checked == false) {
                availability_switch.removeAttribute("checked");
            } else {
                availability_switch.setAttribute("checked", "checked");
            }
        }
        // verify password is valid or not
        function pass_verify() {
            var pass = document.getElementById('<%= new_password.ClientID%>');
            var confirm_pass = document.getElementById('<%= confirm_password.ClientID%>');
            var error_span = document.getElementById('<%= password_error_span.ClientID%>');
            var curr_pass = document.getElementById('<%= current_password.ClientID%>');

            if (pass.value.length == 0 && confirm_pass.value.length == 0 && curr_pass.value.length == 0) {
                error_span.style.display = "none";
                return true;
            }
            if (pass.value != confirm_pass.value) {
                error_span.innerHTML = "<strong>Password</strong> does not match";
            }
            else {
                let error_span = document.getElementById('<%=password_error_span.ClientID%>');
                if (pass.value.length >= 8) {
                    let decimal = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^a-zA-Z0-9])(?!.*\s).{8,30}$/;
                    if (pass.value.match(decimal)) {
                        error_span.style.display = "none";
                        return true;
                    }
                    error_span.innerHTML = "Password should contain <strong>digit, lower and upper case alphabet, special character</strong>";
                }
                else {
                    error_span.innerHTML = "Password should contain <strong>atleast 8 digits</strong>";
                }
            }

            error_span.style.display = "block !important";
            return false;
        }

        function pass_validation() {
            var pass_verify_fail = pass_verify();
            if (!pass_verify_fail) {
                document.getElementById('<%= new_password.ClientID%>').focus();
                event.preventDefault();
                return false;
            }
            else {
                var match_password_fail = match_password();

                if (!match_password_fail) {
                    document.getElementById('<%= current_password.ClientID%>').focus();
                    event.preventDefault();
                    return false;
                }
            }
            return true;
        }
    </script>

    <!--AJAX API-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script type="text/javascript">
        function match_password() {
            let passToCompare = document.getElementById('<%= current_password.ClientID%>').value;
            let newPassword = document.getElementById('<%= new_password.ClientID%>').value;
            if (passToCompare.length == 0 && newPassword.length == 0) return true;

            var responseResult = null;
            $.ajax({
                'async': false,
                type: "POST",
                url: "sprofile_editing.aspx/Is_Password_Correct",
                data: '{"passwordToCompare":"' + passToCompare + '","newPassword":"' + newPassword + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    document.getElementById('<%= old_passowrd_not_match.ClientID%>').style.display = response.d == false ? "initial" : "none";
                    if (response.d == true) {
                        responseResult = true;
                    }
                },
                failure: function (response) {
                    alert("Failed");
                    responseResult = true;
                }
            });
            return responseResult;
        };

    </script>

    <!--CDNs For Bootstrap Modal-->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

    <script type="text/javascript">
        // append contact modal on page load
        $(document).ready(function () {

            var myDiv = document.createElement("div");
            myDiv.innerHTML = modal_template();
            document.getElementById("form1").appendChild(myDiv);
        });


        // to hide required field error msg
        function reset_required_field_error(inp, error_msg_id) {
            if (inp.value.length > 0) {
                $("#" + error_msg_id).css("display", "none");
            }
        }

        // contatc modal template
        function modal_template() {
            return '<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true"> \
                <div class="modal-dialog modal-dialog-centered" role = "document" > \
                    <div class="modal-content"> \
                        <div class="modal-header"> \
                            <h5 class="modal-title" id="exampleModalLongTitle">Contact US</h5> \
                            <button type="button" id="cross-btn" class="close" data-dismiss="modal" aria-label="Close"> \
                                <span aria-hidden="true">&times;</span> \
                            </button> \
                        </div> \
                        <div class="modal-body"> \
                            <label class=" ml-auto font-weight-bold">Payment Details</label> \
                            <div class="row"> \
                                <div class="form-group"> \
                                    <label>Name</label> \
                                    <input id="contact_nameID" class="form-control" onfocusout="reset_required_field_error(this, \'RequiredField_Name_Error\')" placeholder="Farhan Ali"/> \
                                    <span id="RequiredField_Name_Error" style="display:none;">Required*</span> \
                                </div> \
                            </div> \
                            <div class="row"> \
                                <div class="form-group"> \
                                    <label>Email</label> \
                                    <input id="contact_emailID" class="form-control" type="email" onfocusout="reset_required_field_error(this, \'RequiredField_Email_Error\')"  placeholder="example@gmail.com" /> \
                                    <span id="RequiredField_Email_Error" style="display:none;">Required*</span> \
                                </div> \
                            </div> \
                            <div class="row"> \
                                <div class="form-group"> \
                                    <label>Password</label> \
                                    <input id="contact_passwordID" class="form-control" type="password" onfocusout="reset_required_field_error(this, \'RequiredField_Password_Error\')"  placeholder="&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;&#9679;" /> \
                                     <span id="RequiredField_Password_Error" style="display:none;">Required*</span> \
                                </div > \
                            </div> \
                            <div class="row"> \
                                <div class="form-group"> \
                                    <label>Message</label> \
                                    <textarea class="form-control" placeholder="Type your message here . . . " id="contact_messageID" onfocusout="reset_required_field_error(this, \'RequiredField_Message_Error\')"  rows="5" style="resize: none"></textarea> \
                                    <span id="RequiredField_Message_Error" style="display:none;">Required*</span> \
                                </div > \
                            </div > \
                            <span id="email_send_message" style="display:none;">Required*</span> \
                        </div> \
                        <div class="modal-footer"> \
                            <button type="button" class="button1" data-dismiss="modal">Close</button> \
                            <button id="contact_send_btnID" onclick="return send_message();" class="button2">Send</button> \
                        </div> \
                    </div> \
                </div> \
            </div>';
        }


        // send message of user to WorKarr
        function send_message() {
            let fromEmail = document.getElementById('contact_emailID').value;
            let fromName = document.getElementById('contact_nameID').value;
            let contactMessage = document.getElementById('contact_messageID').value;
            let contactPassword = document.getElementById('contact_passwordID').value;

            $("#RequiredField_Email_Error").css("display", "none");
            $("#RequiredField_Name_Error").css("display", "none");
            $("#RequiredField_Password_Error").css("display", "none");
            $("#RequiredField_Message_Error").css("display", "none");


            // front-end checks
            let isValidMessage = true;

            if (fromEmail.length <= 0) {
                $("#RequiredField_Email_Error").css("display", "block");
                isValidMessage = false;
            }
            if (fromName.length <= 0) {
                $("#RequiredField_Name_Error").css("display", "block");
                isValidMessage = false;
            }
            if (contactPassword.length <= 0) {
                $("#RequiredField_Password_Error").css("display", "block");
                isValidMessage = false;
            }
            if (contactMessage.length <= 0) {
                $("#RequiredField_Message_Error").css("display", "block");
                isValidMessage = false;
            }
            if (!isValidMessage) return false;


            $.ajax({
                type: "POST",
                url: "sprofile_editing.aspx/Send_Contact_Message",
                data: '{"fromEmail":"' + fromEmail + '","contactPassword":"' + contactPassword + '","fromName":"' + fromName + '","contactMessage":"' + contactMessage + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

                    if (response.d) {
                        let msg_span = document.getElementById("email_send_message");
                        msg_span.innerText = "Email has been sent successfully!";
                        msg_span.style.display = "block";
                        msg_span.style.color = "green";
                    }
                    else {
                        let msg_span = document.getElementById("email_send_message");
                        msg_span.innerText = "OOPS! Fail to send email. Retry!";
                        msg_span.style.display = "block";
                        msg_span.style.color = "red";
                    }

                },
                failure: function (response) {
                    let msg_span = document.getElementById("email_send_message");
                    msg_span.innerText = "OOPS! Fail to send email. Retry!";
                    msg_span.style.display = "block";
                    msg_span.style.color = "red";
                }
            });

            return false;
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="right-section">
        <div class="container">
            <div class="row flex-lg-nowrap">
                <div class="col">
                    <div class="row">
                        <div class="col mb-3 profile-form-container">
                            <div class="card">
                                <div class="card-body">
                                    <div class="e-profile">
                                        <div class="row">
                                            <div class="col-12 col-sm-auto mb-3">
                                                <div class="mx-auto" style="width: 140px;">
                                                    <div class="user-photo-container" style="width: 140px; height: 140px;">

                                                        <asp:Image ID="my_photo_display" Style="width: 140px; height: 140px;" ImageUrl="images/user_images/no_image.png" onclick="click_fileUplaod(1)" CssClass="gigImages-display" onerro="this.src='images/user_images/no_image.png'" runat="server" />
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col d-flex flex-column flex-sm-row justify-content-between mb-3">
                                                <div class="text-sm-left mb-2 mb-sm-0">
                                                    <h4 class="pt-sm-2 pb-1 mb-0 text-nowrap" id="display_userFullName" runat="server"></h4>
                                                    <p class="mb-0" id="display_username" runat="server"></p>
                                                    <div class="text-muted"><small>Last seen 2 hours ago</small></div>
                                                    <div class="mt-2">
                                                        <asp:FileUpload ID="my_photo" runat="server" accept="image/*" onchange="loadFile(event)" />
                                                    </div>
                                                </div>
                                                <div>
                                                    <div class="form-check form-switch">
                                                        <input class="form-check-input" onchange="turn_off_check(this);" type="checkbox" id="flexSwitchCheckDefault" runat="server">
                                                        <label class="form-check-label" for="flexSwitchCheckDefault">Available</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <ul class="nav nav-tabs">
                                            <li class="nav-item"><a href="#" class="active nav-link">Settings</a></li>
                                        </ul>
                                        <div class="tab-content pt-3">
                                            <div class="tab-pane active">
                                                <div class="row">
                                                    <div class="col">
                                                        <div class="row">
                                                            <div class="col">
                                                                <div class="form-group">
                                                                    <label>First Name</label>
                                                                    <asp:TextBox MaxLength="30" ID="edit_firstname" class="form-control" name="firstname" placeholder="Farhan" runat="server"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator_FName" Text="Required*" ValidationGroup="Save_User_Detail" ControlToValidate="edit_firstname" runat="server" />
                                                                </div>
                                                            </div>
                                                            <div class="col">
                                                                <div class="form-group">
                                                                    <label>Last Name</label>
                                                                    <input maxlength="30" id="edit_lastname" runat="server" class="form-control" type="text" name="lastname" placeholder="Ali">
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator_LName" Text="Required*" ValidationGroup="Save_User_Detail" ControlToValidate="edit_lastname" runat="server" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col">
                                                                <div class="form-group">
                                                                    <label>Country</label>

                                                                    <!--Countries drop down list-->
                                                                    <div>
                                                                        <select id="countryId" name="countryId" class="form-control" runat="server">
                                                                            <option value="none">Country</option>
                                                                            <option value="Afganistan">Afghanistan</option>
                                                                            <option value="Albania">Albania</option>
                                                                            <option value="Algeria">Algeria</option>
                                                                            <option value="American Samoa">American Samoa</option>
                                                                            <option value="Andorra">Andorra</option>
                                                                            <option value="Angola">Angola</option>
                                                                            <option value="Anguilla">Anguilla</option>
                                                                            <option value="Antigua & Barbuda">Antigua & Barbuda</option>
                                                                            <option value="Argentina">Argentina</option>
                                                                            <option value="Armenia">Armenia</option>
                                                                            <option value="Aruba">Aruba</option>
                                                                            <option value="Australia">Australia</option>
                                                                            <option value="Austria">Austria</option>
                                                                            <option value="Azerbaijan">Azerbaijan</option>
                                                                            <option value="Bahamas">Bahamas</option>
                                                                            <option value="Bahrain">Bahrain</option>
                                                                            <option value="Bangladesh">Bangladesh</option>
                                                                            <option value="Barbados">Barbados</option>
                                                                            <option value="Belarus">Belarus</option>
                                                                            <option value="Belgium">Belgium</option>
                                                                            <option value="Belize">Belize</option>
                                                                            <option value="Benin">Benin</option>
                                                                            <option value="Bermuda">Bermuda</option>
                                                                            <option value="Bhutan">Bhutan</option>
                                                                            <option value="Bolivia">Bolivia</option>
                                                                            <option value="Bonaire">Bonaire</option>
                                                                            <option value="Bosnia & Herzegovina">Bosnia & Herzegovina</option>
                                                                            <option value="Botswana">Botswana</option>
                                                                            <option value="Brazil">Brazil</option>
                                                                            <option value="British Indian Ocean Ter">British Indian Ocean Ter</option>
                                                                            <option value="Brunei">Brunei</option>
                                                                            <option value="Bulgaria">Bulgaria</option>
                                                                            <option value="Burkina Faso">Burkina Faso</option>
                                                                            <option value="Burundi">Burundi</option>
                                                                            <option value="Cambodia">Cambodia</option>
                                                                            <option value="Cameroon">Cameroon</option>
                                                                            <option value="Canada">Canada</option>
                                                                            <option value="Canary Islands">Canary Islands</option>
                                                                            <option value="Cape Verde">Cape Verde</option>
                                                                            <option value="Cayman Islands">Cayman Islands</option>
                                                                            <option value="Central African Republic">Central African Republic</option>
                                                                            <option value="Chad">Chad</option>
                                                                            <option value="Channel Islands">Channel Islands</option>
                                                                            <option value="Chile">Chile</option>
                                                                            <option value="China">China</option>
                                                                            <option value="Christmas Island">Christmas Island</option>
                                                                            <option value="Cocos Island">Cocos Island</option>
                                                                            <option value="Colombia">Colombia</option>
                                                                            <option value="Comoros">Comoros</option>
                                                                            <option value="Congo">Congo</option>
                                                                            <option value="Cook Islands">Cook Islands</option>
                                                                            <option value="Costa Rica">Costa Rica</option>
                                                                            <option value="Cote DIvoire">Cote DIvoire</option>
                                                                            <option value="Croatia">Croatia</option>
                                                                            <option value="Cuba">Cuba</option>
                                                                            <option value="Curaco">Curacao</option>
                                                                            <option value="Cyprus">Cyprus</option>
                                                                            <option value="Czech Republic">Czech Republic</option>
                                                                            <option value="Denmark">Denmark</option>
                                                                            <option value="Djibouti">Djibouti</option>
                                                                            <option value="Dominica">Dominica</option>
                                                                            <option value="Dominican Republic">Dominican Republic</option>
                                                                            <option value="East Timor">East Timor</option>
                                                                            <option value="Ecuador">Ecuador</option>
                                                                            <option value="Egypt">Egypt</option>
                                                                            <option value="El Salvador">El Salvador</option>
                                                                            <option value="Equatorial Guinea">Equatorial Guinea</option>
                                                                            <option value="Eritrea">Eritrea</option>
                                                                            <option value="Estonia">Estonia</option>
                                                                            <option value="Ethiopia">Ethiopia</option>
                                                                            <option value="Falkland Islands">Falkland Islands</option>
                                                                            <option value="Faroe Islands">Faroe Islands</option>
                                                                            <option value="Fiji">Fiji</option>
                                                                            <option value="Finland">Finland</option>
                                                                            <option value="France">France</option>
                                                                            <option value="French Guiana">French Guiana</option>
                                                                            <option value="French Polynesia">French Polynesia</option>
                                                                            <option value="French Southern Ter">French Southern Ter</option>
                                                                            <option value="Gabon">Gabon</option>
                                                                            <option value="Gambia">Gambia</option>
                                                                            <option value="Georgia">Georgia</option>
                                                                            <option value="Germany">Germany</option>
                                                                            <option value="Ghana">Ghana</option>
                                                                            <option value="Gibraltar">Gibraltar</option>
                                                                            <option value="Great Britain">Great Britain</option>
                                                                            <option value="Greece">Greece</option>
                                                                            <option value="Greenland">Greenland</option>
                                                                            <option value="Grenada">Grenada</option>
                                                                            <option value="Guadeloupe">Guadeloupe</option>
                                                                            <option value="Guam">Guam</option>
                                                                            <option value="Guatemala">Guatemala</option>
                                                                            <option value="Guinea">Guinea</option>
                                                                            <option value="Guyana">Guyana</option>
                                                                            <option value="Haiti">Haiti</option>
                                                                            <option value="Hawaii">Hawaii</option>
                                                                            <option value="Honduras">Honduras</option>
                                                                            <option value="Hong Kong">Hong Kong</option>
                                                                            <option value="Hungary">Hungary</option>
                                                                            <option value="Iceland">Iceland</option>
                                                                            <option value="Indonesia">Indonesia</option>
                                                                            <option value="India">India</option>
                                                                            <option value="Iran">Iran</option>
                                                                            <option value="Iraq">Iraq</option>
                                                                            <option value="Ireland">Ireland</option>
                                                                            <option value="Isle of Man">Isle of Man</option>
                                                                            <option value="Israel">Israel</option>
                                                                            <option value="Italy">Italy</option>
                                                                            <option value="Jamaica">Jamaica</option>
                                                                            <option value="Japan">Japan</option>
                                                                            <option value="Jordan">Jordan</option>
                                                                            <option value="Kazakhstan">Kazakhstan</option>
                                                                            <option value="Kenya">Kenya</option>
                                                                            <option value="Kiribati">Kiribati</option>
                                                                            <option value="Korea North">Korea North</option>
                                                                            <option value="Korea Sout">Korea South</option>
                                                                            <option value="Kuwait">Kuwait</option>
                                                                            <option value="Kyrgyzstan">Kyrgyzstan</option>
                                                                            <option value="Laos">Laos</option>
                                                                            <option value="Latvia">Latvia</option>
                                                                            <option value="Lebanon">Lebanon</option>
                                                                            <option value="Lesotho">Lesotho</option>
                                                                            <option value="Liberia">Liberia</option>
                                                                            <option value="Libya">Libya</option>
                                                                            <option value="Liechtenstein">Liechtenstein</option>
                                                                            <option value="Lithuania">Lithuania</option>
                                                                            <option value="Luxembourg">Luxembourg</option>
                                                                            <option value="Macau">Macau</option>
                                                                            <option value="Macedonia">Macedonia</option>
                                                                            <option value="Madagascar">Madagascar</option>
                                                                            <option value="Malaysia">Malaysia</option>
                                                                            <option value="Malawi">Malawi</option>
                                                                            <option value="Maldives">Maldives</option>
                                                                            <option value="Mali">Mali</option>
                                                                            <option value="Malta">Malta</option>
                                                                            <option value="Marshall Islands">Marshall Islands</option>
                                                                            <option value="Martinique">Martinique</option>
                                                                            <option value="Mauritania">Mauritania</option>
                                                                            <option value="Mauritius">Mauritius</option>
                                                                            <option value="Mayotte">Mayotte</option>
                                                                            <option value="Mexico">Mexico</option>
                                                                            <option value="Midway Islands">Midway Islands</option>
                                                                            <option value="Moldova">Moldova</option>
                                                                            <option value="Monaco">Monaco</option>
                                                                            <option value="Mongolia">Mongolia</option>
                                                                            <option value="Montserrat">Montserrat</option>
                                                                            <option value="Morocco">Morocco</option>
                                                                            <option value="Mozambique">Mozambique</option>
                                                                            <option value="Myanmar">Myanmar</option>
                                                                            <option value="Nambia">Nambia</option>
                                                                            <option value="Nauru">Nauru</option>
                                                                            <option value="Nepal">Nepal</option>
                                                                            <option value="Netherland Antilles">Netherland Antilles</option>
                                                                            <option value="Netherlands">Netherlands (Holland, Europe)</option>
                                                                            <option value="Nevis">Nevis</option>
                                                                            <option value="New Caledonia">New Caledonia</option>
                                                                            <option value="New Zealand">New Zealand</option>
                                                                            <option value="Nicaragua">Nicaragua</option>
                                                                            <option value="Niger">Niger</option>
                                                                            <option value="Nigeria">Nigeria</option>
                                                                            <option value="Niue">Niue</option>
                                                                            <option value="Norfolk Island">Norfolk Island</option>
                                                                            <option value="Norway">Norway</option>
                                                                            <option value="Oman">Oman</option>
                                                                            <option value="Pakistan">Pakistan</option>
                                                                            <option value="Palau Island">Palau Island</option>
                                                                            <option value="Palestine">Palestine</option>
                                                                            <option value="Panama">Panama</option>
                                                                            <option value="Papua New Guinea">Papua New Guinea</option>
                                                                            <option value="Paraguay">Paraguay</option>
                                                                            <option value="Peru">Peru</option>
                                                                            <option value="Phillipines">Philippines</option>
                                                                            <option value="Pitcairn Island">Pitcairn Island</option>
                                                                            <option value="Poland">Poland</option>
                                                                            <option value="Portugal">Portugal</option>
                                                                            <option value="Puerto Rico">Puerto Rico</option>
                                                                            <option value="Qatar">Qatar</option>
                                                                            <option value="Republic of Montenegro">Republic of Montenegro</option>
                                                                            <option value="Republic of Serbia">Republic of Serbia</option>
                                                                            <option value="Reunion">Reunion</option>
                                                                            <option value="Romania">Romania</option>
                                                                            <option value="Russia">Russia</option>
                                                                            <option value="Rwanda">Rwanda</option>
                                                                            <option value="St Barthelemy">St Barthelemy</option>
                                                                            <option value="St Eustatius">St Eustatius</option>
                                                                            <option value="St Helena">St Helena</option>
                                                                            <option value="St Kitts-Nevis">St Kitts-Nevis</option>
                                                                            <option value="St Lucia">St Lucia</option>
                                                                            <option value="St Maarten">St Maarten</option>
                                                                            <option value="St Pierre & Miquelon">St Pierre & Miquelon</option>
                                                                            <option value="St Vincent & Grenadines">St Vincent & Grenadines</option>
                                                                            <option value="Saipan">Saipan</option>
                                                                            <option value="Samoa">Samoa</option>
                                                                            <option value="Samoa American">Samoa American</option>
                                                                            <option value="San Marino">San Marino</option>
                                                                            <option value="Sao Tome & Principe">Sao Tome & Principe</option>
                                                                            <option value="Saudi Arabia">Saudi Arabia</option>
                                                                            <option value="Senegal">Senegal</option>
                                                                            <option value="Seychelles">Seychelles</option>
                                                                            <option value="Sierra Leone">Sierra Leone</option>
                                                                            <option value="Singapore">Singapore</option>
                                                                            <option value="Slovakia">Slovakia</option>
                                                                            <option value="Slovenia">Slovenia</option>
                                                                            <option value="Solomon Islands">Solomon Islands</option>
                                                                            <option value="Somalia">Somalia</option>
                                                                            <option value="South Africa">South Africa</option>
                                                                            <option value="Spain">Spain</option>
                                                                            <option value="Sri Lanka">Sri Lanka</option>
                                                                            <option value="Sudan">Sudan</option>
                                                                            <option value="Suriname">Suriname</option>
                                                                            <option value="Swaziland">Swaziland</option>
                                                                            <option value="Sweden">Sweden</option>
                                                                            <option value="Switzerland">Switzerland</option>
                                                                            <option value="Syria">Syria</option>
                                                                            <option value="Tahiti">Tahiti</option>
                                                                            <option value="Taiwan">Taiwan</option>
                                                                            <option value="Tajikistan">Tajikistan</option>
                                                                            <option value="Tanzania">Tanzania</option>
                                                                            <option value="Thailand">Thailand</option>
                                                                            <option value="Togo">Togo</option>
                                                                            <option value="Tokelau">Tokelau</option>
                                                                            <option value="Tonga">Tonga</option>
                                                                            <option value="Trinidad & Tobago">Trinidad & Tobago</option>
                                                                            <option value="Tunisia">Tunisia</option>
                                                                            <option value="Turkey">Turkey</option>
                                                                            <option value="Turkmenistan">Turkmenistan</option>
                                                                            <option value="Turks & Caicos Is">Turks & Caicos Is</option>
                                                                            <option value="Tuvalu">Tuvalu</option>
                                                                            <option value="Uganda">Uganda</option>
                                                                            <option value="United Kingdom">United Kingdom</option>
                                                                            <option value="Ukraine">Ukraine</option>
                                                                            <option value="United Arab Erimates">United Arab Emirates</option>
                                                                            <option value="United States of America">United States of America</option>
                                                                            <option value="Uraguay">Uruguay</option>
                                                                            <option value="Uzbekistan">Uzbekistan</option>
                                                                            <option value="Vanuatu">Vanuatu</option>
                                                                            <option value="Vatican City State">Vatican City State</option>
                                                                            <option value="Venezuela">Venezuela</option>
                                                                            <option value="Vietnam">Vietnam</option>
                                                                            <option value="Virgin Islands (Brit)">Virgin Islands (Brit)</option>
                                                                            <option value="Virgin Islands (USA)">Virgin Islands (USA)</option>
                                                                            <option value="Wake Island">Wake Island</option>
                                                                            <option value="Wallis & Futana Is">Wallis & Futana Is</option>
                                                                            <option value="Yemen">Yemen</option>
                                                                            <option value="Zaire">Zaire</option>
                                                                            <option value="Zambia">Zambia</option>
                                                                            <option value="Zimbabwe">Zimbabwe</option>
                                                                        </select>
                                                                    </div>

                                                                </div>                                                                
                                                            </div>
                                                            <div class="col">
                                                                <div class="form-group">
                                                                    <label>Gender</label>
                                                                    <div class="gender-input-container">
                                                                        <label>
                                                                            <input type="radio" id="Male_radioBtn" name="gender" value="Male" runat="server" />
                                                                            Male</label>
                                                                        <label>
                                                                            <input type="radio" id="Female_radioBtn" name="gender" value="Female" runat="server" />
                                                                            Female</label>
                                                                        <label>
                                                                            <input type="radio" id="Others_radioBtn" name="gender" value="Others" runat="server" />
                                                                            Others</label>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col">
                                                                <div class="form-group">
                                                                    <label>Username</label>
                                                                    <input id="edit_username" class="form-control" readonly type="text" name="username" placeholder="farhanali" runat="server">
                                                                </div>
                                                            </div>
                                                            <div class="col">
                                                                <div class="form-group">
                                                                    <label>Email</label>
                                                                    <input readonly id="edit_email" runat="server" class="form-control" type="text" placeholder="user@example.com">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col mb-3">
                                                                <div class="form-group">
                                                                    <label>About</label>
                                                                    <textarea maxlength="600" id="edit_description" runat="server" class="form-control" rows="5" placeholder="My Bio"></textarea>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-12 col-sm-6 mb-3">
                                                        <div class="mb-2"><b>Change Password</b></div>
                                                        <div class="row">
                                                            <div class="col">
                                                                <div class="form-group">
                                                                    <label>Current Password</label>
                                                                    <input class="form-control" id="current_password" type="password" placeholder="••••••" runat="server">
                                                                    <span id="old_passowrd_not_match" style="display: none;" runat="server">Incorrect <strong>Password</strong></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col">
                                                                <div class="form-group">
                                                                    <label>New Password</label>
                                                                    <input class="form-control" id="new_password" type="password" placeholder="••••••" runat="server">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col">
                                                                <div class="form-group">
                                                                    <label>Confirm Password</label>

                                                                    <input class="form-control" id="confirm_password" type="password" placeholder="••••••" runat="server">
                                                                    <span id="password_error_span" runat="server"></span>

                                                                </div>

                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-12 col-sm-5 offset-sm-1 mb-3">
                                                        <div class="mb-2"><b>Work Area</b></div>
                                                        <div class="row">
                                                            <div class="col">
                                                                <label>Category</label>
                                                                <div class="dropdown-style">
                                                                    <!-- Category Drop down list -->
                                                                    <asp:DropDownList CssClass="form-control" ID="ddlCategories" AppendDataBoundItems="true" DataTextField="category_name"
                                                                        DataValueField="category_id" runat="server">
                                                                    </asp:DropDownList>
                                                                    <asp:RequiredFieldValidator ID="reqCategory" Text="Required*" ValidationGroup="Save_User_detail" InitialValue="0" ControlToValidate="ddlCategories" runat="server" />
                                                                </div>


                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col d-flex justify-content-end">
                                                        <asp:Button ID="save_btn" ValidationGroup="Save_User_Detail" OnClientClick="pass_validation()" OnClick="save_btn_Click" Text="Save Changes" runat="server" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div style="height: 100px;"></div>
                        </div>
                        <div class="col-12 col-md-3 mb-3">
                            <div class="card mb-3">
                                <div class="card-body">
                                    <div class="px-xl-3">
                                        <asp:Button ID="button_logoutID" style="width: 100% !important;" class="btn btn-block btn-secondary" runat="server" Text="Logout" PostBackUrl="~/Home.aspx" />
                                    </div>
                                </div>
                            </div>
                            <div class="card">
                                <div class="card-body">
                                    <h6 class="card-title font-weight-bold">Support</h6>
                                    <p class="card-text">Get fast, free help from our friendly assistants.</p>
                                    <!-- Button trigger modal -->
                                    <button type="button" data-toggle="modal" data-target="#exampleModalCenter" data-backdrop='static' data-keyboard='false'>CONTACT US</button>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <script>            
        // to display images on upload
        var loadFile = function (event) {
            var image = document.getElementById('<%= my_photo_display.ClientID %>');
            image.src = URL.createObjectURL(event.target.files[0]);
        };

    </script>
</asp:Content>

