<%@page import="projeto.util.MenuUtils"%>
<%@page import="projeto.util.Cast"%>
<%@page import="projeto.util.AppSecrets"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<%	
	String p_cr_id_receita = null!=request.getParameter("id_receita")?request.getParameter("id_receita"):"";
	
	System.out.println("p_cr_id_receita :: "+p_cr_id_receita);
	%>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="icon" href="imagens/cr_logo_guia_ret_arredondado.png" type="image/png">			
		<title>Cozinha Rápida - Cadastro Receita</title>
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="fontawesome/css/all.min.css" rel="stylesheet">
		<link href="css/bootstrap-datepicker.css" rel="stylesheet"/>
		<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		<script type="text/javascript" src="fontawesome/js/all.min.js"></script>
		<script type="text/javascript" src="js/bootstrap-autocomplete.js"></script>
		<script type="text/javascript" src="js/popper.js"></script>
		<script src="js/bootstrap-datepicker.min.js"></script>
		<script src="js/bootstrap-datepicker.pt-BR.min.js"></script>
		<!-- <script src="js/jquery.maskMoney.min.js" type="text/javascript"></script>         data-thousands="." data-decimal="," data-prefix="R$ "  -->
		
		<!-- Data Tables -->
		<script src="js/datatables/jquery.dataTables.min.js"></script>
		<script src="js/datatables/dataTables.bootstrap4.min.js"></script>
		<script src="js/datatables/dataTables.fixedHeader.min.js"></script>
		<script src="js/datatables/dataTables.responsive.min.js"></script>
		<script src="js/datatables/responsive.bootstrap.min.js"></script>

		<link rel="stylesheet" href="css/datatables/dataTables.bootstrap4.min.css">
		<link rel="stylesheet" href="css/datatables/fixedHeader.bootstrap4.min.css">
		<link rel="stylesheet" href="css/datatables/responsive.bootstrap.min.css">
		<!-- Final Data Tables -->
		<style type="text/css">
			select[readonly] {
			  background: #eee; /*Simular campo inativo - Sugestão @GabrielRodrigues*/
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
			
			$('input[type="file"]').on("change", function() {
			    var filenames = [];
			    var files = this.files;
			   if(files.length > 1) {
			      filenames.push("Selecionados(" + files.length + ")");
		 	      $('#file').val(filenames);
			    }else{
			    	var filename = files[0].name;
					$("#file").val(filename);
			    }
			  });
		});
		
		function carregaReceita(idrec){
			
			var cr_id_receita = "";
			var cr_titulo_receita = "";
			var cr_ingrediente_receita = "";
			var cr_modo_preparo_receita = "";
			var cr_tempo_preparo_receita = "";
			var cr_rendimento_receita = "";
			var cr_valor_receita = "";
			var cr_receita_nome_img = "";
			
			if(""!=idrec && "0"!=idrec){
				$.postJSON("./jsonservlet",{opc_servlet:'find_receita',cr_id_receita:idrec},
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
								cr_receita_nome_img = datalin.cr_receita_nome_img;
																							
							}
						}
						$("#cr_id_receita").val(cr_id_receita);
						$("#cr_titulo_receita").val(cr_titulo_receita);
						$("#cr_ingrediente_receita").val(cr_ingrediente_receita);
						$("#cr_modo_preparo_receita").val(cr_modo_preparo_receita);
						$("#cr_tempo_preparo_receita").val(cr_tempo_preparo_receita);
						$("#cr_rendimento_receita").val(cr_rendimento_receita);
						$("#cr_valor_receita").val(cr_valor_receita);
						$("#cr_receita_nome_img").val(cr_receita_nome_img);
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
				$("#cr_receita_nome_img").val("");
					
			}		
		}
		
		/* Função que salva todos os dados de cadastro digitados pelo usuário no banco de dados, fazendo validações
		 * na tela antes de salvar.
		 * Ao clicar no botão SALVAR essa função.
		 * Para passar para a próxima tela são validados:
		 * - Se o campo de Email não está em Branco;
		 * - Se as senhas digitadas pelo usuário são iguais;
		 * Caso essas duas funções sejam verdadeiras ele irá salvar.
		 */
		function salvarRegistro(){
			var arrayJSON = $('#frmreceita').serializeArray();
			$.postJSON("./jsonservlet",arrayJSON,
				function(data,status){
					if(data.id_receita!="0" && data.id_receita != ""){
						alert("Receita atualizada com Sucesso!");						
						carregaReceita(data.id_receita);
						$("#frmreceita").submit();
					}else{
						alert("Problema ao salvar registro!");
						return false;
					}
				}
			);			
		}
	</script>

	<body>		
	
		<!-- FORM DA ABA ARQUIVOS -->
		<form id="frm_img_receita" name="frm_img_receita" method="post" action="cr_cadastro_receita.jsp"></form>							
		
		<form id="frmreceita" name="frmreceita" method="post" action="cr_lista_receitas.jsp">
			<input type="hidden" id="cr_id_receita" name="cr_id_receita" value="0"/>
			<input type="hidden" id="opc_servlet" name="opc_servlet" value="salva_receita"/>
			
			<div id="div_tela">
				<div class="row">
					<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12" align="center">
						<div class="row">
							<div class="container rounded col-xl-11 col-lg-11 col-md-11 col-sm-12 col-12 well" align="center">
								<br>
								<div class="row mt-3">
									<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12" align="center">
										<h1>
										 	Cadastrar Receita
										</h1>
									</div>
								</div>																						
								<br>								
								<!-- DIV CADASTRO RECEITA -->
								<div class="div_cadastro">								
									<div class="col-xl-8 col-lg-8 col-md-8 col-sm-12 col-12">																
										
										<div class="row mt-3 justify-content-md-center">
											<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
												<label for="cr_receita_nome_img" style="font-size: 15px; font-weight: bold;"><strong>Link da Imagem</strong> <i class="fab fa-google-drive"></i></label> 
												<input type="text" class="form-control form-control-lg rounded-50" name="cr_receita_nome_img" id="cr_receita_nome_img" style="font-size: 15px; height: 50px; color:black; border-radius: 10px;"
												placeholder="Cole o link incorporado da imagem do Google Drive aqui..."/> 
											</div>				
										</div> 
																																																				
										<div class="row mt-3 justify-content-md-center">
											<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
												<label for="cr_titulo_receita" style="font-size: 15px; font-weight: bold;"><strong>Titulo</strong></label> 
												<input type="text" class="form-control form-control-lg rounded-50" name="cr_titulo_receita" id="cr_titulo_receita" style="font-size: 15px; height: 50px; color:black; border-radius: 10px;"/> 
											</div>				
										</div>
										
										<div class="row mt-3 justify-content-md-center">
											<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
												<label for="cr_ingrediente_receita" style="font-size: 15px; font-weight: bold;"><strong>Ingredientes</strong></label> 
												<textarea type="textarea" class="form-control" name="cr_ingrediente_receita" id="cr_ingrediente_receita" rows="4">
												</textarea> 
											</div>				
										</div>
										
										
										<div class="row mt-3 justify-content-md-center">
											<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
												<label for="cr_modo_preparo_receita" style="font-size: 15px; font-weight: bold;"><strong>Modo de preparo</strong></label> 
												<textarea type="textarea" class="form-control" name="cr_modo_preparo_receita" id="cr_modo_preparo_receita" rows="4">
												</textarea> 
											</div>				
										</div>
										
										<div class="row mt-3 justify-content-md-center">
											<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
												<label for="cr_rendimento_receita" style="font-size: 15px; font-weight: bold;"><strong>Rendimento</strong></label> 
												<textarea type="textarea" class="form-control" name="cr_rendimento_receita" id="cr_rendimento_receita" rows="4">
												</textarea> 
											</div>				
										</div>
										
										
										<div class="row mt-3 justify-content-md-center">
											<div class="col-xl-6 col-lg-6 col-md-6 col-sm-12 col-12">
												<label for="cr_tempo_preparo_receita" style="font-size: 15px; font-weight: bold;"><strong>Tempo de preparo</strong></label> 
												<input type="text" class="form-control" name="cr_tempo_preparo_receita" id="cr_tempo_preparo_receita">
											</div>		
													
										</div>
										
										<div class="row mt-3 justify-content-md-center">
										<div class="col-xl-6 col-lg-6 col-md-6 col-sm-12 col-12">
												<label for="cr_valor_receita" style="font-size: 15px; font-weight: bold;"><strong>Valor</strong></label> 
												<input type="text" class="form-control" name="cr_valor_receita"  id="cr_valor_receita" >
											</div>		
										</div>
																																																			
										<br/>
										<div class="row mt-3 justify-content-md-center">																					
											<button type="button" class="btn btn-success btn-lg" id="btnAddUsuario" style="font-size: 15px; padding-top:10px; padding-bottom:10px; padding-left:50px; padding-right:50px;" onclick="salvarRegistro();">
												<strong>Salvar <i class="fa fa-save" aria-hidden="true"></i></strong> 
											</button>										
										</div>
										<div class="row mt-3 justify-content-md-center">																															
											<button type="submit" class="btn btn-info btn-lg" id="btnAddUsuario" style="font-size: 15px; padding-top:10px; padding-bottom:10px; padding-left:50px; padding-right:50px;">
												<strong>Voltar para Lista</strong> 
											</button>
										</div>																										
									</div>				
								</div>	
							</div>
						</div>
						<br>
					</div>
				</div>
			</div>
			<div id="div_loading">
				<div class="row h-100">
					<div
						class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12 align-self-center"
						align="center">
						<strong>Processando solicitação... &nbsp;</strong>
						<div class="spinner-border text-primary ml-auto" role="status"
							aria-hidden="true"></div>
					</div>
				</div>
			</div>
		</form>		
	</body>
</html>
