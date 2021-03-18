<%@ Page Title="" Language="C#" MasterPageFile="~/mPageAdm.master" AutoEventWireup="true"  MaintainScrollPositionOnPostback="true" CodeFile="~/cs/detalhesPedido.aspx.cs" Inherits="detalhesPedido" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        #divEsquerda{
            float: left;
            width: 40%;
            margin-left: 10%;
            text-align: center;
        }

        #divDireita{
            float: right;
            width: 40%;
            margin-right: 10%;
            text-align: center;
        }

        #divDetalhes{
            width: 100%;
        }

        #divProds{
            width: 100%;
            text-align: center;
        }

        @media (max-width: 700px){
             #divEsquerda{
                 margin-left: 6%;
            }

            #divDireita{
                margin-right: 6%;
            }
        }

        @media screen and (max-width: 400px){
            #divEsquerda{
                width: 90%;
                margin-left: 10%;
                text-align: left;
            }

            #divDireita{
                width: 90%;
                margin-left: 10%;
                margin-right: 0;
                text-align: left;
            }

            #brSumir{
                display: none;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="divProg">
        <h1 class="h1M">Detalhes do Pedido</h1>
        <br />
        <asp:SqlDataSource ID="sqlPedido" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT pedido.id_pedido, pedido.data_pedido, pedido.dataEntrega_pedido, pedido.horarioEntrega_pedido, pedido.estagio_pedido, pedido.comentario_pedido, pedido.preco_compra, pagamento.nome_pag, endereco.cep_end, endereco.num_end, endereco.compl_end, cliente.nome_cli, cliente.sobrenome_cli, cliente.dataNasc_cli, cliente.tel1_cli, cliente.tel2_cli, cliente.email_cli FROM pedido INNER JOIN pagamento ON pedido.id_pag = pagamento.id_pag INNER JOIN endereco ON pedido.id_end = endereco.id_end INNER JOIN cliente ON endereco.id_cli = cliente.id_cli WHERE (pedido.id_pedido = @ID)">
            <SelectParameters>
                <asp:SessionParameter Name="ID" SessionField="idPedido" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    <div id="divDetalhes">
        <div id="divEsquerda">
            <h1>Cliente</h1>
            <p>Nome: <asp:Label ID="lblCliNome" runat="server" Text=""></asp:Label></p>
            <p>Sobrenome: <asp:Label ID="lblCliSobrenome" runat="server" Text=""></asp:Label></p>
            <p>Email: <asp:Label ID="lblCliEmail" runat="server" Text=""></asp:Label></p>
            <p>Telefone 1: <asp:Label ID="lblCliTel1" runat="server" Text=""></asp:Label></p>
            <p>Telefone 2: <asp:Label ID="lblCliTel2" runat="server" Text=""></asp:Label></p>
      
            <h1>Endereço de Entrega</h1>
            <p>Cidade: <asp:Label ID="lblEndCidade" runat="server" Text=""></asp:Label></p>  
            <p>Rua: <asp:Label ID="lblEndRua" runat="server" Text=""></asp:Label></p>  
            <p>Número: <asp:Label ID="lblEndNum" runat="server" Text=""></asp:Label></p>  
            <p>Complemento: <asp:Label ID="lblEndComp" runat="server" Text=""></asp:Label></p>  
            <br id="brSumir"/>
            <br />
        </div>
        <div id="divDireita">
            <br />
            <br />
            <p><h1>Pedido</h1></p>
            <p>Comentário do Pedido <asp:Label ID="lblComentario" runat="server" Text=""></asp:Label></p>
            <p>Estágio: <asp:Label ID="lblEstagio" runat="server" Text=""></asp:Label></p>
            <p>Data do Pedido: <asp:Label ID="lblDataPedido" runat="server" Text=""></asp:Label></p>
            <p>Data de Entrega: <asp:Label ID="lblDataEntrega" runat="server" Text=""></asp:Label></p>
            <p>Horário de Entrega: <asp:Label ID="lblHorarioEntrega" runat="server" Text=""></asp:Label></p>
            <p>Total: R$<asp:Label ID="lblTotal" runat="server" Text=""></asp:Label></p>
            <p>Pagamento: <asp:Label ID="lblPag" runat="server" Text=""></asp:Label></p>
            <br id="brSumir"/>
            <br />
        </div>    
    </div>
    
    <div id="divProds">
        <br />
        <br />
        <br />        
        <asp:DataList ID="dlProd" runat="server" DataKeyField="id_prod" CssClass="dlProd" RepeatColumns="3" RepeatDirection="Horizontal">
            <FooterTemplate>
                <asp:LinkButton ID="btnAnterior" runat="server" OnClick="btnAnterior_Click" CssClass="links">&lt;&lt;</asp:LinkButton>
                &nbsp;&nbsp;
                <asp:LinkButton ID="btnProx" runat="server" OnClick="btnProx_Click" CssClass="links">&gt;&gt;</asp:LinkButton>
            </FooterTemplate>
            <ItemTemplate>
                <asp:Image ID="Image1" runat="server" ImageUrl='<%# "~\\imgs\\produtos\\" + Eval("imagem", "{0}") %>' Width="350px" />
                <br />
                <asp:Label ID="id_prodLabel" runat="server" Text='<%# Eval("id_prod") %>' Visible="false" />
                <p>Quantidade de itens: <asp:Label ID="lblQtdItens" runat="server" Text='<%# Eval("qt_itens") %>'></asp:Label></p>
                <p>Preço unitário: <asp:Label ID="lblPrecoProd" runat="server" Text='<%# Eval("preco_prod") %>' /></p>
                <br />
                <asp:HyperLink ID="linkMaisInfo" runat="server" CssClass="link" NavigateUrl='<%# Eval("id_prod", "detalhesProd.aspx?id_prod={0}") %>' text="Mais Informações"></asp:HyperLink>
                <br />
                <br />
            </ItemTemplate>
        </asp:DataList>
        <br />
        <br />
    </div>
        
        <asp:SqlDataSource ID="sqlExibir" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT itens_pedido.id_prod, itens_pedido.qt_itens, itens_pedido.total_item, produto.preco_prod, produto.imagem, itens_pedido.id_pedido FROM itens_pedido INNER JOIN produto ON itens_pedido.id_prod = produto.id_prod WHERE (itens_pedido.id_pedido = @IDPEDIDO)">
            <SelectParameters>
                <asp:SessionParameter Name="IDPEDIDO" SessionField="idPedido" />
            </SelectParameters>
        </asp:SqlDataSource>
    
</asp:Content>

