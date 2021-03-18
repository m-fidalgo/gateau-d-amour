<%@ Page Title="" Language="C#" MasterPageFile="~/mPage.master" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeFile="~/cs/receitas.aspx.cs" Inherits="receitas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .dl {
        width: 60%;
        padding-left: 20%;
        padding-right: 20%;
        margin-left: 20%;
        margin-right: 20%;     
    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="divProg">
        <br />
        <br />
        <h1 class="h1M">Receitas</h1>
        <br />
        <p>Pesquisar:</p>
        <asp:TextBox ID="txtPesq" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="btnPesq" runat="server" Text="PESQUISAR" CssClass="btn" OnClick="btnPesq_Click" />
        <br />
        <br />
        <asp:Label ID="lblErro" runat="server" Text=""></asp:Label>
        <br />
        <br />
        <br />
        <asp:DataList ID="dlReceitas" runat="server" DataKeyField="id_receita" RepeatColumns="1" RepeatDirection="Horizontal" CssClass="dl" CellPadding="4">
            <FooterTemplate>
                <asp:LinkButton ID="btnAnterior" runat="server" OnClick="btnAnterior_Click" CssClass="links">&lt;&lt;</asp:LinkButton>
                &nbsp;&nbsp;
                <asp:LinkButton ID="btnProx" runat="server" OnClick="btnProx_Click" CssClass="links">&gt;&gt;</asp:LinkButton>
            </FooterTemplate>
            <ItemTemplate>
               <asp:Image ID="Image1" runat="server" Width="400px" ImageUrl='<%# Eval("imagem_receita", "{0}") %>'  />
               <br />
               <h1><asp:Label ID="titulo_receitaLabel" runat="server" Text='<%# Eval("titulo_receita") %>' /></h1>
               <h2>Ingredientes</h2>
               <p><asp:Label ID="ingredientes_receitaLabel" runat="server" Text='<%# ((string)Eval("ingredientes_receita")).Replace("\n","<br />") %>' /></p>
               <br />
               <h2>Modo de Preparo:</h2>
               <p><asp:Label ID="modo_receitaLabel" runat="server" Text='<%# ((string)Eval("modo_receita")).Replace("\n","<br />") %>' /></p>
               <br /> 
            </ItemTemplate>
        </asp:DataList>        
        <br />
        <asp:SqlDataSource ID="sqlExibir" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT id_receita, id_cli, titulo_receita, ingredientes_receita, modo_receita, status_receita, imagem_receita FROM receitas WHERE (titulo_receita LIKE @PESQ) AND (status_receita = 'Publicado')">
            <SelectParameters>
                <asp:Parameter Name="PESQ" />
            </SelectParameters>
        </asp:SqlDataSource>
        <h1>Envie-nos uma receita!</h1>
        <p>Título:</p>
        <asp:TextBox ID="txtTitulo" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <p>Ingredientes:</p>
        <asp:TextBox ID="txtIngredientes" runat="server" CssClass="txt" TextMode="MultiLine" Rows="10" style="resize:none;"></asp:TextBox>
        <br />
        <p>Modo de Preparo:</p>
        <asp:TextBox ID="txtModo" runat="server" CssClass="txt" TextMode="MultiLine" Rows="10" style="resize:none;"></asp:TextBox>
        <br />
        <p>Imagem:</p>
        <p style="line-height: 40px;"><asp:FileUpload ID="fuImagem" runat="server" onchange="fileinfo()" style="display: none;"/><asp:LinkButton ID="LinkButton1" runat="server" CssClass="btnFU" CausesValidation="False">Selecione uma Imagem</asp:LinkButton></p> 
        <asp:TextBox ID="txtImg" runat="server" CssClass="txt" ReadOnly="True"></asp:TextBox>
        <br />
        <br />
        <br />
        <asp:Button ID="btnEnviar" runat="server" Text="ENVIAR" CssClass="btn" OnClick="btnEnviar_Click" />
        <br />
        <br />
        <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
        <asp:SqlDataSource ID="sqlReceitas" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" InsertCommand="INSERT INTO receitas(titulo_receita, ingredientes_receita, modo_receita, id_cli, status_receita, imagem_receita) VALUES (@TITULO, @INGRED, @MODO, @IDCLI, 'Analisar', @IMG)" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [receitas]">
            <InsertParameters>
                <asp:ControlParameter ControlID="txtTitulo" Name="TITULO" PropertyName="Text" />
                <asp:Parameter Name="INGRED" />
                <asp:Parameter Name="MODO" />
                <asp:SessionParameter Name="IDCLI" SessionField="idCli" />
                <asp:Parameter Name="IMG" />
            </InsertParameters>
        </asp:SqlDataSource>
    </div>

    <script type="text/javascript">
        function fileinfo()
        {
            document.getElementById('<%=txtImg.ClientID%>').value = document.getElementById('<%=fuImagem.ClientID%>').value;
        }
    </script>
</asp:Content>

