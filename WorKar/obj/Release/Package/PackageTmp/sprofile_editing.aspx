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
   <link href="style/main_background.css" rel="stylesheet" runat="server"/>
   <link href="style/glass_background.css" rel="stylesheet" runat="server"/>
   <link href="style/circle.css" rel="stylesheet" runat="server"/>
   <link href="style/input_tag.css" rel="stylesheet" runat="server" />
   <link href="style/sidebar.css" rel="stylesheet" runat="server" />
  
    <style runat="server">
      *{ padding: 0; margin: 0;}
      body {
      color: #012e4d;
      }
      body p {
      font-size: 1em;
      font-weight: 200;
      }
      li p{
      margin-top: 20px;
      }
      .right-section{
      padding: 0;
      overflow-x: hidden;
      overflow-y: scroll;
      }
      .container {
      height: 100vh;
      padding: 15px !important;
      }
      ::-webkit-scrollbar {
      width: 7px;
      transition: all 0.3s;
      -webkit-transition: all 0.3s;
      -moz-transition: all 0.3s;
      -ms-transition: all 0.3s;
      -o-transition: all 0.3s;
      }
      ::-webkit-scrollbar-thumb {
      background: #9b9b9bcc;
      outline: none;
      border: none;
      }
      textarea {
      resize: none;
      }
      img:hover{
      cursor: pointer;
      filter: brightness(80%);
      }
      input[type=file]{
      color: transparent;
      overflow: hidden;
      display: none;
      }
      input[type=file]:focus, input[type=file]:hover{
      border: none !important;
      box-shadow: none !important;
      }
      body *{
      outline: none;
      }
      .gender-input-container{
      display: flex;
      justify-content: space-between;
      align-items: center;
      }
      .gender-input-container label{
      color: gray;
      }
      #flexSwitchCheckChecked{
          border: none;
      }
      #flexSwitchCheckChecked:hover,
      #flexSwitchCheckChecked:focus{
          border: none !important;
      }

      input[readonly] {
            background-color: transparent !important;
        }


      input[readonly]:focus,
      input[readonly]:hover{
          cursor: default;
       } 

      span{
          color: red;
      }

   </style>
   <script>
       // click file upload buttons on click on image
       function click_fileUplaod() {
           document.getElementById('<%= my_photo.ClientID%>').click();
       }

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

       function pass_validation()
       {
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
    <script type = "text/javascript">
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
                                          
                                          <asp:Image ID="my_photo_display" style="width: 140px; height: 140px;" ImageUrl="images/user_images/no_image.png" onclick="click_fileUplaod(1)" CssClass="gigImages-display" onerro="this.src='images/user_images/no_image.png'" runat="server" />
                                       </div>
                                    </div>
                                 </div>

                                 <div class="col d-flex flex-column flex-sm-row justify-content-between mb-3">
                                    <div class="text-sm-left mb-2 mb-sm-0">
                                       <h4 class="pt-sm-2 pb-1 mb-0 text-nowrap" id="display_userFullName" runat="server"></h4>
                                       <p class="mb-0" id="display_username" runat="server"></p>
                                       <div class="text-muted"><small>Last seen 2 hours ago</small></div>
                                       <div class="mt-2">
                                          <asp:FileUpLoad ID="my_photo" runat="server" accept="image/*" onchange="loadFile(event)"/>
                                       </div>
                                    </div>
                                    <div>
 <div class="form-check form-switch">
  <input class="form-check-input"  onchange="turn_off_check(this);" type="checkbox" id="flexSwitchCheckDefault" runat="server">
  <label class="form-check-label" for="flexSwitchCheckDefault">Available</label>
</div>                                   </div>
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
                                                      <label >First Name</label>
                                                       <asp:TextBox MaxLength="30" ID="edit_firstname" class="form-control" name="firstname" placeholder="Farhan"  runat="server"></asp:TextBox>
                                                        <asp:RequiredFieldValidator id="RequiredFieldValidator_FName" Text="Required*" ValidationGroup="Save_User_Detail"  ControlToValidate="edit_firstname" Runat="server" />
                                                   </div>
                                                </div>
                                                <div class="col">
                                                   <div class="form-group">
                                                      <label>Last Name</label>
                                                      <input maxlength="30" id="edit_lastname" runat="server" class="form-control" type="text" name="lastname" placeholder="Ali">
                                                        <asp:RequiredFieldValidator id="RequiredFieldValidator_LName" Text="Required*" ValidationGroup="Save_User_Detail"  ControlToValidate="edit_lastname" Runat="server" />
                                                   </div>
                                                </div>
                                             </div>
                                             <div class="row">
                                                <div class="col">
                                                   <div class="form-group">
                                                      <label>Email</label>
                                                      <input readonly id="edit_email" runat="server" class="form-control" type="text" placeholder="user@example.com">
                                                   </div>
                                                </div>
                                                <div class="col">
                                                   <div class="form-group">
                                                      <label>Gender</label>
                                                      <div class="gender-input-container">
                                                         <label><input type="radio" id="Male_radioBtn" name="gender" value="Male" runat="server"/> Male</label>
                                                         <label><input type="radio" id="Female_radioBtn" name="gender" value="Female" runat="server"/> Female</label>
                                                         <label><input type="radio" id="Others_radioBtn" name="gender" value="Others" runat="server"/> Others</label>
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
                                                      <input class="form-control" ID="new_password" type="password" placeholder="••••••" runat="server">
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
                    <asp:RequiredFieldValidator id="reqCategory" Text="Required*" ValidationGroup="Save_User_detail" InitialValue="0" ControlToValidate="ddlCategories" Runat="server" /> 
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
                              <asp:Button ID="button_logoutID" class="btn btn-block btn-secondary"  runat="server" Text="Logout" PostBackUrl="~/Home.aspx" />
                           </div>
                        </div>
                     </div>
                     <div class="card">
                        <div class="card-body">
                           <h6 class="card-title font-weight-bold">Support</h6>
                           <p class="card-text">Get fast, free help from our friendly assistants.</p>
                           <button type="button" >Contact Us</button>
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

