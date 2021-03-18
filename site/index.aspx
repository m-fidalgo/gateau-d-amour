<%@ Page Language="C#" AutoEventWireup="true" CodeFile="~/cs/index.aspx.cs"  MaintainScrollPositionOnPostback="true" Inherits="index" %>

<!DOCTYPE html>
<html>
  <head runat="server">
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no">

	<title>Gâteau d'Amour</title>
	<link rel="stylesheet" type="text/css" href="css/style.css" >
	<link rel="stylesheet" type="text/css" href="css/menuResp.css" />
	<link rel="stylesheet" type="text/css" href="css/siteResp.css" />
	<link rel="shortcut icon" href="imgs/icons/favicon.ico" type="image/x-icon" />
	
	<script src="js/modernizr.custom.js"></script>
	
	<style>
	  .imgSlide{
		display: none;
        width: 100%;
	  }

      .slide{
          width: 100%;
      }
	</style>
  </head>
  
  <body>
    <div id="topo">
	  <a id="topo"></a>
	  <div id="logo">
	    <a href="index.aspx"><img title="Home" src="imgs/icons/logoIcon.png" /><img title="Home" id="logoTexto" src="imgs/icons/logoTexto.png" /></a>
	  </div>
	  
	  <div id="menu">
      <!-- menu dropdown -->
	  <nav>
	    <div class="dropdownMenu">
		  <button class="btnMenu"> <img src="imgs/icons/bolo.png" />   Bolos  <span class="setaBaixo"></span></button>
		  <div class="contMenuDrop">
			<div class="dropCont" id="dropCont">
			<a href="bolosProntos.aspx"> Prontos</a>
			<a href="montarBolos.aspx"> Montar</a>						
		    </div> 		
		  </div>
		</div>
		<div class="dropdownMenu">
		  <button class="btnMenu"> <img src="imgs/icons/cupcake.png" />   Cupcakes  <span class="setaBaixo"></span></button>
		  <div class="contMenuDrop">
			<div class="dropCont" id="dropCont">
			<a href="cupcakesProntos.aspx"> Prontos</a>
			<a href="montarCupcakes.aspx"> Montar</a>						
		    </div> 		
		  </div>
		</div>
        <div class="dropdownMenu">
		  <button class="btnMenu" onclick="window.location.href='receitas.aspx'"> <img src="imgs/icons/receitas.png" />  Receitas</button>
		</div>
		<div class="dropdownMenu">
		  <button class="btnMenu" onclick="window.location.href='user.aspx'"> <img src="imgs/icons/user.png" />   Usuário </button>
		</div>
		<div class="dropdownMenu">
		  <button class="btnMenu" onclick="window.location.href='carrinho.aspx'"> <img src="imgs/icons/carrinho.png" /></button>
		</div>
	  </nav>
	  <!-- fim menu dropdown -->
		
	  <!--menu responsivo-->
	  <div id="dl-menu" class="dl-menuwrapper">
	      <button class="dl-trigger">    </button>
		  <ul class="dl-menu">
	        <li>
			  <a>Bolos</a>
			  <ul class="dl-submenu">
			    <li><a href="bolosProntos.aspx">Prontos</a></li>
				<li><a href="montarBolos.aspx">Montar</a></li>
		      </ul>				
			</li>
            <li>
			  <a>Cupcakes</a>
			  <ul class="dl-submenu">
			    <li><a href="bolosProntos.aspx">Prontos</a></li>
				<li><a href="montarBolos.aspx">Montar</a></li>
		      </ul>				
			</li>
            <li>
			  <a href="receitas.aspx">Receitas</a>		
			</li>
            <li>
			  <a href="user.aspx">Usuário</a>		
			</li>
            <li>
			  <a href="carrinho.aspx">Carrinho</a>		
			</li>			
		  </ul>
      </div>
	  <!--fim menu responsivo-->
	  </div>
	</div>

	<div id="conteudo">

        <!-- slideshow -->
        <div class="slide">
	      <img class="imgSlide" src="imgs/slide/img1.jpg" style="width:100%">
	      <img class="imgSlide" src="imgs/slide/img2.jpg" style="width:100%">		
	      <img class="imgSlide" src="imgs/slide/img3.jpg" style="width:100%">
		  <img class="imgSlide" src="imgs/slide/img4.jpg" style="width:100%">
	    </div>
        <!-- fim slideshow -->

        <h1 class="h1M">Sobre</h1>
        <h2>História</h2>
	    <p>&nbsp;&nbsp;&nbsp; A empresa foi criada em 2016, por cinco amigos que planejaram fazer um bolo <i>red velvet</i> para uma 
            confraternização. Como eles não conseguiram preparar o bolo, pois não tinham os ingredientes necessários, eles 
            decidiram procurar confeitarias que fizessem o bolo <i>red velvet</i>, mas nenhuma confeitaria fazia do jeito exato que 
            eles queriam. Assim, os amigos começaram a pensar em uma confeitaria em que o cliente pudesse encomendar um bolo do 
            jeito que ele quisesse, começando a planejar uma confeitaria online e física, a "Gâteau D´Amour", que agiliza e 
            melhora o processo de encomenda de bolos e cupcakes para os clientes.</p>
        <h2>Missão</h2>
        <p>&nbsp;&nbsp;&nbsp; A Gâteau d'Amour tem como missão adocicar os eventos de seus clientes com seus bolos e cupcakes, 
           dando a eles uma experiência perfeita, nos mínimos detalhes.</p>
        <h2>Visão</h2>
        <p>&nbsp;&nbsp;&nbsp; Queremos expandir em âmbito nacional o alcance da empresa, criando novas lojas por todo o país e continuando a prezar pela satisfação do cliente pela honestidade da nossa empresa e pela qualidade de todos os nossos produtos.</p>
        <h2>Valores</h2>
        <p>&nbsp;&nbsp;&nbsp; Temos como valores  compromisso de nossos profissionais e da empresa como um todo para com o cliente, a ética na realização dos serviços e a honestidade de nossos membros.</p>
	    
        <!-- animação (esquerda)-->

        <!-- email (direita)-->
        <form id="form1" runat="server">
          <div class="divProg" id="email">
            <h1 class="h1M">Contato</h1>
            <br />
            <asp:TextBox ID="txtEmail" placeholder="Seu email" runat="server" CssClass="txt"></asp:TextBox>
            <br />
            <br />
            <asp:TextBox ID="txtNome" placeholder="Seu nome" runat="server" CssClass="txt"></asp:TextBox>
            <br />
            <br />
            <asp:TextBox ID="txtAssunto" placeholder="Assunto" runat="server" CssClass="txt"></asp:TextBox>
            <br class="brAparecer"/> 
            <br class="brAparecer"/>            
            <asp:TextBox ID="txtMensagem" placeholder="Mensagem" runat="server" CssClass="txt" TextMode="MultiLine" Rows="5" style="resize:none;"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="btnEnviar" runat="server" Text="ENVIAR" CssClass="btn" OnClick="btnEnviar_Click"/>
            <br />
            <br />
            <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
          </div>          
        </form>
        <!-- fim email -->
        
	</div>
	
	<div id="footer">
      <div style="float: left; width: 10%">
	    <p><a href="#topo"><span class="setaCima"></span></a></p>
	  </div>
	  <div style="display: inline-block; float: right; width: 70%; text-align: right; padding-right: 50px;">
	    <p>
   	      <a class="linkFooter" href="index.aspx#email"><img src="imgs/icons/email.png" style="height: 20px" title="gateau.d.amour.tcc@outlook.com" /></a>
		  <a class="linkFooter" href="http://www.facebook.com/G%C3%A2teau-D-Amour-247416255851051/"><img src="imgs/icons/facebook.png" style="height: 20px" title="Gâteau d'Amour" /></a>
		  <a class="linkFooter" href="http://www.instagram.com/gateau.d.amour.tcc"><img src="imgs/icons/instagram.png" style="height: 20px" title="@gateaudamour" /></a>
		  <a class="linkFooter" href="http://www.pin.it/j6dilg2krzbt3c"><img src="imgs/icons/pinterest.png" style="height: 20px" title="@gateaudamour" /></a>
		</p>
	  </div>
	</div>
	
	<!-- scripts menu responsivo -->
	<script src="js/jquery.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
	<script src="js/jquery.dlmenu.js"></script>
	<script>
		$(function() {
			$( '#dl-menu' ).dlmenu({
				animationClasses : { classin : 'dl-animate-in-5', classout : 'dl-animate-out-5' }
			});
		});
    </script>
	<script>
		var index = 0;
		carousel();

		function carousel() {
			var i;
			var x = document.getElementsByClassName("imgSlide");
			for (i = 0; i < x.length; i++) {
				x[i].style.display = "none";  
			}
			index++;
			if (index > x.length) {index = 1}    
			x[index-1].style.display = "block";  
			setTimeout(carousel, 2000);
		}
</script>
  </body>
</html>
