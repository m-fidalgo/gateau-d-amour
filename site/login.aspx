<%@ Page Title="" Language="C#" MasterPageFile="~/mPage.master" AutoEventWireup="true"  MaintainScrollPositionOnPostback="true" CodeFile="~/cs/login.aspx.cs" Inherits="login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .brAparecer{
            display: none;
        }

        #login {
            float: right;
            width: 55%;
        }

        #loginD{
            float: left;
            width: 35%;
            padding-left: 50px;
        }

        #cadastrar{
            text-align: center;
            padding: 5px;
            border: 1px solid #4D2100;
            border-radius: 4px;
        }

        #cadastrar:hover{
            border: 1px solid #FFC3D0;
        }

        .panel{
            margin-left: 30%;
        }

        @media screen and (max-width: 1100px){
            .panel{
                margin-left: 20%;
            }
        }

        @media screen and (max-width: 850px){
	        #login{
                float: left;
                width: 100%;
                padding-bottom: 20px;
	        }

            #loginD{
                float: left;
                width: 100%;
                padding-left: 0px;
                padding-right: 10px;
                text-align: center;
            }

            .brSumir{
                display: none;
            }

            .brAparecer{
                display: inline-block;
            }

             #cadastrar{
                width: 50%;
                margin-left: 25%;
            }

            .panel{
               width: 10px;
            }
        }
         
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div id="loginD">
        <br class="brSumir" />
        <br class="brSumir" />
        <br class="brSumir" />
        <br class="brSumir" />
        <br class="brSumir" />
        <br class="brSumir" />
        <br class="brSumir" />
        <br class="brSumir" />
        <br class="brSumir" />
        <br />
        <p>Bem vindo(a) ao</p>
        <h1>GÂTEAU D'AMOUR</h1>
        <p>Faça login para poder encomendar seus bolos e cupcakes!</p>
        <a href="cadastrarUser.aspx" style="text-decoration: none;"><div id="cadastrar"><p style="color: black;">Ainda não é nosso cliente? <span style="color: #FFC3D0;">Cadastre-se.</span></p></div></a>
    </div>
    <br class="brAparecer" />
    <div id="login">
    <div class="divProg">
        <br class="brSumir" />
        <br />
        <h1 class="h1M">Login</h1>
        <br />
        <p>Email:</p>
        <asp:TextBox ID="txtEmail" placeholder="EX: exemplo@gmail.com" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <asp:RequiredFieldValidator CssClass="rfv" ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmail" ErrorMessage="O campo &quot;email&quot; é obrigatório."></asp:RequiredFieldValidator>
        <p>Senha:</p>
        <asp:TextBox ID="txtSenha" placeholder="EX: exemplo123" runat="server" CssClass="txt" TextMode="Password"></asp:TextBox>
        <br />
        <asp:RequiredFieldValidator CssClass="rfv" ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtSenha" ErrorMessage="O campo &quot;senha&quot; é obrigatório."></asp:RequiredFieldValidator>
        <a href="esqueciSenha.aspx" style="text-decoration: none;"><p style="color: #FFC3D0;">Esqueci minha senha</p></a>
        <asp:Label ID="lblErro" runat="server" Text=""></asp:Label>
        <br />
        <br />
        <asp:Button ID="btnLogin" runat="server" Text="LOGIN" CssClass="btn" OnClick="btnLogin_Click" />
        <br />
        <br />        
        <%@ Register Assembly="GoogleReCaptcha" Namespace="GoogleReCaptcha" TagPrefix="cc1" %>
        <script src='https://www.google.com/recaptcha/api.js?hl=pt-BR'></script>

        <asp:Panel ID="Panel1" runat="server" CssClass="panel"  Visible="false">

        </asp:Panel>
        <br />
        <asp:SqlDataSource ID="sqlLogin" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT id_cli, nome_cli, sobrenome_cli, dataNasc_cli, tel1_cli, tel2_cli, email_cli, senha_cli, cpf_cli, rg_cli, tipo_cli, resposta_cli, login_cli FROM cliente WHERE (email_cli = @EMAIL) AND (senha_cli = @SENHA)">
            <SelectParameters>
                <asp:Parameter Name="EMAIL" />
                <asp:Parameter Name="SENHA" />
            </SelectParameters>
        </asp:SqlDataSource>
        
        <br />
        <br />

        
    </div>
    </div>
    
</asp:Content>

