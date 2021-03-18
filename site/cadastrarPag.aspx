<%@ Page Title="" Language="C#" MasterPageFile="~/mPageAdm.master" AutoEventWireup="true"   MaintainScrollPositionOnPostback="true" CodeFile="~/cs/cadastrarPag.aspx.cs" Inherits="cadastrarPag" %>

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
        <h1 class="h1M">Cadastrar Pagamento</h1>
        <br />
        <p>Nome:</p>
        <asp:TextBox ID="txtNome" placeholder="EX: Boleto" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="btnCadastrar" runat="server" Text="CADASTRAR" CssClass="btn" OnClick="btnCadastrar_Click" />
        <br />
        <br />
        <asp:Label ID="lblMsg" runat="server"></asp:Label>        
        <asp:SqlDataSource ID="sqlCadastrarPag" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" InsertCommand="INSERT INTO pagamento(nome_pag) VALUES (@NOME)" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [pagamento]">
            <InsertParameters>
                <asp:ControlParameter ControlID="txtNome" Name="NOME" PropertyName="Text" />
            </InsertParameters>
        </asp:SqlDataSource>        
     </div>
</asp:Content>

