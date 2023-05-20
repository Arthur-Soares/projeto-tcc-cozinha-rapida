<%@page import="projeto.util.MenuUtils"%>
<%@page import="projeto.util.Cast"%>
<%@page import="projeto.util.AppSecrets"%>
<%@page import="projeto.model.Cr_usuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">		
		<title>Cozinha Rápida - Lista Ingredientes</title>
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
			carregaListaIngredientes('');
			$("#div_loading").hide();	
			
			//Isto está definido diretamente no nosso <select> e tem o objetivo de carregar as possíveis opções do nosso autocomplete
			//data-url='./jsonservlet?opc_servlet=sel_pesquisa_receita'
			//Implementando componente de AUTOCOMPLETE em um <select com o ID = "sel_receita"
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
					
			//Lógica do Carrinho de Compras
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
		
		function carregaListaIngredientes(crep){
			var table = $('#table_ingredientes').DataTable();
			table.clear().draw();
			$.postJSON("./jsonservlet",{opc_servlet:'list_ingredientes'},
				function(datalin,statuslin){
					if(datalin.length > 0){
						for(var cx=0;cx<datalin.length;cx++){
							var cr_id_ingrediente = datalin[cx].cr_id_ingrediente;
							var cr_desc_ingrediente = datalin[cx].cr_desc_ingrediente;
							var cr_valor_ingrediente = datalin[cx].cr_valor_ingrediente;
							var cr_nome_fornecedor = datalin[cx].cr_nome_fornecedor;
													
													
							var arrayRow = [];
			                arrayRow.push(cr_id_ingrediente);
							arrayRow.push(cr_desc_ingrediente);
							arrayRow.push(cr_valor_ingrediente);
							arrayRow.push(cr_nome_fornecedor);
							arrayRow.push("<i class='fas fa-edit' onclick='carregaIngrediente(\""+cr_id_ingrediente+"\")'> </i>");
							arrayRow.push("<i class='fas fa-trash' onclick='apagaIngrediente(\""+cr_id_ingrediente+"\")'> </i>");
							table.row.add(arrayRow).draw();
						}
					}
				}
			);
		}		 
		
		function carregaIngrediente(cr_id_ingrediente){
			//alert(cr_id_receita);
			if("" == cr_id_ingrediente){				
				$("#cr_id_ingrediente").val(0);
			}else{
				$("#cr_id_ingrediente").val(cr_id_ingrediente);
				$("#frm_tela_ingrediente").submit();
			}
		}
		
		function apagaIngrediente(id_ingrediente){												
			if(confirm("Deseja apagar este ingrediente?")){			
				$.postJSON("./jsonservlet",{opc_servlet:'apaga_ingrediente',id_ingrediente:id_ingrediente},
					function(data,status){
						if(data.ERRO == ""){						
						   alert("Ingrediente deletado com sucesso!");
						   carregaListaIngredientes();
						}else{
							alert(data.ERRO);
							return false;
						}
					}
				);
			}
		}	
		
		function voltaLogin(){							
			$("#frmlogin").submit();			
		}
		
		function novoIngrediente(){	
			$("#cr_id_ingrediente").val("");
			$("#frm_tela_ingrediente").submit();	
		}
		
		function listaReceitas(){
			$("#frmlistaReceitas").submit();
		}
	</script>

	<body>	
	
		<%=MenuUtils.buildMenu("receita", cru)%>
		
		<form id="frmreceita" name="frmreceita" method="post" action="cr_receita.jsp">
			<input type="hidden" id="cr_id_receita" name="cr_id_receita"/>
		</form>		
		<form id="frmlogin" name="frmlogin" method="post" action="cr_login.jsp"></form>
		<form id="frmlistaReceitas" name="frmlistaReceitas" method="post" action="cr_lista_receitas.jsp"></form>								
		<form id="frm_tela_ingrediente" name="frm_tela_ingrediente" method="post" action="cr_cadastro_ingredientes.jsp">
			<input type="hidden" id="cr_id_ingrediente" name="cr_id_ingrediente"/>
			<div id="div_tela">
				<div class="row mt-3">
					<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12" align="center">
						<div class="row mt-3">
							<div class="container rounded col-xl-11 col-lg-11 col-md-11 col-sm-12 col-12 well" align="center">
								<br>
								<div class="row mt-3">
									<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12" align="center">
										<h1>
											Lista de Ingredientes
										</h1>
									</div>
								</div>																							
								<br>								
								<div class="row text-center mt-3">
									<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12 text-center">
										<button class="btn btn-success text-center" type="button" onclick="novoIngrediente();"> 
											<i class="fa fa-plus" aria-hidden="true"></i> <strong> Novo Ingrediente </strong> 
										</button>
										<button type="button" class="btn btn-info" data-dismiss="modal" onclick="listaReceitas();">
										  	<i class="fa fa-list" aria-hidden="true"></i> <strong>Lista de Receitas </strong>
										 </button>																																																		
									</div>
								</div>
								<div class="row mt-3">
									<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
										<table id="table_ingredientes" class="table table-striped table-bordered" style="width:100%">
									        <thead class="thead-dark">
									            <tr>											                
									                <th>ID</th>
									                <th>Descrição do Ingrediente</th>
									                <th>Valor</th>
									                <th>Fornecedor</th>
									                <th>Editar</th>
									                <th>Excluir</th>
									            </tr>
									        </thead>
								        </table>
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
