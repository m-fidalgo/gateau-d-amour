<%@ Page Title="" Language="C#" MasterPageFile="~/mPageAdm.master" AutoEventWireup="true"  MaintainScrollPositionOnPostback="true" CodeFile="~/cs/alt_excSabor.aspx.cs" Inherits="alt_excSabor" %>

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
        <h1 class="h1M">Alterar ou Excluir Sabor</h1>
        <br />
        <p>Sabor:</p>
        <asp:DropDownList ID="ddlSabor" runat="server" CssClass="ddl" AutoPostBack="True" DataSourceID="sqlCarregarDDL" DataTextField="desc_sabor" DataValueField="id_sabor" OnSelectedIndexChanged="ddlSabor_SelectedIndexChanged"></asp:DropDownList>
        
        <asp:SqlDataSource ID="sqlCarregarDDL" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM sabor"></asp:SqlDataSource>
        <br />
        <asp:SqlDataSource ID="sqlExibirSabor" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT id_sabor, desc_sabor FROM sabor WHERE (id_sabor = @ID)" DeleteCommand="DELETE FROM sabor WHERE (id_sabor = @ID)" UpdateCommand="UPDATE sabor SET desc_sabor = @NOME WHERE (id_sabor = @ID)">
            <DeleteParameters>
                <asp:ControlParameter ControlID="ddlSabor" Name="ID" PropertyName="SelectedValue" />
            </DeleteParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlSabor" Name="ID" PropertyName="SelectedValue" />
            </SelectParameters>
            <UpdateParameters>
                <asp:ControlParameter ControlID="ddlSabor" Name="ID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="txtNome" Name="NOME" PropertyName="Text" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <p>Nome:</p>
        <asp:TextBox ID="txtNome" placeholder="EX: Chocolate" runat="server" CssClass="txt"></asp:TextBox>
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

