<%@page import="projeto.util.MenuUtils"%>
<%@page import="projeto.util.Cast"%>
<%@page import="projeto.util.AppSecrets"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<%	
	String p_cr_id_usuario = null!=request.getParameter("cr_id_usuario")?request.getParameter("cr_id_usuario"):"";
	
	System.out.println("p_cr_id_usuario :: "+p_cr_id_usuario);
	%>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">		
		<title>Cozinha Rápida - Lista Usuários</title>
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
			carregaUsuario('<%=p_cr_id_usuario%>');
		});
		
		function carregaUsuario(idusu){
			
			var cr_id_usuario = "";
			var cr_email_usuario = "";
			var cr_senha_usuario = "";
			var cr_nome_completo_usuario = "";
			var cr_cpf_usuario = "";
			var cr_telefone_usuario = "";
			var cr_cep_usuario = "";
			var cr_endereco_usuario = "";
			var cr_nrmcasa_usuario = "";
			var cr_endcomplemento_usuario = "";
			var cr_pontoreferencia_usuario = "";
			
			
			if(""!=idusu && "0"!=idusu){
				$.postJSON("./jsonservlet",{opc_servlet:'find_usuario',cr_id_usuario:idusu},
					function(datalin,statuslin){
						if(datalin){
							cr_id_usuario = datalin.cr_id_usuario;
							if(cr_id_usuario != "0"){								
								cr_email_usuario = datalin.cr_email_usuario;
								cr_senha_usuario = datalin.cr_senha_usuario;
								cr_nome_completo_usuario = datalin.cr_nome_completo_usuario;
								cr_cpf_usuario = datalin.cr_cpf_usuario;
								cr_telefone_usuario = datalin.cr_telefone_usuario;
								cr_cep_usuario = datalin.cr_cep_usuario;
								cr_endereco_usuario = datalin.cr_endereco_usuario;
								cr_nrmcasa_usuario = datalin.cr_nrmcasa_usuario;
								cr_endcomplemento_usuario = datalin.cr_endcomplemento_usuario;
								cr_pontoreferencia_usuario = datalin.cr_pontoreferencia_usuario;								
							}
						}
						$("#cr_id_usuario").val(cr_id_usuario);
						$("#cr_email_usuario").val(cr_email_usuario);
						$("#cr_senha_usuario").val(cr_senha_usuario);
						$("#cr_nome_completo_usuario").val(cr_nome_completo_usuario);
						$("#cr_cpf_usuario").val(cr_cpf_usuario);
						$("#cr_telefone_usuario").val(cr_telefone_usuario);
						$("#cr_cep_usuario").val(cr_cep_usuario);
						$("#cr_endereco_usuario").val(cr_endereco_usuario);
						$("#cr_nrmcasa_usuario").val(cr_nrmcasa_usuario);
						$("#cr_endcomplemento_usuario").val(cr_endcomplemento_usuario);
						$("#cr_pontoreferencia_usuario").val(cr_pontoreferencia_usuario);						
					}
				);
			}else{								
				$("#cr_id_usuario").val("");
				$("#cr_email_usuario").val("");
				$("#cr_senha_usuario").val("");
				$("#cr_nome_completo_usuario").val("");
				$("#cr_cpf_usuario").val("");
				$("#cr_telefone_usuario").val("");
				$("#cr_cep_usuario").val("");
				$("#cr_endereco_usuario").val("");
				$("#cr_nrmcasa_usuario").val("");
				$("#cr_endcomplemento_usuario").val("");
				$("#cr_pontoreferencia_usuario").val("");	
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
			var arrayJSON = $('#frmusuario').serializeArray();
			$.postJSON("./jsonservlet",arrayJSON,
				function(data,status){
					if(data.id_usuario!="0" && data.id_usuario != ""){
						alert("Usuário atualizado com Sucesso!");
					}else{
						alert("Problema ao salvar registro!");
						return false;
					}
				}
			);			
		}
	</script>

	<body>									
		<form id="frmusuario" name="frmusuario" method="post" action="cr_lista_usuarios.jsp">
			<input type="hidden" id="cr_id_usuario" name="cr_id_usuario" value="0"/>
			<input type="hidden" id="opc_servlet" name="opc_servlet" value="salva_usuario"/>
			
			<div id="div_tela">
				<div class="row">
					<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12" align="center">
						<div class="row">
							<div class="container rounded col-xl-11 col-lg-11 col-md-11 col-sm-12 col-12 well" align="center">
								<br>
								<div class="row mt-3">
									<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12" align="center">
										<h1>
											Visualizar Usuário
										</h1>
									</div>
								</div>																						
								<br>								
								<!-- DIV CADASTRO CONTA - PRIMEIRA PARTE -->
								<div class="div_cadastro">								
									<div class="col-xl-8 col-lg-8 col-md-8 col-sm-12 col-12">																																												
										<div class="row mt-3 justify-content-md-center">
											<div class="col-xl-5 col-lg-5 col-md-5 col-sm-12 col-12">
												<label for="cr_nome_completo_usuario" style="font-size: 15px; font-weight: bold;"><strong>Nome</strong></label> 
												<input type="text" class="form-control form-control-lg rounded-50" name="cr_nome_completo_usuario" id="cr_nome_completo_usuario" style="font-size: 15px; height: 50px; color:black; border-radius: 10px;"/> 
											</div>
											<div class="col-xl-4 col-lg-4 col-md-4 col-sm-12 col-12">
												<label for="cr_cpf_usuario" style="font-size: 15px; font-weight: bold;"><strong>CPF</strong></label> 
												<input type="text" class="form-control form-control-lg rounded-50" readonly name="cr_cpf_usuario" id="cr_cpf_usuario" style="font-size: 15px; height: 50px; color:black; border-radius: 10px;"/> 
											</div>
											<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-12">
												<label for="cr_telefone_usuario" style="font-size: 15px; font-weight: bold;"><strong>Telefone</strong></label> 
												<input type="text" class="form-control form-control-lg rounded-50" name="cr_telefone_usuario" id="cr_telefone_usuario" style="font-size: 15px; height: 50px; color:black; border-radius: 10px;"/> 
											</div>					
										</div>
										<div class="row mt-3 justify-content-md-center">
											<div class="col-xl-2 col-lg-2 col-md-2 col-sm-12 col-12">
												<label for="cr_cep_usuario" style="font-size: 15px; font-weight: bold;"><strong>CEP</strong></label> 
												<input type="text" class="form-control form-control-lg rounded-50" name="cr_cep_usuario" id="cr_cep_usuario" style="font-size: 15px; height: 50px; color:black; border-radius: 10px;"/> 
											</div>
											<div class="col-xl-6 col-lg-6 col-md-6 col-sm-12 col-12">
												<label for="cr_endereco_usuario" style="font-size: 15px; font-weight: bold;"><strong>Endereço</strong></label> 
												<input type="text" class="form-control form-control-lg rounded-50" name="cr_endereco_usuario" id="cr_endereco_usuario" style="font-size: 15px; height: 50px; color:black; border-radius: 10px;"/> 
											</div>
											<div class="col-xl-1 col-lg-1 col-md-1 col-sm-12 col-12">
												<label for="cr_nrmcasa_usuario" style="font-size: 15px; font-weight: bold;"><strong>Nº</strong></label> 
												<input type="text" class="form-control form-control-lg rounded-50" name="cr_nrmcasa_usuario" id="cr_nrmcasa_usuario" style="font-size: 15px; height: 50px; color:black; border-radius: 10px;"/> 
											</div>		
											<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-12">
												<label for="cr_endcomplemento_usuario" style="font-size: 15px; font-weight: bold;"><strong>Complemento</strong></label> 
												<input type="text" class="form-control form-control-lg rounded-50" name="cr_endcomplemento_usuario" id="cr_endcomplemento_usuario" style="font-size: 15px; height: 50px; color:black; border-radius: 10px;"/> 
											</div>			
										</div>
										<div class="row mt-3 justify-content-md-center">											
											<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
												<label for="cr_pontoreferencia_usuario" style="font-size: 15px; font-weight: bold;"><strong>Ponto de Refêrencia</strong></label> 
												<input type="text" class="form-control form-control-lg rounded-50" name="cr_pontoreferencia_usuario" id="cr_pontoreferencia_usuario" style="font-size: 15px; height: 50px; color:black; border-radius: 10px;"/> 
											</div>														
										</div>											
										<div class="row mt-3 justify-content-md-center">
											<div class="col-xl-6 col-lg-6 col-md-6 col-sm-12 col-12">
												<label for="cr_email_usuario" style="font-size: 15px; font-weight: bold;"><strong>Email</strong></label> 
												<input type="text" class="form-control form-control-lg rounded-50" name="cr_email_usuario" id="cr_email_usuario" readonly style="font-size: 15px; height: 50px; color:black; border-radius: 10px;"/> 
											</div>
											<div class="col-xl-6 col-lg-6 col-md-6 col-sm-12 col-12">
												<label for="cr_senha_usuario" style="font-size: 15px; font-weight: bold;"><strong>Senha</strong></label> 
												<div class="input-group">																			  															 
													<input type="password" class="form-control form-control-lg rounded-50" name="cr_senha_usuario" id="cr_senha_usuario" readonly style="font-size: 15px; height: 50px; color:black; font-weight: bold;"/>																							   											    	
											  	</div> 
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
