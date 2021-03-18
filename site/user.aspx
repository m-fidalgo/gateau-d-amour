<%@ Page Title="" Language="C#" MasterPageFile="~/mPage.master" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeFile="~/cs/user.aspx.cs" Inherits="user"EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="divProg">
        <h1 class="h1M">Bem vindo(a), <asp:Label ID="lblNomeUser" runat="server" Text=""></asp:Label></h1>
        <br />
        <asp:Button ID="btnAlterar" runat="server" Text="EDITAR PERFIL" CssClass="btn" OnClick="btnAlterar_Click" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      
        <asp:Button ID="btnSair" runat="server" Text="SAIR" CssClass="btn" OnClick="btnSair_Click" />
        <br />
        <br />
        <h1>Sua Festa</h1>
        <h2>Tipo de Bolo</h2>
        <p> Descubra qual é o melhor tipo de bolo para sua festa, dependendo do número de pessoas.</p>
        <asp:TextBox ID="txtNum" placeholder="EX: 20" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="btnOK" runat="server" Text="OK" CssClass="btn" OnClick="btnOK_Click" />
        <br />
        <br />
        <asp:Label ID="lblResp" runat="server" Text=""></asp:Label>
        <br />
        <br />
        <h2>Cores</h2>
        <p>Descubra qual a paleta de cores ideal para sua festa, dependendo do tema.</p>
        <asp:DropDownList ID="ddlGenero" runat="server" CssClass="ddl" DataSourceID="sqlGenero" DataTextField="nome_genero" DataValueField="id_genero"></asp:DropDownList>
        <br />
        <br />
        <asp:Button ID="btnOK2" runat="server" Text="OK" CssClass="btn" OnClick="btnOK2_Click" />
        <br />
        <br />
        <asp:Label ID="lblResp2" runat="server" Text=""></asp:Label>
        <br />
        <br />
        <asp:SqlDataSource ID="sqlGenero" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM genero"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlGeneroEsc" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT id_genero, nome_genero FROM genero WHERE (id_genero = @GEN)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlGenero" Name="GEN" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <h1>Meus Pedidos</h1>
        <asp:GridView ID="gvPedidosUser" runat="server" CssClass="gv" CellPadding="3" GridLines="None" BackColor="#FFC3D0" CellSpacing="1" AutoGenerateColumns="False" DataSourceID="sqlPedidos" DataKeyNames="id_pedido" OnRowDataBound = "gvPedidosUser_RowDataBound" OnSelectedIndexChanged="gvPedidosUser_SelectedIndexChanged">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:CheckBox ID="chk" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="id_pedido" HeaderText="Código" SortExpression="id_pedido" InsertVisible="False" ReadOnly="True" />
                <asp:BoundField DataField="data_pedido" HeaderText="Data" SortExpression="data_pedido" DataFormatString="{0:d}" />
                <asp:BoundField DataField="dataEntrega_pedido" HeaderText="Data de Entrega" SortExpression="dataEntrega_pedido" DataFormatString="{0:d}" />
                <asp:BoundField DataField="preco_compra" HeaderText="Total" SortExpression="preco_compra" DataFormatString="{0:c}" />
                <asp:BoundField DataField="estagio_pedido" HeaderText="Estágio" SortExpression="estagio_pedido" />
            </Columns>
            <HeaderStyle ForeColor="#4D2100" Font-Names="amatic sc" BackColor="White"/>
            <RowStyle BackColor="White" />
        </asp:GridView>
        <br />
        <br />
        <asp:Button ID="btnCancelar" runat="server" Text="CANCELAR" CssClass="btn" OnClick="btnCancelar_Click" />
        <br />
        <br />
        <asp:Label ID="lblMsgPedidos" runat="server" Text=""></asp:Label>
        <br />
        <br />
        <asp:SqlDataSource ID="sqlPedidos" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT pedido.data_pedido, pedido.dataEntrega_pedido, pedido.estagio_pedido, pedido.preco_compra, pedido.id_pedido, endereco.id_cli FROM pedido INNER JOIN endereco ON pedido.id_end = endereco.id_end WHERE 
(endereco.id_cli = @ID) AND pedido.estagio_pedido IN ('A fazer','Em andamento')" DeleteCommand="DELETE FROM pedido WHERE (id_pedido = @ID)">
            <DeleteParameters>
                <asp:Parameter Name="ID" />
            </DeleteParameters>
            <SelectParameters>
                <asp:SessionParameter Name="ID" SessionField="idCli" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        
    </div>
</asp:Content>

