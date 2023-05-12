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
		<title>Lista Usuários</title>
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
		</style>		
	</head>

	<script type="text/javascript">
		function carregaListaItens(crep){
			var table = $('#table_itens').DataTable();
			table.clear().draw();
			$.postJSON("../jsonservlet",{opc_servlet:'list_usuarios'},
				function(datalin,statuslin){
					if(datalin.length > 0){
						for(var cx=0;cx<datalin.length;cx++){
							var id_usuario = datalin[cx].id_usuario;
							var codigo_usuario = datalin[cx].codigo_usuario;
							var nome_completo = datalin[cx].nome_completo;
							var email_usuario = datalin[cx].email_usuario;
							var opc_tipo_acesso = datalin[cx].opc_tipo_acesso;
							var opc_ativo_usuario = datalin[cx].opc_ativo_usuario;
							var nivel_usuario = datalin[cx].nivel_usuario;
							var dhd_atualizacao = datalin[cx].dhd_atualizacao;
							
							var acesso_real = "";
							if("1" == opc_tipo_acesso){
								acesso_real = "Admin";
							}else if ("2" == opc_tipo_acesso){
								acesso_real = "Padrão";
							}else if ("3" == opc_tipo_acesso){
								acesso_real = "Limitado";
							}
							
							var nivel_nome = "";
							if("P" == nivel_usuario){
								nivel_nome = "Digitador";
							}else if ("S" == nivel_usuario){
								nivel_nome = "Supervisor";
							}else if ("D" == nivel_usuario){
								nivel_nome = "Diretoria";
							}else if ("F" == nivel_usuario){
								nivel_nome = "Financeiro";
							}
														
							var arrayRow = [];
			                arrayRow.push(codigo_usuario);
							arrayRow.push(nome_completo);
							arrayRow.push(email_usuario);
							arrayRow.push(acesso_real);
							arrayRow.push(nivel_nome);
							arrayRow.push(opc_ativo_usuario);
							arrayRow.push(dhd_atualizacao);
							arrayRow.push("<i class='fas fa-search' onclick='carregaUsuario(\""+id_usuario+"\")'> </i>");
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
			var dtable = $('#table_itens').DataTable(
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
			carregaListaItens('')
			$("#div_loading").hide();
		});


		jQuery.extend({
	 	   postJSON: function( url, data, callback) {
	 	      return jQuery.post(url, data, callback, "json");
	 	   }
	 	});
		
	</script>

	<body style="background: #FEFEFE">
<div class="wrapper">			
				
	<div id="content">
		<form id="frmusuario" name="frmusuario" method="post" action="usuarios.jsp">
			<input type="hidden" id="id_usuario" name="id_usuario" value="0"/>
			<div id="div_tela">
				<div class="row">
					<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12"
						align="center">
						<div class="row">
							<div class="container rounded col-xl-11 col-lg-11 col-md-11 col-sm-12 col-12 well"
								align="center">
								<br>
								<div class="row">
									<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12"
										align="center">
										<h4 align="center">
											Lista de Usuários
										</h4>
									</div>
								</div>
								<br>
								<div class="row">
									<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12" align="center">
										<button id="btn_cadastro" name="btn_cadastro" class="text-center btn btn-success" type="submit"> <i class="fas fa-plus"></i> Novo Usuário</button> 
									</div>
								</div>
								<br>
								<div class="row">
									<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
										<table id="table_itens" class="table table-striped table-bordered" style="width:100%">
									        <thead>
									            <tr>
									                <th>Código</th>
									                <th width="30%">Nome</th>
									                <th width="30%">Email</th>
									                <th>Tipo Acesso</th>
									                <th>Nível Usuário</th>
									                <th>Ativo</th>
									                <th>Data</th>
									                <th>Editar</th>
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
	</div>
</div>
	</body>
</html>
