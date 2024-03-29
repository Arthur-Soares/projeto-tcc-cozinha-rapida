<%@page import="projeto.util.MenuUtils"%>
<%@page import="projeto.util.AppSecrets"%>
<%@page import="projeto.model.Cr_usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR, pt">
	<head>  
		<link rel="icon" href="imagens/cr_logo_guia_ret_arredondado.png" type="image/png">	
		<title>Home - Cozinha Rápida</title>
		<link href="css/cr_login.css" rel="stylesheet">
	    <link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="fontawesome/css/all.min.css" rel="stylesheet">
		<meta http-equiv="Content-Type" content="text/html; charset:iso-88590-1">		
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		<script type="text/javascript" src="fontawesome/js/all.min.js"></script>
		<script type="text/javascript" src="js/bootstrap-autocomplete.js"></script>		
		<script type="text/javascript" src="./js/carrinho.js"></script> 
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
	    <script src="js/bootstrap-dialog.min.js"></script>
		<script type="text/javascript" src="js/popper.js"></script>
		<script src="./js/bootstrap-datepicker.min.js"></script>
		<script src="./js/bootstrap-datepicker.pt-BR.min.js"></script>		
		<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>		
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css">
		<!-- 
		Font Awesome Free 5.3.1 by @fontawesome - (https://fontawesome.com)
		Bootstrap v4.1.3 (https://getbootstrap.com/)
		jQuery JavaScript Library v3.3.1 (https://jquery.com/)
 		Includes Sizzle.js (https://sizzlejs.com/)
		-->
		<%
		Cr_usuario cru = null!=session.getAttribute(AppSecrets.USER_KEY)?(Cr_usuario)session.getAttribute(AppSecrets.USER_KEY):null;
		int cuserid = null!=cru?cru.getCr_id_usuario():0;
		String cuseradmin = null!=cru?cru.getCr_nivel_usuario():"";
		String cusername = null!=cru?cru.getCr_nome_completo_usuario():"";
		String copcsenhaalt = null!= cru?cru.getCr_senha_alterada():"";
		String redir = null!=request.getParameter("redir")?request.getParameter("redir"):"";
		String opclogoff = null!=request.getParameter("logoff")?request.getParameter("logoff"):"";
		//logoff=S
		String msgIndex = null != session.getAttribute("errologin") ? (String) session.getAttribute("errologin") : "";
		
		//System.out.println("VENDO O ID DO USUÁRIO :: "+cuserid);
				
		if("S".equals(opclogoff) || !"".equals(msgIndex)){
			session.setAttribute("errologin", null);
			session.setAttribute("projeto.model.Cr_usuario", null);			
		}
				
		%>
		
		
		<script type="text/javascript">
			<%
			if(!"".equals(msgIndex)){
			%>
			alert('<%=msgIndex%>');
			<%
			}
			%>
		</script>
		
		<style>		
		
		h1 {	
			color: #FFFFFF;
			font-weight: 800;								
		}
		
		h2 {	
			color: #FFFFFF;
			font-weight: 800;								
		}
		
		h6 {	
			color: #FFFFFF;
			font-weight: 800;								
		}
		
		body {
			background: url('imagens/fast_kitchen_home_menorzinha.png') no-repeat center center fixed; 
			height: 100%;
			-webkit-background-size: cover;
			-moz-background-size: cover;
			-o-background-size: cover;
			background-size: cover;			
			font-family: 'Open Sans', sans-serif;
			overflow-y: hidden;			
		}
		#tit_rec_mais_pesquisadas {	
			height: 800;
			color: #FFFFFF;
			font-weight: 800;
			font-family: 'Open Sans', sans-serif;									
		}
		#btnReceita {	
			/*margin-top: 10px;	*/		
			font-weight: 800;
			border: 5px solid #CCCCCC;							
			outline: none;			
			background: #CCCCCC;
			color: #000000;
			border-radius: 40px;
			transition: 0.2s;
			cursor: pointer;			
			transition: 0.2s;
			font-size: 13px;
			margin-top: 10%;
			padding-left:50px; padding-right:50px;
			/*padding-top:10px; padding-bottom:10px; padding-left:50px; padding-right:50px;*/
		}
		@media (max-width: 768px) {
		  .container {
		    flex-direction: column;
		    align-items: center;
		  }
		}
		
		@keyframes arrow-bounce {
		  0% {
		    transform: translateY(0);
		  }
		  50% {
		    transform: translateY(5px);
		  }
		  100% {
		    transform: translateY(0);
		  }
		}
		.div_home {			
			margin: 0px;
		    height: 100vh;
		    display: flex;
			flex-direction: row;
			justify-content: center;
			align-items: center;
			text-align: center;
			float: center;
		}
		.div_ver_mais {
		  display: flex;
		  justify-content: center;
		}
		.div_ver_menos {
		  position: absolute; /* define a posição absoluta */
		  top: 50%; /* define o topo da div no meio da tela */
		  left: 50%; /* define a esquerda da div no meio da tela */		  
		}
		.div_card_receita{			
			background: url('imagens/brazilian-food-black.jpg') no-repeat center center fixed;
			margin: 0px;
		    height: 100vh;
		    display: flex;			
			text-align: center;
			justify-content: center;
			align-items: center;
			/* 
			float: center; */
		}
		.card-body {
		  background-color: rgba(99, 111, 97, 0.9);
		  backdrop-filter: blur(40px);
		  -webkit-backdrop-filter: blur(40px);
		  border-radius: 0 0 11px 11px; /* Define o border-radius apenas nas pontas inferiores */
		  border-top: 6px solid #323232; /* Adiciona uma borda preta na parte superior */
		}

		.card {
		  position: flex;			  
		  background-color: #323232;		  			  	
		  border-radius: 11px;	
		  height: 60vh;   		 
		  margin-bottom: 30px;
		  /*width: 240px;  ajuste o tamanho do cartão de acordo com suas necessidades */
		  /*height: 320px;  ajuste o tamanho do cartão de acordo com suas necessidades */			  		
		}
		.card-text{
			color: #FFFFFF;					
		}
		.img_receita {
		  position: relative;
		  height: 200px; /* ajuste a altura da imagem de acordo com suas necessidades */
		  border: 6px solid #323232; /* adiciona uma borda preta de 2px */
		  border-bottom: none;
		  border-radius: 8px 8px 0px 0px;
  		  box-sizing: border-box; /* inclui a largura da borda no cálculo do tamanho do iframe */  		   		 
		}
		.img_receita img {
		  position: absolute;
		  top: 0;
		  left: 0;
		  width: 100%;
		  height: 90%;
	      object-fit: cover;		           	    
		}
		.arrow-icon {
		  animation-name: arrow-bounce;
		  animation-duration: 1s;
		  animation-timing-function: ease-in-out;
		  animation-iteration-count: infinite;
		}
		.carousel_receitas_mais {
			 top: 40%; /* define o topo da div no meio da tela */
			 position: absolute;
		}
		
		.div_conteudo_rec{
			margin-bottom: 20px;
			
		}
		.item {
            text-align: center;
            color: #FFFFFF;
        }
        .item img {
        max-width: 100%;
        height: auto;
   		}
		.owl-prev {
		 	text-align: center;
            color: #FFFFFF;
            width: 50px;
		  	height: 50px;
		  	background-color:  #FFFFFF;
		}
		
		.owl-next{		
		 	text-align: center;
            color: #FFFFFF;
            width: 50px;
		  	height: 50px;
		  	
		}
		
		.owl-carousel .custom-prev-button,
		.owl-carousel .custom-next-button {
		    background-color: rgba(0, 0, 0, 0.6); /* Cor de fundo preta com transparência */
		    font-size: 24px; /* Tamanho da fonte */
		    width: 50px; /* Largura do botão */
		    height: 50px; /* Altura do botão */
		    color: #fff; /* Cor do texto */
		    display: flex; /* Exibir como flex para centralizar o ícone */
		    align-items: center; /* Centralizar verticalmente o ícone */
		    justify-content: center; /* Centralizar horizontalmente o ícone */
		    border-radius: 50%; /* Bordas arredondadas */
		    
		}
		
		.owl-carousel .custom-prev-button:before,
		.owl-carousel .custom-next-button:before {
		    content: '\2039'; /* Ícone do botão de seta para esquerda */
		}
		
		.owl-carousel .custom-next-button:before {
		    content: '\203A'; /* Ícone do botão de seta para direita */
		}
		.card-title {
		   max-width: 100%;
		   overflow: hidden;
		   text-overflow: ellipsis;
		   white-space: nowrap;
		   height:100px;
		   
		}
		/*
		@media (max-width: 1000px) {
		   .item_card_7,
		   .item_card_8,
		   .item_card_9,
		   .item_card_10,
		   .item_card_11 {
		      display: none !important;
		      visibility: hidden;
		   }
		}
		*/
		</style>
	</head>	 
		
	<script type="text/javascript">
		//Chamada para utilizar o Jquery
		jQuery.extend({
	 	   postJSON: function( url, data, callback) {
	 	      return jQuery.post(url, data, callback, "json");
	 	   }
	 	});
		
		//Inicia assim que a tela abre
		$(document).ready(function() {
			carregalistaTopReceitas();				
		
			var logoff = '<%=opclogoff%>';
			if(logoff == "S"){
				$("#tela_home").submit();
			}
			
			//SE A SENHA DO USUÁRIO FOI ALTERADA, IRÁ APARECER UM MODAL PARA ELE REDEFINIR ELA:
			<%
			if("S".equals(copcsenhaalt)){
			%>
				$("#modalsenha").modal('show');		
			<%
			}else{
			%>
				$("#modalsenha").modal('hide');		
			<%
			}
			%>
			
			carregaListaCarrinhodeCompras('<%=cuserid%>');
			
			//ESCONDENDO DIV DO CARD DE RECEITAS
			var div_home = $('.div_home');
			div_home.show();
			var div_card_receita = $('.div_card_receita');
			div_card_receita.hide();					
			
			//Isto está definido diretamente no nosso <select> e tem o objetivo de carregar as possíveis opções do nosso autocomplete
			//data-url='./jsonservlet?opc_servlet=sel_pesquisa_receita'
			//Implementando componente de AUTOCOMPLETE em um <select com o ID = "sel_receita"
			//$('#sel_receita').autoComplete();
			$('#sel_receita').autoComplete({
			  // configurações do autocomplete aqui
			  noResultsText: 'Nenhum resultado encontrado'
			});
			//O AUTOCOMPLETE contém um evento que é chamado ao selecionarmos uma linha dele = 'autocomplete.select'
			$('#sel_receita').on('autocomplete.select', function (evt, item) {				 		
				//ITEM é o item em específico que selecionamos do nosso autocomplete (possui as propriedades relativas a aquela linha)
				//item.text e item.value
				//Checa se foi selecionada uma LINHA e se ela EXISTE
				//console.log('Passei evt :: '+evt+' -- item.value :: '+item.value+' -- item.text :: '+item.text);
				if(item){										
					//CHAMANDO outra URL para buscar os dados específicos do CLIENTE que selecionamos
					//$.getJSON( "./jsonservlet?opc_servlet=find_pesquisa_receita&q="+item.value, function( data ) {
						
					var cr_id_receita = "";
					//TENTANDO OUTRA FORMA DE CHAMAR
					$.getJSON("./jsonservlet",{opc_servlet:'find_receita',cr_id_receita:item.value}, 
					 function(datalin,statuslin){						
						  if(datalin){							  
							cr_id_receita = datalin.cr_id_receita;
							//console.log('cr_id_receita :: '+cr_id_receita);
							//alert(datalin.cr_titulo_receita);				
							$('#sel_receita').val("");
							$('#cr_id_receita').val(item.value);							
							$("#frmreceita").submit();
						  }else{
							//zeraCamposCli();
						  }
					});
				}				
			});
					
			const btnAbrirCarrinho = $('#abrir-carrinho');
		    const btnFecharCarrinho = $('#fechar-carrinho');
		    const carrinho = $('.carrinho');
		    carrinho.hide();

		    btnAbrirCarrinho.click(function() {
		        carrinho.show();
		        carrinho.addClass('aberto');
		    });

		    btnFecharCarrinho.click(function() {
		        carrinho.removeClass('aberto');
		        carrinho.hide();
		    });
		});
			
		
				
		//Chama a div card de receitas mais pesquisadas
		function verMais(){   									    
			$(".div_home").slideUp(200);
		    $(".div_card_receita").slideDown(200);		   
		}
		
		//Chama a div card de receitas mais pesquisadas
		function verMenos(){   									    
		    $(".div_card_receita").slideUp(200);		   
			$(".div_home").slideDown(200);
		}
		
		/* FORMA QUE TINHA FEITO QUE DIMINUI A QUANTIDADE DE CARDS QUE APARECEM NO CELULAR:
		function carregalistaTopReceitas(){		
			// limite o número de caracteres para exibir no modo de preparo e a Quantidade de Cards
			var larguraDaTela = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
			console.log("Largura da tela: " + larguraDaTela);

			//Desenhando os cards do Carrosel:
		  	var div_carrosel = $(".owl-carousel");
            div_carrosel.empty(); // Limpa o conteúdo do carrossel antes de adicionar os novos cards
            var cards_carrosel = ""; // Variável para armazenar os cards HTML
            var qtd_cards = 11;
            
            if(larguraDaTela < 1000){
            	qtd_cards = 5;
            }
            						
			for (var cards = 0; cards <= qtd_cards; cards++) {						    						    						
			    var card_carrosel = "<div class=\"item item_card_"+cards+"\"> " +
								    "    <div class=\"card\" id=\"cr_receita_card_"+cards+"\"> " +
								    "        <div class=\"img_receita\" id=\"cr_receita_nome_img_"+cards+"\"></div> " +
								    "        <div class=\"card-body d-flex flex-column\"> " +
								    "            <h6 class=\"card-title\" id=\"tit_receita_card_"+cards+"\"></h6> " +
								    "            <p class=\"card-text\" id=\"cr_modo_preparo_card_"+cards+"\"></p> " +
								    "            <div class=\"mt-auto\"> " +
								    "                <input type=\"hidden\" id=\"card_id_receita_"+cards+"\" name=\"card_id_receita_"+cards+"\"/> " +
								    "                <button type=\"button\" class=\"btn btn-success btn-lg\" id=\"btnReceita\" onclick=\"verReceita('"+cards+"');\"> " +
								    "                    <strong>Ver</strong> " +
								    "                </button> " +
								    "            </div> " +
								    "        </div> " +
								    "    </div> " +
								    "</div> ";								    
			    cards_carrosel += card_carrosel; // Concatena o card_carrosel na variável cards_carrosel			
			}			            					
            div_carrosel.append(cards_carrosel); // Adiciona todos os cards ao carrossel
            
			$.postJSON("./jsonservlet",{opc_servlet:'list_top_receitas',largura_tela:larguraDaTela},
				function(datalin,statuslin){
					if(datalin.length > 0){
						var num = 0;										         				
						for(var cx=0;cx <= qtd_cards;cx++){
													
							var cr_id_receita = datalin[cx].cr_id_receita;
							var cr_titulo_receita = datalin[cx].cr_titulo_receita;	
							var cr_modo_preparo_receita = datalin[cx].cr_modo_preparo_receita;	
							var cr_receita_nome_img = datalin[cx].cr_receita_nome_img;													
							
							var div_image = $("#cr_receita_nome_img_"+num);							
							div_image.append(cr_receita_nome_img);													
														
							var limite_caracteres = 30;
							
							if(larguraDaTela == 960){
								limite_caracteres = 20;
							}
							if(larguraDaTela == 1280){
								limite_caracteres = 40;
							}
							if(larguraDaTela >= 1300){
								limite_caracteres = 50;
							}
							
							// obtém a substring do modo de preparo com limite de caracteres
							var cr_modo_preparo_resumido = cr_modo_preparo_receita.slice(0, limite_caracteres) + '...';
																				
							$("#tit_receita_card_"+num).text(cr_titulo_receita);
							$("#cr_modo_preparo_card_"+num).text(cr_modo_preparo_resumido);
							$("#card_id_receita_"+num).val(cr_id_receita);
							
							num++;
						}
					}
					 $('.owl-carousel').owlCarousel({
				            loop: true,
				            margin: 10,
				            responsiveClass: true,
				            responsive: {
				                0: {
				                    items: 1,
				                    nav: true
				                },
				                560: {
				                    items: 2,
				                    nav: true
				                },
				                800: {
				                    items: 3,
				                    nav: true
				                },
				                1000: {
				                    items: 4,
				                    nav: true,
				                    loop: false
				                }
				            },
				            navText: ["<span class='custom-prev-button'></span>", "<span class='custom-next-button'></span>"]
				        });	
				}
			);
		}	
		*/
		
		//FORMA QUE CARREGA TODOS OS CARDS E IMPLEMENTA A BIBLIOTECA DO CARROUSEL DEPOIS
		function carregalistaTopReceitas(){		
			// limite o número de caracteres para exibir no modo de preparo
			var larguraDaTela = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
			console.log("Largura da tela: " + larguraDaTela);

			//Desenhando os cards do Carrosel:
		  	var div_carrosel = $(".owl-carousel");
            div_carrosel.empty(); // Limpa o conteúdo do carrossel antes de adicionar os novos cards
            var cards_carrosel = ""; // Variável para armazenar os cards HTML
            var qtd_cards = 11;
            					
			for (var cards = 0; cards <= qtd_cards; cards++) {						    						    						
			    var card_carrosel = "<div class=\"item item_card_"+cards+"\"> " +
								    "    <div class=\"card\" id=\"cr_receita_card_"+cards+"\"> " +
								    "        <div class=\"img_receita\" id=\"cr_receita_nome_img_"+cards+"\"></div> " +
								    "        <div class=\"card-body d-flex flex-column\"> " +
								    "            <h6 class=\"card-title\" id=\"tit_receita_card_"+cards+"\"></h6> " +
								    "            <p class=\"card-text\" id=\"cr_modo_preparo_card_"+cards+"\"></p> " +
								    "            <div class=\"mt-auto\"> " +
								    "                <input type=\"hidden\" id=\"card_id_receita_"+cards+"\" name=\"card_id_receita_"+cards+"\"/> " +
								    "                <button type=\"button\" class=\"btn btn-success btn-lg\" id=\"btnReceita\" onclick=\"verReceita('"+cards+"');\"> " +
								    "                    <strong>Ver</strong> " +
								    "                </button> " +
								    "            </div> " +
								    "        </div> " +
								    "    </div> " +
								    "</div> ";								    
			    cards_carrosel += card_carrosel; // Concatena o card_carrosel na variável cards_carrosel			
			}			            					
            div_carrosel.append(cards_carrosel); // Adiciona todos os cards ao carrossel
            
			$.postJSON("./jsonservlet",{opc_servlet:'list_top_receitas'},
				function(datalin,statuslin){
					if(datalin.length > 0){
						var num = 0;										         				
						for(var cx=0;cx <= qtd_cards;cx++){
													
							var cr_id_receita = datalin[cx].cr_id_receita;
							var cr_titulo_receita = datalin[cx].cr_titulo_receita;	
							var cr_modo_preparo_receita = datalin[cx].cr_modo_preparo_receita;	
							var cr_receita_nome_img = datalin[cx].cr_receita_nome_img;													
							
							var div_image = $("#cr_receita_nome_img_"+num);							
							div_image.append(cr_receita_nome_img);													
														
							var limite_caracteres = 30;
							
							if(larguraDaTela == 960){
								limite_caracteres = 20;
							}
							if(larguraDaTela == 1280){
								limite_caracteres = 40;
							}
							if(larguraDaTela >= 1300){
								limite_caracteres = 50;
							}
							
							// obtém a substring do modo de preparo com limite de caracteres
							var cr_modo_preparo_resumido = cr_modo_preparo_receita.slice(0, limite_caracteres) + '...';
																				
							$("#tit_receita_card_"+num).text(cr_titulo_receita);
							$("#cr_modo_preparo_card_"+num).text(cr_modo_preparo_resumido);
							$("#card_id_receita_"+num).val(cr_id_receita);
							
							num++;
						}
					}
					 $('.owl-carousel').owlCarousel({
				            loop: true,
				            margin: 10,
				            responsiveClass: true,
				            responsive: {
				                0: {
				                    items: 1,
				                    nav: true
				                },
				                560: {
				                    items: 2,
				                    nav: true
				                },
				                800: {
				                    items: 3,
				                    nav: true
				                },
				                1000: {
				                    items: 4,
				                    nav: true,
				                    loop: false
				                }
				            },
				            navText: ["<span class='custom-prev-button'></span>", "<span class='custom-next-button'></span>"]
				        });	
				}
			);
		}	
		
		function validaTamanhoDescReceita(){
			
			// limite o número de caracteres para exibir no modo de preparo
			var larguraDaTela = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
			//console.log("Largura da tela: " + larguraDaTela);
			
			var limite_caracteres = 0;
			
			/*
			 * Se a larguraDaTela for MAIOR ou IGUAL a 1300 irá
			 * Definir o limite_caracteres para 200 caracteres
			 */
			if(larguraDaTela >= 1300){				
				limite_caracteres = 200; 
				
				$.postJSON("./jsonservlet",{opc_servlet:'list_top_receitas'},
					function(datalin,statuslin){
						if(datalin.length > 0){
							var num = 0;					
							for(var cx=0;cx<datalin.length;cx++){
																				
								var cr_modo_preparo_receita = datalin[cx].cr_modo_preparo_receita;																																												

								var limite_caracteres = 50;																						
								
								// Obtém a substring do modo de preparo com limite de caracteres
								var cr_modo_preparo_resumido = cr_modo_preparo_receita.slice(0, limite_caracteres) + '...';
																											
								$("#cr_modo_preparo_card_"+num).text(cr_modo_preparo_resumido);							
								
								num++;
							}
						}
					}
				);
			}
			/*
			 * Se não se a larguraDaTela for IGUAL a 1280 irá
			 * Definir o limite_caracteres para 40 caracteres
			 */
			else if(larguraDaTela == 1280){
				limite_caracteres = 40;
				
				$.postJSON("./jsonservlet",{opc_servlet:'list_top_receitas'},
					function(datalin,statuslin){
						if(datalin.length > 0){
							var num = 0;					
							for(var cx=0;cx<datalin.length;cx++){
																				
								var cr_modo_preparo_receita = datalin[cx].cr_modo_preparo_receita;																																																					
								
								// Obtém a substring do modo de preparo com limite de caracteres
								var cr_modo_preparo_resumido = cr_modo_preparo_receita.slice(0, limite_caracteres) + '...';
																											
								$("#cr_modo_preparo_card_"+num).text(cr_modo_preparo_resumido);							
								
								num++;
							}
						}
					}
				);
			}
			/*
			 * Se não não for nenhuma das opções irá
			 * Definir o limite_caracteres para 50 caracteres
			 */
			 else{
				limite_caracteres = 50;
				
				$.postJSON("./jsonservlet",{opc_servlet:'list_top_receitas'},
					function(datalin,statuslin){
						if(datalin.length > 0){
							var num = 0;					
							for(var cx=0;cx<datalin.length;cx++){
																				
								var cr_modo_preparo_receita = datalin[cx].cr_modo_preparo_receita;																																												
						
								// Obtém a substring do modo de preparo com limite de caracteres
								var cr_modo_preparo_resumido = cr_modo_preparo_receita.slice(0, limite_caracteres) + '...';
																											
								$("#cr_modo_preparo_card_"+num).text(cr_modo_preparo_resumido);							
								
								num++;
							}
						}
					}
				);								
			}
		}
		
		//window.addEventListener('resize', validaTamanhoDescReceita);
	
		function verReceita(card_num){			
			var card_id = $("#card_id_receita_"+card_num).val();				
			$("#cr_id_receita").val(card_id);
			$("#frmreceita").submit();		
		}
		
		
		//Funções da Redefinição de Senha:
		function novaSenha(){
			var senha = $("#nova_senha").val();			
						
			if(senha == "" || senha.length == 0){
			 	// Remove a classe input-error se já estiver presente
			  	$("#nova_senha").removeClass('input-error');

			  	// Adiciona a classe input-error para acionar a animação e destaque vermelho
			  	$("#nova_senha").addClass('input-error');

			  	// Foca no input de email
			  	$("#nova_senha").focus();
				
			    // Remove o elemento de mensagem de erro existente
			    $(".error-message").remove();
			    
			 	// Cria um elemento para exibir a mensagem de erro
			 	var errorElement = $('<div class="error-message">Senha em branco, digite algo antes de enviar!</div>');
			  	$("#email_esqueci_senha_error").parent().append(errorElement);
				return false;
			}
			
			$.postJSON("./jsonservlet",{opc_servlet:'atualiza_senha',senha:senha},
				function(retornasenha){				
					var retorno = retornasenha.retorno;					
					if(retorno == 0){											        										      					 					
					    // Remove o elemento de mensagem de sucesso existente
					    $(".success-message").remove();
					    
					 	// Cria um elemento para exibir a mensagem de sucesso
					 	$("#nova_senha").val("");
					 	var successElement = $('<div class="success-message">Senha alterada com sucesso!</div>');
					  	$("#email_esqueci_senha_error").parent().append(successElement);									        
					}else{	
						// Remove a classe input-error se já estiver presente
					  	$("#email_esqueci_senha").removeClass('input-error');

					  	// Adiciona a classe input-error para acionar a animação e destaque vermelho
					  	$("#email_esqueci_senha").addClass('input-error');

					  	// Foca no input de email
					  	$("#email_esqueci_senha").focus();
						
					    // Remove o elemento de mensagem de erro existente
					    $(".error-message").remove();
					    
					 	// Cria um elemento para exibir a mensagem de erro
					 	var errorElement = $('<div class="error-message">Erro ao alterar senha!</div>');
					  	$("#email_esqueci_senha_error").parent().append(errorElement);														        									
					}					
					$("#nova_senha").prop('readonly', true);					
				}
			);
		}		
	</script>
		
	<body>	
		
		<%=MenuUtils.buildMenu("welcome", cru)%>
		
		
		<form id="frmreceita" name="frmreceita" method="post" action="cr_receita.jsp">
			<input type="hidden" id="cr_id_receita" name="cr_id_receita"/>
		</form>
		<form id="tela_home" name=tela_home method="post" action="cr_home.jsp">	
			<input type="hidden" id="cr_id_usuario" name="cr_id_usuario" value="0"/>
			<input type="hidden" id="opc_servlet" name="opc_servlet" value="salva_usuario"/>						
			<div class="div_home" style="font-size: 90%;">																
				<h2>Olá, Bem vindo ao<br/>Cozinha Rápida!</h2>																																								
				<div class="row justify-content-center mt-3 col-xl-2 col-lg-2 col-md-2 col-sm-12 col-12" style="position: absolute; left:50%; top:90%; transform: translate(-50%, -50%);">															
					<button type="button" class="btn btn-lg float-center arrow-icon" style="color: #FFFFFF; font-size: 20px;" onmouseover="verMais();">
						<strong>Ver mais</strong><br><i class="fa fa-chevron-down" aria-hidden="true"></i>	
					</button>								
				</div>				
			</div>		
			<!-- DIV CARD CARROSSEL RECEITA -->
			<div class="div_card_receita">				
				<div class="row justify-content-center mt-3 col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12" style="position: absolute; left:50%; top:10%; transform: translate(-50%, -50%);">															
						<button type="button" class="btn btn-lg float-center arrow-icon" style="color: #FFFFFF; font-size: 20px;" onmouseover="verMenos();">
							<i class="fa fa-chevron-up" aria-hidden="true"></i>
						</button>						
			   </div>	
								
				<div class="row justify-content-center col-xl-10 col-lg-10 col-md-10 col-sm-12 col-12 text-align" style="margin-top: 110px; position: absolute;">	
					<div id="tit_rec_mais_pesquisadas">
						<h4><strong>Receitas mais pesquisadas</strong></h4>
					</div>			
					<br>					
					<div class="owl-carousel">	
						<!-- CARROSEL COM 12 CARDS DA RECEITAS MAIS PESQUISADAS -->				       
					</div>
			     </div>
			</div>
		</form>
		<!-- MODAL ESQUECI SENHA -->
		<div class="modal fade" id="modalsenha" tabindex="-1" role="dialog" aria-labelledby="modalsenhaLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">		      
		      <div class="modal-header text-white" style="background-color:#636f61;">
		        <h5 class="modal-title" id="modalErroLabel">Redefinição de Senha</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
		          <span aria-hidden="true" class="text-white">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
	        	<p>Olá!<br>Notamos que você entrou com uma senha de redefinição. Por favor, digite sua nova senha abaixo:</p>
	        	<div class="input-group">
				  <input id="nova_senha" name="nova_senha" type="password" class="form-control" placeholder="Senha">
				  <div class="input-group-append">
				    <button class="btn btn-success" type="button" onclick="javascript:novaSenha();">Salvar</button>
				  </div>
				</div>				
			    <input type="hidden" id="email_esqueci_senha_error"  name="email_esqueci_senha_error">				  								
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-outline-dark" id="fecha_modal_esqueci_senha" data-dismiss="modal">Fechar</button>
		      </div>
		    </div>
		   </div>
		 </div>	
		 
 		<!-- Modal de mensagem de tratamento de Alerta -->
		<div class="modal fade" id="modalErro" tabindex="-1" role="dialog" aria-labelledby="modalErroLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header text-white" style="background-color:#636f61;">
		        <h5 class="modal-title" id="modalErroLabel">Alerta</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
		          <span aria-hidden="true" class="text-white">&times;</span>
		        </button>
		      </div>
		      <div class="mt-3 modal-body">    			      	   	  		        			    
	       		 <p id="mensagemErro"></p>			         
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-outline-dark" data-dismiss="modal">Fechar</button>
		      </div>
		    </div>
		   </div>
		 </div>
	</body>
</html>