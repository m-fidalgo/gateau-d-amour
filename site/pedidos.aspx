<%@ Page Title="" Language="C#" MasterPageFile="~/mPageAdm.master" AutoEventWireup="true" CodeFile="~/cs/pedidos.aspx.cs" Inherits="pedidos" EnableEventValidation="false" %>

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
       
        <h1 class="h1M">Pedidos</h1>
        <asp:GridView ID="gvPedidosAdm" runat="server" CssClass="gv" CellPadding="3" GridLines="None" BackColor="#FFC3D0" CellSpacing="1" AutoGenerateColumns="False" DataSourceID="sqlPedidos" DataKeyNames="id_pedido" OnSelectedIndexChanged="gvPedidosAdm_SelectedIndexChanged" OnRowDataBound = "gvPedidosAdm_RowDataBound" >
            
            <Columns>
                <asp:TemplateField HeaderText="Marcar: Entregue">
                    <ItemTemplate>
                        <asp:CheckBox ID="chk" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="id_pedido" HeaderText="Código" InsertVisible="False" ReadOnly="True" SortExpression="id_pedido" />
                <asp:BoundField DataField="nome_cli" HeaderText="Nome" SortExpression="nome_cli" />
                <asp:BoundField DataField="data_pedido" HeaderText="Data" SortExpression="data_pedido" DataFormatString="{0:d}" />
                <asp:BoundField DataField="dataEntrega_pedido" DataFormatString="{0:d}" HeaderText="Data de Entrega" SortExpression="dataEntrega_pedido" />
                <asp:BoundField DataField="estagio_pedido" HeaderText="Estágio" SortExpression="estagio_pedido" />
            </Columns>
            
            <HeaderStyle ForeColor="#4D2100" Font-Names="amatic sc" BackColor="White" />
            <RowStyle BackColor="White" />
        </asp:GridView>  

        <br />
        <asp:SqlDataSource ID="sqlPedidos" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT pedido.data_pedido, pedido.dataEntrega_pedido, pedido.estagio_pedido, pedido.id_pedido, cliente.nome_cli FROM pedido INNER JOIN endereco ON pedido.id_end = endereco.id_end INNER JOIN cliente ON endereco.id_cli = cliente.id_cli WHERE (pedido.estagio_pedido = 'A fazer') OR (pedido.estagio_pedido = 'Em andamento') ORDER BY pedido.dataEntrega_pedido" UpdateCommand="UPDATE pedido SET estagio_pedido = 'Entregue' WHERE (id_pedido = @ID)">
            <UpdateParameters>
                <asp:Parameter Name="ID" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <br />


     </div>
</asp:Content>

