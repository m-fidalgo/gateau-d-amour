<%@ Page Title="" Language="C#" MasterPageFile="~/mPageAdm.master" AutoEventWireup="true"  MaintainScrollPositionOnPostback="true" CodeFile="~/cs/alt_excDecor.aspx.cs" Inherits="alt_excDecoracao" %>

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
        <h1 class="h1M">Alterar ou Excluir Decoração</h1>
        <br />
        <p>Decoração:</p>
        <asp:DropDownList ID="ddlDecoracao" runat="server" CssClass="ddl" AutoPostBack="True" DataSourceID="sqlCarregarDDL" DataTextField="descr_decor" DataValueField="id_decor" OnSelectedIndexChanged="ddlDecoracao_SelectedIndexChanged"></asp:DropDownList>
        <asp:SqlDataSource ID="sqlCarregarDDL" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM decoracao"></asp:SqlDataSource>
        <br />
        <p>Nome:</p>
        <asp:TextBox ID="txtNome" placeholder="EX: Raspas de Chocolate" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <p>Preço Adicional:</p>
        <asp:TextBox ID="txtPreco" placeholder="EX: 45" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <asp:SqlDataSource ID="sqlExibirDecoracao" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" DeleteCommand="DELETE FROM decoracao WHERE (id_decor = @ID)" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT id_decor, descr_decor, precoAdc_decor FROM decoracao WHERE (id_decor = @ID)" UpdateCommand="UPDATE decoracao SET descr_decor = @NOME, precoAdc_decor = @PRECOADC WHERE (id_decor = @ID)">
            <DeleteParameters>
                <asp:ControlParameter ControlID="ddlDecoracao" Name="ID" PropertyName="SelectedValue" />
            </DeleteParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlDecoracao" Name="ID" PropertyName="SelectedValue" />
            </SelectParameters>
            <UpdateParameters>
                <asp:ControlParameter ControlID="ddlDecoracao" Name="ID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="txtNome" Name="NOME" PropertyName="Text" />
                <asp:Parameter Name="PRECOADC" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <br />
        <asp:Button ID="btnAlterar" runat="server" Text="ALTERAR" CssClass="btn" OnClick="btnAlterar_Click" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        <asp:Button ID="btnExcluir" runat="server" Text="EXCLUIR" CssClass="btn" OnClick="btnExcluir_Click" />
        <br />
        <br />
        <asp:Label ID="lblMsg" runat="server"></asp:Label>
     </div>
</asp:Content>

