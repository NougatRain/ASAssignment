<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegistrationForm.aspx.cs" Inherits="ASAssignmentV3.RegistrationForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Registration</title>

    <script src="https://www.google.com/recaptcha/api.js?render="></script> 

            <script type="text/javascript">
                function validate() {
                    var str = document.getElementById('<%=tb_password.ClientID %>').value;

                if (str.length < 8) {
                    document.getElementById("lbl_pwdchecker").innerHTML = "Password Length Must be at Least 8 Characters";
                    document.getElementById("lbl_pwdchecker").style.color = "Red";
                    return ("too_short")
                }

                else if (str.search(/[0-9]/) == -1) {
                    document.getElementById("lbl_pwdchecker").innerHTML = "Password require at least 1 number";
                    document.getElementById("lbl_pwdchecker").style.color = "Red";
                    return ("no_number");
                }

                else if (str.search(/[A-Z]/) == -1) {
                    document.getElementById("lbl_pwdchecker").innerHTML = "Password require at least 1 uppercase";
                    document.getElementById("lbl_pwdchecker").style.color = "Red";
                    return ("no_uppercase");
                }

                else if (str.search(/[a-z]/) == -1) {
                    document.getElementById("lbl_pwdchecker").innerHTML = "Password require at least 1 lowercase";
                    document.getElementById("lbl_pwdchecker").style.color = "Red";
                    return ("no_lowercase");
                }

                else if (str.search(/[!@#$%^&*]/) == -1) {
                    document.getElementById("lbl_pwdchecker").innerHTML = "Password require at least 1 symbol";
                    document.getElementById("lbl_pwdchecker").style.color = "Red";
                    return ("no_symbol");
                }

                document.getElementById("lbl_pwdchecker").innerHTML = "Good Password"
                document.getElementById("lbl_pwdchecker").style.color = "Green";
            }
            </script>       

    <style type="text/css">
        .auto-style1 {
            width: 151px;
            height: 21px;
        }
        .auto-style2 {
            width: 132px;
            height: 21px;
        }
        .auto-style3 {
            height: 21px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
            <table class="nav-justified">
            
        <tr>
            <td style="width: 151px"><h2>Registration</h2></td>
            <td class="modal-sm" style="width: 132px">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 151px">First Name:</td>
            <td class="modal-sm" style="width: 132px">
                <asp:TextBox ID="tb_fname" runat="server"></asp:TextBox>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="height: 20px; width: 151px">Last Name:</td>
            <td style="height: 20px; width: 132px">
                <asp:TextBox ID="tb_lname" runat="server"></asp:TextBox>
            </td>
            <td style="height: 20px">&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 151px">Credit Card No.:</td>
            <td class="modal-sm" style="width: 132px">
                <asp:TextBox ID="tb_credit" runat="server"></asp:TextBox>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 151px; height: 22px;">Email:</td>
            <td class="modal-sm" style="width: 132px; height: 22px;">
                <asp:TextBox ID="tb_email" runat="server" TextMode="Email"></asp:TextBox>
            </td>
            <td style="height: 22px">
                <asp:Label ID="lbl_error" runat="server"></asp:Label>
            </td>
        </tr> 
        <tr>
            <td style="width: 151px; height: 22px;">Password:</td>
            <td class="modal-sm" style="width: 132px; height: 22px;">
                <asp:TextBox ID="tb_password" runat="server"  TextMode="Password" onkeyup="javascript:validate()"></asp:TextBox>
            </td>
            <td style="height: 22px">
                <asp:Label ID="lbl_pwdchecker" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="width: 151px">Date Of Birth:</td>
            <td class="modal-sm" style="width: 132px">
                <asp:TextBox ID="tb_dob" runat="server" OnTextChanged="tb_dob_TextChanged" TextMode="Date"></asp:TextBox>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style1"></td>
            <td class="auto-style2">
                <asp:Label ID="lbl_gScore" runat="server"></asp:Label>
            </td>
            <td class="auto-style3"></td>
        </tr>
        <tr>
            <td style="width: 151px">
                <asp:Button ID="btn_Login" runat="server" OnClick="btn_Login_Click" Text="Login" Width="149px" />
            </td>
            <td class="modal-sm" style="width: 132px">
                <asp:Button ID="btn_checkPassword" runat="server" Text="Check Password" Width="130px" OnClick="btn_checkPassword_Click1" />
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 151px">&nbsp;</td>
            <td class="modal-sm" style="width: 132px">
                <asp:Button ID="btn_Submit" runat="server" Text="Register" Width="131px" OnClick="btn_Submit_Click" />
            </td>
            <td><input type="hidden" id="g-recaptcha-response" name="g-recaptcha-response"/></td>
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
