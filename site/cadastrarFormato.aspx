<%@ Page Title="" Language="C#" MasterPageFile="~/mPageAdm.master" AutoEventWireup="true"  MaintainScrollPositionOnPostback="true" CodeFile="~/cs/cadastrarFormato.aspx.cs" Inherits="cadastrarFormato" %>

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
        <h1 class="h1M">Cadastrar Formato</h1>
        <br />
        <p>Descrição:</p>
        <asp:TextBox ID="txtDesc" placeholder="EX: Redondo" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="btnCadastrar" runat="server" Text="CADASTRAR" CssClass="btn" OnClick="btnCadastrar_Click" />
        <br />
        <br />
        <asp:Label ID="lblMsg" runat="server"></asp:Label>
        <asp:SqlDataSource ID="sqlCadFormato" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" InsertCommand="INSERT INTO formato(descr_formato) VALUES ( @DESC )" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [formato]">
            <InsertParameters>
                <asp:ControlParameter ControlID="txtDesc" Name="DESC" PropertyName="Text" />
            </InsertParameters>
        </asp:SqlDataSource>       
     </div>
</asp:Content>

