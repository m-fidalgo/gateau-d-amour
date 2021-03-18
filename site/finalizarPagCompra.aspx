<%@ Page Title="" Language="C#" MasterPageFile="~/mPage.master" AutoEventWireup="true" CodeFile="~/cs/finalizarPagCompra.aspx.cs" Inherits="finalizarPagCompra" %>

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
        <h1 class="h1M">Cartão</h1>
        <br />
        <p>Número do Cartão *</p>
        <asp:TextBox ID="txtNum" placeholder="EX: 0000.0000.0000.0000" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <asp:RequiredFieldValidator CssClass="rfv" ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtNum" ErrorMessage="O campo é obrigatório."></asp:RequiredFieldValidator>
        <p>Código de Segurança *</p>
        <asp:TextBox ID="txtCodSeg" placeholder="EX: 0000" runat="server" CssClass="txt" TextMode="Password"></asp:TextBox>
        <br />
        <asp:RequiredFieldValidator CssClass="rfv" ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtCodSeg" ErrorMessage="O campo é obrigatório."></asp:RequiredFieldValidator>
        <p>Bandeira *</p>
        <asp:TextBox ID="txtBandeira" placeholder="EX: Visa" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <asp:RequiredFieldValidator CssClass="rfv" ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtBandeira" ErrorMessage="O campo é obrigatório."></asp:RequiredFieldValidator>        
        <p>Nome do Titular *</p>
        <asp:TextBox ID="txtNome" placeholder="EX: Maria Oliveira" runat="server" CssClass="txt"></asp:TextBox>
        <br />   
        <asp:RequiredFieldValidator CssClass="rfv" ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtNome" ErrorMessage="O campo é obrigatório."></asp:RequiredFieldValidator>        
        <p>CPF do Titular *</p>
        <asp:TextBox ID="txtCPF" placeholder="EX: 555.555.555-55" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <asp:RequiredFieldValidator CssClass="rfv" ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtCPF" ErrorMessage="O campo é obrigatório."></asp:RequiredFieldValidator>        
        <p>Validade *</p>
        <asp:TextBox ID="txtValidade" placeholder="EX: 01/01/2020" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <asp:RequiredFieldValidator CssClass="rfv" ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtValidade" ErrorMessage="O campo é obrigatório."></asp:RequiredFieldValidator>        
        <br />
        <br />
        <asp:Button ID="btnFinalizar" runat="server" Text="FINALIZAR" CssClass="btn" OnClick="btnFinalizar_Click" />
        <asp:SqlDataSource ID="sqlCartao" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" InsertCommand="INSERT INTO cartao(id_cli, num_cartao, codSeg_cartao, nomeTit_cartao, bandeira_cartao, cpfTit_cartao, validade_cartao) VALUES (@IDCLI, @NUM, @COD, @NOME, @BAND, @CPF, @VAL)" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT MAX(id_cartao) AS cartao FROM cartao">
            <InsertParameters>
                <asp:SessionParameter Name="IDCLI" SessionField="idCli" />
                <asp:Parameter Name="NUM" />
                <asp:Parameter Name="NOME" />
                <asp:Parameter Name="COD" />
                <asp:ControlParameter ControlID="txtBandeira" Name="BAND" PropertyName="Text" />
                <asp:Parameter Name="CPF" />
                <asp:Parameter Name="VAL" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:Label ID="lblMsg" runat="server"></asp:Label>
        <br />
        <asp:SqlDataSource ID="sqlComprar" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [pedido]" UpdateCommand="UPDATE pedido SET id_cartao = @IDCARTAO WHERE (id_pedido = @IDPEDIDO)">
            <UpdateParameters>
                <asp:Parameter Name="IDCARTAO" />
                <asp:SessionParameter Name="IDPEDIDO" SessionField="idPedido" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>

