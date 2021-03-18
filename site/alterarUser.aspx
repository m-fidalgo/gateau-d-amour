<%@ Page Title="" Language="C#" MasterPageFile="~/mPage.master" AutoEventWireup="true"  MaintainScrollPositionOnPostback="true" CodeFile="~/cs/alterarUser.aspx.cs" Inherits="alterarUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="divProg">
        <h1 class="h1M">Editar Perfil</h1>
        <br />
        <br /> 
        <p>Nome:
        <asp:Label ID="lblNome" runat="server"></asp:Label>
        </p>
        <p>Sobrenome:
        <asp:Label ID="lblSobrenome" runat="server"></asp:Label>
        </p>
        Data de nascimento:
        <asp:Label ID="lblDtNasc" runat="server"></asp:Label>
        <br />
        <p>Telefone 1:
            <asp:Label ID="lblTelefone1" runat="server"></asp:Label>
        </p>
        <asp:TextBox ID="txtTel1" placeholder="Alterar telefone" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <p>Telefone 2:
            <asp:Label ID="lblTelefone2" runat="server"></asp:Label>
        </p>
        <asp:TextBox ID="txtTel2" placeholder="Alterar telefone (opcional)" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <br />
        Email:
        <asp:Label ID="lblEmail" runat="server"></asp:Label>
        <br />
        <br />
        <asp:TextBox ID="txtEmail" placeholder="Alterar email" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <br />
        Cpf:
        <asp:Label ID="lblCpf" runat="server"></asp:Label>
        <br />
        <br />
        RG:
        <asp:Label ID="lblRg" runat="server"></asp:Label>
        <br />
        <p>Senha:</p>
        <asp:TextBox ID="txtSenha" placeholder="EX: exemplo123" runat="server" CssClass="txt" TextMode="Password"></asp:TextBox>
        <br />
        <asp:Label CssClass="rfv" ID="lblForca" runat="server" Text=""></asp:Label>
        <br />
        <p>Confirmar Senha:</p>
        <asp:TextBox ID="txtConfSenha" placeholder="EX: exemplo123" runat="server" CssClass="txt" TextMode="Password"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="btnForca" runat="server" Text="VERIFICAR FORÇA DA SENHA" CssClass="btnFU" OnClick="btnForca_Click" />
        <br />
        <br />
        <asp:Button ID="btnAlterar" runat="server" Text="ALTERAR" CssClass="btn" OnClick="btnAlterar_Click" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      
        <asp:Button ID="btnSair" runat="server" Text="SAIR" CssClass="btn" OnClick="btnSair_Click" CausesValidation="False" />
        <br />
        <br />
        <p>OBS: A senha deve ser forte, ou seja, deve ter 6 caracteres, com pelo menos uma letra maiúscula, uma minúscula, um número e um caracter especial.</p>
        <br />
        <br />
        <asp:Label ID="lblMsg" runat="server"></asp:Label>
        <br />
        <asp:SqlDataSource ID="sqlAltPerfil" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM cliente" UpdateCommand="UPDATE cliente SET tel1_cli = @TELEFONE1, tel2_cli = @TELEFONE2, email_cli = @EMAIL WHERE (id_cli = @PESQ)">
            <UpdateParameters>
                <asp:Parameter Name="TELEFONE1" />
                <asp:Parameter Name="TELEFONE2" />
                <asp:Parameter Name="EMAIL" />
                <asp:SessionParameter Name="PESQ" SessionField="idCli" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlAltSenha" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [cliente]" UpdateCommand="UPDATE cliente SET senha_cli = @SENHA WHERE (id_cli = @PESQ)">
            <UpdateParameters>
                <asp:Parameter Name="SENHA" />
                <asp:SessionParameter Name="PESQ" SessionField="idCli" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlPesquisar" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT id_cli, nome_cli, sobrenome_cli, dataNasc_cli, tel1_cli, tel2_cli, email_cli, senha_cli, cpf_cli, rg_cli, tipo_cli FROM cliente WHERE (id_cli = @PESQ)">
            <SelectParameters>
                <asp:SessionParameter Name="PESQ" SessionField="idCli" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        
    </div>
</asp:Content>

