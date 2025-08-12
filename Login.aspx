<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Ecommerce.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        .submit:hover{
            background-color: #808080;
        }
    </style>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous"/>
    <script type="text/javascript"> 
function ShowPassword(checkBox) {
    var PassBox = document.getElementById('password');
    if (checkBox.checked == true) {
        PassBox.setAttribute("type", "text");
    }
    else {
        PassBox.setAttribute("type", "password");
    }
    }

    </script>
</head>
<body >
    <form id="form1" runat="server">
        <div>
            <table class="form shadow-lg p-3 mb-5 bg-body-tertiary rounded"
       style="margin:auto; border: 2px solid black; border-radius: 15px; overflow: hidden; border-collapse: separate; border-spacing: 0;">
    <tr>
        <td style="border: none;">Email</td>
        <td style="border: none;">
            <asp:TextBox runat="server" CssClass="form-control border-success rounded-pill" ID="email"></asp:TextBox>
            <asp:RequiredFieldValidator runat="server" ID="emailVal" ForeColor="Red" ErrorMessage="Enter your email" ControlToValidate="email" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="rightEmail" runat="server" ErrorMessage="Enter valid email" SetFocusOnError="True" ControlToValidate="email" ForeColor="Red" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
        </td>
    </tr>
    <tr>
        <td style="border: none;">Password</td>
        <td style="border: none;">
            <asp:TextBox CssClass="form-control border-success rounded-pill" runat="server" ID="password" TextMode="Password"></asp:TextBox>
            <asp:RequiredFieldValidator runat="server" ID="passVal" ForeColor="Red" Text="*" ErrorMessage="Enter your password" ControlToValidate="password" Display="Dynamic" SetFocusOnError="true" TextMode="password"></asp:RequiredFieldValidator>
            <input type="checkbox" onclick="ShowPassword(this)" /> Show Password 

        </td>
    </tr>
    <tr>
        <td colspan="2" style="border: none;">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<asp:Button CssClass="btn btn-primary submit" ID="signin" runat="server" Text="Sign In" OnClick="signin_Click" />
        </td>
    </tr>
</table>
            </div>
        <div style="text-align: center">
    <asp:LinkButton ID="register" runat="server" ForeColor="Blue" CausesValidation="False" OnClick="register_Click" >Not a User? Register</asp:LinkButton>
</div>
</form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
</body>
</html>
