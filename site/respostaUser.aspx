<%@ Page Title="" Language="C#" MasterPageFile="~/mPage.master" AutoEventWireup="true" CodeFile="~/cs/respostaUser.aspx.cs" Inherits="respostaUser" %>

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
        <br /> 
        <br />
        <br /> 
        <p>Qual foi o nome do seu primeiro animal de estimação?</p>
        <asp:TextBox ID="txtResp" placeholder="Digite aqui sua resposta para a pergunta de segurança" runat="server" CssClass="txt"></asp:TextBox> 
        <br />
        <br />
        <asp:Label ID="lblErro" runat="server" Text=""></asp:Label>
        <br />
        <br />
        <asp:Button ID="btn" runat="server" Text="LOGIN" CssClass="btn" OnClick="btn_Click" />
        <br />
        <asp:SqlDataSource ID="sqlResp" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT id_cli, resposta_cli, login_cli FROM cliente WHERE (id_cli = @ID) AND (resposta_cli = @RESP)">
            <SelectParameters>
                <asp:SessionParameter Name="ID" SessionField="idCli" />
                <asp:ControlParameter ControlID="txtResp" Name="RESP" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
    </div>
</asp:Content>

