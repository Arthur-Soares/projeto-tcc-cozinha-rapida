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
			background-color: #636f61;
			margin: 0px;
		    height: 100vh;
		    display: flex;
			flex-direction: row;
			justify-content: center;
			align-items: center;
			text-align: center;
			float: center;
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
							var cr_ingrediente_receita = datalin[cx].cr_ingrediente_receita;	
							
							$("#tit_receita_card_"+num).text(cr_titulo_receita);
							$("#desc_receita_card_"+num).text(cr_ingrediente_receita);
							
							num++;
						}
					}
				}
			);
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
			<div class="row justify-content-md-center mt-3  col-xl-2 col-lg-2 col-md-2 col-sm-12 col-12" style="position: absolute; left:50%; top:90%; transform: translate(-50%, -50%);">															
				<button type="button" class="btn btn-lg float-center" style="color: #FFFFFF; font-size: 20px;" onmouseover="verMais();">
					<strong>Ver mais</strong><br><i class="fa fa-chevron-down" aria-hidden="true"></i>	
				</button>								
			</div>				
			</div>		
			<!-- DIV CARD CARROSSEL RECEITA -->
			<div class="div_card_receita">				
				<div class="row mt-3 col-xl-1 col-lg-1 col-md-1 col-sm-12 col-12" style="position: absolute; left:50%; top:10%; transform: translate(-50%, -50%);">															
					<button type="button" class="btn btn-lg float-center" style="color: #FFFFFF; font-size: 20px;" onmouseover="verMenos();">
						<i class="fa fa-chevron-up" aria-hidden="true"></i>
					</button>						
				</div>
					<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
					    <h1><strong>Receitas Mais Pesquisadas</strong></h1>
						<br>								
					<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
					  <div class="carousel-inner">
					    <div class="carousel-item active">
					      <div class="row justify-content-center">
							  <div class="col-xl-8 col-lg-8 col-md-8 col-sm-12 col-12">
							    <div class="row text-center">
							      <div class="col-md-3">
							        <div class="card">
							          <img class="card-img-top" src="..." alt="Card image cap">
							          <div class="card-body"> 
							            <h5 class="card-title" id="tit_receita_card_0"></h5> <!-- CARD 1 -->
							            <p class="card-text" id="desc_receita_card_0"></p>
							          </div>
							        </div>
							      </div>
							      <div class="col-md-3">
							        <div class="card">
							          <img class="card-img-top" src="..." alt="Card image cap">
							          <div class="card-body">
							            <h5 class="card-title" id="tit_receita_card_1"></h5>
							            <p class="card-text" id="desc_receita_card_1"></p>
							          </div>
							        </div>
							      </div>
							      <div class="col-md-3">
							        <div class="card">
							          <img class="card-img-top" src="..." alt="Card image cap">
							          <div class="card-body">
							            <h5 class="card-title" id="tit_receita_card_2"></h5>
							            <p class="card-text" id="desc_receita_card_2"></p>
							          </div>
							        </div>
							      </div>
							      <div class="col-md-3">
							        <div class="card">
							          <img class="card-img-top" src="..." alt="Card image cap">
							          <div class="card-body">
							            <h5 class="card-title" id="tit_receita_card_3"></h5>
							            <p class="card-text" id="desc_receita_card_3"></p>
							          </div>
							        </div>
							      </div>
							    </div>
							  </div>
							</div>
					    </div>
					    <div class="carousel-item">
					      <div class="row justify-content-center">
							  <div class="col-xl-8 col-lg-8 col-md-8 col-sm-12 col-12">
							    <div class="row text-center">
							      <div class="col-md-3">
							        <div class="card">
							          <img class="card-img-top" src="..." alt="Card image cap">
							          <div class="card-body">
							            <h5 class="card-title" id="tit_receita_card_4"></h5>
							            <p class="card-text" id="desc_receita_card_4"></p>
							          </div>
							        </div>
							      </div>
							      <div class="col-md-3">
							        <div class="card">
							          <img class="card-img-top" src="..." alt="Card image cap">
							          <div class="card-body">
							            <h5 class="card-title" id="tit_receita_card_5"></h5>
							            <p class="card-text" id="desc_receita_card_5"></p>
							          </div>
							        </div>
							      </div>
							      <div class="col-md-3">
							        <div class="card">
							          <img class="card-img-top" src="..." alt="Card image cap">
							          <div class="card-body">
							            <h5 class="card-title" id="tit_receita_card_6"></h5>
							            <p class="card-text" id="desc_receita_card_6"></p>
							          </div>
							        </div>
							      </div>
							      <div class="col-md-3">
							        <div class="card">
							          <img class="card-img-top" src="..." alt="Card image cap">
							          <div class="card-body">
							            <h5 class="card-title" id="tit_receita_card_7"></h5>
							            <p class="card-text" id="desc_receita_card_7"></p>
							          </div>
							        </div>
							      </div>
							    </div>
							  </div>
							</div>
					    </div>
					    <div class="carousel-item">
					      <div class="row justify-content-center">
							  <div class="col-xl-8 col-lg-8 col-md-8 col-sm-12 col-12">
							    <div class="row text-center">
							      <div class="col-md-3">
							        <div class="card">
							          <img class="card-img-top" src="..." alt="Card image cap">
							          <div class="card-body">
							            <h5 class="card-title" id="tit_receita_card_8"></h5>
							            <p class="card-text" id="desc_receita_card_8"></p>
							          </div>
							        </div>
							      </div>
							      <div class="col-md-3">
							        <div class="card">
							          <img class="card-img-top" src="..." alt="Card image cap">
							          <div class="card-body">
							            <h5 class="card-title" id="tit_receita_card_9"></h5>
							            <p class="card-text" id="desc_receita_card_9"></p>
							          </div>
							        </div>
							      </div>
							      <div class="col-md-3">
							        <div class="card">
							          <img class="card-img-top" src="..." alt="Card image cap">
							          <div class="card-body">
							            <h5 class="card-title" id="tit_receita_card_10"></h5>
							            <p class="card-text" id="desc_receita_card_10"></p>
							          </div>
							        </div>
							      </div>
							      <div class="col-md-3">
							        <div class="card">
							          <img class="card-img-top" src="..." alt="Card image cap">
							          <div class="card-body">
							            <h5 class="card-title" id="tit_receita_card_11"></h5>
							            <p class="card-text" id="desc_receita_card_11"></p>
							          </div>
							        </div>
							      </div>
							    </div>
							  </div>
							</div>
					    </div>
					  </div>
					  <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
					    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
					    <span class="sr-only">Previous</span>
					  </a>
					  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
					    <span class="carousel-control-next-icon" aria-hidden="true"></span>
					    <span class="sr-only">Next</span>
					  </a>
					 <br><br>
					  <ol class="carousel-indicators">
					    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
					    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
					    <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
					  </ol>
					</div>
				</div>
			</div>
		</form>
	</body>
</html>