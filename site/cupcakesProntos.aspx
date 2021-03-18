<%@ Page Title="" Language="C#" MasterPageFile="~/mPage.master" MaintainScrollPositionOnPostback="true" AutoEventWireup="true" CodeFile="~/cs/cupcakesProntos.aspx.cs" Inherits="cupcakesProntos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="divProg">
        <br />
        <br />
        <h1 class="h1M">Cupcakes</h1>
        <br />
        <p>Pesquisar:</p>
        <asp:TextBox ID="txtPesq" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="btnPesq" runat="server" Text="PESQUISAR" CssClass="btn" OnClick="btnPesq_Click" />
        <br />
        <br />
        <asp:Label ID="lblErro" runat="server" Text=""></asp:Label>
        <br />
        <br />
        <br />
        <asp:DataList ID="dlCupcake" runat="server" DataKeyField="id_prod" RepeatColumns="3" RepeatDirection="Horizontal" CssClass="dlProd" CellPadding="4" >
            <FooterTemplate>
                <asp:LinkButton ID="btnAnterior" runat="server" OnClick="btnAnterior_Click" CssClass="links">&lt;&lt;</asp:LinkButton>
                &nbsp;&nbsp;
                <asp:LinkButton ID="btnProx" runat="server" OnClick="btnProx_Click" CssClass="links">&gt;&gt;</asp:LinkButton>
            </FooterTemplate>
            <ItemTemplate>
                <asp:Image ID="Image1" runat="server" Width="350px" ImageUrl='<%# "~\\imgs\\produtos\\" + Eval("imagem", "{0}") %>' />
                <br />
                <asp:Label ID="nome_prodLabel" runat="server" Text='<%# Eval("nome_prod") %>' />
                <br />
                <asp:Label ID="preco_prodLabel" runat="server" Text='<%# Eval("preco_prod", "{0:C}") %>' />
                <br />
                <br />
                <asp:HyperLink ID="linkMaisInfo" runat="server" text="Mais Informações" CssClass="link" NavigateUrl='<%# Eval("id_prod", "detalhesProd.aspx?id_prod={0}") %>'></asp:HyperLink>
                <br />
                <br />
            </ItemTemplate>
        </asp:DataList>
        <br />
        <asp:SqlDataSource ID="sqlExibir" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT produto.nome_prod, produto.preco_prod, produto.imagem, produto.id_prod FROM produto INNER JOIN tamanho ON produto.id_tamanho = tamanho.id_tamanho WHERE (produto.nome_prod LIKE @PESQ) AND (tamanho.id_cat = 2) AND (produto.nome_prod != 'SELECIONE')">
            <SelectParameters>
                <asp:Parameter Name="PESQ" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>

