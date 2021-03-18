<%@ Page Title="" Language="C#" MasterPageFile="~/mPageAdm.master" AutoEventWireup="true"  MaintainScrollPositionOnPostback="true" CodeFile="~/cs/alt_excTamanho.aspx.cs" Inherits="alt_excTamanho" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="divProg">
        <br />
        <br />
        <h1 class="h1M">Alterar ou Excluir Tamanho</h1>
        <br />
        <p>Categoria:</p>
        <asp:DropDownList ID="ddlCategoria" runat="server" CssClass="ddl" DataSourceID="sqlCarregarDDLcat" DataTextField="nome_cat" DataValueField="id_cat" AutoPostBack="True" OnSelectedIndexChanged="ddlCategoria_SelectedIndexChanged"></asp:DropDownList>
        <asp:SqlDataSource ID="sqlCarregarDDLcat" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM categoria"></asp:SqlDataSource>
        <br />
        <p>Formato:</p>
        <asp:DropDownList ID="ddlFormato" runat="server" CssClass="ddl" DataSourceID="sqlCarregarDDLformato" DataTextField="descr_formato" DataValueField="id_formato" AutoPostBack="True" OnSelectedIndexChanged="ddlFormato_SelectedIndexChanged" Enabled="False"></asp:DropDownList>
        <asp:SqlDataSource ID="sqlCarregarDDLformato" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM formato"></asp:SqlDataSource>
        <br />
        <p>Tamanho:</p>
        <asp:DropDownList ID="ddlTamanho" runat="server" CssClass="ddl" AutoPostBack="True" DataSourceID="sqlCarregarDDL" DataTextField="descr_tamanho" DataValueField="id_tamanho" Enabled="False" OnSelectedIndexChanged="ddlTamanho_SelectedIndexChanged"></asp:DropDownList>
        <asp:SqlDataSource ID="sqlCarregarDDL" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT id_tamanho, id_formato, descr_tamanho, medidas_tamanho, preco_tamanho, id_cat FROM tamanho WHERE (id_formato = @IDFORM) AND (id_cat = @IDCAT)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlFormato" Name="IDFORM" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="ddlCategoria" Name="IDCAT" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlExibirTamanho" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" DeleteCommand="DELETE FROM tamanho WHERE (id_tamanho = @ID)" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT id_tamanho, id_formato, id_cat, descr_tamanho, medidas_tamanho, preco_tamanho FROM tamanho WHERE (id_tamanho = @ID)" UpdateCommand="UPDATE tamanho SET descr_tamanho = @DESC , medidas_tamanho = @MEDIDAS, preco_tamanho = @PRECO WHERE (id_tamanho = @ID)">
            <DeleteParameters>
                <asp:ControlParameter ControlID="ddlTamanho" Name="ID" PropertyName="SelectedValue" />
            </DeleteParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlTamanho" Name="ID" PropertyName="SelectedValue" />
            </SelectParameters>
            <UpdateParameters>
                <asp:ControlParameter ControlID="txtDesc" Name="DESC" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtMedidas" Name="MEDIDAS" PropertyName="Text" />
                <asp:Parameter Name="PRECO" />
                <asp:ControlParameter ControlID="ddlTamanho" Name="ID" PropertyName="SelectedValue" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <br />   
        <p>Descrição:</p>
        <asp:TextBox ID="txtDesc" placeholder="EX: Pequeno" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <p>Medidas:</p>
        <asp:TextBox ID="txtMedidas" placeholder="EX: 25cm x 25cm" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <p>Preço:</p>
        <asp:TextBox ID="txtPreco" placeholder="EX: 45,00" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="btnAlterar" runat="server" Text="ALTERAR" CssClass="btn" OnClick="btnAlterar_Click" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        <asp:Button ID="btnExcluir" runat="server" Text="EXCLUIR" CssClass="btn" OnClick="btnExcluir_Click" />
        <br />
        <br />
        <asp:Label ID="lblMsg" runat="server"></asp:Label>
     </div>
</asp:Content>

