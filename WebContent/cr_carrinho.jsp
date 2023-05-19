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
	
	//System.out.println("VENDO O ID DO USUÁRIO :: "+cuserid);
			
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
		<link rel="icon" href="imagens/cr_logo_guia_ret_arredondado.png" type="image/png">			
		<title>Cozinha Rápida - Receita Favoritas</title>
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="fontawesome/css/all.min.css" rel="stylesheet">
		<link href="css/bootstrap-datepicker.css" rel="stylesheet"/>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
		<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		<script type="text/javascript" src="fontawesome/js/all.min.js"></script>
		<script type="text/javascript" src="js/bootstrap-autocomplete.js"></script>
		<script type="text/javascript" src="js/popper.js"></script>
		<script src="js/bootstrap-datepicker.min.js"></script>
		<script src="js/bootstrap-datepicker.pt-BR.min.js"></script>
		<!-- <script src="js/jquery.maskMoney.min.js" type="text/javascript"></script>       
		 data-thousands="." data-decimal="," data-prefix="R$ "  -->
		
		<!-- Data Tables -->
		<script src="js/datatables/jquery.dataTables.min.js"></script>
		<script src="js/datatables/dataTables.bootstrap4.min.js"></script>
		<script src="js/datatables/dataTables.fixedHeader.min.js"></script>
		<script src="js/datatables/dataTables.responsive.min.js"></script>
		<script src="js/datatables/responsive.bootstrap.min.js"></script>

		<link rel="stylesheet" href="css/datatables/dataTables.bootstrap4.min.css">
		<link rel="stylesheet" href="css/datatables/fixedHeader.bootstrap4.min.css">
		<link rel="stylesheet" href="css/datatables/responsive.bootstrap.min.css">
		<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
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
			
			.carrinho {
			  position: fixed;
			  top: 0;
			  right: -400px;
			  width: 400px;
			  height: 100vh;
			  background-color: rgba(0, 0, 0, 0.7);
			  padding: 35px;
			  transition: right 0.3s ease-in-out;
			  display: flex;
			  flex-direction: column;
			  justify-content: space-between;
			}
			
			.carrinho.aberto {
			  right: 0;
			}
			
			.carrinho .cabecalho-carrinho {
			  display: flex;
			  justify-content: space-between;
			  align-items: center;
			  margin-bottom: 20px;
			}
			
			.carrinho .cabecalho-carrinho h3 {
			  color: #fff;
			  font-size: 1.2rem;
			}
			
			.carrinho .cabecalho-carrinho button {
			  color: #fff;
			  font-size: 1.2rem;
			  background-color: transparent;
			  border: none;
			  cursor: pointer;
			}
			
			.carrinho .conteudo-carrinho {
			  margin: 50px;
			  display: flex;
			  flex-direction: column;
			  justify-content: center;
			  align-items: center;
			  color: #fff;
			  flex-grow: 1;
			  margin-bottom: 20px;
			}
			
			.carrinho .conteudo-carrinho h4 {
			  margin-bottom: 10px;
			}
			
			.carrinho .conteudo-carrinho .lista-produtos {
			  list-style: none;
			  padding-left: 0;
			}
			
			.carrinho .conteudo-carrinho .lista-produtos li {
			  margin-bottom: 10px;
			}
			
			.carrinho .pagar {
			  display: block;
			  width: 100%;
			  padding: 10px;
			  border: none;
			  border-radius: 50px;
			  background-color: red;
			  color: #fff;
			  font-weight: bold;
			  text-align: center;
			  cursor: pointer;
			  transition: background-color 0.3s;
			  align-self: flex-end;
			}
			
			.carrinho .conteudo-carrinho .pagar:hover {
			  background-color: #cc0000;
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
					
			const btnAbrirCarrinho = $('#abrir-carrinho');
		    const btnFecharCarrinho = $('#fechar-carrinho');
		    const carrinho = $('.carrinho');

		    btnAbrirCarrinho.click(function() {
		        carrinho.addClass('aberto');
		    });

		    btnFecharCarrinho.click(function() {
		        carrinho.removeClass('aberto');
		    });
		});				
	</script>

	<body>		
	<%=MenuUtils.buildMenu("receita", cru)%>									
			
		<div class="container" style="margin-top: 4%">	
		    <div class="carrinho" style="position: absolute; z-index: 9999;">
		        <div class="cabecalho-carrinho">
		          <h3>Carrinho de Compras</h3>
		          <button id="fechar-carrinho">&times;</button>
		        </div>
		        <div class="conteudo-carrinho">
		          <!-- Conteúdo do carrinho de compras -->
		          <ul class="lista-produtos">
		            <li>
		                <p class="produto">Produto 1</p>
		                <p class="preco">R$10,00</p>
		                <i>............................................................</i>
		            </li>
		          </ul>
		        </div>
		        <div class="total">
		            <p id="total">Total: </p>
		        </div>
		        <button class="pagar">Pagar</button>
		    </div> 							
	 	</div>
	 	<br><br><br><br><br><br>		
	 	<button id="abrir-carrinho">Abrir Carrinho</button> 			 
</body>
</html>
