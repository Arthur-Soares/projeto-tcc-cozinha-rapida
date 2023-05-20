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
			
			var dtable = $('#table_ingredientes').DataTable(
					{
						responsive: true,
			            "language": {
			               url: '//cdn.datatables.net/plug-ins/1.10.20/i18n/Portuguese-Brasil.json'
			            },
			            //"order": [[ 0, 'desc' ]],
			            searching: true, 
			            paging: true, 
			            info: false
					}
				); 
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
						
						carregaIngrediente(cr_id_receita);
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
			 
			//Cr_receita_ingrediente
			var ids_ingredientes = arrIngredientes.toString();
	        $("#ids_ingredientes").val(ids_ingredientes);	        
	        
			var arrayJSON = $('#frmreceita').serializeArray();
			$.postJSON("./jsonservlet",arrayJSON,
				function(data,status){
					if(data.id_receita!="0" && data.id_receita != ""){
						alert("Receita atualizada com Sucesso!");						
						carregaReceita(data.id_receita);											
					}else{
						alert("Problema ao salvar registro!");
						return false;
					}
				}
			);			
		}
		 
		 
		//PARTE DO CÓDIGO RELACIONADO A PARTE DE VINCULAR INGREDIENTE A RECEITA
			function limpaSearch(){
				$('#table_ingredientes').DataTable().search( "" ).draw();			
			}
			
			function vincularIngrediente(){			
				limpaSearch();
				carregaListaIngredientes();
				$("#ModalIngredientes").modal("show");
			}


			
			//VINCULAR INGREDIENTES A RECEITA
			var arrIngredientes = [];
			var nomIngredientes = [];
			
			function checarIngredientes(objcheck, nome_ingredientes){
				if(objcheck.checked){
					arrIngredientes.push((objcheck.id).toString());
					nomIngredientes.push(nome_ingredientes);
				}else{							
					for (var i = arrIngredientes.length; i--;) {
						   if (arrIngredientes[i] == objcheck.id){ 
							   arrIngredientes.splice(i, 1);
						   }
					}
					for (var i = nomIngredientes.length; i--;) {
						   if (nomIngredientes[i] == nome_ingredientes){ 
							   nomIngredientes.splice(i, 1);
						   }
					}
				}
				console.log("check arrIngredientes :: "+arrIngredientes.toString());
				console.log("check nomIngredientes :: "+nomIngredientes.toString());
			}
		
			function carregaIngrediente(cr_id_receita){
				arrIngredientes = [];
				nomIngredientes = [];
				$.postJSON("./jsonservlet",{opc_servlet:'find_receita_ingrediente',cr_id_receita:cr_id_receita},
					function(datalin,statuslin){
						if(datalin.length > 0){
							for(var cx=0;cx<datalin.length;cx++){
								cr_id_ingrediente = datalin[cx].cr_id_ingrediente;								
								cr_desc_ingrediente = datalin[cx].cr_desc_ingrediente;
								
								arrIngredientes.push(cr_id_ingrediente.toString());
								nomIngredientes.push(cr_desc_ingrediente);
								var nomes_completo = nomIngredientes.toString();
								nomes_completo = nomes_completo.replaceAll(",",", ");
								$("#ingredientes_vinculados").val(nomes_completo);
								console.log("arrIngredientes ca:: "+arrIngredientes.toString());
								console.log("nomIngredientes ca:: "+nomIngredientes.toString());
							}
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
			<input type="hidden" id="ids_ingredientes" name="ids_ingredientes" value=""/>
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
											<div class="col-xl-6 col-lg-6 col-md-6 col-sm-12 col-12">
												<label for="cr_valor_receita" style="font-size: 15px; font-weight: bold;"><strong>Valor</strong></label> 
												<input type="text" class="form-control" name="cr_valor_receita"  id="cr_valor_receita" >
											</div>	
										</div>
										
										<div class="row mt-3 text-center justify-content-center">
											<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
												<label for="ingredientes_vinculados"><b>Ingredientes Vinculados</b></label>												
												<div class="input-group">
													<input readonly type="text" class="form-control" id="ingredientes_vinculados" name="ingredientes_vinculados" placeholder="Vincule Ingredientes...">
												  <div class="input-group-append">
													<button type="button" class="browse btn btn-dark" id="btn_seleciona_ingrediente" onclick="javascript:vincularIngrediente();"><strong><i class="fas fa-link"></i> Vincular</strong></button>
												  </div>
												</div>
											</div>
										</div>																																																													
										<br/>
										<div class="row mt-3 justify-content-center">																					
											<button type="button" class="btn btn-success btn-lg" id="btnAddUsuario" style="font-size: 15px; padding-top:10px; padding-bottom:10px; padding-left:50px; padding-right:50px;" onclick="salvarRegistro();">
												<strong>Salvar <i class="fa fa-save" aria-hidden="true"></i></strong> 
											</button>										
										</div>
										<div class="row mt-3 justify-content-center">																															
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
			
					<!-- PARTE SCRITP E MODAL SELECIONA SUPERVISOR -->
		<script type="text/javascript">
		
			function carregaListaIngredientes(){				
				var table = $('#table_ingredientes').DataTable();
				table.clear().draw();
											
				$.postJSON("./jsonservlet",{opc_servlet:'list_ingredientes'},
					function(datalin,statuslin){
						if(datalin.length > 0){
							for(var cx=0;cx<datalin.length;cx++){
								var cr_id_ingrediente = datalin[cx].cr_id_ingrediente;
								var cr_desc_ingrediente = datalin[cx].cr_desc_ingrediente;

								//console.log("list cr_id_ingrediente:'"+cr_id_ingrediente+"' arrIngredientes :: "+arrIngredientes.toString());
								//console.log("list nomIngredientes :: "+nomIngredientes.toString());

								var arrayRow = [];
								arrayRow.push(cr_desc_ingrediente);
								if(arrIngredientes.includes(cr_id_ingrediente.toString())){
									arrayRow.push("<input style=\"width: 20px; height: 20px;\" type=\"checkbox\" id=\""+cr_id_ingrediente+"\" name=\"check\" onclick='javascript:checarIngredientes(this,\""+cr_desc_ingrediente+"\")' checked/>");
				                }else{
				                	arrayRow.push("<input style=\"width: 20px; height: 20px;\" type=\"checkbox\" id=\""+cr_id_ingrediente+"\" name=\"check\" onclick='javascript:checarIngredientes(this,\""+cr_desc_ingrediente+"\")' />");
				                }									
								table.row.add(arrayRow).draw();
							}
						}
					}
				);
			}
			
			function adicionarIngredientes(){				
				var ingredientes = nomIngredientes.toString();
				ingredientes = ingredientes.replaceAll(",",", ");				
				$("#ingredientes_vinculados").val(ingredientes);	
				salvarRegistro('');
				$("#ModalIngredientes").modal("hide");				
			}
		</script>
		
		<div class="modal" id="ModalIngredientes" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-xl" style="max-width:90%; margin-left: 70;">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalCenterTitle"><strong>Vincular Ingredientes</strong></h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					  <span aria-hidden="true">&times;</span>
					</button>			           
				 </div>
				  <div class="modal-body">
					<div class="row text-center">
						<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12 text-center">
							<button class="btn btn-success" type="button" onclick="javascript:adicionarIngredientes();"><strong><i class="fas fa-plus"></i> Adicionar Ingredientes Selecionados</strong></button>
						</div>
					</div>
						<br>
					   <div class="row mt-3">
							<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
								<table id="table_ingredientes" class="table table-striped table-bordered" style="width: 100%; text-align:center;">
									<thead>
										<tr>
											<th>Ingrediente</th>
											<th>Selecionar</th>
										</tr>
									</thead>
								</table>
							</div>
					  </div>
				  </div>
				  <div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal"><strong>Fechar</strong></button>
				  </div>
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
