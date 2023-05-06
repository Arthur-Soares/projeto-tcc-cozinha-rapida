<%@page import="projeto.util.MenuUtils"%>
<%@page import="projeto.util.AppSecrets"%>
<%@page import="projeto.model.Cr_usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR, pt">
	<head>
		<title>Home - Cozinha Rápida</title>
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
			font-family: 'Open Sans', sans-serif;							
		}
			
		h6 {	
			color: #FFFFFF;
			font-weight: 800;
			font-family: 'Open Sans', sans-serif;							
		}
		
		#tit_rec_mais_pesquisadas {	
			height: 800;
			color: #FFFFFF;
			font-weight: 800;
			font-family: 'Open Sans', sans-serif;
			font-size: 40px;							
		}		
		
		body {
			background: url('imagens/fast_kitchen_home_menorzinha.png') no-repeat center center fixed; 
			height: 100%;
			-webkit-background-size: cover;
			-moz-background-size: cover;
			-o-background-size: cover;
			background-size: cover;			
			font-family: 'Open Sans', sans-serif;			
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
		
		@media (max-width: 768px) {
		  .container {
		    flex-direction: column;
		    align-items: center;
		  }
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
			
		.card-body{
		  background-color: #636f61;
		  border-radius: 11px;			  		  
		}
				
		.card {
		  position: flex;	
		  background-color: #636f61;
		  border-radius: 11px;	
		  height: 50vh;   		 
		  margin-bottom: 30px;
		  /*width: 240px;  ajuste o tamanho do cartão de acordo com suas necessidades */
		  /*height: 320px;  ajuste o tamanho do cartão de acordo com suas necessidades */			  		
		}
		
		.card-text{
			color: #FFFFFF;			
			font-family: 'Open Sans', sans-serif;		
		}
		
		.img_receita {
		  position: relative;
		  height: 200px; /* ajuste a altura da imagem de acordo com suas necessidades */
		  border: 6px solid #323232; /* adiciona uma borda preta de 2px */
		  border-radius: 10px;
  		  box-sizing: border-box; /* inclui a largura da borda no cálculo do tamanho do iframe */
  		  box-shadow: 0px 0px 10px; /* adiciona uma sombra de 10px ao redor da div */  		  
		}
		
		.img_receita iframe {
		  position: absolute;
		  top: 0;
		  left: 0;
		  width: 100%;
		  height: 100%;
	      object-fit: cover;		           	    
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
		
		.carousel-control-prev,
		.carousel-control-next {
		  /* Adicione essas propriedades: */
		  top: 50%; /* posiciona os botões verticalmente ao meio da tela */
		  transform: translateY(-50%); /* centraliza verticalmente */
		  margin-top: 0; /* remove o espaçamento superior */
		  /* mantenha as outras propriedades que você já definiu */
	      overflow: hidden;
		}
			
		.carousel-control-prev {
		  left: 4%;
		}
		
		.carousel-control-next {
		  right: 4%;
		}
		
		.carousel-control-prev,
		.carousel-control-next {
		  width: 50px; /* ajuste o tamanho conforme necessário */
		  height: 50px;
		  background-color: #000;
		  border-radius: 10px;
		  opacity: 0.5;
		}
		
		.carousel-control-prev:hover,
		.carousel-control-next:hover {
		  opacity: 1;
		}
		
		.carousel-control-prev-icon,
		.carousel-control-next-icon {
		  background-color: transparent;
		  border: none;
		}
		
		.carousel-control-prev-icon::before,
		.carousel-control-next-icon::before {		  
		  width: 20px;
		  height: 20px;		  
		  color: #fff; 
		}
		
		.arrow-icon {
		  animation-name: arrow-bounce;
		  animation-duration: 1s;
		  animation-timing-function: ease-in-out;
		  animation-iteration-count: infinite;
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
		/* 
		@media(max-width: 1100px) {
   			#cr_receita_card_3,#cr_receita_card_7,#cr_receita_card_11{
       			display: none;
   			}
		}
		
		@media(max-width: 768px) {
   			#cr_receita_card_1,#cr_receita_card_2,#cr_receita_card_3,#cr_receita_card_5,#cr_receita_card_6,
   			#cr_receita_card_7,#cr_receita_card_9,#cr_receita_card_10,#cr_receita_card_11{
       			display: none;
   			} */
   			
   		/* 	.carousel-inner {
			  width: 80%; 
			  margin: 0 auto; 
		} */
		
		/* @media(max-width: 600px) {
   			#cr_receita_card_1,#cr_receita_card_2,#cr_receita_card_3,#cr_receita_card_5,#cr_receita_card_6,
   			#cr_receita_card_7,#cr_receita_card_9,#cr_receita_card_10,#cr_receita_card_11{
       			display: none;
   			} */
   			   	
			/* .carousel-inner {
			  width: 80%; 
			  margin: 0 auto; 		  
			}	
			
			#cr_receita_card_0,#cr_receita_card_4,#cr_receita_card_8{
       			margin-left: 14%;			
   			}
   			
   			#tit_rec_mais_pesquisadas {	
				color: #FFFFFF;
				font-weight: 800;
				font-family: 'Open Sans', sans-serif;
				font-size: 25px;	
				padding-bottom: 10px;						
			}			   
		}		
		 */
		
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
			 $('.owl-carousel').owlCarousel({
		            loop: true,
		            margin: 10,
		            responsiveClass: true,
		            responsive: {
		                0: {
		                    items: 1,
		                    nav: true
		                },
		                600: {
		                    items: 3,
		                    nav: false
		                },
		                1000: {
		                    items: 4,
		                    nav: true,
		                    loop: false
		                }
		            }
		        });	
		
			var logoff = '<%=opclogoff%>';
			if(logoff == "S"){
				$("#tela_home").submit();
			}
			carregalistaTopReceitas();
			
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
				console.log('Passei evt :: '+evt+' -- item.value :: '+item.value+' -- item.text :: '+item.text);
				if(item){										
					//CHAMANDO outra URL para buscar os dados específicos do CLIENTE que selecionamos
					//$.getJSON( "./jsonservlet?opc_servlet=find_pesquisa_receita&q="+item.value, function( data ) {
						
					var cr_id_receita = "";
					//TENTANDO OUTRA FORMA DE CHAMAR
					$.getJSON("./jsonservlet",{opc_servlet:'find_receita',cr_id_receita:item.value}, 
					 function(datalin,statuslin){						
						  if(datalin){							  
							cr_id_receita = datalin.cr_id_receita;
							console.log('cr_id_receita :: '+cr_id_receita);
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
		
		function carregalistaTopReceitas(){						
			$.postJSON("./jsonservlet",{opc_servlet:'list_top_receitas'},
				function(datalin,statuslin){
					if(datalin.length > 0){
						var num = 0;					
						for(var cx=0;cx<datalin.length;cx++){
													
							var cr_id_receita = datalin[cx].cr_id_receita;
							var cr_titulo_receita = datalin[cx].cr_titulo_receita;	
							var cr_modo_preparo_receita = datalin[cx].cr_modo_preparo_receita;	
							var cr_receita_nome_img = datalin[cx].cr_receita_nome_img;													
							
							var div_image = $("#cr_receita_nome_img_"+num);							
							div_image.append(cr_receita_nome_img);													
							
							// limite o número de caracteres para exibir no modo de preparo
							var limite_caracteres = 100;						

							// obtém a substring do modo de preparo com limite de caracteres
							var cr_modo_preparo_resumido = cr_modo_preparo_receita.slice(0, limite_caracteres) + '...';
																				
							$("#tit_receita_card_"+num).text(cr_titulo_receita);
							$("#cr_modo_preparo_card_"+num).text(cr_modo_preparo_resumido);
							$("#card_id_receita_"+num).val(cr_id_receita);
							
							num++;
						}
					}
				}
			);
		}	
	
		function verReceita(card_num){			
			var card_id = $("#card_id_receita_"+card_num).val();				
			$("#cr_id_receita").val(card_id);
			$("#frmreceita").submit();		
		}
	</script>
		
	<body>	
		
		<%=MenuUtils.buildMenu("welcome", cru, "")%>
		
		
		<form id="frmreceita" name="frmreceita" method="post" action="/projeto-tcc-cozinha-rapida/restrito/cr_receita.jsp">
			<input type="hidden" id="cr_id_receita" name="cr_id_receita"/>
		</form>
		<form id="tela_home" name=tela_home method="post" action="home_cozinharapida.jsp">	
			<input type="hidden" id="cr_id_usuario" name="cr_id_usuario" value="0"/>
			<input type="hidden" id="opc_servlet" name="opc_servlet" value="salva_usuario"/>						
			<div class="div_home" style="font-size: 90%;">																
				<h1>Olá, Bem vindo ao<br/>Cozinha Rápida!</h1>																																								
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
								
				<div class="row justify-content-center col-xl-10 col-lg-10 col-md-10 col-sm-12 col-12 text-align" style="margin-top: 8%;">	
					<div id="tit_rec_mais_pesquisadas">Receitas Mais Pesquisadas</div>			
					<br>					
					<div class="owl-carousel">
				        <div class="item">
				            <div class="card" id="cr_receita_card_0">
					          <div class="img_receita" id="cr_receita_nome_img_0"></div>							          
						          <div class="card-body"> 
						            <h6 class="card-title" id="tit_receita_card_0"></h6>
						            <p class="card-text" id="cr_modo_preparo_card_0"></p>
						            <div class="row mt-3 justify-content-center div_conteudo_rec">
						            	<input type="hidden" id="card_id_receita_0" name="card_id_receita_0"/>							            																														
										<button type="button" class="btn btn-success btn-lg" id="btnReceita" onclick="verReceita('0');">
											<strong>Ver</strong> 
										</button>
									</div>
						          </div>
					        </div>
				        </div>
				        <div class="item">
				            <div class="card" id="cr_receita_card_1">
					          <div class="img_receita" id="cr_receita_nome_img_1"></div>							          
						          <div class="card-body"> 
						            <h6 class="card-title" id="tit_receita_card_1"></h6>
						            <p class="card-text" id="cr_modo_preparo_card_1"></p>
						            <div class="row mt-3 justify-content-center div_conteudo_rec">
						            	<input type="hidden" id="card_id_receita_1" name="card_id_receita_1"/>							            																														
										<button type="button" class="btn btn-success btn-lg" id="btnReceita" onclick="verReceita('1');">
											<strong>Ver</strong> 
										</button>
									</div>
						          </div>
					        </div>
				        </div>
				        <div class="item">
				            <div class="card" id="cr_receita_card_2">
					          <div class="img_receita" id="cr_receita_nome_img_2"></div>							          
				         		<div class="card-body"> 
						            <h6 class="card-title" id="tit_receita_card_2"></h6>
						            <p class="card-text" id="cr_modo_preparo_card_2"></p>
						            <div class="row mt-3 justify-content-center div_conteudo_rec">
						            	<input type="hidden" id="card_id_receita_2" name="card_id_receita_2"/>							            																														
										<button type="button" class="btn btn-success btn-lg" id="btnReceita" onclick="verReceita('2');">
											<strong>Ver</strong> 
										</button>
									</div>
					          	</div>
					        </div>
				        </div>
				        <div class="item">
				            <div class="card" id="cr_receita_card_3">
					          <div class="img_receita" id="cr_receita_nome_img_3"></div>							          
					          	<div class="card-body"> 
						            <h6 class="card-title" id="tit_receita_card_3"></h6>
						            <p class="card-text" id="cr_modo_preparo_card_3"></p>
						            <div class="row mt-3 justify-content-center div_conteudo_rec">
						            	<input type="hidden" id="card_id_receita_3" name="card_id_receita_3"/>							            																														
										<button type="button" class="btn btn-success btn-lg" id="btnReceita" onclick="verReceita('3');">
											<strong>Ver</strong> 
										</button>
									</div>
					          	</div>
					        </div>
				        </div>
				        <div class="item">
				            <div class="card" id="cr_receita_card_4">
					          <div class="img_receita" id="cr_receita_nome_img_4"></div>							          
					          	<div class="card-body"> 
						            <h6 class="card-title" id="tit_receita_card_4"></h6>
						            <p class="card-text" id="cr_modo_preparo_card_4"></p>
						            <div class="row mt-3 justify-content-center div_conteudo_rec">
						            	<input type="hidden" id="card_id_receita_4" name="card_id_receita_4"/>							            																														
										<button type="button" class="btn btn-success btn-lg" id="btnReceita" onclick="verReceita('4');">
											<strong>Ver</strong> 
										</button>
									</div>
					          	</div>
					        </div>
				        </div>
				        <div class="item">
				            <div class="card" id="cr_receita_card_5">
					          <div class="img_receita" id="cr_receita_nome_img_5"></div>							          
					          	<div class="card-body"> 
						            <h6 class="card-title" id="tit_receita_card_5"></h6>
						            <p class="card-text" id="cr_modo_preparo_card_5"></p>
						            <div class="row mt-3 justify-content-center div_conteudo_rec">
						            	<input type="hidden" id="card_id_receita_5" name="card_id_receita_5"/>							            																														
										<button type="button" class="btn btn-success btn-lg" id="btnReceita" onclick="verReceita('5');">
											<strong>Ver</strong> 
										</button>
									</div>
					          	</div>
					        </div>
				        </div>
				        <div class="item">
				            <div class="card" id="cr_receita_card_6">
					          <div class="img_receita" id="cr_receita_nome_img_6"></div>							          
					         	 <div class="card-body"> 
						            <h6 class="card-title" id="tit_receita_card_6"></h6>
						            <p class="card-text" id="cr_modo_preparo_card_6"></p>
						            <div class="row mt-3 justify-content-center div_conteudo_rec">
						            	<input type="hidden" id="card_id_receita_6" name="card_id_receita_6"/>							            																														
										<button type="button" class="btn btn-success btn-lg" id="btnReceita" onclick="verReceita('6');">
											<strong>Ver</strong> 
										</button>
									</div>
					          	</div>
					        </div>
				        </div>
				        <div class="item">
				            <div class="card" id="cr_receita_card_7">
					          <div class="img_receita" id="cr_receita_nome_img_7"></div>							          
					          	<div class="card-body"> 
						            <h6 class="card-title" id="tit_receita_card_7"></h6>
						            <p class="card-text" id="cr_modo_preparo_card_7"></p>
						            <div class="row mt-3 justify-content-center div_conteudo_rec">
						            	<input type="hidden" id="card_id_receita_7" name="card_id_receita_7"/>							            																														
										<button type="button" class="btn btn-success btn-lg" id="btnReceita" onclick="verReceita('7');">
											<strong>Ver</strong> 
										</button>
									</div>
				         	 	</div>
					        </div>
				        </div>
				        <div class="item">
				            <div class="card" id="cr_receita_card_8">
					          <div class="img_receita" id="cr_receita_nome_img_8"></div>							          
					          	<div class="card-body"> 
						            <h6 class="card-title" id="tit_receita_card_8"></h6>
						            <p class="card-text" id="cr_modo_preparo_card_8"></p>
						            <div class="row mt-3 justify-content-center div_conteudo_rec">
						            	<input type="hidden" id="card_id_receita_8" name="card_id_receita_8"/>							            																														
										<button type="button" class="btn btn-success btn-lg" id="btnReceita" onclick="verReceita('8');">
											<strong>Ver</strong> 
										</button>
									</div>
				         	 	</div>
					        </div>
				        </div>
				        <div class="item">
				            <div class="card" id="cr_receita_card_9">
					          <div class="img_receita" id="cr_receita_nome_img_9"></div>							          
					          	<div class="card-body"> 
						            <h6 class="card-title" id="tit_receita_card_9"></h6>
						            <p class="card-text" id="cr_modo_preparo_card_9"></p>
						            <div class="row mt-3 justify-content-center div_conteudo_rec">
						            	<input type="hidden" id="card_id_receita_9" name="card_id_receita_9"/>							            																														
										<button type="button" class="btn btn-success btn-lg" id="btnReceita" onclick="verReceita('9');">
											<strong>Ver</strong> 
										</button>
									</div>
					          	</div>
					        </div>
				        </div>
				        <div class="item">
				            <div class="card" id="cr_receita_card_10">
					          <div class="img_receita" id="cr_receita_nome_img_10"></div>							          
					          	<div class="card-body"> 
						            <h6 class="card-title" id="tit_receita_card_10"></h6>
						            <p class="card-text" id="cr_modo_preparo_card_10"></p>
						            <div class="row mt-3 justify-content-center div_conteudo_rec">
						            	<input type="hidden" id="card_id_receita_10" name="card_id_receita_10"/>							            																														
										<button type="button" class="btn btn-success btn-lg" id="btnReceita" onclick="verReceita('10');">
											<strong>Ver</strong> 
										</button>
									</div>
					          	</div>
					        </div>
				        </div>
				        <div class="item">
				            <div class="card" id="cr_receita_card_11">
					          <div class="img_receita" id="cr_receita_nome_img_11"></div>							          
					          	<div class="card-body"> 
						            <h6 class="card-title" id="tit_receita_card_11"></h6>
						            <p class="card-text" id="cr_modo_preparo_card_11"></p>
						            <div class="row mt-3 justify-content-center div_conteudo_rec">
						            	<input type="hidden" id="card_id_receita_11" name="card_id_receita_11"/>							            																														
										<button type="button" class="btn btn-success btn-lg" id="btnReceita" onclick="verReceita('11');">
											<strong>Ver</strong> 
										</button>
									</div>
					          	</div>
					        </div>
				        </div>			        
				    </div>
			     </div>

			    
				<!-- 				
				<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12" style="margin-top: 80px;">																							
					<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel"  id="carousel_receitas_mais">
					    <div id="tit_rec_mais_pesquisadas">Receitas Mais Pesquisadas</div>	
					  <div class="carousel-inner">
					    <div class="carousel-item active">
					      <div class="row justify-content-center">
							  <div class="col-xl-10 col-lg-10 col-md-10 col-sm-12 col-12" style="height: 60vh"> 
							    <div class="row text-center">
							      <div class="col-xl-3 col-lg-3 col-md-4 col-sm-6 col-12">
							        <div class="card" id="cr_receita_card_0">
							          <div class="img_receita" id="cr_receita_nome_img_0"></div>							          
							          <div class="card-body"> 
							            <h6 class="card-title" id="tit_receita_card_0"></h6>
							            <p class="card-text" id="cr_modo_preparo_card_0"></p>
							            <div class="row mt-3 justify-content-center div_conteudo_rec">
							            	<input type="hidden" id="card_id_receita_0" name="card_id_receita_0"/>							            																														
											<button type="button" class="btn btn-success btn-lg" id="btnReceita" onclick="verReceita('0');">
												<strong>Ver</strong> 
											</button>
										</div>
							          </div>
							        </div>
							      </div>
							      <div class="col-xl-3 col-lg-3 col-md-4 col-sm-6 col-12">
							        <div class="card" id="cr_receita_card_1">
							          <div class="img_receita" id="cr_receita_nome_img_1"></div>	
							          <div class="card-body">
							            <h6 class="card-title" id="tit_receita_card_1"></h6>
							            <p class="card-text" id="cr_modo_preparo_card_1"></p>
							             <div class="row mt-3 justify-content-center div_conteudo_rec">																															
											<input type="hidden" id="card_id_receita_1" name="card_id_receita_1"/>							            																														
											<button type="button" class="btn btn-success btn-lg" id="btnReceita" onclick="verReceita('1');">
												<strong>Ver</strong> 
											</button>
										</div>
							          </div>
							        </div>
							      </div>
							      <div class="col-xl-3 col-lg-3 col-md-4 col-sm-6 col-12">
							        <div class="card" id="cr_receita_card_2">
							          <div class="img_receita" id="cr_receita_nome_img_2"></div>	
							          <div class="card-body">
							            <h6 class="card-title" id="tit_receita_card_2"></h6>
							            <p class="card-text" id="cr_modo_preparo_card_2"></p>
						                <div class="row mt-3 justify-content-center div_conteudo_rec">																															
											<input type="hidden" id="card_id_receita_2" name="card_id_receita_2"/>							            																														
											<button type="button" class="btn btn-success btn-lg" id="btnReceita" onclick="verReceita('2');">
												<strong>Ver</strong> 
											</button>
										</div>
							          </div>
							        </div>
							      </div>
							      <div class="col-xl-3 col-lg-3 col-md-3 col-sm-6x col-12">
							        <div class="card" id="cr_receita_card_3">
							          <div class="img_receita" id="cr_receita_nome_img_3"></div>	
							          <div class="card-body">
							            <h6 class="card-title" id="tit_receita_card_3"></h6>
							            <p class="card-text" id="cr_modo_preparo_card_3"></p>
						                <div class="row mt-3 justify-content-center div_conteudo_rec">																															
											<input type="hidden" id="card_id_receita_3" name="card_id_receita_3"/>							            																														
											<button type="button" class="btn btn-success btn-lg" id="btnReceita" onclick="verReceita('3');">
												<strong>Ver</strong> 
											</button>
										</div>
							          </div>
							        </div>
							      </div>
							    </div>
							  </div>
							</div>
					    </div>
					    <div class="carousel-item">
					      <div class="row justify-content-center">
							  <div class="col-xl-10 col-lg-10 col-md-10 col-sm-12 col-12" style="height: 60vh"> 
							    <div class="row text-center">
							      <div class="col-xl-3 col-lg-3 col-md-4 col-sm-6 col-12">
							        <div class="card" id="cr_receita_card_4">
							          <div class="img_receita" id="cr_receita_nome_img_4"></div>
							          <div class="card-body">
							            <h6 class="card-title" id="tit_receita_card_4"></h6>
							            <p class="card-text" id="cr_modo_preparo_card_4"></p>
							            <div class="row mt-3 justify-content-center div_conteudo_rec">																															
											<input type="hidden" id="card_id_receita_4" name="card_id_receita_4"/>							            																														
											<button type="button" class="btn btn-success btn-lg" id="btnReceita" onclick="verReceita('4');">
												<strong>Ver</strong> 
											</button>
										</div>
							          </div>
							        </div>
							      </div>
							      <div class="col-xl-3 col-lg-3 col-md-4 col-sm-6 col-12">
							        <div class="card" id="cr_receita_card_5">
							          <div class="img_receita" id="cr_receita_nome_img_5"></div>
							          <div class="card-body">
							            <h6 class="card-title" id="tit_receita_card_5"></h6>
							            <p class="card-text" id="cr_modo_preparo_card_5"></p>
							            <div class="row mt-3 justify-content-center div_conteudo_rec">																															
											<input type="hidden" id="card_id_receita_5" name="card_id_receita_5"/>							            																														
											<button type="button" class="btn btn-success btn-lg" id="btnReceita" onclick="verReceita('5');">
												<strong>Ver</strong> 
											</button>
										</div>
							          </div>
							        </div>
							      </div>
							      <div class="col-xl-3 col-lg-3 col-md-4 col-sm-6 col-12">
							        <div class="card" id="cr_receita_card_6">
							          <div class="img_receita" id="cr_receita_nome_img_6"></div>
							          <div class="card-body">
							            <h6 class="card-title" id="tit_receita_card_6"></h6>
							            <p class="card-text" id="cr_modo_preparo_card_6"></p>
							            <div class="row mt-3 justify-content-center div_conteudo_rec">																															
											<input type="hidden" id="card_id_receita_6" name="card_id_receita_6"/>							            																														
											<button type="button" class="btn btn-success btn-lg" id="btnReceita" onclick="verReceita('6');">
												<strong>Ver</strong> 
											</button>
										</div>
							          </div>
							        </div>
							      </div>
							      <div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-12">
							        <div class="card" id="cr_receita_card_7">
							          <div class="img_receita" id="cr_receita_nome_img_7"></div>
							          <div class="card-body">
							            <h6 class="card-title" id="tit_receita_card_7"></h6>
							            <p class="card-text" id="cr_modo_preparo_card_7"></p>
							            <div class="row mt-3 justify-content-center div_conteudo_rec">																															
											<input type="hidden" id="card_id_receita_7" name="card_id_receita_7"/>							            																														
											<button type="button" class="btn btn-success btn-lg" id="btnReceita" onclick="verReceita('7');">
												<strong>Ver</strong> 
											</button>
										</div>
							          </div>
							        </div>
							      </div>
							    </div>
							  </div>
							</div>
					    </div>
					    <div class="carousel-item">
					      <div class="row justify-content-center">
							  <div class="col-xl-10 col-lg-10 col-md-10 col-sm-12 col-12" style="height: 60vh"> 
							    <div class="row text-center">
							      <div class="col-xl-3 col-lg-3 col-md-4 col-sm-6 col-12">
							        <div class="card" id="cr_receita_card_8">
							          <div class="img_receita" id="cr_receita_nome_img_8"></div>
							          <div class="card-body">
							            <h6 class="card-title" id="tit_receita_card_8"></h6>
							            <p class="card-text" id="cr_modo_preparo_card_8"></p>
							            <div class="row mt-3 justify-content-center div_conteudo_rec">																															
											<input type="hidden" id="card_id_receita_8" name="card_id_receita_8"/>							            																														
											<button type="button" class="btn btn-success btn-lg" id="btnReceita" onclick="verReceita('8');">
												<strong>Ver</strong> 
											</button>
										</div>
							          </div>
							        </div>
							      </div>
							      <div class="col-xl-3 col-lg-3 col-md-4 col-sm-6 col-12">
							        <div class="card" id="cr_receita_card_9">
							          <div class="img_receita" id="cr_receita_nome_img_9"></div>
							          <div class="card-body">
							            <h6 class="card-title" id="tit_receita_card_9"></h6>
							            <p class="card-text" id="cr_modo_preparo_card_9"></p>
							            <div class="row mt-3 justify-content-center div_conteudo_rec">																															
											<input type="hidden" id="card_id_receita_9" name="card_id_receita_9"/>							            																														
											<button type="button" class="btn btn-success btn-lg" id="btnReceita" onclick="verReceita('9');">
												<strong>Ver</strong> 
											</button>
										</div>
							          </div>
							        </div>
							      </div>
							      <div class="col-xl-3 col-lg-3 col-md-4 col-sm-6 col-12">
							        <div class="card" id="cr_receita_card_10">
							          <div class="img_receita" id="cr_receita_nome_img_10"></div>
							          <div class="card-body">
							            <h6 class="card-title" id="tit_receita_card_10"></h6>
							            <p class="card-text" id="cr_modo_preparo_card_10"></p>
							            <div class="row mt-3 justify-content-center div_conteudo_rec">																															
											<input type="hidden" id="card_id_receita_10" name="card_id_receita_10"/>							            																														
											<button type="button" class="btn btn-success btn-lg" id="btnReceita" onclick="verReceita('10');">
												<strong>Ver</strong> 
											</button>
										</div>
							          </div>
							        </div>
							      </div>
							      <div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-12">
							        <div class="card" id="cr_receita_card_11">
							          <div class="img_receita" id="cr_receita_nome_img_11"></div>
							          <div class="card-body">
							            <h6 class="card-title" id="tit_receita_card_11"></h6>
							            <p class="card-text" id="cr_modo_preparo_card_11"></p>
							            <div class="row mt-3 justify-content-center div_conteudo_rec">																															
											<input type="hidden" id="card_id_receita_11" name="card_id_receita_11"/>							            																														
											<button type="button" class="btn btn-success btn-lg" id="btnReceita" onclick="verReceita('11');">
												<strong>Ver</strong> 
											</button>
										</div>
							          </div>
							        </div>
							      </div>
							    </div>
							  </div>
							</div>
					    </div>
					  </div>					 
					 <br><br><br>
					  <ol class="carousel-indicators">
					    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
					    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
					    <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
					  </ol>
					</div>
						 <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
						    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
						    <span class="sr-only">Previous</span>
						  </a>
						  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
						    <span class="carousel-control-next-icon" aria-hidden="true"></span>
						    <span class="sr-only">Next</span>
						  </a>
				</div> -->
			</div>
		</form>
	</body>
</html>