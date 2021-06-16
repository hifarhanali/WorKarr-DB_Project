<%@ Page Title="" Language="C#" MasterPageFile="~/seller.Master" AutoEventWireup="true" CodeBehind="sgig_creation.aspx.cs" Inherits="WorKar.WebForm10" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <meta charset="UTF-8">
        <title>Create Gig | WorKarr</title>

        <link href="style/job_creation.css" rel="stylesheet" runat="server" />

        <!--Bootstrap link-->
        <link href="Content/bootstrap.min.css" rel="stylesheet" />

        <!--My stylesheets link-->
        <link href="style/main_background.css" rel="stylesheet" runat="server" />
        <link href="style/glass_background.css" rel="stylesheet" runat="server" />
        <link href="style/circle.css" rel="stylesheet" runat="server" />
        <link href="style/sidebar.css" rel="stylesheet" runat="server" />
        <link href="style/gig_creation.css" rel="stylesheet" runat="server" />
        <link href="style/input_tag.css" rel="stylesheet" runat="server" />


        <script>

            // click file upload buttons on click on image
            function click_fileUplaod(image_num)
            {
                if (image_num == 1) {
                    document.getElementById('<%= img_gig1ID.ClientID%>').click();
                }
                else if (image_num == 2) {
                    document.getElementById('<%= img_gig2ID.ClientID%>').click();
                } else {
                    document.getElementById('<%= img_gig3ID.ClientID%>').click();
                }
            }
        </script>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    
        <div class="right-section">
            <div class="container-fluid">
                <h2 class="gigCreationHeading align-content-center">Gigs Creation</h2>

                <div class="form-floating mb-4">
                    <label for="exampleFormControlFile1" class="mt-3 ml-auto font-weight-bold">Gig Title</label>
                    <input type="text" class="form-control" id="gigTitle" placeholder="I will make a typographic logo for your work . . . ." maxlength="100" runat="server" />
                    <asp:RequiredFieldValidator id="RequiredFieldValidator6" Text="Required*" ValidationGroup="Save_Gig"  ControlToValidate="gigTitle" Runat="server" /> 
                </div>

                <div class="form-floating mb-4">
                    <label for="exampleFormControlFile1" class=" ml-auto font-weight-bold">Gig Description</label>
                    <textarea class="form-control" placeholder="Services you can provide . . . ." id="gigDescription" maxlength="1200" rows="7" style="resize: none" runat="server"></textarea>
                    <asp:RequiredFieldValidator id="RequiredFieldValidator5" Text="Required*" ValidationGroup="Save_Gig"  ControlToValidate="gigDescription" Runat="server" /> 
                </div>

                <!-- Specifications container-->
                <div class="form-floating mb-4">
                    <label class=" ml-auto font-weight-bold ">Three Reasons Why You Should Hire Me?</label>
                    <div class="specifications-container">

                        <div>
                            <input class="form-control"  maxlength="30" placeholder="Accurate Code" id="specification1"  runat="server" />
                            <asp:RequiredFieldValidator id="RequiredFieldValidator2" Text="Required*" ValidationGroup="Save_Gig"  ControlToValidate="specification1" Runat="server" /> 
                        </div>
                        <div>                            
                            <input class="form-control" maxlength="30" placeholder="24/7 Availability" id="specification2"  runat="server"/>
                            <asp:RequiredFieldValidator id="RequiredFieldValidator3" Text="Required*" ValidationGroup="Save_Gig"  ControlToValidate="specification2" Runat="server" /> 
                        </div>
                        <div>
                            <input class="form-control" maxlength="30" placeholder="Clean Code" id="specification3"  runat="server" />
                            <asp:RequiredFieldValidator id="RequiredFieldValidator4" Text="Required*" ValidationGroup="Save_Gig"  ControlToValidate="specification3" Runat="server" /> 
                        </div>
                   </div>
                </div>

                <!-- Images container-->
                <div class="mb-4">
                    <label class=" ml-auto font-weight-bold ">Gig Images</label>

                    <div class="gigImages-display-containers">
                        <asp:Image ID="Gig_Image1" onclick="click_fileUplaod(1)" CssClass="gigImages-display" ImageUrl="images/gig_images/select_image.jpg" onerro="this.src='images/gig_images/select_image.jpg'" runat="server" />
                        <asp:Image ID="Gig_Image2" onclick="click_fileUplaod(2)" CssClass="gigImages-display" ImageUrl="images/gig_images/select_image.jpg" onerro="this.src='images/gig_images/select_image.jpg'" runat="server" />
                        <asp:Image ID="Gig_Image3" onclick="click_fileUplaod(3)" CssClass="gigImages-display" ImageUrl="images/gig_images/select_image.jpg" onerro="this.src='images/gig_images/select_image.jpg'" runat="server" />
                    </div>

                    <div class="images-container">
                        <label class="custom-file-upload">
                            <i class="far fa-image"></i>
                              <asp:FileUpLoad ID="img_gig1ID"   runat="server" accept="image/*" onchange="loadFile(event, 1)" />
                                                                                        Image 1
                        </label>
                        <label class="custom-file-upload">
                            <i class="far fa-image"></i>
                            <asp:FileUpLoad ID="img_gig2ID"  runat="server" accept="image/*" onchange="loadFile(event, 2)" />
                            Image 2
                        </label>
                        <label class="custom-file-upload">
                            <i class="far fa-image"></i>
                            <asp:FileUpLoad ID="img_gig3ID"   runat="server" accept="image/*" onchange="loadFile(event, 3)"/>
                            Image 3
                        </label>
                    </div>
                                                <asp:RequiredFieldValidator ID="Image1_ReqFieldValidator" Enabled="true" Text="Required*" ValidationGroup="Save_Gig" ControlToValidate="img_gig1ID" runat="server">
                            </asp:RequiredFieldValidator>


                </div>

                <!-- Price container-->
                <div class="form-floating mb-4">
                    <label for="exampleFormControlFile1" class=" ml-auto font-weight-bold">Price in PKR</label>
                    <asp:TextBox ID="gigPrice" CssClass="form-control" placeholder="5000" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator id="RequiredFieldValidator1" Text="Required*" ValidationGroup="Save_Gig"  ControlToValidate="gigPrice" Runat="server" /> 
                    <asp:RegularExpressionValidator ID="GigPrice_RegexValidator"
                        ControlToValidate="gigPrice" runat="server"
                        ErrorMessage="(Inavlid Price)"
                        ValidationExpression="\d+">
                    </asp:RegularExpressionValidator>

                </div>

                <!-- Categoriess container-->
                <h6 class="font-weight-bold">Choose Category </h6>
                <div class="dropdown-style mb-4">
                    <!-- Category Drop down list -->
                    <asp:DropDownList ID="ddlCategories" AppendDataBoundItems="true" DataTextField="category_name"
                        DataValueField="category_id" runat="server">
                        <asp:ListItem Value="0">Select Category</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator id="reqCategory" Text="Required*" ValidationGroup="Save_Gig" InitialValue="0" ControlToValidate="ddlCategories" Runat="server" /> 
                </div>

                <!-- Duration container-->
                <h6 class="font-weight-bold">In How Many Days/Months/Years You Can Complete The Order?</h6>
                <div class="dropdown-style mb-4">
                    <asp:DropDownList ID="ddlDuration" required="required" runat="server">
                        <asp:ListItem Value="0">Please Select Number of Days</asp:ListItem>
                        <asp:ListItem Value="1">1 Day </asp:ListItem>
                        <asp:ListItem Value="2">2 Days</asp:ListItem>
                        <asp:ListItem Value="3">3 Days</asp:ListItem>
                        <asp:ListItem Value="4">4 Days</asp:ListItem>
                        <asp:ListItem Value="7">1 Week </asp:ListItem>
                        <asp:ListItem Value="14">2 Weeks </asp:ListItem>
                        <asp:ListItem Value="21">3 Weeks </asp:ListItem>
                        <asp:ListItem Value="30">1 Month</asp:ListItem>
                        <asp:ListItem Value="60">2 Months</asp:ListItem>
                        <asp:ListItem Value="90">3 Months</asp:ListItem>
                        <asp:ListItem Value="180">6 Months</asp:ListItem>
                        <asp:ListItem Value="365">1 year</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator id="reqDuration" Text="Required*" ValidationGroup="Save_Gig"  InitialValue="0" ControlToValidate="ddlDuration" Runat="server" /> 
                </div>

                <!-- Buttons container-->
                <div class="button-container">
                    <asp:Button ID="button_saveID" ValidationGroup="Save_Gig" runat="server"  OnClick="button_saveID_Click" Text="Save" CssClass=" m-1 button1" />
                    <asp:Button ID="button_cancelID" OnClick="button_cancelID_Click" CausesValidation="false" runat="server" Text="Cancel" CssClass="m-1 button2" />
                </div>

            </div>

            <div style="height: 100px;"></div>

        </div>
        <script>            
            // to display images on upload
            var loadFile = function (event, id) {
                if (id == 1) {
                    var image = document.getElementById('<%= Gig_Image1.ClientID %>');
                }
                else if (id == 2) {
                    var image = document.getElementById('<%= Gig_Image2.ClientID %>');
                }
                else {
                    var image = document.getElementById('<%= Gig_Image3.ClientID %>');
                }

                image.src = URL.createObjectURL(event.target.files[0]);
            };
        </script>

</asp:Content>
