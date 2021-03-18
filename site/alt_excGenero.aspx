<%@ Page Title="" Language="C#" MasterPageFile="~/mPageAdm.master" AutoEventWireup="true"  MaintainScrollPositionOnPostback="true" CodeFile="~/cs/alt_excGenero.aspx.cs" Inherits="alt_excGenero" %>

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
        <h1 class="h1M">Alterar ou Excluir Gênero</h1>
        <br />
        <p>Gênero:</p>
        <asp:DropDownList ID="ddlGen" runat="server" CssClass="ddl" AutoPostBack="True" DataSourceID="sqlCarregarDDL" DataTextField="nome_genero" DataValueField="id_genero" OnSelectedIndexChanged="ddlGen_SelectedIndexChanged"></asp:DropDownList>
        <asp:SqlDataSource ID="sqlCarregarDDL" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM genero"></asp:SqlDataSource>
        <br />
        <asp:SqlDataSource ID="sqlExibirGen" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" DeleteCommand="DELETE FROM genero WHERE (id_genero = @ID)" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [genero]" UpdateCommand="UPDATE genero SET nome_genero = @NOME WHERE (id_genero = @ID)">
            <DeleteParameters>
                <asp:ControlParameter ControlID="ddlGen" Name="ID" PropertyName="SelectedValue" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:ControlParameter ControlID="txtNome" Name="NOME" PropertyName="Text" />
                <asp:ControlParameter ControlID="ddlGen" Name="ID" PropertyName="SelectedValue" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <p>Nome:</p>
        <asp:TextBox ID="txtNome" placeholder="EX: Casamento" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        
        <br />
        <asp:Button ID="btnAlterar" runat="server" Text="ALTERAR" CssClass="btn" OnClick="btnAlterar_Click" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        <asp:Button ID="btnExcluir" runat="server" Text="EXCLUIR" CssClass="btn" OnClick="btnExcluir_Click" />
        <br />
        <br />
        <asp:Label ID="lblMsg" runat="server"></asp:Label>
</asp:Content>

