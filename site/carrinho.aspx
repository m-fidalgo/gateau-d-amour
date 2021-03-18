<%@ Page Title="" Language="C#" MasterPageFile="~/mPage.master" AutoEventWireup="true" CodeFile="~/cs/carrinho.aspx.cs" Inherits="carrinho" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="divProg">
        <br />
        <br />
        <h1 class="h1M">Carrinho</h1>
        <br />
        <p>Total do pedido: <asp:Label ID="lblTotal" runat="server" Text=""></asp:Label></p>
        <br />
        <br />
        <asp:Button ID="btnCancelar" runat="server" Text="CANCELAR PEDIDO" CssClass="btnFU" OnClick="btnCancelar_Click" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      
        <asp:Button ID="btnComprar" runat="server" Text="FINALIZAR COMPRA" CssClass="btnFU" OnClick="btnComprar_Click" />
        <br />
        <br />
        <asp:DataList ID="dtCarrinho" runat="server" DataKeyField="id_prod" DataSourceID="sqlExibir" OnDeleteCommand="dtCarrinho_DeleteCommand" RepeatColumns="3" RepeatDirection="Horizontal" CssClass="dlProd" CellPadding="4">
            <ItemTemplate>
                <asp:ImageButton ID="excluir" src="imgs/icons/x.png" runat="server" Width="20px" ImageAlign="Right" CommandName="delete"/>
                <br />
                <asp:Image ID="Image1" runat="server" Width="350px" ImageUrl='<%# "~\\imgs\\produtos\\" + Eval("imagem", "{0}") %>' />
                <br />
                <asp:Label ID="id_prodLabel" Visible="false" runat="server" Text='<%# Eval("id_prod") %>' />
                <p>Quantidade de itens: <asp:Label ID="lblQtdItens" runat="server" Text='<%# Eval("qt_itens") %>'></asp:Label></p>
                <p>Preço unitário: <asp:Label ID="lblPrecoProd" runat="server" Text='<%# Eval("preco_prod") %>' /></p>
                <br />
                <asp:HyperLink ID="linkMaisInfo" runat="server" text="Mais Informações" CssClass="link" NavigateUrl='<%# Eval("id_prod", "detalhesProd.aspx?id_prod={0}") %>'></asp:HyperLink>         
            </ItemTemplate>
        </asp:DataList>
        <asp:SqlDataSource ID="sqlExibir" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT itens_pedido.id_prod, itens_pedido.qt_itens, itens_pedido.total_item, produto.preco_prod, produto.imagem, itens_pedido.id_pedido FROM itens_pedido INNER JOIN produto ON itens_pedido.id_prod = produto.id_prod WHERE (itens_pedido.id_pedido = @IDPEDIDO)">
            <SelectParameters>
                <asp:SessionParameter Name="IDPEDIDO" SessionField="idPedido" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlTotal" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT SUM(total_item) AS total FROM itens_pedido WHERE (id_pedido = @IDPEDIDO)">
            <SelectParameters>
                <asp:SessionParameter Name="IDPEDIDO" SessionField="idPedido" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlExcluir" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" DeleteCommand="DELETE FROM itens_pedido WHERE (id_prod = @IDPROD) AND (id_pedido = @IDPEDIDO)" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [itens_pedido]">
            <DeleteParameters>
                <asp:Parameter Name="IDPROD" />
                <asp:SessionParameter Name="IDPEDIDO" SessionField="idPedido" />
            </DeleteParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlCancelar" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" DeleteCommand="DELETE FROM pedido WHERE (id_pedido = @IDPEDIDO)" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [pedido]">
            <DeleteParameters>
                <asp:SessionParameter Name="IDPEDIDO" SessionField="idPedido" />
            </DeleteParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlComprar" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [pedido]" UpdateCommand="UPDATE pedido SET preco_compra = @TOTAL WHERE (id_pedido = @IDPEDIDO)">
            <UpdateParameters>
                <asp:SessionParameter Name="IDPEDIDO" SessionField="idPedido" />
                <asp:Parameter Name="TOTAL" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>

