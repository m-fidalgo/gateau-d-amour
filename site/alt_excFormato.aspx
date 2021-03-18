<%@ Page Title="" Language="C#" MasterPageFile="~/mPageAdm.master" AutoEventWireup="true"  MaintainScrollPositionOnPostback="true" CodeFile="~/cs/alt_excFormato.aspx.cs" Inherits="alt_excFormato" %>

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
        <h1 class="h1M">Alterar ou Excluir Formato</h1>
        <br />
        <p>Formato:</p>
        <asp:DropDownList ID="ddlFormato" runat="server" CssClass="ddl" AutoPostBack="True" DataSourceID="sqlCarregarDDL" DataTextField="descr_formato" DataValueField="id_formato" OnSelectedIndexChanged="ddlFormato_SelectedIndexChanged"></asp:DropDownList>
        <asp:SqlDataSource ID="sqlCarregarDDL" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM formato"></asp:SqlDataSource>
        <br />
        <p>Descrição:</p>
        <asp:TextBox ID="txtDesc" placeholder="EX: Redondo" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <asp:SqlDataSource ID="sqlExibirFormato" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" DeleteCommand="DELETE FROM formato WHERE (id_formato = @ID)" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT id_formato, descr_formato FROM formato WHERE (id_formato = @ID)" UpdateCommand="UPDATE formato SET descr_formato = @DESC WHERE (id_formato = @ID)">
            <DeleteParameters>
                <asp:ControlParameter ControlID="ddlFormato" Name="ID" PropertyName="SelectedValue" />
            </DeleteParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlFormato" Name="ID" PropertyName="SelectedValue" />
            </SelectParameters>
            <UpdateParameters>
                <asp:ControlParameter ControlID="txtDesc" Name="DESC" PropertyName="Text" />
                <asp:ControlParameter ControlID="ddlFormato" Name="ID" PropertyName="SelectedValue" />
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

