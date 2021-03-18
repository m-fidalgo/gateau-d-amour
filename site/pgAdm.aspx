<%@ Page Title="" Language="C#" MasterPageFile="~/mPageAdm.master" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeFile="~/cs/pgAdm.aspx.cs" Inherits="pgAdm" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
   <style>
       #prod{
            width: 30%;
            float: left;
            margin-left: 17%;
            margin-right: 2%;
            text-align: center;
            padding: 5px;
            
        }

       #faturamento{
            width: 30%;
            float: right;
            margin-left: 2%;
            margin-right: 17%;
            text-align: center;
            padding: 5px;
       }

       #receitas{
           width: 100%;
       }

       @media screen and (max-width: 1150px){
           #prod{
                width: 100%;  
                margin-left: 0%;
                margin-right: 0%;
                float: left;
            }

           #faturamento{
                width: 100%; 
                margin-left: 0%;
                margin-right: 0%;
                float: left;
            }
       }

   </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="divProg">
        <h1 class="h1M">Bem vindo(a), ADM</h1>
        <br />
        <asp:Button ID="btnSair" runat="server" Text="SAIR" CssClass="btn" OnClick="btnSair_Click" UseSubmitBehavior="false"/>
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        <asp:Button ID="btnCadastrar" runat="server" Text="CADASTRAR" CssClass="btn" OnClick="btnCadastrar_Click" />
        <br />
        <br />
        <br />        
        <div id="prod">
            <h1>Produtos vendidos</h1>
            <p>No ano: <asp:Label ID="lblTotalProdAno" runat="server"></asp:Label></p>
            <p>No mês (atual): <asp:Label ID="lblTotalProdMes" runat="server"></asp:Label></p>
        </div>
       
        <div id="faturamento">
            <h1>Faturamento</h1>
            <p>No ano: <asp:Label ID="lblFaturamentoAno" runat="server"></asp:Label></p>
            <p>No mês (atual): <asp:Label ID="lblFaturamentoMes" runat="server"></asp:Label></p>
        </div>
        
        <div id="receitas">
            <br />
            <br />
            <h1>Receitas</h1>
            <br />
            <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
            <br />
            <asp:DataList ID="dlReceitas" runat="server" DataKeyField="id_receita" RepeatColumns="2" RepeatDirection="Horizontal" CssClass="dlProd" CellPadding="4" OnDeleteCommand="dlReceitas_DeleteCommand" OnUpdateCommand="dlReceitas_UpdateCommand" DataSourceID="sqlExibir" >
                <ItemTemplate>
                    <asp:Image ID="Image1" runat="server" Width="80%" ImageUrl='<%# Eval("imagem_receita", "{0}") %>' />
                    <br />
                    <asp:Label ID="id_receitaLabel" Visible="false" runat="server" Text='<%# Eval("id_receita") %>' />
                    <h1><asp:Label ID="titulo_receitaLabel" runat="server" Text='<%# Eval("titulo_receita") %>' /></h1>
                    <h2>Ingredientes</h2>
                    <p><asp:Label ID="ingredientes_receitaLabel" runat="server" Text='<%# ((string)Eval("ingredientes_receita")).Replace("\n","<br />") %>' /></p>
                    <br />
                    <h2>Modo de Preparo:</h2>
                    <p><asp:Label ID="modo_receitaLabel" runat="server" Text='<%# ((string)Eval("modo_receita")).Replace("\n","<br />") %>' /></p>
                    <br />
                    <asp:Button ID="btnPublicar" runat="server" Text="PUBLICAR" CssClass="btn" CommandName="update" />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                    <asp:Button ID="btnExcluir" runat="server" Text="EXCLUIR" CssClass="btn" CommandName="delete" />
                </ItemTemplate>
            </asp:DataList>  
        </div>
         
        <asp:SqlDataSource ID="sqlExibir" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT id_receita, id_cli, titulo_receita, ingredientes_receita, modo_receita, status_receita, imagem_receita FROM receitas WHERE (status_receita = 'Analisar')"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlExcluir" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" DeleteCommand="DELETE FROM receitas WHERE (id_receita = @ID)" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [receitas]" UpdateCommand="UPDATE receitas SET status_receita = 'Publicado' WHERE (id_receita = @ID)">
            <DeleteParameters>
                <asp:Parameter Name="ID" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="ID" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlTotalProdAno" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT SUM(itens_pedido.qt_itens) AS somaProdAno FROM pedido INNER JOIN itens_pedido ON pedido.id_pedido = itens_pedido.id_pedido WHERE pedido.estagio_pedido = 'Entregue' and year(dataEntrega_pedido) = year(curdate())"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlTotalProdMes" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT SUM(itens_pedido.qt_itens) AS somaProdMes FROM pedido INNER JOIN itens_pedido ON pedido.id_pedido = itens_pedido.id_pedido WHERE (pedido.estagio_pedido = 'Entregue') AND (MONTH(pedido.dataEntrega_pedido) = MONTH(CURDATE()))" ></asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlFaturAno" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT SUM(preco_compra) AS faturAno FROM pedido WHERE (estagio_pedido = 'Entregue') AND (YEAR(dataEntrega_pedido) = YEAR(CURDATE()))"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlFaturMes" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT SUM(preco_compra) AS faturMes FROM pedido WHERE (estagio_pedido = 'Entregue') AND (MONTH(dataEntrega_pedido) = MONTH(CURDATE()))"></asp:SqlDataSource>
    </div>
</asp:Content>

