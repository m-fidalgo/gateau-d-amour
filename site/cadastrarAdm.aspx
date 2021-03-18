<%@ Page Title="" Language="C#" MasterPageFile="~/mPageAdm.master" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeFile="~/cs/cadastrarAdm.aspx.cs" Inherits="cadastrarAdm" %>

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
        <br />
        <h1 class="h1M">Cadastrar Administrador</h1>
        <p>Nome * </p>
        <asp:TextBox ID="txtNomeAdm" placeholder="EX: Maria" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <asp:RequiredFieldValidator CssClass="rfv" ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtNomeAdm" ErrorMessage="O campo &quot;nome&quot; é obrigatório."></asp:RequiredFieldValidator>
        <p>Sobrenome * </p>
        <asp:TextBox ID="txtSobrenomeAdm" placeholder="EX: Oliveira" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <asp:RequiredFieldValidator CssClass="rfv" ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtSobrenomeAdm" ErrorMessage="O campo &quot;sobrenome&quot; é obrigatório."></asp:RequiredFieldValidator>
        <p>Email * </p>
        <asp:TextBox ID="txtEmailAdm" placeholder="EX: exemplo@gmail.com" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <asp:RequiredFieldValidator CssClass="rfv" ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtEmailAdm" ErrorMessage="O campo &quot;email&quot; é obrigatório."></asp:RequiredFieldValidator>
        <p>Data de nascimento * </p>
        <asp:TextBox ID="txtDtNascAdm" placeholder="EX: 01/01/1990" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <asp:RequiredFieldValidator CssClass="rfv" ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtDtNascAdm" ErrorMessage="O campo &quot;data de nascimento&quot; é obrigatório."></asp:RequiredFieldValidator>
        <p>Telefone 1 * </p>
        <asp:TextBox ID="txtTelefoneAdm" placeholder="EX: (12) 99999-9999" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <asp:RequiredFieldValidator CssClass="rfv" ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtTelefoneAdm" ErrorMessage="O campo &quot;telefone&quot; é obrigatório."></asp:RequiredFieldValidator>
        <p>Telefone 2: </p>
        <asp:TextBox ID="txtTelefone2Adm" placeholder="EX: (12) 99999-9999" runat="server" CssClass="txt"></asp:TextBox>
        <br />        
        <p>CPF * </p>
        <asp:TextBox ID="txtCpfAdm" placeholder="EX: 555.555.555-55" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <asp:RequiredFieldValidator CssClass="rfv" ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtCpfAdm" ErrorMessage="O campo &quot;CPF&quot; é obrigatório."></asp:RequiredFieldValidator>
        <p>RG * </p>
        <asp:TextBox ID="txtRgAdm" placeholder="EX: 55.555.555-5" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <asp:RequiredFieldValidator CssClass="rfv" ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtRgAdm" ErrorMessage="O campo &quot;RG&quot; é obrigatório."></asp:RequiredFieldValidator>
        <p>Qual foi o nome do seu primeiro animal de estimação?</p>
        <asp:TextBox ID="txtResp" placeholder="EX: Totó" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <asp:RequiredFieldValidator CssClass="rfv" ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtResp" ErrorMessage="O campo &quot;resposta&quot; é obrigatório."></asp:RequiredFieldValidator>
        <br />
        <br />
        <asp:Button ID="btnCadastrarAdm" runat="server" CssClass="btn" OnClick="btnCadastrarAdm_Click" Text="Cadastrar" />
        <br />
        <br />
        <asp:Label ID="lblMensagem" runat="server"></asp:Label>
        <br />
        <br />
        <%@ Register Assembly="GoogleReCaptcha" Namespace="GoogleReCaptcha" TagPrefix="cc1" %>
        <script src='https://www.google.com/recaptcha/api.js?hl=pt-BR'></script>

        <asp:Panel ID="Panel1" runat="server" CssClass="panel" HorizontalAlign="Center" >

        </asp:Panel>
        <br />
        <br />
        <br />
        <asp:SqlDataSource ID="sqlCadastrarAdm" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" InsertCommand="INSERT INTO cliente(nome_cli, sobrenome_cli, tel1_cli, tel2_cli, email_cli, senha_cli, cpf_cli, rg_cli, tipo_cli, dataNasc_cli, login_cli, resposta_cli) VALUES (@NOME, @SOBRENOME, @TELEFONE, @TELEFONE2, @EMAIL, @SENHA, @CPF, @RG, 'adm', @DTNASC, '1', @RESP)" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [cliente]">
            <InsertParameters>
                <asp:ControlParameter ControlID="txtNomeAdm" Name="NOME" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtSobrenomeAdm" Name="SOBRENOME" PropertyName="Text" />
                <asp:Parameter Name="DTNASC" />
                <asp:ControlParameter ControlID="txtTelefoneAdm" Name="TELEFONE" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtTelefone2Adm" Name="TELEFONE2" PropertyName="Text" />
                <asp:Parameter Name="EMAIL" />
                <asp:Parameter Name="CPF" />
                <asp:Parameter Name="RG" />
                <asp:Parameter Name="SENHA" />
                <asp:ControlParameter ControlID="txtResp" Name="RESP" PropertyName="Text" />
            </InsertParameters>
        </asp:SqlDataSource>
        <br />

    </div>
</asp:Content>

