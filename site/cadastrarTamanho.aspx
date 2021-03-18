<%@ Page Title="" Language="C#" MasterPageFile="~/mPageAdm.master" AutoEventWireup="true"  MaintainScrollPositionOnPostback="true" CodeFile="~/cs/cadastrarTamanho.aspx.cs" Inherits="cadastrarTamanho" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="divProg">
        <br />
        <br />
        <h1 class="h1M">Cadastrar Tamanho</h1>
        <br />
        <p>Categoria:</p>
        <asp:DropDownList ID="ddlCat" runat="server" CssClass="ddl" DataSourceID="sqlCarregarDDLcat" DataTextField="nome_cat" DataValueField="id_cat" ></asp:DropDownList>
        <asp:SqlDataSource ID="sqlCarregarDDLcat" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM categoria"></asp:SqlDataSource>
        <br /> 
        <p>Formato: <asp:Label ID="lbl1" runat="server" CssClass="rfv"></asp:Label></p>
        <asp:DropDownList ID="ddlFormato" runat="server" CssClass="ddl" DataSourceID="sqlCarregarDDLformato" DataTextField="descr_formato" DataValueField="id_formato"></asp:DropDownList>
        <asp:SqlDataSource ID="sqlCarregarDDLformato" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM formato"></asp:SqlDataSource>
        <br />
        <p>Descrição:</p>
        <asp:TextBox ID="txtDesc" placeholder="EX: Pequeno" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <p>Medidas:</p>
        <asp:TextBox ID="txtMedidas" placeholder="EX: 25cm x 25cm" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <p>Preço:</p>
        <asp:TextBox ID="txtPreco" placeholder="EX: 45" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="btnCadastrar" runat="server" Text="CADASTRAR" CssClass="btn" OnClick="btnCadastrar_Click" />
        <br />
        <asp:SqlDataSource ID="sqlCadastrarTamanho" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" InsertCommand="INSERT INTO tamanho(id_formato, descr_tamanho, medidas_tamanho, preco_tamanho, id_cat) VALUES (@FORMATO, @DESC , @MEDIDAS, @PRECO, @CAT)" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [tamanho]">
            <InsertParameters>
                <asp:ControlParameter ControlID="ddlFormato" Name="FORMATO" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="txtDesc" Name="DESC" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtMedidas" Name="MEDIDAS" PropertyName="Text" />
                <asp:Parameter Name="PRECO" />
                <asp:ControlParameter ControlID="ddlCat" Name="CAT" PropertyName="SelectedValue" />
            </InsertParameters>
        </asp:SqlDataSource>
        <br />
        <asp:Label ID="lblMsg" runat="server"></asp:Label>
         
     </div>
</asp:Content>

