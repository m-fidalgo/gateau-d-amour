<%@ Page Title="" Language="C#" MasterPageFile="~/mPageAdm.master" AutoEventWireup="true"  MaintainScrollPositionOnPostback="true" CodeFile="~/cs/cadastrarCupcakes.aspx.cs" Inherits="cadastrarCupcakes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="divProg">
        <br />
        <br />
        <h1 class="h1M">Cadastrar Cupcakes</h1>
        <br />
        <p>Nome:</p>
        <asp:TextBox ID="txtNome" placeholder="EX: Cupcake de Chocolate" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <p>Formato: <asp:Label ID="lbl1" runat="server" CssClass="rfv"></asp:Label></p>
        <asp:DropDownList ID="ddlFormato" runat="server" CssClass="ddl" AutoPostBack="True" DataSourceID="sqlCarregarFormato" DataTextField="descr_formato" DataValueField="id_formato" OnSelectedIndexChanged="ddlFormato_SelectedIndexChanged"></asp:DropDownList>

        <asp:SqlDataSource ID="sqlCarregarFormato" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM formato"></asp:SqlDataSource>

        <br />
        <p>Tamanho: <asp:Label ID="lblTam" runat="server" CssClass="rfv"></asp:Label></p>
        <asp:DropDownList ID="ddlTamanho" runat="server" CssClass="ddl" DataSourceID="sqlCarregarTamanho" DataTextField="descr_tamanho" DataValueField="id_tamanho" OnSelectedIndexChanged="ddlTamanho_SelectedIndexChanged" Enabled="False"></asp:DropDownList>
        <asp:SqlDataSource ID="sqlCarregarTamanho" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT id_tamanho, id_formato, id_cat, descr_tamanho, medidas_tamanho, preco_tamanho FROM tamanho WHERE (id_cat = 2) AND (id_formato = @IDFORM)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlFormato" Name="IDFORM" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlTamanhoEsc" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT id_tamanho, id_formato, id_cat, descr_tamanho, medidas_tamanho, preco_tamanho FROM tamanho WHERE (id_tamanho = @ID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlTamanho" Name="ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <p>Gênero: </p>
        <asp:DropDownList ID="ddlGen" runat="server" CssClass="ddl" DataSourceID="sqlCarregarGen" DataTextField="nome_genero" DataValueField="id_genero" ></asp:DropDownList>
        <asp:SqlDataSource ID="sqlCarregarGen" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM genero"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlGenEsc" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT id_genero, nome_genero FROM genero WHERE (id_genero = @ID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlGen" Name="ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <p>Massa: <asp:Label ID="lblMassa" runat="server" CssClass="rfv"></asp:Label></p>
        <asp:DropDownList ID="ddlMassa" runat="server" CssClass="ddl" DataSourceID="sqlCarregarMassa" DataTextField="nome_massa" DataValueField="id_massa" OnSelectedIndexChanged="ddlMassa_SelectedIndexChanged"></asp:DropDownList>
        <asp:SqlDataSource ID="sqlCarregarMassa" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM massa"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlMassaEsc" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT id_massa, nome_massa, precoAdc_massa FROM massa WHERE (id_massa = @ID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlMassa" Name="ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <p>Cor da Massa:</p>
        <asp:DropDownList ID="ddlCorMassa" runat="server" CssClass="ddl" DataSourceID="sqlCarregarCor" DataTextField="nome_cor" DataValueField="id_cor" ></asp:DropDownList>
        <asp:SqlDataSource ID="sqlCarregarCor" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM cor"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlCorMassaEsc" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT id_cor, nome_cor FROM cor WHERE (id_cor = @ID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlCorMassa" Name="ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <p>Recheio:</p>
        <asp:DropDownList ID="ddlRecheio" runat="server" CssClass="ddl" DataSourceID="sqlCarregarRecheio" DataTextField="nome_recheio" DataValueField="id_recheio" ></asp:DropDownList>
        <asp:SqlDataSource ID="sqlCarregarRecheio" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM recheio"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlRecheioEsc" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT id_recheio, nome_recheio FROM recheio WHERE (id_recheio = @ID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlRecheio" Name="ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <p>Sabor do Recheio:</p>
        <asp:DropDownList ID="ddlSaborRecheio" runat="server" CssClass="ddl" DataSourceID="sqlCarregarSabor" DataTextField="desc_sabor" DataValueField="id_sabor" ></asp:DropDownList>
        <asp:SqlDataSource ID="sqlCarregarSabor" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM sabor"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlSaborEsc" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT id_sabor, desc_sabor FROM sabor WHERE (id_sabor = @ID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlSaborRecheio" Name="ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <p>Cobertura: <asp:Label ID="lblCob" runat="server" CssClass="rfv"></asp:Label></p>
        <asp:DropDownList ID="ddlCobertura" runat="server" CssClass="ddl" DataSourceID="sqlCarregarCobertura" DataTextField="nome_cobertura" DataValueField="id_cobertura" OnSelectedIndexChanged="ddlCobertura_SelectedIndexChanged"></asp:DropDownList>
        <asp:SqlDataSource ID="sqlCarregarCobertura" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM cobertura"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlCoberturaEsc" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT id_cobertura, nome_cobertura, precoAdc_cobertura FROM cobertura WHERE (id_cobertura = @ID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlCobertura" Name="ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <p>Cor da Cobertura:</p>
        <asp:DropDownList ID="ddlCorCobertura" runat="server" CssClass="ddl" DataSourceID="sqlCarregarCor" DataTextField="nome_cor" DataValueField="id_cor" ></asp:DropDownList>
        <asp:SqlDataSource ID="sqlCorCoberturaEsc" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT id_cor, nome_cor FROM cor WHERE (id_cor = @ID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlCorCobertura" Name="ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <p>Decoração: <asp:Label ID="lblDecor" runat="server" CssClass="rfv"></asp:Label></p>
        <asp:DropDownList ID="ddlDecor" runat="server" CssClass="ddl" DataSourceID="sqlCarregarDecor" DataTextField="descr_decor" DataValueField="id_decor" OnSelectedIndexChanged="ddlDecor_SelectedIndexChanged"></asp:DropDownList>
        <asp:SqlDataSource ID="sqlCarregarDecor" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM decoracao"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlDecorEsc" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT id_decor, descr_decor, precoAdc_decor FROM decoracao WHERE (id_decor = @ID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlDecor" Name="ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <p>Cor da Decoração:</p>
        <asp:DropDownList ID="ddlCorDecor" runat="server" CssClass="ddl" DataSourceID="sqlCarregarCor" DataTextField="nome_cor" DataValueField="id_cor" ></asp:DropDownList>
        <asp:SqlDataSource ID="sqlCorDecorEsc" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT id_cor, nome_cor FROM cor WHERE (id_cor = @ID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlCorDecor" Name="ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <p>Imagem:</p>
        <p style="line-height: 40px;"><asp:FileUpload ID="fuImagem" runat="server" onchange="fileinfo()" style="display: none;"/><asp:LinkButton ID="LinkButton1" runat="server" CssClass="btnFU" CausesValidation="False">Selecione uma Imagem</asp:LinkButton></p> 
        <asp:TextBox ID="txtImg" runat="server" CssClass="txt" ReadOnly="True"></asp:TextBox>
        <br />
        <br />
        <br />
        <asp:Button ID="btnPreco" runat="server" Text="GERAR PREÇO" CssClass="btn" OnClick="btnPreco_Click" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnCadastrar" runat="server" Text="CADASTRAR" CssClass="btn" OnClick="btnCadastrar_Click" />
        <br />
        <br />
        <asp:Label ID="lblPreco" runat="server" Text=""></asp:Label>
        <br />
        <br />
        <asp:Label ID="lblMsg" runat="server"></asp:Label>
        <asp:SqlDataSource ID="sqlCadastrar" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" InsertCommand="INSERT INTO produto(id_tamanho, nome_prod, preco_prod, camadas_bolo, andares_bolo, imagem, status_prod) VALUES (@IDTAM, @NOME, @PRECO, 0, 0, @IMG, 'Permanente')" OnInserted="sqlCadastrar_Inserted" SelectCommand="SELECT max(id_prod) as lastId FROM produto">
            <InsertParameters>
                <asp:ControlParameter ControlID="ddlTamanho" Name="IDTAM" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="txtNome" Name="NOME" PropertyName="Text" />
                <asp:Parameter Name="PRECO" />
                <asp:Parameter Name="IMG" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlCadCorCobertura" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" InsertCommand="INSERT INTO cor_cobertura(id_cor, id_prod, id_cobertura) VALUES (@IDCOR, @IDPROD, @IDCOB)" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [cor_cobertura]">
            <InsertParameters>
                <asp:ControlParameter ControlID="ddlCorCobertura" Name="IDCOR" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="ddlCobertura" Name="IDCOB" PropertyName="SelectedValue" />
                <asp:SessionParameter Name="IDPROD" SessionField="idProdC" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlCadCorDecor" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" InsertCommand="INSERT INTO cor_decoracao(id_cor, id_prod, id_decor) VALUES (@IDCOR, @IDPROD, @IDDECOR)" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [cor_decoracao]">
            <InsertParameters>
                <asp:ControlParameter ControlID="ddlCorDecor" Name="IDCOR" PropertyName="SelectedValue" />
                <asp:SessionParameter Name="IDPROD" SessionField="idProdC" />
                <asp:ControlParameter ControlID="ddlDecor" Name="IDDECOR" PropertyName="SelectedValue" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlCadCorMassa" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" InsertCommand="INSERT INTO cor_massa(id_cor, id_prod, id_massa) VALUES (@IDCOR, @IDPROD, @IDMASSA)" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [cor_massa]">
            <InsertParameters>
                <asp:ControlParameter ControlID="ddlCorMassa" Name="IDCOR" PropertyName="SelectedValue" />
                <asp:SessionParameter Name="IDPROD" SessionField="idProdC" />
                <asp:ControlParameter ControlID="ddlMassa" Name="IDMASSA" PropertyName="SelectedValue" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlCadGenProd" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" InsertCommand="INSERT INTO gen_prod(id_prod, id_genero) VALUES (@IDPROD, @IDGEN)" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [gen_prod]">
            <InsertParameters>
                <asp:ControlParameter ControlID="ddlGen" Name="IDGEN" PropertyName="SelectedValue" />
                <asp:SessionParameter Name="IDPROD" SessionField="idProdC" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlCadSaborRecheio" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" InsertCommand="INSERT INTO sabor_recheio(id_sabor, id_prod, id_recheio) VALUES (@IDSABOR, @IDPROD, @IDREC)" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [sabor_recheio]">
            <InsertParameters>
                <asp:SessionParameter Name="IDPROD" SessionField="idProdC" />
                <asp:ControlParameter ControlID="ddlSaborRecheio" Name="IDSABOR" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="ddlRecheio" Name="IDREC" PropertyName="SelectedValue" />
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

