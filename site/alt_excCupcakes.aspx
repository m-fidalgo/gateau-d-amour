<%@ Page Title="" Language="C#" MasterPageFile="~/mPageAdm.master" AutoEventWireup="true"  MaintainScrollPositionOnPostback="true" CodeFile="~/cs/alt_excCupcakes.aspx.cs" Inherits="alt_excCupcakes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="divProg">
        <br />
        <br />
        <h1 class="h1M">Alterar ou Excluir Cupcakes</h1>
        <br />
        <p>Cupcakes: <asp:Label ID="lbl1" runat="server" CssClass="rfv"></asp:Label></p>
        <asp:DropDownList ID="ddlCupcakes" runat="server" CssClass="ddl" AutoPostBack="True" DataSourceID="sqlCarregarCupcakes" DataTextField="nome_prod" DataValueField="id_prod" OnSelectedIndexChanged="ddlCupcakes_SelectedIndexChanged" ></asp:DropDownList>
         <asp:SqlDataSource ID="sqlCarregarCupcakes" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT produto.id_prod, produto.id_tamanho, produto.nome_prod, produto.preco_prod, produto.camadas_bolo, produto.andares_bolo, produto.imagem, produto.status_prod FROM produto INNER JOIN tamanho ON produto.id_tamanho = tamanho.id_tamanho WHERE (tamanho.id_cat = 2) AND (produto.status_prod = 'Permanente')"></asp:SqlDataSource>
         <asp:SqlDataSource ID="sqlCupcakes" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT produto.id_prod, produto.id_tamanho, produto.nome_prod, produto.preco_prod, produto.camadas_bolo, produto.andares_bolo, produto.imagem, produto.status_prod, tamanho.descr_tamanho, cobertura.id_cobertura, cobertura.nome_cobertura, cor.nome_cor AS corCobertura, cor_1.nome_cor AS corDecor, decoracao.descr_decor, genero.nome_genero, cor_2.nome_cor AS corMassa, massa.nome_massa, sabor.desc_sabor, recheio.nome_recheio, formato.descr_formato FROM produto INNER JOIN tamanho ON produto.id_tamanho = tamanho.id_tamanho INNER JOIN cor_cobertura ON produto.id_prod = cor_cobertura.id_prod INNER JOIN cobertura ON cor_cobertura.id_cobertura = cobertura.id_cobertura INNER JOIN cor ON cor_cobertura.id_cor = cor.id_cor INNER JOIN cor_decoracao ON produto.id_prod = cor_decoracao.id_prod INNER JOIN decoracao ON cor_decoracao.id_decor = decoracao.id_decor INNER JOIN cor cor_1 ON cor_decoracao.id_cor = cor_1.id_cor INNER JOIN gen_prod ON produto.id_prod = gen_prod.id_prod INNER JOIN genero ON gen_prod.id_genero = genero.id_genero INNER JOIN cor_massa ON produto.id_prod = cor_massa.id_prod INNER JOIN massa ON cor_massa.id_massa = massa.id_massa INNER JOIN cor cor_2 ON cor_massa.id_cor = cor_2.id_cor INNER JOIN sabor_recheio ON produto.id_prod = sabor_recheio.id_prod INNER JOIN recheio ON sabor_recheio.id_recheio = recheio.id_recheio INNER JOIN sabor ON sabor_recheio.id_sabor = sabor.id_sabor INNER JOIN formato ON tamanho.id_formato = formato.id_formato WHERE (produto.id_prod = @ID)">
             <SelectParameters>
                 <asp:ControlParameter ControlID="ddlCupcakes" Name="ID" PropertyName="SelectedValue" />
             </SelectParameters>
         </asp:SqlDataSource>
        <br />

        <p>Nome:</p>
        <asp:TextBox ID="txtNome" placeholder="EX: Cupcake de Chocolate" runat="server" CssClass="txt"></asp:TextBox>
        <br />

        <p>Formato:&nbsp;&nbsp;&nbsp;<asp:Label ID="lblFormato" runat="server" Text=""></asp:Label></p>
        <asp:DropDownList ID="ddlFormato" runat="server" CssClass="ddl" AutoPostBack="True" DataSourceID="sqlCarregarFormato" DataTextField="descr_formato" DataValueField="id_formato" OnSelectedIndexChanged="ddlFormato_SelectedIndexChanged"></asp:DropDownList>
        <p><asp:Label ID="lbl1Formato" runat="server" CssClass="rfv"></asp:Label></p>
        <asp:SqlDataSource ID="sqlCarregarFormato" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM formato"></asp:SqlDataSource>
        <br />

        <p>Tamanho:&nbsp;&nbsp;&nbsp;<asp:Label ID="lblTamanho" runat="server" Text=""></asp:Label></p>
        <asp:DropDownList ID="ddlTamanho" runat="server" CssClass="ddl" DataSourceID="sqlCarregarTamanho" DataTextField="descr_tamanho" DataValueField="id_tamanho" Enabled="False" AutoPostBack="True" OnSelectedIndexChanged="ddlTamanho_SelectedIndexChanged"></asp:DropDownList>
        <p><asp:Label ID="lbl1Tam" runat="server" CssClass="rfv"></asp:Label></p>
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

        <p>Gênero:&nbsp;&nbsp;&nbsp;<asp:Label ID="lblGen" runat="server" Text=""></asp:Label></p>
        <asp:DropDownList ID="ddlGen" runat="server" CssClass="ddl" DataSourceID="sqlCarregarGen" DataTextField="nome_genero" DataValueField="id_genero"></asp:DropDownList>
        <asp:SqlDataSource ID="sqlCarregarGen" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM genero"></asp:SqlDataSource>
        <br />

        <p>Massa:&nbsp;&nbsp;&nbsp;<asp:Label ID="lblMassa" runat="server" Text=""></asp:Label></p>
        <asp:DropDownList ID="ddlMassa" runat="server" CssClass="ddl" DataSourceID="sqlCarregarMassa" DataTextField="nome_massa" DataValueField="id_massa" AutoPostBack="True" OnSelectedIndexChanged="ddlMassa_SelectedIndexChanged"></asp:DropDownList>
        <p><asp:Label ID="lbl1Massa" runat="server" CssClass="rfv"></asp:Label></p>
        <asp:SqlDataSource ID="sqlCarregarMassa" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM massa"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlMassaEsc" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT id_massa, nome_massa, precoAdc_massa FROM massa WHERE (id_massa = @ID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlMassa" Name="ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />

        <p>Cor da Massa:&nbsp;&nbsp;&nbsp;<asp:Label ID="lblCorMassa" runat="server" Text=""></asp:Label></p>
        <asp:DropDownList ID="ddlCorMassa" runat="server" CssClass="ddl" DataSourceID="sqlCarregarCor" DataTextField="nome_cor" DataValueField="id_cor"></asp:DropDownList>
        <asp:SqlDataSource ID="sqlCarregarCor" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM cor"></asp:SqlDataSource>
        <br />

        <p>Recheio:&nbsp;&nbsp;&nbsp;<asp:Label ID="lblRecheio" runat="server" Text=""></asp:Label></p>
        <asp:DropDownList ID="ddlRecheio" runat="server" CssClass="ddl" DataSourceID="sqlCarregarRecheio" DataTextField="nome_recheio" DataValueField="id_recheio"></asp:DropDownList>
        <asp:SqlDataSource ID="sqlCarregarRecheio" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM recheio"></asp:SqlDataSource>
        <br />

        <p>Sabor do Recheio:&nbsp;&nbsp;&nbsp;<asp:Label ID="lblSaborRecheio" runat="server" Text=""></asp:Label></p>
        <asp:DropDownList ID="ddlSaborRecheio" runat="server" CssClass="ddl" DataSourceID="sqlCarregarSabor" DataTextField="desc_sabor" DataValueField="id_sabor"></asp:DropDownList>
        <asp:SqlDataSource ID="sqlCarregarSabor" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM sabor"></asp:SqlDataSource>
        <br />

        <p>Cobertura:&nbsp;&nbsp;&nbsp;<asp:Label ID="lblCobertura" runat="server" Text=""></asp:Label></p>
        <asp:DropDownList ID="ddlCobertura" runat="server" CssClass="ddl" DataSourceID="sqlCarregarCobertura" DataTextField="nome_cobertura" DataValueField="id_cobertura" AutoPostBack="True" OnSelectedIndexChanged="ddlCobertura_SelectedIndexChanged"></asp:DropDownList>
        <p><asp:Label ID="lbl1Cob" runat="server" CssClass="rfv"></asp:Label></p>
        <asp:SqlDataSource ID="sqlCarregarCobertura" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM cobertura"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlCoberturaEsc" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT id_cobertura, nome_cobertura, precoAdc_cobertura FROM cobertura WHERE (id_cobertura = @ID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlCobertura" Name="ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />

        <p>Cor da Cobertura:&nbsp;&nbsp;&nbsp;<asp:Label ID="lblCorCobertura" runat="server" Text=""></asp:Label></p>
        <asp:DropDownList ID="ddlCorCobertura" runat="server" CssClass="ddl" DataSourceID="sqlCarregarCor" DataTextField="nome_cor" DataValueField="id_cor"></asp:DropDownList>
        <br />

        <p>Decoração:&nbsp;&nbsp;&nbsp;<asp:Label ID="lblDecor" runat="server" Text=""></asp:Label></p>
        <asp:DropDownList ID="ddlDecor" runat="server" CssClass="ddl" DataSourceID="sqlCarregarDecor" DataTextField="descr_decor" DataValueField="id_decor" AutoPostBack="True" OnSelectedIndexChanged="ddlDecor_SelectedIndexChanged"></asp:DropDownList>
        <p><asp:Label ID="lbl1Decor" runat="server" CssClass="rfv"></asp:Label></p>
        <asp:SqlDataSource ID="sqlCarregarDecor" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM decoracao"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlDecorEsc" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT id_decor, descr_decor, precoAdc_decor FROM decoracao WHERE (id_decor = @ID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlDecor" Name="ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />

        <p>Cor da Decoração:&nbsp;&nbsp;&nbsp;<asp:Label ID="lblCorDecor" runat="server" Text=""></asp:Label></p>
        <asp:DropDownList ID="ddlCorDecor" runat="server" CssClass="ddl" DataSourceID="sqlCarregarCor" DataTextField="nome_cor" DataValueField="id_cor"></asp:DropDownList>
        <br />

        <p>Imagem:</p>
        <asp:Image ID="imgBolo" runat="server" visible="false" CssClass="imgProd" />
        <br />
        <p style="line-height: 40px;"><asp:FileUpload ID="fuImagem" runat="server" onchange="fileinfo()" style="display: none;"/><asp:LinkButton ID="LinkButton1" runat="server" CssClass="btnFU" CausesValidation="False">Selecione uma Imagem</asp:LinkButton></p> 
        <asp:TextBox ID="txtImg" runat="server" CssClass="txt" ReadOnly="True"></asp:TextBox>
        <br />
        <br />
        <br />
        <asp:Button ID="btnAlterar" runat="server" Text="ALTERAR" CssClass="btn" OnClick="btnAlterar_Click" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        <asp:Button ID="btnExcluir" runat="server" Text="EXCLUIR" CssClass="btn" OnClick="btnExcluir_Click" />
        <br />
        <asp:SqlDataSource ID="sqlAltProd" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" DeleteCommand="DELETE FROM produto WHERE (id_prod = @ID)" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [produto]" UpdateCommand="UPDATE produto SET id_tamanho = @TAM, nome_prod = @NOME, imagem = @IMG, preco_prod = @PRECO WHERE (id_prod = @ID)">
            <DeleteParameters>
                <asp:ControlParameter ControlID="ddlCupcakes" Name="ID" PropertyName="SelectedValue" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:ControlParameter ControlID="txtNome" Name="NOME" PropertyName="Text" />
                <asp:ControlParameter ControlID="ddlTamanho" Name="TAM" PropertyName="SelectedValue" />
                <asp:Parameter Name="IMG" />
                <asp:ControlParameter ControlID="ddlCupcakes" Name="ID" PropertyName="SelectedValue" />
                <asp:Parameter Name="PRECO" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlAltCorCob" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [cor_cobertura]" UpdateCommand="UPDATE cor_cobertura SET id_cobertura = @COB, id_cor = @COR WHERE (id_prod = @ID)">
            <UpdateParameters>
                <asp:ControlParameter ControlID="ddlCorCobertura" Name="COR" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="ddlCobertura" Name="COB" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="ddlCupcakes" Name="ID" PropertyName="SelectedValue" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlAltCorDecor" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [cor_decoracao]" UpdateCommand="UPDATE cor_decoracao SET id_decor = @DECOR, id_cor = @COR WHERE (id_prod = @ID)">
            <UpdateParameters>
                <asp:ControlParameter ControlID="ddlCupcakes" Name="ID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="ddlCorDecor" Name="COR" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="ddlDecor" Name="DECOR" PropertyName="SelectedValue" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlAltCorMassa" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [cor_massa]" UpdateCommand="UPDATE cor_massa SET id_cor = @COR, id_massa = @MASSA WHERE (id_prod = @ID)">
            <UpdateParameters>
                <asp:ControlParameter ControlID="ddlCupcakes" Name="ID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="ddlMassa" Name="MASSA" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="ddlCorMassa" Name="COR" PropertyName="SelectedValue" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlAltGenProd" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [gen_prod]" UpdateCommand="UPDATE gen_prod SET id_genero = @GEN WHERE (id_prod = @ID)">
            <UpdateParameters>
                <asp:ControlParameter ControlID="ddlCupcakes" Name="ID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="ddlGen" Name="GEN" PropertyName="SelectedValue" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlAltSabor" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [sabor_recheio]" UpdateCommand="UPDATE sabor_recheio SET id_sabor = @SABOR, id_recheio = @REC WHERE (id_prod = @ID)">
            <UpdateParameters>
                <asp:ControlParameter ControlID="ddlCupcakes" Name="ID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="ddlSaborRecheio" Name="SABOR" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="ddlRecheio" Name="REC" PropertyName="SelectedValue" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <br />
        <asp:Label ID="lblMsg" runat="server"></asp:Label>
     </div>

    <script type="text/javascript">
        function fileinfo()
        {
            document.getElementById('<%=txtImg.ClientID%>').value = document.getElementById('<%=fuImagem.ClientID%>').value;
        }
    </script>
</asp:Content>

