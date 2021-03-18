<%@ Page Title="" Language="C#" MasterPageFile="~/mPage.master" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeFile="~/cs/montarCupcakes.aspx.cs" Inherits="montarCupcakes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        #preco{
            text-align: center;
            padding: 5px;
            border: 1px solid #4D2100;
            border-radius: 4px;
            width: 200px;
        }

        #esquerda{
            position: fixed;
            text-align: center;
            height: calc(100% - 102px);
            width: 300px;
            padding-left: 50px;
            float: left;
        }

        #direita{
            text-align: center;
            padding-left: 100px;
        }

        .flashContent{
            width: 200px;
            padding: 5px;
        }

        @media screen and (max-width: 1000px){
            #esquerda{
                position: static;
                height: 180px;
                width: 100%;
                padding-left: 0px;
                margin-bottom: 200px;
            }

             #preco{
                width: 50%;
                margin-left: 25%;
            }

            #direita{
                padding-left: 0px;
            }

            .flashContent{
                margin-left: calc((100% - 200px)/2);
            }

        }

        @media screen and (max-width: 650px) {
            #preco {
                padding: 4.25px;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="divProg">
        <br />
        <br />
        <h1 class="h1M">Monte seu Cupcake!</h1>
        <p>OBS: Vendemos por dúzias</p>
        <br />

      <div id="esquerda">
        <div id="preco">
            <h2>Preço Total:</h2>
            <asp:Label ID="lblPreco" runat="server" Text=""></asp:Label>
            <br />
        </div>
        <br />
        <br />
	    
		<div class="flashContent">
			<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" width="100%" id="cupcake" align="middle">
				<param name="movie" value="anim/cupcake.swf" />
				<param name="quality" value="high" />
				<param name="bgcolor" value="#ffffff" />
				<param name="play" value="true" />
				<param name="loop" value="true" />
				<param name="wmode" value="window" />
				<param name="scale" value="showall" />
				<param name="menu" value="true" />
				<param name="devicefont" value="false" />
				<param name="salign" value="" />
				<param name="allowScriptAccess" value="sameDomain" />
				<!--[if !IE]>-->
				<object type="application/x-shockwave-flash" data="anim/cupcake.swf" width="100%" >
					<param name="movie" value="anim/cupcake.swf" />
					<param name="quality" value="high" />
					<param name="bgcolor" value="#ffffff" />
					<param name="play" value="true" />
					<param name="loop" value="true" />
					<param name="wmode" value="window" />
					<param name="scale" value="showall" />
					<param name="menu" value="true" />
					<param name="devicefont" value="false" />
					<param name="salign" value="" />
					<param name="allowScriptAccess" value="sameDomain" />
				<!--<![endif]-->
					<a class="links" href="http://www.adobe.com/go/getflash">
						<img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Obter Adobe Flash Player" />
					</a>
				<!--[if !IE]>-->
				</object>
				<!--<![endif]-->
			</object>
        </div>
		
      </div>

      <div id="direita">
        <p>Formato: <asp:Label ID="lbl1" runat="server" CssClass="rfv"></asp:Label></p>
        <asp:DropDownList ID="ddlFormato" runat="server" CssClass="ddl" AutoPostBack="True" DataSourceID="sqlCarregarFormato" DataTextField="descr_formato" DataValueField="id_formato" OnSelectedIndexChanged="ddlFormato_SelectedIndexChanged"></asp:DropDownList>

        <asp:SqlDataSource ID="sqlCarregarFormato" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM formato"></asp:SqlDataSource>

        <br />
        <p>Tamanho: <asp:Label ID="lblTam" runat="server" CssClass="rfv"></asp:Label></p>
        <asp:DropDownList ID="ddlTamanho" runat="server" CssClass="ddl" DataSourceID="sqlCarregarTamanho" DataTextField="descr_tamanho" DataValueField="id_tamanho" OnSelectedIndexChanged="ddlTamanho_SelectedIndexChanged" Enabled="False" AutoPostBack="True"></asp:DropDownList>
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
        <p>Quantidade de itens:</p>
        <asp:TextBox ID="txtQtd" placeholder="EX: 1" runat="server" CssClass="txt"></asp:TextBox>
        <br />
        <p>Massa: <asp:Label ID="lblMassa" runat="server" CssClass="rfv"></asp:Label></p>
        <asp:DropDownList ID="ddlMassa" runat="server" CssClass="ddl" DataSourceID="sqlCarregarMassa" DataTextField="nome_massa" DataValueField="id_massa" OnSelectedIndexChanged="ddlMassa_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
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
        <asp:DropDownList ID="ddlCobertura" runat="server" CssClass="ddl" DataSourceID="sqlCarregarCobertura" DataTextField="nome_cobertura" DataValueField="id_cobertura" OnSelectedIndexChanged="ddlCobertura_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
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
        <asp:DropDownList ID="ddlDecor" runat="server" CssClass="ddl" DataSourceID="sqlCarregarDecor" DataTextField="descr_decor" DataValueField="id_decor" OnSelectedIndexChanged="ddlDecor_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
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
        <p>Comentário:</p>
        <asp:TextBox ID="txtComentario" placeholder="Coloque aqui qualquer informação adicional que deseje." runat="server" CssClass="txt" TextMode="MultiLine" Rows="5" style="resize:none;"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="btnOK" runat="server" Text="OK" CssClass="btn" OnClick="btnOK_Click" />
          <asp:SqlDataSource ID="sqlCadastrar" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" InsertCommand="INSERT INTO produto(id_prod, id_tamanho, nome_prod, preco_prod, status_prod, comentario_prod, imagem) VALUES (0, @TAM, 'Personalizado', @PRECO, 'Temporário', @COMENT, 'noImg.png')" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT max(id_prod) AS idMax FROM produto">
            <InsertParameters>
                <asp:ControlParameter ControlID="ddlTamanho" Name="TAM" PropertyName="SelectedValue" />
                <asp:Parameter Name="PRECO" />
                <asp:ControlParameter ControlID="txtComentario" Name="COMENT" PropertyName="Text" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlCadCorCob" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" InsertCommand="INSERT INTO cor_cobertura(id_cor, id_prod, id_cobertura) VALUES (@IDCOR, @IDPROD, @IDCOB)" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [cor_cobertura]">
            <InsertParameters>
                <asp:SessionParameter Name="IDPROD" SessionField="idProdC" />
                <asp:ControlParameter ControlID="ddlCorCobertura" Name="IDCOR" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="ddlCobertura" Name="IDCOB" PropertyName="SelectedValue" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlCadCorDecor" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" InsertCommand="INSERT INTO cor_decoracao(id_cor, id_prod, id_decor) VALUES (@IDCOR, @IDPROD, @IDDECOR)" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [cor_decoracao]">
            <InsertParameters>
                <asp:SessionParameter Name="IDPROD" SessionField="idProdC" />
                <asp:ControlParameter ControlID="ddlCorDecor" Name="IDCOR" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="ddlDecor" Name="IDDECOR" PropertyName="SelectedValue" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlCadCorMassa" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" InsertCommand="INSERT INTO cor_massa(id_cor, id_prod, id_massa) VALUES (@IDCOR, @IDPROD, @IDMASSA)" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [cor_massa]">
            <InsertParameters>
                <asp:SessionParameter Name="IDPROD" SessionField="idProdC" />
                <asp:ControlParameter ControlID="ddlCorMassa" Name="IDCOR" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="ddlMassa" Name="IDMASSA" PropertyName="SelectedValue" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlCadSaborRecheio" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" InsertCommand="INSERT INTO sabor_recheio(id_sabor, id_prod, id_recheio) VALUES (@IDSABOR, @IDPROD, @IDRECHEIO)" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [sabor_recheio]">
            <InsertParameters>
                <asp:SessionParameter Name="IDPROD" SessionField="idProdC" />
                <asp:ControlParameter ControlID="ddlSaborRecheio" Name="IDSABOR" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="ddlRecheio" Name="IDRECHEIO" PropertyName="SelectedValue" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlInserirVenda" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" InsertCommand="INSERT INTO pedido(id_end, id_pag, data_pedido, dataEntrega_pedido, horarioEntrega_pedido, preco_compra) VALUES (1, 1, @DATA, @DATA, '00:00', 0)" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT max(id_pedido) as idPedido FROM pedido">
                <InsertParameters>
                    <asp:Parameter Name="DATA" />
                </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlInserirItens" runat="server" ConnectionString="<%$ ConnectionStrings:gateaudamourConnectionString %>" InsertCommand="INSERT INTO itens_pedido(id_prod, id_pedido, qt_itens, total_item) VALUES (@IDPROD, @IDPEDIDO, @QTDITENS, @TOTAL)" ProviderName="<%$ ConnectionStrings:gateaudamourConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [itens_pedido]">
                <InsertParameters>
                    <asp:SessionParameter Name="IDPROD" SessionField="idProdC" />
                    <asp:SessionParameter Name="IDPEDIDO" SessionField="idPedido" />
                    <asp:ControlParameter ControlID="txtQtd" Name="QTDITENS" PropertyName="Text" />
                    <asp:Parameter Name="TOTAL" />
                </InsertParameters>
        </asp:SqlDataSource>
        <br />
        <br />
        <br />
        <asp:Label ID="lblMsg" runat="server"></asp:Label>
      </div>
    </div>
    
</asp:Content>

