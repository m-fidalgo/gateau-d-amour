<%@ Page Title="" Language="C#" MasterPageFile="~/mPageAdm.master" AutoEventWireup="true"  MaintainScrollPositionOnPostback="true" CodeFile="~/cs/alt_excCor.aspx.cs" Inherits="alt_excCor" %>

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
        <h1 class="h1M">Alterar ou Excluir Cor</h1>
        <br />
        <p>Cor:</p>
        <asp:DropDownList ID="ddlCor" runat="server" CssClass="ddl" AutoPostBack="True" DataSourceID="sqlCarregarDDL" DataTextField="nome_cor" DataValueField="id_cor" OnSelectedIndexChanged="ddlCor_SelectedIndexChanged"></asp:DropDownList>
        
        <asp:SqlDataSource ID="sqlCarregarDDL" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM cor"></asp:SqlDataSource>
        <br />
        <asp:SqlDataSource ID="sqlExibirCor" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" DeleteCommand="DELETE FROM cor WHERE (id_cor = @ID)" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [cor]" UpdateCommand="UPDATE cor SET nome_cor = @NOME WHERE (id_cor = @ID)">
            <DeleteParameters>
                <asp:ControlParameter ControlID="ddlCor" Name="ID" PropertyName="SelectedValue" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:ControlParameter ControlID="ddlCor" Name="ID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="txtNome" Name="NOME" PropertyName="Text" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <p>Nome:</p>
        <asp:TextBox ID="txtNome" placeholder="EX: Azul" runat="server" CssClass="txt"></asp:TextBox>
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

