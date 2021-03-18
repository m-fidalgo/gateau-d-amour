<%@ Page Title="" Language="C#" MasterPageFile="~/mPage.master" AutoEventWireup="true" CodeFile="~/cs/esqueciSenha.aspx.cs" Inherits="esqueciSenha" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="divProg">
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />   
        <h1 class="h1M">Insira seu email</h1>
        <br />
        <asp:TextBox ID="txtEmail" runat="server" CssClass="txt" placeholder="EX: exemplo@gmail.com"></asp:TextBox>
        <br />        
        <br />
        <asp:Button ID="btnEnviar" runat="server" Text="ENVIAR" CssClass="btn" OnClick="btnEnviar_Click" />
        <br />
        <br />
        <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>        
        <asp:SqlDataSource ID="sqlSenha" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT email_cli FROM cliente WHERE (email_cli = @EMAIL)" UpdateCommand="UPDATE cliente SET senha_cli = @SENHA WHERE (email_cli = @EMAIL)">
            <SelectParameters>
                <asp:Parameter Name="EMAIL" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="SENHA" />
                <asp:Parameter Name="EMAIL" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>

