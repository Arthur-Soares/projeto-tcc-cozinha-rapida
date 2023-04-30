<%@page import="projeto.util.MenuUtils"%>
<%@page import="projeto.util.Cast"%>
<%@page import="projeto.util.AppSecrets"%>
<%@page import="projeto.model.Cr_usuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<%	
	Cr_usuario cru = null!=session.getAttribute(AppSecrets.USER_KEY)?(Cr_usuario)session.getAttribute(AppSecrets.USER_KEY):null;
	int p_cr_id_usuario = null!=cru?cru.getCr_id_usuario():0;
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
	
	//String p_cr_id_usuario = null!=request.getParameter("cr_id_usuario")?request.getParameter("cr_id_usuario"):"";
	
	System.out.println("p_cr_id_usuario :: "+p_cr_id_usuario);
	%>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">		
		<title>Cozinha Rápida - Editar Usuário</title>
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
			
			h1 {	
				color: #945d60;
				font-weight: 800;
				font-family: 'Open Sans', sans-serif;
				font-size: 40px;
			}	
			
			h2 {
				color: #FFFFFF;
				font-weight: 800;
				font-family: 'Open Sans', sans-serif;
				font-size: 30px;
				margin-top:10px;
			}
			
			h3 {	
				font-weight: bold;
				font-family: 'Open Sans', sans-serif;
				color: #FFFFFF;
				font-size: 20px;
			}			
			
			#btnCadastro {	
				border: none;						
				color: #FFFFFF;
				background: #636f61;
				border-radius: 40px;
				transition: 0.2s;
				cursor: pointer;			
				transition: 0.2s;
				font-size: 15px;
			}
						
			#btnSalvarDados {	
				border: none;						
				color: #FFFFFF;
				background: #636f61;
				border-radius: 40px;
				transition: 0.2s;
				cursor: pointer;			
				transition: 0.2s;
				font-size: 15px;
			}
			
			body {
				background: url('../imagens/fast_kitchen_login_dark.png') no-repeat center center fixed; 
				-webkit-background-size: cover;
				-moz-background-size: cover;
				-o-background-size: cover;
				background-size: cover;
				color: #323232;
				font-family: 'Open Sans', sans-serif;	
			}
			
			.login {
				background-color: #636f61;
				margin: 0px;
			    height: 100vh;
			    display: flex;
				flex-direction: row;
				justify-content: center;
				align-items: center;
				text-align: center;
				float: left;
			}
			
			.div_cadastro_sucesso {
				background-color: #636f61;
				margin: 0px;
			    height: 100vh;
			    display: flex;
				flex-direction: row;
				justify-content: center;
				align-items: center;
				text-align: center;
				float: center;
			}
			
			.cadastro {			
				margin: 0px;
			    height: 100vh;
			    display: flex;
				flex-direction: row;
				justify-content: center;
				align-items: center;
				text-align: center;
				float: right;
			}
			
			.div_cadastro_dois{
				margin: 0px;
			    height: 100vh;
			    display: flex;
				flex-direction: row;
				justify-content: center;
				align-items: center;
				text-align: center;
				float: center;
			}
			
			.div_cadastro{
				margin: 0px;
			    height: 100vh;
			    display: flex;
				flex-direction: row;
				justify-content: center;
				align-items: center;
				text-align: center;
				float: center;
			}
			
			.div_cadastro_tres{
				margin: 0px;
			    height: 100vh;
			    display: flex;
				flex-direction: row;
				justify-content: center;
				align-items: center;
				text-align: center;
				float: center;
			}
			
			.conta {			
				margin: 0px;
			    height: 100vh;
			    display: flex;
				flex-direction: row;
				justify-content: center;
				align-items: center;
				text-align: center;
				float: right;
			}
			
			@media(max-width: 766px) {
    			#btnSalvarDados.btn1 {
        			margin-left: 40%;
    			}
			}
			@media(max-width: 550px) {
    			#btnSalvarDados.btn1 {
        			margin-left: 30%;
    			}
			}
			@media(max-width: 400px) {
    			#btnSalvarDados.btn2 {
        			margin-right: 50%%;
        			width: 150px;
        			margin-top: 5px;
    			}
			}
			
			#btnCadastrar {	
				border: none;			
				outline: none;
				color: #FFFFFF;
				background: #fff;			
				transition: 0.2s;
				cursor: pointer;
				background: transparent;
				transition: 0.2s;
				font-size: 15px;
			}
			
			#btnCadastrar:hover {	 	    
			    border: 5px solid;					
				border-color: #FFFFFF;
				border-radius: 40px;
			}		
			
			#btnLogin {	
				border: 5px solid;					
				border-color: #FFFFFF; 
				outline: none;
				color: #FFFFFF;
				background: #fff;
				border-radius: 40px;
				transition: 0.2s;
				cursor: pointer;
				background: transparent;
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
			var div_cadastro = $('.div_cadastro');	
		    var div_cadastro_dois = $('.div_cadastro_dois');		
		    var div_cadastro_tres = $('.div_cadastro_tres');
		    var div_cadastro_sucesso = $('.div_cadastro_sucesso');		
		    			    
		    div_cadastro.show();
		    div_cadastro_dois.hide();				  			
		    div_cadastro_tres.hide();	
		    div_cadastro_sucesso.hide();	
		    
			carregaUsuario('<%=p_cr_id_usuario%>');
			
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
					$.getJSON("../jsonservlet",{opc_servlet:'find_receita',cr_id_receita:item.value}, 
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
		
		function carregaUsuario(idusu){
			
			var cr_id_usuario = "";
			var cr_email_usuario = "";			
			var cr_nome_completo_usuario = "";
			var cr_cpf_usuario = "";
			var cr_telefone_usuario = "";
			var cr_cep_usuario = "";
			var cr_endereco_usuario = "";
			var cr_nrmcasa_usuario = "";
			var cr_endcomplemento_usuario = "";
			var cr_pontoreferencia_usuario = "";
			
			
			if(""!=idusu && "0"!=idusu){
				$.postJSON("../jsonservlet",{opc_servlet:'find_usuario',cr_id_usuario:idusu},
					function(datalin,statuslin){
						if(datalin){
							cr_id_usuario = datalin.cr_id_usuario;
							if(cr_id_usuario != "0"){								
								cr_email_usuario = datalin.cr_email_usuario;								
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
		
		//Chama a segunda tela para preenchimento dos dados, nessa tela são cadastrado as partes referentes ao endereço
		function chamaCadastroDois(){   		
			var cr_nome_completo_usuario = $("#cr_nome_completo_usuario").val();
			var cr_cpf_usuario = $("#cr_cpf_usuario").val();
			var cr_telefone_usuario = $("#cr_telefone_usuario").val();					
			
			if(cr_nome_completo_usuario == "" || cr_cpf_usuario == "" || cr_telefone_usuario == ""){
				alert('Preencha todos os campos!');
				return false;					
			}else{
				$(".div_cadastro").toggle('slide');
			    $(".div_cadastro_dois").toggle('slide');
			}						   
		}
	
		//Chama a terceira tela para preenchimento dos dados, nessa tela são cadastrado as partes referentes a Email e Senha
		function chamaCadastroTres(){   									    
			var cr_cep_usuario = $("#cr_cep_usuario").val();
			var cr_nrmcasa_usuario = $("#cr_nrmcasa_usuario").val();
			var cr_endereco_usuario = $("#cr_endereco_usuario").val();					
			
			if(cr_cep_usuario == "" || cr_nrmcasa_usuario == "" || cr_endereco_usuario == ""){
				alert('Preencha todos os campos!');
				return false;					
			}else{
			    $(".div_cadastro_dois").toggle('slide');
			    $(".div_cadastro_tres").toggle('slide');		  
			}
		}
					
		//Volta para a primeira tela de preenchimento de dados onde se encontra: Nome, CPF e Telefone 
		function voltarCadastroUm(){   									    
		    $(".div_cadastro_dois").toggle('slide');
		    $(".div_cadastro").toggle('slide');		   
		}
		
		//Volta para a primeira tela de preenchimento de dados onde se encontra: Nome, CPF e Telefone 
		function voltarCadastroDois(){   									    
		    $(".div_cadastro_tres").toggle('slide');
		    $(".div_cadastro_dois").toggle('slide');		   
		}
		
		//Volta para a tela inicial de Login e Cadastro ao cadastrar Conta
		function voltarLoginSucesso(){   								
			$("#tela_home").submit();			    
		}
		
		/* Função que ao clicar no olho ao lado dos inputs das senhas transforma o tipo dela de PASSWORD para TEXT assim tornando
		 * possivel visualizar o que foi digitado nos campos, caso seja clicado novamente faz o inverso.
		 */
		function mostraSenha(input){
			var input = document.querySelector(input);
			
		    if(input.getAttribute('type') == 'password') {
		    	input.setAttribute('type', 'text');
		    }else{
		    	input.setAttribute('type', 'password');
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
			var cr_email_usuario = $("#cr_email_usuario").val();							
			
			if(cr_email_usuario == ""){
				alert('Email em Branco!');
				$("#cr_email_usuario").focus();
				return false;
			}
			
			var arrayJSON = $('#login_cadastro').serializeArray();
			$.postJSON("../jsonservlet",arrayJSON,
				function(data,status){
					if(data.id_usuario!="0" && data.id_usuario != ""){
						$("#cr_id_usuario").val(data.id_usuario);																		
						$(".div_cadastro_tres").slideUp(200);
					    $(".div_cadastro_sucesso").slideDown(200);	
					    limpaCamposCadastro();
					}else{
						alert("Problema ao salvar registro!");
						return false;
					}
				}
			);			
		}
		
		//Função que pesquisa o CEP, é chamada assim que o usuário clica fora do campo CEP
		function pesquisaCEP() {
			var cr_cep_usuario = $("#cr_cep_usuario").val();
			var cr_endereco_usuario = $("#cr_endereco_usuario").val();
			var cr_nrmcasa_usuario = $("#cr_nrmcasa_usuario").val();
			var cr_endcomplemento_usuario = $("#cr_endcomplemento_usuario").val();
			var cr_pontoreferencia_usuario = $("#cr_pontoreferencia_usuario").val();						

			//Nova variável "cep" somente com dígitos.
			var cep = cr_cep_usuario.replace(/\D/g, '');
			//Verifica se campo cep possui valor informado.
			if (cep != "") {
				//Expressão regular para validar o CEP.
				var validacep = /^[0-9]{8}$/;
				//Valida o formato do CEP.
				if(validacep.test(cep)) {
					//Preenche os campos com "..." enquanto consulta webservice.
					$("#cr_endereco_usuario").val("...");				 					
					//Cria um elemento javascript.
					var script = document.createElement('script');
					//Sincroniza com o callback.
					script.src = 'https://viacep.com.br/ws/'+ cep + '/json/?callback=retornoCEP';
					//Insere script no documento e carrega o conteúdo.
					document.body.appendChild(script);
				} else {
					//cep é inválido.
					limpaCamposCEP();
					alert("Formato de CEP inválido.");
				}
			} else {
				//cep sem valor, limpa formulário.
				limpaCamposCEP();
				alert("Digite o CEP antes de pesquisar!");
				return false;
			}
		}
		
		/* Pega o conteudo retornado pelo pesquisaCEP e retorna na tela, neste caso só iremos retornar o endereço
		 * pois será o unico dados que iremos utilizar
		 */		
		function retornoCEP(conteudo) {				
			var cr_endereco_usuario = $("#cr_endereco_usuario").val();	 
			
			if (!("erro" in conteudo)) {
				//Atualiza os campos com os valores.
				 $("#cr_endereco_usuario").val(conteudo.logradouro);					 								
			} else {
				//CEP não Encontrado.
				limpaCamposCEP();
				alert("CEP não encontrado!");
			}
		}	      
		
		//Função que Limpa os campos do CEP
		function limpaCamposCEP() {			
			$("#cr_cep_usuario").val("");
			$("#cr_endereco_usuario").val("");
			$("#cr_nrmcasa_usuario").val("");
			$("#cr_endcomplemento_usuario").val("");
			$("#cr_pontoreferencia_usuario").val("");			
		}
		
		//Função que Limpa todos os campos ao Salvar Registro
		function limpaCamposCadastro() {			
			$("#cr_id_usuario").val("");
			$("#cr_email_usuario").val("");			
			$("#cr_nome_completo_usuario").val("");
			$("#cr_cpf_usuario").val("");
			$("#cr_telefone_usuario").val("");
			$("#cr_cep_usuario").val("");
			$("#cr_endereco_usuario").val("");
			$("#cr_nrmcasa_usuario").val("");
			$("#cr_endcomplemento_usuario").val("");
			$("#cr_pontoreferencia_usuario").val("");			
		}		

		//Aplica a máscara no campo
		//Função para ser utilizada nos eventos do input para formatação dinâmica
		function aplica_mascara_cpfcnpj(campo,tammax,teclapres) {
		    //var tecla = teclapres.keyCode;
	
		    /*if ( ( (tecla < 48 || tecla > 57) && (tecla < 96 || tecla > 105) && tecla != 46 && tecla != 8) ){
		        return false;
		    }*/
	
		    var vr = campo.value;
		    vr = vr.replace( /\//g, "" );
		    vr = vr.replace( /-/g, "" );
		    vr = vr.replace( /\./g, "" );
		    var tam = vr.length;
	
		    if ( tam <= 2 ) {
		        campo.value = vr;
		    }
		    if ( (tam > 2) && (tam <= 5) ) {
		        campo.value = vr.substr( 0, tam - 2 ) + '-' + vr.substr( tam - 2, tam );
		    }
		    if ( (tam >= 6) && (tam <= 8) ) {
		        campo.value = vr.substr( 0, tam - 5 ) + '.' + vr.substr( tam - 5, 3 ) + '-' + vr.substr( tam - 2, tam );
		    }
		    if ( (tam >= 9) && (tam <= 11) ) {
		        campo.value = vr.substr( 0, tam - 8 ) + '.' + vr.substr( tam - 8, 3 ) + '.' + vr.substr( tam - 5, 3 ) + '-' + vr.substr( tam - 2, tam );
		    }
		    if ( (tam == 12) ) {
		        campo.value = vr.substr( tam - 12, 3 ) + '.' + vr.substr( tam - 9, 3 ) + '/' + vr.substr( tam - 6, 4 ) + '-' + vr.substr( tam - 2, tam );
		    }
		    if ( (tam > 12) && (tam <= 14) ) {
		        campo.value = vr.substr( 0, tam - 12 ) + '.' + vr.substr( tam - 12, 3 ) + '.' + vr.substr( tam - 9, 3 ) + '/' + vr.substr( tam - 6, 4 ) + '-' + vr.substr( tam - 2, tam );
		    }
		}
		
		function retorna_verifica_cpfcnpj(){
			var cpf_cnpj = $("#cr_cpf_usuario").val();
			ret = verifica_cpf_cnpj(retira_mascara(cpf_cnpj));		
			if(!falsidade){
				alert("CPF/CNPJ inválido!");
				$("#cr_cpf_usuario").val("");
				$("#cr_cpf_usuario").focus();
				return false;
			}
		}
		
		//Verifica se CPF ou CGC e encaminha para a devida função, no caso do cpf/cgc estar digitado sem mascara
		function verifica_cpf_cnpj(cpf_cnpj) {
		    if (cpf_cnpj.length == 11) {
		        return(verifica_cpf(cpf_cnpj));
		    } else if (cpf_cnpj.length == 14) {
		        return(verifica_cnpj(cpf_cnpj));
		    } else { 
		        return false;
		    }		   
		}
	
		//Verifica se o número de CPF informado é válido
		function verifica_cpf(sequencia) {
		    if ( Procura_Str(1,sequencia,'00000000000,11111111111,22222222222,33333333333,44444444444,55555555555,66666666666,77777777777,88888888888,99999999999,00000000191,19100000000') > 0 ) {
		        return false;
		    }
		    seq = sequencia;
		    soma = 0;
		    multiplicador = 2;
		    for (f = seq.length - 3;f >= 0;f--) {
		        soma += seq.substring(f,f + 1) * multiplicador;
		        multiplicador++;
		    }
		    resto = soma % 11;
		    if (resto == 1 || resto == 0) {
		        digito = 0;
		    } else {
		        digito = 11 - resto;
		    }
		    if (digito != seq.substring(seq.length - 2,seq.length - 1)) {
		        return false;
		    }
		    soma = 0;
		    multiplicador = 2;
		    for (f = seq.length - 2;f >= 0;f--) {
		        soma += seq.substring(f,f + 1) * multiplicador;
		        multiplicador++;
		    }
		    resto = soma % 11;
		    if (resto == 1 || resto == 0) {
		        digito = 0;
		    } else {
		        digito = 11 - resto;
		    }
		    if (digito != seq.substring(seq.length - 1,seq.length)) {
		        return false;
		    }
		    return true;
		}
	
		//Verifica se o número de CNPJ informado é válido
		function verifica_cnpj(sequencia) {
		    seq = sequencia;
		    soma = 0;
		    multiplicador = 2;
		    for (f = seq.length - 3;f >= 0;f-- ) {
		        soma += seq.substring(f,f + 1) * multiplicador;
		        if ( multiplicador < 9 ) {
		            multiplicador++;
		        } else {
		            multiplicador = 2;
		        }
		    }
		    resto = soma % 11;
		    if (resto == 1 || resto == 0) {
		        digito = 0;
		    } else {
		        digito = 11 - resto;
		    }
		    if (digito != seq.substring(seq.length - 2,seq.length - 1)) {
		        return false;
		    }
	
		    soma = 0;
		    multiplicador = 2;
		    for (f = seq.length - 2;f >= 0;f--) {
		        soma += seq.substring(f,f + 1) * multiplicador;
		        if (multiplicador < 9) {
		            multiplicador++;
		        } else {
		            multiplicador = 2;
		        }
		    }
		    resto = soma % 11;
		    if (resto == 1 || resto == 0) {
		        digito = 0;
		    } else {
		        digito = 11 - resto;
		    }
		    if (digito != seq.substring(seq.length - 1,seq.length)) {
		        return false;
		    }
		    return true;
		}
		
		//Procura uma string dentro de outra string
		function Procura_Str(param0,param1,param2) {
		    for (a = param0 - 1;a < param1.length;a++) {
		        for (b = 1;b < param1.length;b++) {
		            if (param2 == param1.substring(b - 1,b + param2.length - 1)) {
		                return a;
		            }
		        }
		    }
		    return 0;
		}
			
		//Retira a máscara do valor de cpf_cnpj
		function retira_mascara(cpf_cnpj) {
		    return cpf_cnpj.replace(/\./g,'').replace(/-/g,'').replace(/\//g,'')
		}
		
		function validacaoEmail() {			  
		  var email = $("#cr_email_usuario").val();			  
		  var usuario = email.substring(0, email.indexOf("@"));
		  var dominio = email.substring(email.indexOf("@")+ 1, email.length);

		  if ((usuario.length >=1) &&
		      (dominio.length >=3) &&
		      (usuario.search("@")==-1) &&
		      (dominio.search("@")==-1) &&
		      (usuario.search(" ")==-1) &&
		      (dominio.search(" ")==-1) &&
		      (dominio.search(".")!=-1) &&
		      (dominio.indexOf(".") >=1)&&
		      (dominio.lastIndexOf(".") < dominio.length - 1)) {
		    // email válido			   
		  } else {
		    // email inválido
		    alert('Por favor, insira um email válido.');
		  }
		}			
	</script>

	<body>	
		<%=MenuUtils.buildMenu("usuario", cru, "S")%>
		
		<form id="frmreceita" name="frmreceita" method="post" action="/projeto-tcc-cozinha-rapida/restrito/cr_receita.jsp">
			<input type="hidden" id="cr_id_receita" name="cr_id_receita"/>
		</form>
		<form id="tela_home" name="tela_home" method="post" action="../home_cozinharapida.jsp">
		</form>
		<form id="login_cadastro" name="login_cadastro" method="post" action="loginservlet">	
			<input type="hidden" id="cr_id_usuario" name="cr_id_usuario" value="0"/>
			<input type="hidden" id="cr_nivel_usuario" name="cr_nivel_usuario" value="2"/>
			<input type="hidden" id="opc_servlet" name="opc_servlet" value="salva_usuario"/>		
			
			<!-- DIV CADASTRO CONTA - PRIMEIRA PARTE -->
			<div class="div_cadastro">
			<br><br>			
				<div class="col-xl-11 col-lg-11 col-md-11 col-sm-12 col-12">					
					<font style="font-size: 0px">										
					<br>								
						<h2>Editar Dados Pessoais:</h2>					
					<br>
					
					<div class="row mt-3 justify-content-md-center">
						<div class="col-xl-3 col-lg-3 col-md-8 col-sm-12 col-12">
							<label for="cr_nome_completo_usuario" style="color: #EEEEEE; font-size: 15px;  float: left; font-weight: bold;"><strong>Nome de Usuario</strong></label> 
							<input type="text" class="form-control form-control-lg rounded-50" maxlength="255" name="cr_nome_completo_usuario" id="cr_nome_completo_usuario" placeholder="Digite seu Nome" style="font-size: 15px; height: 40px; color:black; font-weight: bold; background: #CCCCCC; opacity: 0.8;  border-radius: 10px;"/> 
						</div>					
					</div>
						
					<div class="row mt-3 justify-content-md-center">					
						<div class="col-xl-3 col-lg-3 col-md-8 col-sm-12 col-12">
							<label for="cr_cpf_usuario" style="color: #EEEEEE; font-size: 15px;  float: left; font-weight: bold;"><strong>CPF</strong></label> 
							<input type="text" class="form-control form-control-lg rounded-50" name="cr_cpf_usuario" id="cr_cpf_usuario" placeholder="Digite seu CPF" maxlength="14" onkeydown="javascript:return aplica_mascara_cpfcnpj(this,18,event)" onkeyup="javascript:return aplica_mascara_cpfcnpj(this,18,event)" onchange="javascript:retorna_verifica_cpfcnpj();" style="font-size: 15px; height: 40px; color:black; font-weight: bold; background: #CCCCCC; opacity: 0.8;  border-radius: 10px;"/>
						</div>	
					</div>
					
					<div class="row mt-3 justify-content-md-center">					
						<div class="col-xl-3 col-lg-3 col-md-8 col-sm-12 col-12">
							<label for="cr_telefone_usuario" style="color: #EEEEEE; font-size: 15px;  float: left; font-weight: bold;"><strong>Telefone</strong></label> 
							<input type="text" onkeypress="$(this).mask('(99) 99999-9999');" class="form-control form-control-lg rounded-50" name="cr_telefone_usuario" placeholder="Digite seu Telefone + DD" maxlength="16" id="cr_telefone_usuario" style="font-size: 15px; height: 40px; color:black; font-weight: bold; background: #CCCCCC; opacity: 0.8;  border-radius: 10px;"/>
						</div>	
					</div>						
					<br/>
					
					<br/>
					<div class="row mt-3 justify-content-md-center">																					
						<button type="button" class="btn1 btn btn-success btn-lg float-center" id="btnSalvarDados" style="font-size: 15px; padding-top:10px; padding-bottom:10px; padding-left:50px; padding-right:50px;" onclick="chamaCadastroDois();">
							<strong>Continuar <i class="fa fa-chevron-right" aria-hidden="true"></i></strong> 
						</button>	
					</div>														
					</font>				
				</div>				
			</div>	
			
			<!--  DIV CADASTRO CONTA - SEGUNDA PARTE -->
			<div class="div_cadastro_dois">			
				
				<div class="col-xl-11 col-lg-11 col-md-8 col-sm-12 col-12">				
					<font style="font-size: 0px">	
					<br>								
						<h2>Editar Endereço:</h2>						
					<br>
					
					<div class="row mt-3 justify-content-md-center">
						<div class="col-xl-4 col-lg-6 col-md-8 col-sm-12 col-12">
							<label for="cr_cep_usuario" style="color: #EEEEEE; font-size: 15px;  float: left; font-weight: bold;"><strong>CEP</strong></label> 
							<input type="text" class="form-control form-control-lg rounded-50" name="cr_cep_usuario" id="cr_cep_usuario" placeholder = "Digite seu CEP (Sem traços)" maxlength="20" onkeypress="$(this).mask('00000-000')" style="font-size: 15px; height: 40px; color:black;font-weight: bold;  background: #CCCCCC; opacity: 0.8; border-radius: 10px;" onchange="pesquisaCEP();"/> 
						</div>					
					</div>
					
					<div class="row mt-3 justify-content-md-center">					
						<div class="col-xl-3 col-lg-4 col-md-6 col-sm-10 col-8">
							<label for="cr_endereco_usuario" style="color: #EEEEEE; font-size: 15px;  float: left; font-weight: bold;"><strong>Endereço</strong></label> 
							<input type="text" class="form-control form-control-lg rounded-50" name="cr_endereco_usuario" id="cr_endereco_usuario" placeholder = "Endereço" maxlength="200" style="font-size: 15px; height: 40px; color:black; font-weight: bold; background: #CCCCCC; opacity: 0.8;  border-radius: 10px;" readonly/>
						</div>
						<div class="col-xl-1 col-lg-2 col-md-2 col-sm-2 col-4">
							<label for="cr_nrmcasa_usuario" style="color: #EEEEEE; font-size: 15px;  float: left; font-weight: bold;"><strong>Nº</strong></label> 
							<input type="text" class="form-control form-control-lg rounded-50" name="cr_nrmcasa_usuario" id="cr_nrmcasa_usuario" placeholder = "Nº" maxlength="5" style="font-size: 15px; height: 40px; color:black; font-weight: bold; background: #CCCCCC; opacity: 0.8;  border-radius: 10px;"/>
						</div>		
					</div>		
																		
					<div class="row mt-3 justify-content-md-center">					
						<div class="col-xl-4 col-lg-6 col-md-8 col-sm-12 col-12">
							<label for="cr_endcomplemento_usuario" style="color: #EEEEEE; font-size: 15px;  float: left; font-weight: bold;"><strong>Complemento</strong></label> 
							<input type="text" class="form-control form-control-lg rounded-50" name="cr_endcomplemento_usuario" id="cr_endcomplemento_usuario" placeholder = "Complemento" maxlength="200" style="font-size: 15px; height: 40px; color:black; font-weight: bold; background: #CCCCCC; opacity: 0.8;  border-radius: 10px;"/>
						</div>	
					</div>	
					
					<div class="row mt-3 justify-content-md-center">					
						<div class="col-xl-4 col-lg-6 col-md-8 col-sm-12 col-12">
							<label for="cr_pontoreferencia_usuario" style="color: #EEEEEE; font-size: 15px;  float: left; font-weight: bold;"><strong>Ponto de Referência</strong></label> 
							<input type="text" class="form-control form-control-lg rounded-50" name="cr_pontoreferencia_usuario" placeholder = "Ponto de Referência" id="cr_pontoreferencia_usuario" maxlength="200"  style="font-size: 15px; height: 40px; color:black; font-weight: bold; background: #CCCCCC; opacity: 0.8;  border-radius: 10px;"/>
						</div>	
					</div>	
					
					<br/>
					
					<div class="row mt-3 justify-content-md-center">
						
						<div class="col-xl-2 col-lg-3 col-md-4 col-sm-5 col-12">
							<button type="button" class="btn2 btn btn-success btn-lg float-center" id="btnSalvarDados" style="margin-top: 3px; font-size: 15px;width:185px; padding-top:10px; padding-bottom:10px; padding-left:50px; padding-right:50px;" onclick="voltarCadastroUm();">
								<strong><i class="fa fa-chevron-left" aria-hidden="true"></i> Voltar</strong> 
							</button>	
						
						</div>	
						
						<div class="col-xl-2 col-lg-3 col-md-4 col-sm-5 col-12">
							<button type="button" class="btn2 btn btn-success btn-lg float-center" id="btnSalvarDados" style="margin-top: 3px; font-size: 15px; width:185px; padding-top:10px; padding-bottom:10px; padding-left:50px; padding-right:50px;" onclick="chamaCadastroTres();">
								<strong>Continuar <i class="fa fa-chevron-right" aria-hidden="true"></i></strong> 
							</button>
						</div>
																												
					</div>														
					</font>				
				</div>
			</div>
		
			<!-- DIV CADASTRO CONTA - TERCEIRA PARTE -->
			<div class="div_cadastro_tres">								
				
				<div class="col-xl-11 col-lg-11 col-md-11 col-sm-12 col-12">						
					<font style="font-size: 0px">														
					<br>								
						<h2>Atualizar Email:</h2>						
					<br>																
					<div class="row mt-3 justify-content-md-center"></div>
					
					<div class="row mt-3 justify-content-md-center">
						<div class="col-xl-5 col-lg-6 col-md-8 col-sm-12 col-12">
							<label for="cr_email_usuario" style="color: #EEEEEE; font-size: 15px;  float: left; font-weight: bold;"><strong>Email</strong></label> 
							<input type="email" class="form-control form-control-lg rounded-50" name="cr_email_usuario" id="cr_email_usuario" onchange="validacaoEmail()" placeholder = "Digite seu E-mail" style="font-size: 15px; height: 40px; color:black; font-weight: bold;  background: #CCCCCC; opacity: 0.8; border-radius: 10px;"/> 
						</div>					
					</div>
					
					<br/>
					<div class="row mt-3 justify-content-md-center">
						
						<div class="col-xl-2 col-lg-3 col-md-4 col-sm-5 col-12">
							<button type="button" class="btn2 btn btn-success btn-lg float-center" id="btnSalvarDados" style="margin-top: 3px; font-size: 15px;width:185px; padding-top:10px; padding-bottom:10px; padding-left:50px; padding-right:50px;" onclick="voltarCadastroDois();">
								<strong><i class="fa fa-chevron-left" aria-hidden="true"></i> Voltar</strong> 
							</button>	
						
						</div>	
						
						<div class="col-xl-2 col-lg-3 col-md-4 col-sm-5 col-12">
							<button type="button" class="btn2 btn btn-success btn-lg float-center" id="btnSalvarDados" style="margin-top: 3px; font-size: 15px; width:185px; padding-top:10px; padding-bottom:10px; padding-left:50px; padding-right:50px;" onclick="salvarRegistro();">
								<strong>Atualizar</strong> 
							</button>
						</div>
																												
					</div>		
														
					</font>				
				</div>
			</div>													
			
			<!-- DIV CADASTRO CONTA - CONTA CRIADA COM SUCESSO -->
			<div class="div_cadastro_sucesso">
				<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">	
					<font style="font-size: 0px">	
					<br>								
						<h2>Sua conta foi atualizada com sucesso!</h2>					
					<br>					
					<br/>			
					<div class="row mt-3 justify-content-md-center">															
						<button type="button" class="btn btn-success btn-lg float-center" id="btnLogin" style="font-size: 15px; padding-top:10px; padding-bottom:10px; padding-left:50px; padding-right:50px;"  onclick="voltarLoginSucesso();">
							<strong>Inicio</strong>
						</button>	
					</div>													
					</font>				
				</div>
			</div>					
		</form>
	</body>
</html>
