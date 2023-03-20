<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR, pt">
	<head>
		<title>Cozinha Rápida - Acesso restrito</title>
	    <link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="fontawesome/css/all.min.css" rel="stylesheet">
		<meta http-equiv="Content-Type" content="text/html; charset:iso-88590-1">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		<script type="text/javascript" src="fontawesome/js/all.min.js"></script>
		<script type="text/javascript" src="./js/bootstrap-autocomplete.js"></script>
		<script type="text/javascript" src="./js/popper.js"></script>
		<script type="text/javascript" src="./js/jquery.mask.min.js"></script>
		<script src="./js/bootstrap-datepicker.min.js"></script>
		<script src="./js/bootstrap-datepicker.pt-BR.min.js"></script>		 
		<link href="./js/bootstrap.min.css"rel="stylesheet">
		<link href="./js/bootstrap-dialog.min.css" rel="stylesheet">
		<link href="./js/font-awesome/css/font-awesome.min.css" rel="stylesheet">
		<script src="./js/jquery.js"></script>
		<script type="text/javascript" src="./js/jquery.mask.min.js"></script>
	    <script src="./js/bootstrap.min.js"></script>
	    <script src="./js/bootstrap-dialog.min.js"></script>
		<!--	
		
		<!-- 
		Font Awesome Free 5.3.1 by @fontawesome - (https://fontawesome.com)
		Bootstrap v4.1.3 (https://getbootstrap.com/)
		jQuery JavaScript Library v3.3.1 (https://jquery.com/)
 		Includes Sizzle.js (https://sizzlejs.com/)
		-->
		<%
		String redir = null!=request.getParameter("redir")?request.getParameter("redir"):"";
		String opclogoff = null!=request.getParameter("logoff")?request.getParameter("logoff"):"";
		//logoff=S
		String msgIndex = null != session.getAttribute("errologin") ? (String) session.getAttribute("errologin") : "";
				
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
			color: #945d60;
			font-weight: 800;
			font-family: 'Open Sans', sans-serif;
			font-size: 40px;
		}	
		
		h2 {
			color: #FFFFFF;
			font-weight: 800;
			font-family: 'Open Sans', sans-serif;
			font-size: 40px;
		}
		
		h3 {	
			font-weight: bold;
			font-family: 'Open Sans', sans-serif;
			color: #FFFFFF;
			font-size: 20px;
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
			background: url('imagens/fast_kitchen_login_dark.png') no-repeat center center fixed; 
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
			var div_login = $('.div_login');
			var div_cadastro = $('.div_cadastro');	
		    var div_cadastro_dois = $('.div_cadastro_dois');		
		    var div_cadastro_tres = $('.div_cadastro_tres');
		    var div_cadastro_sucesso = $('.div_cadastro_sucesso');		
		    
		    div_login.show();
		    div_cadastro.hide();
		    div_cadastro_dois.hide();				  			
		    div_cadastro_tres.hide();	
		    div_cadastro_sucesso.hide();	
		});
					
		//Volta para a tela inicial de Login e Cadastro
		function voltarLogin(){   								
		    $(".div_cadastro").slideUp(200);
		    $(".div_login").slideDown(200);		   
		}
		
		//Chama a tela de Cadastro
		function chamaCadastro(){   								
		    $(".div_login").slideUp(200);
		    $(".div_cadastro").slideDown(200);		   
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
		    $(".div_cadastro_sucesso").toggle('slide');
		    $(".div_login").toggle('slide');	
		    $("#cr_email_usuario_login").focus();
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
			var cr_senha_usuario = $("#cr_senha_usuario").val();
			var cr_senha_usuario_confirm = $("#cr_senha_usuario_confirm").val();					
			
			if(cr_email_usuario == ""){
				alert('Email em Branco!');
				$("#cr_email_usuario").focus();
				return false;
			}
			if(cr_senha_usuario == ""){
				alert('Preencha sua senha');				
				$("#cr_senha_usuario").focus();
				return false;
			}
			if(cr_senha_usuario != cr_senha_usuario_confirm){
				alert('Senhas diferentes!');				
				$("#cr_senha_usuario_confirm").focus();
				return false;
			}
			
			var arrayJSON = $('#login_cadastro').serializeArray();
			$.postJSON("./jsonservlet",arrayJSON,
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
			$("#cr_senha_usuario").val("");
			$("#cr_nome_completo_usuario").val("");
			$("#cr_cpf_usuario").val("");
			$("#cr_telefone_usuario").val("");
			$("#cr_cep_usuario").val("");
			$("#cr_endereco_usuario").val("");
			$("#cr_nrmcasa_usuario").val("");
			$("#cr_endcomplemento_usuario").val("");
			$("#cr_pontoreferencia_usuario").val("");
			$("#cr_email_usuario_login").val("");
			$("#cr_senha_usuario_login").val("");
		}
		
		function validaLogin(){
			var cr_email_usuario_login = $("#cr_email_usuario_login").val();
			var cr_senha_usuario_login = $("#cr_senha_usuario_login").val();					
			
			if(cr_email_usuario_login == ""){
				alert('Digite o Email!');
				$("#cr_email_usuario_login").focus();
				return false;
			}else if(cr_senha_usuario_login == ""){
				alert('Digite a Senha!');				
				$("#cr_senha_usuario_login").focus();
				return false;
			}else{
				$("#login_cadastro").submit();
			}			
						
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
		<form id="login_cadastro" name="login_cadastro" method="post" action="loginservlet">	
			<input type="hidden" id="cr_id_usuario" name="cr_id_usuario" value="0"/>
			<input type="hidden" id="cr_nivel_usuario" name="cr_nivel_usuario" value="2"/>
			<input type="hidden" id="opc_servlet" name="opc_servlet" value="salva_usuario"/>
			
			<!-- DIV LOGIN -->
			<div class="div_login">
				<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12 login">
					<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-xs-12 col-12 d-flex justify-content-center card" style="background: rgba(0,0,0,0.6); border-radius: 15px; padding: auto;">				
						<font style="font-size: 0px">						
							<h1>Bem-vindo<br/> de volta!</h1>
							<br>			
							<h3>Acesse sua conta ou crie uma nova!</h3>
							<br>
							
							<div class="row mt-3">														
								<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12 align-self-center form-group">
									<label for="cr_email_usuario_login" style="color: #FFFFFF; font-size: 15px;  float: center; font-weight: bold;"><strong>Email</strong></label> 
									<input type="text" class="form-control form-control-lg rounded-50" name="cr_email_usuario_login" placeholder = "Entre com seu E-mail" id="cr_email_usuario_login" style="font-size: 15px; height: 50px; color:black; font-weight: bold; background: #CCCCCC;  border-radius: 10px;" placeholder="Digite seu Email..."/> 
								</div>
							</div>					
							
							<div class="row mt-3">				
								<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12 align-self-center form-group">
									<label for="cr_senha_usuario_login" style="color: #FFFFFF; font-size: 15px;  float: center; font-weight: bold;"><strong>Senha</strong></label> 																			
									<div class="input-group">																			  															 
										<input type="password" class="form-control form-control-lg rounded-50" name="cr_senha_usuario_login" id="cr_senha_usuario_login" style="font-size: 15px; height: 50px; color:black; font-weight: bold; background: #CCCCCC; border-radius: 10px 0px 0px 10px;" placeholder="Digite sua Senha..."/>															    
								    	<div class="input-group-append">
								     	 	<div class="input-group-text" id="eye_password" style="height: 50px; color:black; font-weight: bold; background: #CCCCCC; border-radius: 0px 10px 10px 0px;" onclick="mostraSenha('#cr_senha_usuario_login');"><i class="fa fa-eye" aria-hidden="true"></i></div>
								    	</div>
								  	</div>
								</div>
							</div>
															
							<br/>
							<div class="row mt-3 justify-content-md-center" style="text-align: center;">															
								<button type="button" class="btn btn-success btn-lg float-center" id="btnLogin" style="font-size: 15px; padding-top:10px; padding-bottom:10px; padding-left:50px; padding-right:50px;" onclick="validaLogin();">
									<strong>Entrar</strong>
								</button>	
							</div>					
							<div class="row mt-3 justify-content-md-center" style="padding-top:2%;">																											
								<button type="button" class="btn btn-success btn-lg float-center" id="btnCadastrar" style="font-size: 15px; padding-top:10px; padding-bottom:10px; padding-left:50px; padding-right:50px;" onclick="chamaCadastro();">
									<strong>Cadastrar-se</strong>
								</button>						
							</div>														
						</font>
					</div>				
				</div>				
			</div>	
			
			<!-- DIV CADASTRO CONTA - PRIMEIRA PARTE -->
			<div class="div_cadastro">
				<div class="row col-xl-1 col-lg-1 col-md-1 col-sm-12 col-12" style="position: absolute; left:2%; top:5%;">															
					<button type="button" class="btn btn-lg float-center" style="color: #FFFFFF; font-size: 20px;" onclick="voltarLogin();">
						<strong><i class="fa fa-chevron-left" aria-hidden="true"></i> Voltar</strong> 
					</button>						
				</div>
				<div class="col-xl-11 col-lg-11 col-md-11 col-sm-12 col-12">					
					<font style="font-size: 0px">										
					<br>								
						<h2>Criando sua conta<br/>Preencha os dados abaixo:</h2>					
					<br>
					
					<div class="row mt-3 justify-content-md-center">
						<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-12">
							<label for="cr_nome_completo_usuario" style="color: #EEEEEE; font-size: 15px;  float: left; font-weight: bold;"><strong>Nome de Usuario</strong></label> 
							<input type="text" class="form-control form-control-lg rounded-50" maxlength="255" name="cr_nome_completo_usuario" id="cr_nome_completo_usuario" placeholder="Digite seu Nome" style="font-size: 15px; height: 50px; color:black; font-weight: bold; background: #CCCCCC; opacity: 0.8;  border-radius: 10px;"/> 
						</div>					
					</div>
						
					<div class="row mt-3 justify-content-md-center">					
						<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-12">
							<label for="cr_cpf_usuario" style="color: #EEEEEE; font-size: 15px;  float: left; font-weight: bold;"><strong>CPF</strong></label> 
							<input type="text" class="form-control form-control-lg rounded-50" name="cr_cpf_usuario" id="cr_cpf_usuario" placeholder="Digite seu CPF" maxlength="14" onkeydown="javascript:return aplica_mascara_cpfcnpj(this,18,event)" onkeyup="javascript:return aplica_mascara_cpfcnpj(this,18,event)" onchange="javascript:retorna_verifica_cpfcnpj();" style="font-size: 15px; height: 50px; color:black; font-weight: bold; background: #CCCCCC; opacity: 0.8;  border-radius: 10px;"/>
						</div>	
					</div>
					
					<div class="row mt-3 justify-content-md-center">					
						<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-12">
							<label for="cr_telefone_usuario" style="color: #EEEEEE; font-size: 15px;  float: left; font-weight: bold;"><strong>Telefone</strong></label> 
							<input type="text" onkeypress="$(this).mask('(99) 99999-9999');" class="form-control form-control-lg rounded-50" name="cr_telefone_usuario" placeholder="Digite seu Telefone + DD" maxlength="16" id="cr_telefone_usuario" style="font-size: 15px; height: 50px; color:black; font-weight: bold; background: #CCCCCC; opacity: 0.8;  border-radius: 10px;"/>
						</div>	
					</div>						
					<br/>
					<div class="row mt-3 justify-content-md-center">															
						<button type="button" style="background: #636f61; border:none; border-radius: 50%;  width: 10px; height: 10px; padding: 10px; margin-right: 15px;"></button>
						<button type="button" style="background: #FFFFFF; border:none; border-radius: 50%;  width: 10px; height: 10px; padding: 10px; margin-right: 15px;"></button>	
						<button type="button" style="background: #FFFFFF; border:none; border-radius: 50%;  width: 10px; height: 10px; padding: 10px;"></button>
					</div>
					<br/>
					<div class="row mt-3 justify-content-md-center">																					
						<button type="button" class="btn btn-success btn-lg float-center" id="btnSalvarDados" style="font-size: 15px; padding-top:10px; padding-bottom:10px; padding-left:50px; padding-right:50px;" onclick="chamaCadastroDois();">
							<strong>Continuar <i class="fa fa-chevron-right" aria-hidden="true"></i></strong> 
						</button>	
					</div>														
					</font>				
				</div>				
			</div>	
			
			<!--  DIV CADASTRO CONTA - SEGUNDA PARTE -->
			<div class="div_cadastro_dois">			
				<div class="row col-xl-1 col-lg-1 col-md-1 col-sm-12 col-12" style="position: absolute; left:2%; top:5%;">															
					<button type="button" class="btn btn-lg float-center" style="color: #FFFFFF; font-size: 20px;" onclick="voltarCadastroUm();">
						<strong><i class="fa fa-chevron-left" aria-hidden="true"></i> Voltar</strong> 
					</button>						
				</div>
				<div class="col-xl-11 col-lg-11 col-md-11 col-sm-12 col-12">				
					<font style="font-size: 0px">	
					<br>								
						<h2>Criando sua conta<br/>Preencha os dados abaixo:</h2>					
					<br>
					
					<div class="row mt-3 justify-content-md-center">
						<div class="col-xl-4 col-lg-4 col-md-4 col-sm-12 col-12">
							<label for="cr_cep_usuario" style="color: #EEEEEE; font-size: 15px;  float: left; font-weight: bold;"><strong>CEP</strong></label> 
							<input type="text" class="form-control form-control-lg rounded-50" name="cr_cep_usuario" id="cr_cep_usuario" placeholder = "Digite seu CEP (Sem traços)" maxlength="20" onkeypress="$(this).mask('00000-000')" style="font-size: 15px; height: 50px; color:black;font-weight: bold;  background: #CCCCCC; opacity: 0.8; border-radius: 10px;" onchange="pesquisaCEP();"/> 
						</div>					
					</div>
					
					<div class="row mt-3 justify-content-md-center">					
						<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-12">
							<label for="cr_endereco_usuario" style="color: #EEEEEE; font-size: 15px;  float: left; font-weight: bold;"><strong>Endereço</strong></label> 
							<input type="text" class="form-control form-control-lg rounded-50" name="cr_endereco_usuario" id="cr_endereco_usuario" placeholder = "Endereço" maxlength="200" style="font-size: 15px; height: 50px; color:black; font-weight: bold; background: #CCCCCC; opacity: 0.8;  border-radius: 10px;" readonly/>
						</div>
						<div class="col-xl-1 col-lg-1 col-md-1 col-sm-12 col-12">
							<label for="cr_nrmcasa_usuario" style="color: #EEEEEE; font-size: 15px;  float: left; font-weight: bold;"><strong>Nº</strong></label> 
							<input type="text" class="form-control form-control-lg rounded-50" name="cr_nrmcasa_usuario" id="cr_nrmcasa_usuario" placeholder = "Nº" maxlength="5" style="font-size: 15px; height: 50px; color:black; font-weight: bold; background: #CCCCCC; opacity: 0.8;  border-radius: 10px;"/>
						</div>		
					</div>		
																		
					<div class="row mt-3 justify-content-md-center">					
						<div class="col-xl-4 col-lg-4 col-md-4 col-sm-12 col-12">
							<label for="cr_endcomplemento_usuario" style="color: #EEEEEE; font-size: 15px;  float: left; font-weight: bold;"><strong>Complemento</strong></label> 
							<input type="text" class="form-control form-control-lg rounded-50" name="cr_endcomplemento_usuario" id="cr_endcomplemento_usuario" placeholder = "Complemento" maxlength="200" style="font-size: 15px; height: 50px; color:black; font-weight: bold; background: #CCCCCC; opacity: 0.8;  border-radius: 10px;"/>
						</div>	
					</div>	
					
					<div class="row mt-3 justify-content-md-center">					
						<div class="col-xl-4 col-lg-4 col-md-4 col-sm-12 col-12">
							<label for="cr_pontoreferencia_usuario" style="color: #EEEEEE; font-size: 15px;  float: left; font-weight: bold;"><strong>Ponto de Referência</strong></label> 
							<input type="text" class="form-control form-control-lg rounded-50" name="cr_pontoreferencia_usuario" placeholder = "Ponto de Referência" id="cr_pontoreferencia_usuario" maxlength="200"  style="font-size: 15px; height: 50px; color:black; font-weight: bold; background: #CCCCCC; opacity: 0.8;  border-radius: 10px;"/>
						</div>	
					</div>	
					<br/>
					<div class="row mt-3 justify-content-md-center">															
						<button type="button" style="background: #FFFFFF; border:none; border-radius: 50%;  width: 10px; height: 10px; padding: 10px; margin-right: 15px;"></button>
						<button type="button" style="background: #636f61; border:none; border-radius: 50%;  width: 10px; height: 10px; padding: 10px; margin-right: 15px;"></button>
						<button type="button" style="background: #FFFFFF; border:none; border-radius: 50%;  width: 10px; height: 10px; padding: 10px;"></button>	
					</div>
					<br/>
					<div class="row mt-3 justify-content-md-center">
						<button type="button" class="btn btn-success btn-lg float-center" id="btnSalvarDados" style="font-size: 15px; padding-top:10px; padding-bottom:10px; padding-left:50px; padding-right:50px;" onclick="chamaCadastroTres();">
							<strong>Continuar <i class="fa fa-chevron-right" aria-hidden="true"></i></strong> 
						</button>																						
					</div>														
					</font>				
				</div>
			</div>
		
			<!-- DIV CADASTRO CONTA - TERCEIRA PARTE -->
			<div class="div_cadastro_tres">								
				<div class="row col-xl-1 col-lg-1 col-md-1 col-sm-12 col-12" style="position: absolute; left:2%; top:5%;">															
					<button type="button" class="btn btn-lg float-center" style="color: #FFFFFF; font-size: 20px;" onclick="voltarCadastroDois();">
						<strong><i class="fa fa-chevron-left" aria-hidden="true"></i> Voltar</strong> 
					</button>						
				</div>
				<div class="col-xl-11 col-lg-11 col-md-11 col-sm-12 col-12">						
					<font style="font-size: 0px">														
					<br>								
						<h2>Criando sua conta<br/>Preencha os dados abaixo:</h2>					
					<br>					
					<div class="row mt-3 justify-content-md-center">
						<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-12">
							<label for="cr_email_usuario" style="color: #EEEEEE; font-size: 15px;  float: left; font-weight: bold;"><strong>Email</strong></label> 
							<input type="email" class="form-control form-control-lg rounded-50" name="cr_email_usuario" id="cr_email_usuario" onchange="validacaoEmail()" placeholder = "Digite seu E-mail" style="font-size: 15px; height: 50px; color:black; font-weight: bold;  background: #CCCCCC; opacity: 0.8; border-radius: 10px;"/> 
						</div>					
					</div>
						
					<div class="row mt-3 justify-content-md-center">										
						<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-12">
							<label for="cr_senha_usuario" style="color: #EEEEEE; font-size: 15px;  float: left; font-weight: bold;"><strong>Senha</strong></label> 																			
							<div class="input-group">																			  															 
								<input type="password" class="form-control form-control-lg rounded-50" name="cr_senha_usuario" id="cr_senha_usuario" placeholder = "Digite a Senha" style="font-size: 15px; height: 50px; color:black; font-weight: bold; background: #CCCCCC; opacity: 0.8; border-radius: 10px 0px 0px 10px;"/>																							   
						    	<div class="input-group-append">
						     	 	<div class="input-group-text" id="eye_password" style="height: 50px; color:black; font-weight: bold; background: #CCCCCC; opacity: 0.8; border-radius: 0px 10px 10px 0px;" onclick="mostraSenha('#cr_senha_usuario');"><i class="fa fa-eye" aria-hidden="true"></i></div>
						    	</div>
						  	</div>
						</div>
					</div>
					
					<div class="row mt-3 justify-content-md-center">											
						<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-12">
							<label for="cr_senha_usuario_confirm" style="color: #EEEEEE; font-size: 15px;  float: left; font-weight: bold;"><strong>Confirme a Senha</strong></label> 																			
							<div class="input-group">																			  															 
								<input type="password" class="form-control form-control-lg rounded-50" name="cr_senha_usuario_confirm" id="cr_senha_usuario_confirm" placeholder = "Confirmar Senha..." style="font-size: 15px; height: 50px; color:black; font-weight: bold; background: #CCCCCC; opacity: 0.8; border-radius: 10px 0px 0px 10px;"/>																							   
						    	<div class="input-group-append">
						     	 	<div class="input-group-text" id="eye_password" style="height: 50px; color:black; font-weight: bold; background: #CCCCCC; opacity: 0.8; border-radius: 0px 10px 10px 0px;" onclick="mostraSenha('#cr_senha_usuario_confirm');"><i class="fa fa-eye" aria-hidden="true"></i></div>
						    	</div>
						  	</div>
						</div>	
					</div>						
					<br/>
					<div class="row mt-3 justify-content-md-center">															
						<button type="button" style="background: #FFFFFF; border:none; border-radius: 50%;  width: 10px; height: 10px; padding: 10px; margin-right: 15px;"></button>
						<button type="button" style="background: #FFFFFF; border:none; border-radius: 50%;  width: 10px; height: 10px; padding: 10px; margin-right: 15px;"></button>	
						<button type="button" style="background: #636f61; border:none; border-radius: 50%;  width: 10px; height: 10px; padding: 10px;"></button>
					</div>
					<br/>
					<div class="row mt-3 justify-content-md-center">															
						<button type="button" class="btn btn-success btn-lg float-center" id="btnSalvarDados" style="font-size: 15px; padding-top:10px; padding-bottom:10px; padding-left:50px; padding-right:50px;" onclick="salvarRegistro();">
							<strong>Salvar Cadastro</strong> 
						</button>
					</div>														
					</font>				
				</div>
			</div>													
			
			<!-- DIV CADASTRO CONTA - CONTA CRIADA COM SUCESSO -->
			<div class="div_cadastro_sucesso">
				<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">	
					<font style="font-size: 0px">	
					<br>								
						<h2>Sua conta foi criada com sucesso!</h2>					
					<br>					
					<br/>			
					<div class="row mt-3 justify-content-md-center">															
						<button type="button" class="btn btn-success btn-lg float-center" id="btnLogin" style="font-size: 15px; padding-top:10px; padding-bottom:10px; padding-left:50px; padding-right:50px;"  onclick="voltarLoginSucesso();">
							<strong>Entrar</strong>
						</button>	
					</div>													
					</font>				
				</div>
			</div>					
		</form>
	</body>
</html>