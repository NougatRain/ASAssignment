<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginForm.aspx.cs" Inherits="ASAssignmentV3.LoginForm" ValidateRequest="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login Form</title>

    <script src="https://www.google.com/recaptcha/api.js?render="></script> 

    <style type="text/css">
        .auto-style1 {
            width: 151px;
            height: 22px;
        }
        .auto-style2 {
            width: 132px;
            height: 22px;
        }
        .auto-style3 {
            height: 22px;
        }
        .auto-style4 {
            width: 151px;
            height: 30px;
        }
        .auto-style5 {
            width: 132px;
            height: 30px;
        }
        .auto-style6 {
            height: 30px;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
            <table class="nav-justified">
            
        <tr>
            <td class="auto-style4"><h2>Login</h2></td>
            <td class="auto-style5"></td>
            <td class="auto-style6"></td>
        </tr>
        <tr>
            <td style="width: 151px; height: 22px;">Email:</td>
            <td class="modal-sm" style="width: 132px; height: 22px;">
                <asp:TextBox ID="tb_userEmail" runat="server"></asp:TextBox>
            </td>
            <td style="height: 22px"></td>
        </tr> 
        <tr>
            <td style="width: 151px; height: 22px;">Password:</td>
            <td class="modal-sm" style="width: 132px; height: 22px;">
                <asp:TextBox ID="tb_userPassword" runat="server"  TextMode="Password"></asp:TextBox>
            </td>
            <td style="height: 22px">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style1">
                <asp:Label ID="lbl_gScore" runat="server"></asp:Label>
            </td>
            <td class="auto-style2">
                <asp:Label ID="lblMessage" runat="server"></asp:Label>
            </td>
            <td class="auto-style3">
                </td>
        </tr>
        <tr>
            <td style="width: 151px">
                <asp:Button ID="btn_Register" runat="server" OnClick="btn_Register_Click" Text="Register" Width="139px" />
            </td>
            <td class="modal-sm" style="width: 132px">
                <asp:Button ID="btn_Login" runat="server" Text="Login" Width="131px" OnClick="LoginMe" />
            </td>
            <td>&nbsp;</td>
        </tr>

        <tr>
            <td style="width: 151px">&nbsp;</td>
            <td class="modal-sm" style="width: 132px">
                &nbsp;</td>
            <td>&nbsp;</td>
        </tr>

        <tr>
            <td style="width: 151px">&nbsp;</td>
            <td class="modal-sm" style="width: 132px">
                <input type="hidden" id="g-recaptcha-response" name="g-recaptcha-response"/></td>
            <td>&nbsp;</td>
        </tr>

    </table>
    </form>
    <script>
        grecaptcha.ready(function () {
            grecaptcha.execute('', { action: 'Login' }).then(function (token) {
                document.getElementById("g-recaptcha-response").value = token;
            });
        });
    </script>       
</body>
</html>
