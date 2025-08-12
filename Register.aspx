<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Ecommerce.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <style>
        .signup-table{
            margin-left:auto;
            margin-right:auto;
            border:solid 1px black;
            border-radius: 10px;
            border-collapse: separate;
         }
    </style>
    <title></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous"/>
    <script type="text/javascript">
    function ShowPassword(checkBox) {
        var PassBox = document.getElementById('txtPassword');
        if (checkBox.checked == true) {
            PassBox.setAttribute("type", "text");
        }
        else {
            PassBox.setAttribute("type", "password");
        }
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            
             
            <table class="signup-table">
                <tr>
                    <td colspan="2" style="text-align:center;">Register</td>
                </tr>
                <tr>
                    <td>
                        Username
                    </td>
                    <td class="control-column">
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control border-success rounded-pill" ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvName" runat="server" 
                            ControlToValidate="txtName" 
                            ErrorMessage="Name is required" 
                            CssClass="validator-message" 
                            Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>

               
                <tr>
                    <td >
                        Age
                    </td>
                    <td class="control-column">
                        <asp:TextBox ID="txtAge" runat="server" CssClass="form-control border-success rounded-pill"  TextMode="Number"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvAge" runat="server" 
                            ControlToValidate="txtAge" 
                            ErrorMessage="Age is required" 
                            CssClass="validator-message" 
                            Display="Dynamic" ForeColor="Red">

                            
                        </asp:RequiredFieldValidator>
                    </td>
                </tr>

                
                <tr>
                    <td>
                        Email
                    </td>
                    <td class="control-column">
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control border-success rounded-pill" TextMode="Email"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
                            ControlToValidate="txtEmail" 
                            ErrorMessage="Email is required" 
                            CssClass="validator-message" 
                            Display="Dynamic" ForeColor="Red">
                            
                        </asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revEmail" runat="server" 
                            ControlToValidate="txtEmail" 
                            ErrorMessage="Please enter a valid email address" 
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                            CssClass="validator-message" 
                            Display="Dynamic" ForeColor="Red">
                            
                        </asp:RegularExpressionValidator>
                    </td>
                </tr>

                
                <tr>
                    <td >
                        Gender
                    </td>
                    <td >
                        <asp:DropDownList ID="ddlGender" runat="server" >
                            <asp:ListItem Text="Select Gender" Value=""></asp:ListItem>
                            <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                            <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
      
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvGender" runat="server" 
                            ControlToValidate="ddlGender" 
                            InitialValue=""
                            ErrorMessage="Please select your gender" 
                            ForeColor="Red"
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>
                    </td>
                </tr>

                
                <tr>
                    <td >
                        Password
                    </td>
                    <td >
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="border-success rounded-pill" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                            ControlToValidate="txtPassword" 
                            ErrorMessage="Password is required" 
                             ForeColor="Red"
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>
                        <input type="checkbox" onclick="ShowPassword(this)" /> Show Password 
                    </td>
                    
                </tr>

                
                <tr>
                    <td>
                        Confirm Password
                    </td>
                    <td>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="border-success rounded-pill" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" 
                            ControlToValidate="txtConfirmPassword" 
                            ErrorMessage="Please confirm your password" 
                            ForeColor="Red"
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="cvPassword" runat="server" 
                            ControlToValidate="txtConfirmPassword" 
                            ControlToCompare="txtPassword" 
                            ErrorMessage="Passwords do not match" 
                            ForeColor="Red"
                            Display="Dynamic">
                        </asp:CompareValidator>
                    </td>
                </tr>

                
                <tr>
                    <td colspan="2" class="button-column">
                        <asp:Button  ID="btnSignUp" style="border-radius:10px; border:solid 1px;" runat="server" CssClass="btn btn-primary" Text="Sign Up" OnClick="btnSignUp_Click" />
                    </td>
                </tr>
            </table>
        </div>
        <div">
    <asp:LinkButton ID="LinkButton1" runat="server" ForeColor="Blue" CausesValidation="false" OnClick="LinkButton1_Click" CssClass="d-flex justify-content-center">Already Registered? Sign In</asp:LinkButton>
    
</div>
    </form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
</body>
</html>
