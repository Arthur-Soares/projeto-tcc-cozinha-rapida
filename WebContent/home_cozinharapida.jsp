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
			-webkit-background-size: cover;
			-moz-background-size: cover;
			-o-background-size: cover;
			background-size: cover;			
			font-family: 'Open Sans', sans-serif;			
		}
		
		.div_cadastro_sucesso {			
			margin: 0px;
		    height: 90vh;
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
		
		@media (max-width: 768px) {
		  .container {
		    flex-direction: column;
		    align-items: center;
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
			var logoff = '<%=opclogoff%>';
			if(logoff == "S"){
				$("#tela_home").submit();
			}
			
			//Isto está definido diretamente no nosso <select> e tem o objetivo de carregar as possíveis opções do nosso autocomplete
			//data-url='./jsonservlet?opc_servlet=sel_pesquisa_receita'
			//Implementando componente de AUTOCOMPLETE em um <select com o ID = "sel_receita"
			$('#sel_receita').autoComplete();
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
		
		//Volta para a tela inicial de Login e Cadastro ao cadastrar Conta
		function voltarLoginSucesso(){   								
		    $(".div_cadastro_sucesso").toggle('slide');
		    $(".div_login").toggle('slide');	
		    $("#cr_email_usuario_login").focus();
		}		
	</script>
		
	<body>	
		
		<%=MenuUtils.buildMenu("welcome", cru)%>
		
		
		<form id="frmreceita" name="frmreceita" method="post" action="/projeto-tcc-cozinha-rapida/restrito/cr_receita.jsp">
			<input type="hidden" id="cr_id_receita" name="cr_id_receita"/>
		</form>
		<form id="tela_home" name=tela_home method="post" action="home_cozinharapida.jsp">	
			<input type="hidden" id="cr_id_usuario" name="cr_id_usuario" value="0"/>
			<input type="hidden" id="opc_servlet" name="opc_servlet" value="salva_usuario"/>						
			<div class="div_cadastro_sucesso" style="font-size: 90%;">																
				<h1>Olá, Bem vindo ao<br/>Cozinha Rápida!</h1>																																								
			</div>		
			<div class="div_ver_mais">															
				<button type="button" class="btn btn-lg float-center" style="color: #FFFFFF; font-size: 20px;" onclick="voltarCadastroDois();">
					<strong>Ver mais</strong><br><i class="fa fa-chevron-down" aria-hidden="true"></i>	
				</button>								
			</div>				
		</form>
	</body>
</html>