<%@ Page Title="" Language="C#" MasterPageFile="~/mPage.master" AutoEventWireup="true" CodeFile="~/cs/finalizarCompra.aspx.cs" Inherits="finalizarCompra" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="divProg">
        <br />
        <br />
        <h1 class="h1M">Finalizar Compra</h1>
        <br />
        <p>Data de Entrega *:</p>
        <asp:TextBox ID="txtData" placeholder="EX: 01/01/2019" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <asp:RequiredFieldValidator CssClass="rfv" ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtData" ErrorMessage="O campo é obrigatório."></asp:RequiredFieldValidator>        
        <p>Horário de Entrega *:</p>
        <asp:TextBox ID="txtHorario" placeholder="EX: 10:00" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <asp:RequiredFieldValidator CssClass="rfv" ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtHorario" ErrorMessage="O campo é obrigatório."></asp:RequiredFieldValidator>        
        <p>Comentário:</p>
        <asp:TextBox ID="txtComentario" placeholder="Comentário" runat="server" CssClass="txt" TextMode="MultiLine" Rows="5" style="resize:none;"></asp:TextBox>
        <br />
        <p>CEP de Entrega *:</p>
        <asp:TextBox ID="txtCEP" placeholder="EX: 11.111-111" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <asp:RequiredFieldValidator CssClass="rfv" ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtCEP" ErrorMessage="O campo é obrigatório."></asp:RequiredFieldValidator>        
        <p>Número *:</p>
        <asp:TextBox ID="txtNum" placeholder="EX: 111" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <asp:RequiredFieldValidator CssClass="rfv" ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtNum" ErrorMessage="O campo é obrigatório."></asp:RequiredFieldValidator>        
        <p>Complemento</p>
        <asp:TextBox ID="txtComp" placeholder="EX: Casa" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <p>Forma de pagamento:</p>
        <asp:DropDownList ID="ddlPagamento" runat="server" CssClass="ddl" DataSourceID="sqlPag" DataTextField="nome_pag" DataValueField="id_pag"></asp:DropDownList>
        <asp:SqlDataSource ID="sqlPag" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM pagamento"></asp:SqlDataSource>
        <br />
        <br />
        <asp:Button ID="btnVoltar" runat="server" Text="VOLTAR" CssClass="btn" OnClick="btnVoltar_Click" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnFinalizar" runat="server" Text="FINALIZAR" CssClass="btn" OnClick="btnFinalizar_Click" />
        <br />
        <br />
        <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
        <asp:SqlDataSource ID="sqlEndereco" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" InsertCommand="INSERT INTO endereco(id_cli, cep_end, num_end, compl_end) VALUES (@IDCLI, @CEP, @NUM, @COMPL)" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT MAX(id_end) AS end FROM endereco">
            <InsertParameters>
                <asp:SessionParameter Name="IDCLI" SessionField="idCli" />
                <asp:ControlParameter ControlID="txtCEP" Name="CEP" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtNum" Name="NUM" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtComp" Name="COMPL" PropertyName="Text" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlComprar" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [pedido]" UpdateCommand="UPDATE pedido SET id_end = @END, id_pag = @IDPAG, data_pedido = @DATA, dataEntrega_pedido = @DATAENTREGA, horarioEntrega_pedido = @HORARIO, comentario_pedido = @COMENTARIO, estagio_pedido = 'A fazer' WHERE (id_pedido = @IDPED)">
            <UpdateParameters>
                <asp:Parameter Name="END" />
                <asp:ControlParameter ControlID="ddlPagamento" Name="IDPAG" PropertyName="SelectedValue" />
                <asp:Parameter Name="DATA" />
                <asp:Parameter Name="DATAENTREGA" />
                <asp:Parameter Name="HORARIO" />
                <asp:ControlParameter ControlID="txtComentario" Name="COMENTARIO" PropertyName="Text" />
                <asp:SessionParameter Name="IDPED" SessionField="idPedido" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>

