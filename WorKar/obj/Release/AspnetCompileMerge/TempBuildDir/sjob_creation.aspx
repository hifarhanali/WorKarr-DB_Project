<%@ Page Title="" Language="C#" MasterPageFile="~/seller.Master" AutoEventWireup="true" CodeBehind="sjob_creation.aspx.cs" Inherits="WorKar.WebForm7" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
            <meta charset="UTF-8">
        <title>Create Job | WorKarr</title>

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

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
        <div class="right-section">
            <div class="container-fluid">
                <h2 class="gigCreationHeading align-content-center">Job Creation</h2>

                <div class="form-floating mb-4">
                    <label for="exampleFormControlFile1" class="mt-3 ml-auto font-weight-bold">Job Title</label>
                    <input type="text" class="form-control" id="gigTitle" placeholder="I am looking for a graphic designer . . . ." maxlength="100" runat="server" />
                    <asp:RequiredFieldValidator id="RequiredFieldValidator6" Text="Required*" ValidationGroup="Save_Gig"  ControlToValidate="gigTitle" Runat="server" /> 
                </div>

                <div class="form-floating mb-4">
                    <label for="exampleFormControlFile1" class=" ml-auto font-weight-bold">Job Description</label>
                    <textarea class="form-control" placeholder="Services you are looking for . . . ." id="gigDescription" maxlength="1200" rows="7" style="resize: none" runat="server"></textarea>
                    <asp:RequiredFieldValidator id="RequiredFieldValidator5" Text="Required*" ValidationGroup="Save_Gig"  ControlToValidate="gigDescription" Runat="server" /> 
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
                <h6 class="font-weight-bold">In How Many Days/Months/Years You Want The Order?</h6>
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
</asp:Content>
