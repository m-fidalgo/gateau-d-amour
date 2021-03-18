<%@ Page Title="" Language="C#" MasterPageFile="~/mPage.master" AutoEventWireup="true" CodeFile="~/cs/detalhesProd.aspx.cs" Inherits="detalhesProd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        #esquerda{
            float: left;
            width: 45%;
            text-align: center;
            position: fixed;
            height: calc(100% - 102px);
        }

        #direita{
            float: right;
            width: 45%;
            padding-left: 20px;    
        }

        #direitaE{
            width: 50%;
            float: left;
        }

        #direitaD{
            width: 50%;
            float: right;
        }

        @media screen and (max-width: 800px){
            #direitaE{
                width: 100%;
            }

            #direitaD{
                width: 100%;
            }

            #brSumir{
                display: none;
            }
        }

        @media screen and (max-width: 500px){
            #esquerda{
                position: static;
                width: 100%;
                padding-left: 0px;
            }

            #direita{
                width: 100%;
                text-align: center;
                margin-left: 0px; 
            }

        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">        
        <asp:SqlDataSource ID="sqlExibir" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT produto.nome_prod, produto.preco_prod, produto.camadas_bolo, produto.andares_bolo, produto.imagem, massa.nome_massa, cor.nome_cor, cor_1.nome_cor AS corCobertura, cobertura.nome_cobertura, cor_2.nome_cor AS corDecor, sabor.desc_sabor, recheio.nome_recheio, decoracao.descr_decor, genero.nome_genero, tamanho.descr_tamanho, formato.descr_formato, tamanho.medidas_tamanho, tamanho.id_cat, produto.id_prod FROM produto INNER JOIN cor_massa ON produto.id_prod = cor_massa.id_prod INNER JOIN cor ON cor_massa.id_cor = cor.id_cor INNER JOIN massa ON cor_massa.id_massa = massa.id_massa INNER JOIN cor_cobertura ON produto.id_prod = cor_cobertura.id_prod INNER JOIN cor cor_1 ON cor_cobertura.id_cor = cor_1.id_cor INNER JOIN cobertura ON cor_cobertura.id_cobertura = cobertura.id_cobertura INNER JOIN cor_decoracao ON produto.id_prod = cor_decoracao.id_prod INNER JOIN cor cor_2 ON cor_decoracao.id_cor = cor_2.id_cor INNER JOIN decoracao ON cor_decoracao.id_decor = decoracao.id_decor INNER JOIN sabor_recheio ON produto.id_prod = sabor_recheio.id_prod INNER JOIN sabor ON sabor_recheio.id_sabor = sabor.id_sabor INNER JOIN recheio ON sabor_recheio.id_recheio = recheio.id_recheio INNER JOIN gen_prod ON produto.id_prod = gen_prod.id_prod INNER JOIN genero ON gen_prod.id_genero = genero.id_genero INNER JOIN tamanho ON produto.id_tamanho = tamanho.id_tamanho INNER JOIN formato ON tamanho.id_formato = formato.id_formato WHERE (produto.id_prod = @ID)">
            <SelectParameters>
                <asp:QueryStringParameter Name="ID" QueryStringField="id_prod" />
            </SelectParameters>
        </asp:SqlDataSource>
        <div id="esquerda">
            <br />
            <asp:Image ID="imgProd" runat="server" width="90%"/>
            <h1><asp:Label ID="lblNome" runat="server" Text=""></asp:Label> - R$<asp:Label ID="lblPreco" runat="server" Text=""></asp:Label></h1>
            <br />
            <asp:Button ID="btnComprar" runat="server" class="btn" Text="COMPRAR" OnClick="btnComprar_Click" />
            <br />
            <br />
            <asp:SqlDataSource ID="sqlInserirVenda" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" InsertCommand="INSERT INTO pedido(id_end, id_pag, data_pedido, dataEntrega_pedido, horarioEntrega_pedido, preco_compra) VALUES (1, 1, @DATA, @DATA, '00:00', 0)" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT max(id_pedido) as idPedido FROM pedido">
                <InsertParameters>
                    <asp:Parameter Name="DATA" />
                </InsertParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sqlInserirItens" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" InsertCommand="INSERT INTO itens_pedido(id_prod, id_pedido, qt_itens, total_item) VALUES (@IDPROD, @IDPEDIDO, @QTDITENS, @TOTAL)" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [itens_pedido]" UpdateCommand="UPDATE itens_pedido SET qt_itens = @QTD, total_item = @TOTAL WHERE (id_prod = @IDPROD) AND (id_pedido = @IDPEDIDO)">
                <InsertParameters>
                    <asp:QueryStringParameter Name="IDPROD" QueryStringField="id_prod" />
                    <asp:SessionParameter Name="IDPEDIDO" SessionField="idPedido" />
                    <asp:ControlParameter ControlID="txtQtd" Name="QTDITENS" PropertyName="Text" />
                    <asp:Parameter Name="TOTAL" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:QueryStringParameter Name="IDPROD" QueryStringField="id_prod" />
                    <asp:SessionParameter Name="IDPEDIDO" SessionField="idPedido" />
                    <asp:ControlParameter ControlID="txtQtd" Name="QTD" PropertyName="Text" />
                    <asp:Parameter Name="TOTAL" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
            <br />
            <br />
            <br />
        </div>
        <br />
        <div id="direita">
            <div id="direitaE">
                <br id="brSumir"/>
                <h2>Massa: </h2>
                    <p>Sabor: <asp:Label ID="lblMassa" runat="server" Text=""></asp:Label></p>
                    <p>Cor: <asp:Label ID="lblMassaCor" runat="server" Text=""></asp:Label></p>
                <h2>Recheio: </h2>
                    <p>Tipo: <asp:Label ID="lblRecheio" runat="server" Text=""></asp:Label></p>
                    <p>Sabor: <asp:Label ID="lblRecheioSabor" runat="server" Text=""></asp:Label></p>
                <h2>Cobertura: </h2>
                    <p>Sabor: <asp:Label ID="lblCobertura" runat="server" Text=""></asp:Label></p>
                    <p>Cor: <asp:Label ID="lblCoberturaCor" runat="server" Text=""></asp:Label></p>
                <h2>Decoração: </h2>
                    <p>Tipo: <asp:Label ID="lblDecor" runat="server" Text=""></asp:Label></p>
                    <p>Cor: <asp:Label ID="lblDecorCor" runat="server" Text=""></asp:Label></p>
                <br id="brSumir"/>
                <br id="brSumir"/>
                <br id="brSumir"/>
            </div>
            <div id="direitaD">
                <br id="brSumir"/>
                <br id="brSumir"/>
                <br id="brSumir"/>
                <h2>Geral</h2>
                <p>Tipo: <asp:Label ID="lblGenero" runat="server" Text=""></asp:Label></p>
                <p>Formato: <asp:Label ID="lblProdFormato" runat="server" Text=""></asp:Label></p>
                <p>Tamanho: <asp:Label ID="lblProdTamanho" runat="server" Text=""></asp:Label></p>
                <p><asp:Label ID="lblDesaparecer1" runat="server" Text="Medidas: "> <asp:Label ID="lblProdMedidas" runat="server" Text=""></asp:Label></asp:Label></p>
                <p><asp:Label ID="lblDesaparecer2" runat="server" Text="Camadas: "> <asp:Label ID="lblProdCamadas" runat="server" Text=""></asp:Label></asp:Label></p>
                <p><asp:Label ID="lblDesaparecer3" runat="server" Text="Andares: "> <asp:Label ID="lblProdAndares" runat="server" Text=""></asp:Label></asp:Label></p>
                <br />
                <p>Quantidade desejada *:</p>
                <asp:TextBox ID="txtQtd" placeholder="EX: 2" runat="server" CssClass="txt"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtQtd" ErrorMessage="Digite a quantidade desejada" CssClass="rfv"></asp:RequiredFieldValidator>
                <br />
                <p><asp:Label ID="lblErro" runat="server" Text=""></asp:Label></p>
                <br />
                <br />
                <br />
                
            </div>
        </div>   
    
</asp:Content>

