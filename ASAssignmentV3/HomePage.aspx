<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="ASAssignmentV3.HomePage" ValidateRequest="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            width: 90px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>HomePage</h2>
            <br />
            <asp:Label ID="lblMessage" runat="server" EnableViewState="False"></asp:Label>
            <br />
            <br />
            <br />
            <br />
            <asp:Button ID="btnLogout" runat="server" Text="Logout" OnClick="LogoutMe" Visible="false"/>
        </div>
    </form>
</body>
</html>
