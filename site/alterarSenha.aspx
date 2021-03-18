<%@ Page Title="" Language="C#" MasterPageFile="~/mPage.master" AutoEventWireup="true" CodeFile="~/cs/alterarSenha.aspx.cs" Inherits="alterarSenha" %>

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
        <h1 class="h1M">Alterar Senha</h1>
        <p>Senha:</p>
        <asp:TextBox ID="txtSenha" placeholder="EX: exemplo123" runat="server" CssClass="txt" TextMode="Password"></asp:TextBox>
        <br />
        <asp:Label CssClass="rfv" ID="lblForca" runat="server" Text=""></asp:Label>
        <br />
        <p>Confirmar Senha:</p>
        <asp:TextBox ID="txtConfSenha" placeholder="EX: exemplo123" runat="server" CssClass="txt" TextMode="Password"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="btnForca" runat="server" Text="VERIFICAR FORÇA DA SENHA" CssClass="btnFU" OnClick="btnForca_Click" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
        <asp:Button ID="btnAlterar" runat="server" Text="ALTERAR" CssClass="btnFU" OnClick="btnAlterar_Click" />
        <br />
        <br />
        <p>OBS: A senha deve ser forte, ou seja, deve ter 6 caracteres, com pelo menos uma letra maiúscula, uma minúscula, um número e um caracter especial.</p>
        <asp:SqlDataSource ID="sqlAltSenha" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [cliente]" UpdateCommand="UPDATE cliente SET senha_cli = @SENHA, login_cli = '+' WHERE (id_cli = @IDCLI)">
            <UpdateParameters>
                <asp:SessionParameter Name="IDCLI" SessionField="idCli" />
                <asp:Parameter Name="SENHA" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>

