<%@ Page Title="" Language="C#" MasterPageFile="~/mPageAdm.master" AutoEventWireup="true"  MaintainScrollPositionOnPostback="true" CodeFile="~/cs/alt_excRecheio.aspx.cs" Inherits="alt_excRecheio" %>

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
        <h1 class="h1M">Alterar ou Excluir Recheio</h1>
        <br />
        <p>Sabor:</p>
        <asp:DropDownList ID="ddlRecheio" runat="server" CssClass="ddl" AutoPostBack="True" DataSourceID="sqlCarregarDDL" DataTextField="nome_recheio" DataValueField="id_recheio" OnSelectedIndexChanged="ddlRecheio_SelectedIndexChanged"></asp:DropDownList>
        
        <asp:SqlDataSource ID="sqlCarregarDDL" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM recheio"></asp:SqlDataSource>
        <br />
        <asp:SqlDataSource ID="sqlExibirRecheio" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT id_recheio, nome_recheio FROM recheio WHERE (id_recheio = @ID)" DeleteCommand="DELETE FROM recheio WHERE (id_recheio = @ID)" UpdateCommand="UPDATE recheio SET nome_recheio = @NOME WHERE (id_recheio = @ID)">
            <DeleteParameters>
                <asp:ControlParameter ControlID="ddlRecheio" Name="ID" PropertyName="SelectedValue" />
            </DeleteParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlRecheio" Name="ID" PropertyName="SelectedValue" />
            </SelectParameters>
            <UpdateParameters>
                <asp:ControlParameter ControlID="ddlRecheio" Name="ID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="txtNome" Name="NOME" PropertyName="Text" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <p>Nome:</p>
        <asp:TextBox ID="txtNome" placeholder="EX: Mousse" runat="server" CssClass="txt"></asp:TextBox>
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

