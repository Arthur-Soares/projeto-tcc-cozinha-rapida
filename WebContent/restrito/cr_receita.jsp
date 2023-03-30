<%@page import="projeto.util.MenuUtils"%>
<%@page import="projeto.util.Cast"%>
<%@page import="projeto.util.AppSecrets"%>
<%@page import="projeto.model.Cr_usuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<%	
	String p_cr_id_receita = null!=request.getParameter("cr_id_receita")?request.getParameter("cr_id_receita"):"";
	Cr_usuario cru = null!=session.getAttribute(AppSecrets.USER_KEY)?(Cr_usuario)session.getAttribute(AppSecrets.USER_KEY):null;
	int cuserid = null!=cru?cru.getCr_id_usuario():0;
	String cuseradmin = null!=cru?cru.getCr_nivel_usuario():"";
	String cusername = null!=cru?cru.getCr_nome_completo_usuario():"";
	String redir = null!=request.getParameter("redir")?request.getParameter("redir"):"";
	String opclogoff = null!=request.getParameter("logoff")?request.getParameter("logoff"):"";
	//logoff=S
	String msgIndex = null != session.getAttribute("errologin") ? (String) session.getAttribute("errologin") : "";
	
	//System.out.println("VENDO O ID DO USU�RIO :: "+cuserid);
			
	if("S".equals(opclogoff) || !"".equals(msgIndex)){
		session.setAttribute("errologin", null);
		session.setAttribute("projeto.model.Cr_usuario", null);		
	}
	
	System.out.println("p_cr_id_receita :: "+p_cr_id_receita);
	%>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">		
		<title>Cozinha R�pida - Receita</title>
		<link href="../css/bootstrap.min.css" rel="stylesheet">
		<link href="../fontawesome/css/all.min.css" rel="stylesheet">
		<link href="../css/bootstrap-datepicker.css" rel="stylesheet"/>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
		<script type="text/javascript" src="../js/jquery-3.3.1.js"></script>
		<script type="text/javascript" src="../js/bootstrap.min.js"></script>
		<script type="text/javascript" src="../fontawesome/js/all.min.js"></script>
		<script type="text/javascript" src="../js/bootstrap-autocomplete.js"></script>
		<script type="text/javascript" src="../js/popper.js"></script>
		<script src="../js/bootstrap-datepicker.min.js"></script>
		<script src="../js/bootstrap-datepicker.pt-BR.min.js"></script>
		<!-- <script src="../js/jquery.maskMoney.min.js" type="text/javascript"></script>       
		 data-thousands="." data-decimal="," data-prefix="R$ "  -->
		
		<!-- Data Tables -->
		<script src="../js/datatables/jquery.dataTables.min.js"></script>
		<script src="../js/datatables/dataTables.bootstrap4.min.js"></script>
		<script src="../js/datatables/dataTables.fixedHeader.min.js"></script>
		<script src="../js/datatables/dataTables.responsive.min.js"></script>
		<script src="../js/datatables/responsive.bootstrap.min.js"></script>

		<link rel="stylesheet" href="../css/datatables/dataTables.bootstrap4.min.css">
		<link rel="stylesheet" href="../css/datatables/fixedHeader.bootstrap4.min.css">
		<link rel="stylesheet" href="../css/datatables/responsive.bootstrap.min.css">
		<!-- Final Data Tables -->
		<style type="text/css">
			select[readonly] {
			  background: #eee; /*Simular campo inativo - Sugest�o @GabrielRodrigues*/
			  pointer-events: none;
			  touch-action: none;
			}
			
			body {
				background-color: #FFFFFF;
				font-family: 'Open Sans', sans-serif;	
			}	
			
			h1 {	
				font-weight: 800;
				font-family: 'Open Sans', sans-serif;
				font-size: 30px;
				color: #323232;
			}	
			
			#btnAddUsuario {	
				border: none;						
				color: #FFFFFF;				
				border-radius: 40px;
				transition: 0.2s;
				cursor: pointer;			
				transition: 0.2s;
				font-size: 15px;
			}	
			
			.visual_tit_rec {	
				font-size: 25px;			
				font-weight: 800;
				font-family: 'Open Sans', sans-serif;
				color: #b1463c;
			}
			
			
			.divpadrao{
				border: black 1px solid;
				height:100px;
				padding: 5px;
				
				
				
			}
			
			@media(max-width: 1000px) {
    			.sugestao {
        			display: none;
    			}
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
			
			$("#div_loading").hide();
			carregaReceita('<%=p_cr_id_receita%>');
		});
		
		function carregaReceita(idrec){
			
			var cr_id_receita = "";
			var cr_titulo_receita = "";
			var cr_ingrediente_receita = "";
			var cr_modo_preparo_receita = "";
			var cr_tempo_preparo_receita = "";
			var cr_rendimento_receita = "";
			var cr_valor_receita = "";
			
			if(""!=idrec && "0"!=idrec){
				$.postJSON("../jsonservlet",{opc_servlet:'find_receita',cr_id_receita:idrec},
					function(datalin,statuslin){
						if(datalin){
							cr_id_receita = datalin.cr_id_receita;
							if(cr_id_receita != "0"){								
								cr_titulo_receita = datalin.cr_titulo_receita;
								cr_ingrediente_receita = datalin.cr_ingrediente_receita;
								cr_modo_preparo_receita = datalin.cr_modo_preparo_receita;
								cr_tempo_preparo_receita = datalin.cr_tempo_preparo_receita;
								cr_rendimento_receita = datalin.cr_rendimento_receita;
								cr_valor_receita = datalin.cr_valor_receita;
								
																
							}
						}
						$("#cr_id_receita").val(cr_id_receita);
						$("#cr_titulo_receita").text(cr_titulo_receita);
						$("#cr_titulo_receita").val(cr_titulo_receita);
						$("#cr_ingrediente_receita").val(cr_ingrediente_receita);
						$("#cr_modo_preparo_receita").val(cr_modo_preparo_receita);
						$("#cr_tempo_preparo_receita").val(cr_tempo_preparo_receita);
						$("#cr_rendimento_receita").val(cr_rendimento_receita);
						$("#cr_valor_receita").val("R$ "+cr_valor_receita);
					}
				);
			}else{								
				$("#cr_id_receita").val("");
				$("#cr_titulo_receita").val("");
				$("#cr_ingrediente_receita").val("");
				$("#cr_modo_preparo_receita").val("");
				$("#cr_tempo_preparo_receita").val("");
				$("#cr_rendimento_receita").val("");
				$("#cr_valor_receita").val("");
					
			}		
		}		
	</script>

	<body>		
		<%=MenuUtils.buildMenu("receita", cru)%>							
	<form id="frmreceita" name="frmreceita" method="post" action="cr_lista_receitas.jsp">
			<input type="hidden" id="cr_id_receita" name="cr_id_receita" value="0"/>
			<input type="hidden" id="opc_servlet" name="opc_servlet" value="salva_receita"/>
			
		<div class="container" style="margin-top: 100px">
			
			
			<div class="row">
			
			<!-- Titulo da Receita -->
				<div class="col-xl-6 col-lg-6 col-md-8 col-sm-8 col-8" style="height: 100px">
					<div class="row mt-3 justify-content-md-center">																									
						<div id="cr_titulo_receita" class="visual_tit_rec"></div>
					</div>	
				</div>
				
				
			<!-- Icone da Receita -->
				<div class="col-xl-1 col-lg-1 col-md-2 col-sm-2 col-2" style="height: 100px">
					<span class="bi bi-heart" style="color: #b1463c;font-size:50px;"></span></div>
				<div class="col-xl-2"></div>

			</div>

			<!-- Imagem da Receita -->
			<div class="row justify-content-between mt-1">
				<div class="col-xl-8 col-lg-8 col-md-12 col-sm-12 col-12"
					style="border: black 1px solid; max-width: 100%"> <img src="../imagens/Brigadeiro.png" 
					class="img-fluid" alt="Imagem receita">
				</div>
				
				<!-- Div de sugest�o a ser implementado -->
				<div class="sugestao" style="border: black 1px solid; width: 300px"></div>
			</div>
			
			<!-- Ingredientes da Receita -->
			<div class="row mt-3 justify-content-between">
			
				<div class="col-xl-8 col-lg-8 col-md-12 col-sm-12 col-12"
					style="border: black 1px solid; height: 400px;">
					
					<div class="col-xl-12 col-lg-12" style="text-align: left;">
						<label for="cr_ingrediente_receita" style="font-size: 20px; font-weight: bold; color: #b1463c;">
							<strong>Ingredientes</strong>
						</label> 
						
						<textarea disabled type="textarea" class="form-control" name="cr_ingrediente_receita" 
						id="cr_ingrediente_receita" rows="12" style="border:none; resize: none; background: #FFFFFF; font-size: 18px;">
						</textarea> 
					</div>	
					
					
				</div>
				<!-- Div de sugest�o a ser implementado -->
				<div class="sugestao" style="border: black 1px solid; width: 300px"></div>

			</div>

			<!-- Modo de preparo da Receita -->
			<div class="row mt-3 justify-content-between">
			
				<div class="col-xl-8 col-lg-8 col-md-12 col-sm-12 col-12" style="border: black 1px solid; height: 400px;">
					
					<div class="row mt-3 justify-content-md-center">
						<div class="col-xl-12 col-lg-12" style="text-align: left;">
							<label for="cr_modo_preparo_receita" style="font-size: 20px; font-weight: bold; color: #b1463c;">
								<strong>Modo de preparo</strong>
							</label> 
							<textarea disabled type="textarea" class="form-control" name="cr_modo_preparo_receita" 
							id="cr_modo_preparo_receita" rows="8" style="border:none; resize: none; background: #FFFFFF; font-size: 18px;">
							</textarea> 
						</div>				
					</div>
						
				</div>
				
				<!-- Div de sugest�o a ser implementado -->
				<div class="sugestao" style="border: black 1px solid; width: 300px"></div>

			</div>
			
			<div class="row mt-3 ">
				
				<!-- Rendimento da Receita -->
				<div class="col-xl-8 col-lg-8 col-md-8 col-sm-12 col-12" style="border: black 1px solid; height:410px; padding: 2px">
				
					<label for="cr_rendimento_receita" style="font-size: 20px; font-weight: bold; color: #b1463c;">7
						<strong>Rendimento</strong>
					</label> 
					
					<textarea disabled  class="form-control" name="cr_rendimento_receita" id="cr_rendimento_receita" rows="12" 
					style="border:solid black 1px; resize: none; background: #FFFFFF; font-size: 18px; text-align: center;">
					</textarea> 
										
				</div>
				
				
				<div class="mt-3 col-xl-4 col-lg-4 col-md-4 col-sm-12 col-12" style="border: black 1px solid">
				 	
				 	<!-- Tempo de preparo da Receita -->
				 	<div class="mt-3 col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12 divpadrao" >
						<label style="font-size: 18px; font-weight: bold; color: #b1463c;"><strong> Tempo de Preparo </strong></label>
						<input disabled type="text" class="form-control" name="cr_tempo_preparo_receita" id="cr_tempo_preparo_receita" 
						style="border:none; background: #FFFFFF; font-size: 18px; text-align: center; ">
					
					</div>
					
					<!-- Valor da Receita -->
				 	<div class="mt-3 col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12 divpadrao" style="font-size: 20px; 
				 	font-weight: bold; color: #b1463c;" >
						<label for="cr_valor_receita" style="font-size: 18px; font-weight: bold; color: #b1463c;">
							<strong>Valor da Receita</strong>
						</label> 
						<input disabled type="text" class="form-control" name="cr_valor_receita"  id="cr_valor_receita" 
						style="border:none; background: #FFFFFF; font-size: 18px; text-align: center; ">
											
					</div>
						
				 	<!-- Bot�o de compra -->
				 	<div class="mt-4 col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12 divpadrao" >
				 		<button type="button" class="btn btn-secondary btn-lg btn-block" style="background-color:  #636f61;">
				 			Comprar
				 		</button>
				 	</div>
				 	
				</div>
				
				

			</div>
		</div>

		
			
		<div id="div_loading">
			<div class="row h-100">
				<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12 align-self-center" align="center">
					<strong>Processando solicita��o... &nbsp;</strong>
					<div class="spinner-border text-primary ml-auto" role="status"
						aria-hidden="true"></div>
				</div>
			</div>
		</div>
	</form>		
		
		  <footer class="bg-dark text-light">
    
    <div class="text-center" style="background-color: #636f61; padding: 20px;margin-top: 5px" >
      &copy 2023 Copyright: <a href="#" style="color:white">Cozinha Rapida</a>
    </div>
  </footer>
	</body>
</html>
