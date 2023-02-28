<%@page import="projeto.util.MenuUtils"%>
<%@page import="projeto.util.Cast"%>
<%@page import="projeto.util.AppSecrets"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">		
		<title>Cozinha Rápida - Lista Usuários</title>
		<link href="../css/bootstrap.min.css" rel="stylesheet">
		<link href="../fontawesome/css/all.min.css" rel="stylesheet">
		<link href="../css/bootstrap-datepicker.css" rel="stylesheet"/>
		<script type="text/javascript" src="../js/jquery-3.3.1.js"></script>
		<script type="text/javascript" src="../js/bootstrap.min.js"></script>
		<script type="text/javascript" src="../fontawesome/js/all.min.js"></script>
		<script type="text/javascript" src="../js/bootstrap-autocomplete.js"></script>
		<script type="text/javascript" src="../js/popper.js"></script>
		<script src="../js/bootstrap-datepicker.min.js"></script>
		<script src="../js/bootstrap-datepicker.pt-BR.min.js"></script>
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
		function carregaListaUsuarios(crep){
			var table = $('#table_usuarios').DataTable();
			table.clear().draw();
			$.postJSON("../jsonservlet",{opc_servlet:'list_usuarios'},
				function(datalin,statuslin){
					if(datalin.length > 0){
						for(var cx=0;cx<datalin.length;cx++){
							var cr_id_usuario = datalin[cx].cr_id_usuario;
							var cr_email_usuario = datalin[cx].cr_email_usuario;
							var cr_nome_completo_usuario = datalin[cx].cr_nome_completo_usuario;
							var cr_cpf_usuario = datalin[cx].cr_cpf_usuario;
							var cr_cep_usuario = datalin[cx].cr_cep_usuario;
							var cr_endereco_usuario = datalin[cx].cr_endereco_usuario;							
													
							var arrayRow = [];
			                arrayRow.push(cr_cpf_usuario);
							arrayRow.push(cr_nome_completo_usuario);
							arrayRow.push(cr_email_usuario);
							arrayRow.push(cr_cep_usuario);
							arrayRow.push(cr_endereco_usuario);							
							arrayRow.push("<i class='fas fa-edit' onclick='carregaUsuario(\""+id_usuario+"\")'> </i>");
							arrayRow.push("<i class='fas fa-trash' onclick='carregaUsuario(\""+id_usuario+"\")'> </i>");
							table.row.add(arrayRow).draw();
						}
					}
				}
			);
		}
		 
		
		function carregaUsuario(idusu){
			if("" == idusu){
				alert("Não há ID vinculado a este registro.")				
			}else{
				$("#id_usuario").val(idusu)
				$("#frmusuario").submit();
			}
		}
		
		
		
 		$(document).ready(function() {
			var dtable = $('#table_usuarios').DataTable(
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
			carregaListaUsuarios('');
			$("#div_loading").hide();
		});


		jQuery.extend({
	 	   postJSON: function( url, data, callback) {
	 	      return jQuery.post(url, data, callback, "json");
	 	   }
	 	});
		
	</script>

	<body>									
		<form id="frmusuario" name="frmusuario" method="post" action="usuarios.jsp">
			<input type="hidden" id="id_usuario" name="id_usuario" value="0"/>
			<div id="div_tela">
				<div class="row">
					<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12" align="center">
						<div class="row">
							<div class="container rounded col-xl-11 col-lg-11 col-md-11 col-sm-12 col-12 well" align="center">
								<br>
								<div class="row mt-3">
									<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12" align="center">
										<h1>
											Lista de Usuários
										</h1>
									</div>
								</div>															
								<div class="row mt-3 justify-content-md-center">																					
									<button type="submit" class="btn btn-success btn-lg float-center" id="btnAddUsuario" style="font-size: 15px; padding-top:10px; padding-bottom:10px; padding-left:50px; padding-right:50px;" onclick="chamaCadastroDois();">
										<strong><i class="fas fa-plus"></i> Novo Usuário</strong> 
									</button>	
								</div>	
								<br>
								<div class="row">
									<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
										<table id="table_usuarios" class="table table-striped table-bordered" style="width:100%">
									        <thead class="thead-dark">
									            <tr>											                
									                <th>CPF</th>
									                <th width="20%">Nome</th>
									                <th width="20%">Email</th>
									                <th>CEP</th>											                											                
									                <th width="20%">Endereço</th>
									                <th>Editar</th>
									                <th>Excluir</th>
									            </tr>
									        </thead>
								        </table>
									</div>
								</div>
								<br>
								
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
