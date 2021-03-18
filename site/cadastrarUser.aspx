<%@ Page Title="" Language="C#" MasterPageFile="~/mPage.master" AutoEventWireup="true"  MaintainScrollPositionOnPostback="true" CodeFile="~/cs/cadastrarUser.aspx.cs" Inherits="cadastrarUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .panel{
            width: 63%;
            float: right;
        }

        @media screen and (max-width: 810px){
            .panel{
                width: 75%;
            }
        }

        @media screen and (max-width: 510px){
            .panel{
                width: 100%;
            }
        }

    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="divProg">
        <br />
        <h1 class="h1M">Cadastre-se</h1>
        <br />
        <p>Nome *</p>
        <asp:TextBox ID="txtNome" placeholder="EX: Maria" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <asp:RequiredFieldValidator CssClass="rfv" ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtNome" ErrorMessage="O campo &quot;nome&quot; é obrigatório."></asp:RequiredFieldValidator>
        <p>Sobrenome *</p>
        <asp:TextBox ID="txtSobrenome" placeholder="EX: Oliveira" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <asp:RequiredFieldValidator CssClass="rfv" ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtSobrenome" ErrorMessage="O campo &quot;sobrenome&quot; é obrigatório."></asp:RequiredFieldValidator>
        <p>Email *</p>
        <asp:TextBox ID="txtEmail" placeholder="EX: exemplo@gmail.com" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <asp:RequiredFieldValidator CssClass="rfv" ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtEmail" ErrorMessage="O campo &quot;email&quot; é obrigatório."></asp:RequiredFieldValidator>
        <p>Data de Nascimento *</p>
        <asp:TextBox ID="txtDataNasc" ClientIDMode="Static" placeholder="EX: 01/01/1990" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <asp:RequiredFieldValidator CssClass="rfv" ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtDataNasc" ErrorMessage="O campo &quot;data de nascimento&quot; é obrigatório."></asp:RequiredFieldValidator>
        <p>Telefone 1 *</p>
        <asp:TextBox ID="txtTel1" placeholder="EX: (12) 99999-9999" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <asp:RequiredFieldValidator CssClass="rfv" ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtTel1" ErrorMessage="O campo &quot;telefone&quot; é obrigatório."></asp:RequiredFieldValidator>
        <p>Telefone 2:</p>
        <asp:TextBox ID="txtTel2" placeholder="EX: (12) 99999-9999" runat="server" CssClass="txt"></asp:TextBox>
        <br />        
        <p>CPF *</p>
        <asp:TextBox ID="txtCPF" placeholder="EX: 555.555.555-55" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <asp:RequiredFieldValidator CssClass="rfv" ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtCPF" ErrorMessage="O campo &quot;CPF&quot; é obrigatório."></asp:RequiredFieldValidator>
        <p>RG *</p>
        <asp:TextBox ID="txtRG" placeholder="EX: 55.555.555-5" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <asp:RequiredFieldValidator CssClass="rfv" ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtRG" ErrorMessage="O campo &quot;RG&quot; é obrigatório."></asp:RequiredFieldValidator>        
        <p>Qual foi o nome do seu primeiro animal de estimação?</p>
        <asp:TextBox ID="txtResp" placeholder="EX: Totó" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <asp:RequiredFieldValidator CssClass="rfv" ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtResp" ErrorMessage="O campo &quot;resposta&quot; é obrigatório."></asp:RequiredFieldValidator>
        <br />
        <br />
        <asp:Button ID="btnCadastrar" runat="server" Text="CADASTRAR" CssClass="btn" OnClick="btnCadastrar_Click" />
        <br />
        <br />
        <%@ Register Assembly="GoogleReCaptcha" Namespace="GoogleReCaptcha" TagPrefix="cc1" %>
        <script src='https://www.google.com/recaptcha/api.js?hl=pt-BR'></script>

        <asp:Panel ID="Panel1" runat="server" CssClass="panel" HorizontalAlign="Center" >

        </asp:Panel>
        <br />
        <br />
        <br />
        <asp:SqlDataSource ID="sqlCadastrarUser" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" InsertCommand="INSERT INTO cliente(nome_cli, sobrenome_cli, dataNasc_cli, tel1_cli, tel2_cli, email_cli, senha_cli, cpf_cli, rg_cli, tipo_cli, resposta_cli, login_cli) VALUES (@NOME, @SOBRENOME, @DATA, @TEL1, @TEL2, @EMAIL, @SENHA, @CPF, @RG, '&quot;cli&quot;', @RESP, '1')" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT id_cli, nome_cli, sobrenome_cli, dataNasc_cli, tel1_cli, tel2_cli, email_cli, senha_cli, cpf_cli, rg_cli, tipo_cli FROM cliente WHERE (email_cli = @EMAIL)">
            <InsertParameters>
                <asp:ControlParameter ControlID="txtNome" Name="NOME" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtSobrenome" Name="SOBRENOME" PropertyName="Text" />
                <asp:Parameter Name="DATA" />
                <asp:ControlParameter ControlID="txtTel1" Name="TEL1" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtTel2" Name="TEL2" PropertyName="Text" />
                <asp:Parameter Name="EMAIL" />
                <asp:Parameter Name="SENHA" />
                <asp:Parameter Name="CPF" />
                <asp:Parameter Name="RG" />
                <asp:ControlParameter ControlID="txtResp" Name="RESP" PropertyName="Text" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="txtEmail" Name="EMAIL" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
        
        <asp:Label ID="lblErro" runat="server"></asp:Label>
        <br />
        <br />
    </div>
</asp:Content>

