<%@ Page Title="" Language="C#" MasterPageFile="~/mPageAdm.master" AutoEventWireup="true"  MaintainScrollPositionOnPostback="true" CodeFile="~/cs/alt_excCobertura.aspx.cs" Inherits="alt_excCobertura" %>

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
        <h1 class="h1M">Alterar ou Excluir Cobertura</h1>
        <br />
        <p>Cobertura:</p>
        <asp:DropDownList ID="ddlCobertura" runat="server" CssClass="ddl" AutoPostBack="True" DataSourceID="sqlCarregarDDL" DataTextField="nome_cobertura" DataValueField="id_cobertura" OnSelectedIndexChanged="ddlFormato_SelectedIndexChanged"></asp:DropDownList>
        <asp:SqlDataSource ID="sqlCarregarDDL" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM cobertura"></asp:SqlDataSource>
        <br />
        <p>Nome:</p>
        <asp:TextBox ID="txtNome" placeholder="EX: Chantilly" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <p>Preço Adicional:</p>
        <asp:TextBox ID="txtPreco" placeholder="EX: 45" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <asp:SqlDataSource ID="sqlExibirCobertura" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" DeleteCommand="DELETE FROM cobertura WHERE (id_cobertura = @ID)" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT id_cobertura, nome_cobertura, precoAdc_cobertura FROM cobertura WHERE (id_cobertura = @ID)" UpdateCommand="UPDATE cobertura SET nome_cobertura = @NOME, precoAdc_cobertura = @PRECOADC WHERE (id_cobertura = @ID)">
            <DeleteParameters>
                <asp:ControlParameter ControlID="ddlCobertura" Name="ID" PropertyName="SelectedValue" />
            </DeleteParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlCobertura" Name="ID" PropertyName="SelectedValue" />
            </SelectParameters>
            <UpdateParameters>
                <asp:ControlParameter ControlID="ddlCobertura" Name="ID" PropertyName="SelectedValue" />
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

