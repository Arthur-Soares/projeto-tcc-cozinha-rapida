<%@page import="projeto.util.MenuUtils"%>
<%@page import="projeto.util.Cast"%>
<%@page import="projeto.util.AppSecrets"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<%	
	String p_cr_id_ingrediente = null!=request.getParameter("cr_id_ingrediente")?request.getParameter("cr_id_ingrediente"):"";
	
	System.out.println("p_cr_id_ingrediente :: "+p_cr_id_ingrediente);
	%>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">		
		<title>Cozinha Rápida - Cadastro Ingrediente</title>
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
			carregaIngrediente('<%=p_cr_id_ingrediente%>');
			
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
		
		function carregaIngrediente(id_ingrediente) {

			var cr_id_ingrediente = "";
			var cr_ingrediente_nome_img = "";
			var cr_desc_ingrediente = "";
			var cr_valor_ingrediente = "";
			var cr_nome_fornecedor = "";

			if ("" != id_ingrediente && "0" != id_ingrediente){ 
			$.postJSON("./jsonservlet",{opc_servlet:'find_ingrediente',cr_id_ingrediente : id_ingrediente},
				function(datalin, statuslin) {
					if (datalin) {
						cr_id_ingrediente = datalin.cr_id_ingrediente;
						if (cr_id_ingrediente != "0") {
							cr_ingrediente_nome_img = datalin.cr_ingrediente_nome_img;
							cr_desc_ingrediente = datalin.cr_desc_ingrediente;
							cr_valor_ingrediente = datalin.cr_valor_ingrediente;
							cr_nome_fornecedor = datalin.cr_nome_fornecedor;
						}
					}
					$("#cr_id_ingrediente").val(cr_id_ingrediente);
					$("#cr_ingrediente_nome_img").val(cr_ingrediente_nome_img);
					$("#cr_desc_ingrediente").val(cr_desc_ingrediente);
					$("#cr_valor_ingrediente").val(cr_valor_ingrediente);
					$("#cr_nome_fornecedor").val(cr_nome_fornecedor);
				});
			} else {
				$("#cr_id_ingrediente").val("");
				$("#cr_ingrediente_nome_img").val("");
				$("#cr_desc_ingrediente").val("");
				$("#cr_valor_ingrediente").val("");
				$("#cr_nome_fornecedor").val("");
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
		function salvarRegistro() {
			var arrayJSON = $('#frmingrediente').serializeArray();
			$.postJSON("./jsonservlet", arrayJSON, function(data, status) {
				if (data.id_ingrediente != "0" && data.id_ingrediente != "") {
					alert("Ingrediente atualizado com Sucesso!");
					carregaIngrediente(data.id_ingrediente);
					$("#frmingrediente").submit();
				} else {
					alert("Problema ao salvar registro!");
					return false;
				}
			});
		}
	</script>

	<body>		
	
		<!-- FORM DA ABA ARQUIVOS -->
		<form id="frm_img_receita" name="frm_img_receita" method="post" action="cr_cadastro_receita.jsp"></form>							
		
		<form id="frmingrediente" name="frmingrediente" method="post" action="cr_lista_ingredientes.jsp">
			<input type="hidden" id="cr_id_ingrediente" name="cr_id_ingrediente" value="0"/>
			<input type="hidden" id="opc_servlet" name="opc_servlet" value="salva_ingrediente"/>
			
			<div id="div_tela">
				<div class="row">
					<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12" align="center">
						<div class="row">
							<div class="container rounded col-xl-11 col-lg-11 col-md-11 col-sm-12 col-12 well" align="center">
								<br>
								<div class="row mt-3">
									<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12" align="center">
										<h1>
										 	Cadastrar Ingredientes
										</h1>
									</div>
								</div>																						
								<br>								
								<!-- DIV CADASTRO RECEITA -->
								<div class="div_cadastro">								
									<div class="col-xl-8 col-lg-8 col-md-8 col-sm-12 col-12">																
										
										<div class="row mt-3 justify-content-md-center">
											<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
												<label for="cr_ingrediente_nome_img" style="font-size: 15px; font-weight: bold;"><strong>Link da Imagem</strong> <i class="fab fa-google-drive"></i></label> 
												<input type="text" class="form-control form-control-lg rounded-50" name="cr_ingrediente_nome_img" id="cr_ingrediente_nome_img" style="font-size: 15px; height: 50px; color:black; border-radius: 10px;"
												placeholder="Cole o link incorporado da imagem do Google Drive aqui..."/> 
											</div>				
										</div> 
																																																				
										<div class="row mt-3 justify-content-md-center">
											<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
												<label for="cr_desc_ingrediente" style="font-size: 15px; font-weight: bold;"><strong>Descrição Ingrediente</strong></label> 
												<input type="text" class="form-control form-control-lg rounded-50" name="cr_desc_ingrediente" id="cr_desc_ingrediente" style="font-size: 15px; height: 50px; color:black; border-radius: 10px;"/> 
											</div>				
										</div>
										
										<div class="row mt-3 justify-content-md-center">
											<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
												<label for="cr_nome_fornecedor" style="font-size: 15px; font-weight: bold;"><strong>Nome do Fornecedor</strong></label> 
												<input type="text" class="form-control form-control-lg rounded-50" name="cr_nome_fornecedor" id="cr_nome_fornecedor" style="font-size: 15px; height: 50px; color:black; border-radius: 10px;"/> 
											</div>				
										</div>	
																			
										<div class="row mt-3 justify-content-md-center">
											<div class="col-xl-6 col-lg-6 col-md-6 col-sm-12 col-12">
												<label for="cr_valor_ingrediente" style="font-size: 15px; font-weight: bold;"><strong>Valor</strong></label> 
												<input type="text" class="form-control" name="cr_valor_ingrediente"  id="cr_valor_ingrediente">
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
