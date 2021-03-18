<%@ Page Title="" Language="C#" MasterPageFile="~/mPageAdm.master" AutoEventWireup="true"  MaintainScrollPositionOnPostback="true" CodeFile="~/cs/cadastrarMassa.aspx.cs" Inherits="cadastrarMassa" %>

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
        <h1 class="h1M">Cadastrar Massa</h1>
        <br />
        <p>Nome:</p>
        <asp:TextBox ID="txtNome" placeholder="EX: Massa de Chocolate" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <p>Preço adicional:</p>
        <asp:TextBox ID="txtPrecADC" placeholder="EX: 45" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="btnCadastrar" runat="server" Text="CADASTRAR" CssClass="btn" OnClick="btnCadastrar_Click" />
        <br />
        <asp:SqlDataSource ID="sqlCadastrarMassa" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" InsertCommand="INSERT INTO massa(nome_massa, precoAdc_massa) VALUES (@NOME, @PRECOADC)" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [massa]">
            <InsertParameters>
                <asp:ControlParameter ControlID="txtNome" Name="NOME" PropertyName="Text" />
                <asp:Parameter Name="PRECOADC" />
            </InsertParameters>
        </asp:SqlDataSource>
        <br />
        <asp:Label ID="lblMsg" runat="server"></asp:Label>
         
     </div>
</asp:Content>

