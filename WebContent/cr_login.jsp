<%@page import="org.apache.poi.util.SystemOutLogger"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR, pt">
	<head>
		<link rel="icon" href="imagens/cr_logo_guia_ret_arredondado.png" type="image/png">	
		<title>Login - Cozinha Rápida</title>
		<link href="css/cr_login.css" rel="stylesheet">
	    <link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="fontawesome/css/all.min.css" rel="stylesheet">
		<meta http-equiv="Content-Type" content="text/html; charset:iso-88590-1">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		<script type="text/javascript" src="fontawesome/js/all.min.js"></script>
		<script type="text/javascript" src="js/bootstrap-autocomplete.js"></script>
		<script type="text/javascript" src="js/popper.js"></script>
		<script type="text/javascript" src="js/jquery.mask.min.js"></script>
		<script src="js/bootstrap-datepicker.min.js"></script>
		<script src="js/bootstrap-datepicker.pt-BR.min.js"></script>		 		
		<link href="js/bootstrap-dialog.min.css" rel="stylesheet">
		<link href="fontawesome/css/fontawesome.min.css" rel="stylesheet">
		<script src="js/jquery.js"></script>
		<script type="text/javascript" src="js/jquery.mask.min.js"></script>
	    <script src="js/bootstrap.min.js"></script>
	    <script src="js/bootstrap-dialog.min.js"></script>	    	    
		<!--	
		Font Awesome Free 5.3.1 by @fontawesome - (https://fontawesome.com)
		Bootstrap v4.1.3 (https://getbootstrap.com/)
		jQuery JavaScript Library v3.3.1 (https://jquery.com/)
 		Includes Sizzle.js (https://sizzlejs.com/)
		-->
		<%
		String redir = null!=request.getParameter("redir")?request.getParameter("redir"):"";
		String opclogoff = null!=request.getParameter("logoff")?request.getParameter("logoff"):"";
		String msgIndex = null != session.getAttribute("errologin") ? (String) session.getAttribute("errologin") : "";
		//System.out.println("Mensagem Index :: "+msgIndex);
		if("S".equals(opclogoff) || !"".equals(msgIndex)){
			session.setAttribute("errologin", null);
			session.setAttribute("projeto.model.Cr_usuario", null);			
		}
		%>
		<style>		
		h1 {	
			color: #945d60;
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
			background: linear-gradient(135deg, rgba(99, 111, 97 , 0));
		    -webkit-backdrop-filter: blur(20px);
		    backdrop-filter: blur(20px);
		    padding: 30px;    		    
		    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.37);
		    border: 1px solid rgba(255, 255, 255, 0.18);
			margin: 0px;
		    height: 100vh;
		    display: flex;
			flex-direction: row;
			justify-content: center;
			align-items: center;
			text-align: center;
			float: center;
		}
		
		  .div_cadastro_sucesso h2 {
		    text-align: center;	
		    color: #FFFFFF;	    
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
		    
		    retornaMsgErro('<%=msgIndex%>');
		});
		
		function retornaMsgErro(msg_erro){
			if(msg_erro != ""){
				$("#mensagemErro").text(msg_erro);
			    $("#modalErro").modal('show');
			    $("#cr_email_usuario_login").focus();
			    return false;
			}
		}
		
		function voltarHome(){
			window.location.href = "cr_home.jsp";
		}
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
		//Função para validar login
		function validaLogin(){	
			var cr_email_usuario_login = $("#cr_email_usuario_login").val();
			var cr_senha_usuario_login = $("#cr_senha_usuario_login").val();
			var emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/; //expressão regular para email
			var senhaRegex = /^\w{6,}$/;                 //expressão regular para senha
			
			if(cr_email_usuario_login == ""){
				$("#mensagemErro").text('Digite o Email!');
			    $("#modalErro").modal('show');
			    $("#cr_email_usuario_login").focus();
			    return false;
			}else if(cr_senha_usuario_login == ""){
				$("#mensagemErro").text('Digite a Senha!');
			    $("#modalErro").modal('show');
			    $("#cr_senha_usuario_login").focus();
			    return false;
			}else if(!emailRegex.test(cr_email_usuario_login)){
			    $("#mensagemErro").text('Email inválido!');
			    $("#modalErro").modal('show');
			    $("#cr_email_usuario_login").focus();
			    return false;
			}else if(!senhaRegex.test(cr_senha_usuario_login)){
			    $("#mensagemErro").text('Senha inválida! A senha deve ter no mínimo 6 caracteres Alfanumericos!');
			    $("#modalErro").modal('show');
			    $("#cr_senha_usuario_login").focus();
			    return false;
			  }
			else{
				$("#login_cadastro").submit();
			}			
						
		}	 		
		//Chama a tela de cadastro
		function chamaCadastroDois() {   		
		    var cr_nome_completo_usuario = $("#cr_nome_completo_usuario").val();
		    var cr_cpf_usuario = $("#cr_cpf_usuario").val();
		    var cr_telefone_usuario = $("#cr_telefone_usuario").val();
		    var nomeRegex = /^[A-Za-z]+([\ A-Za-z]+)*$/; //expressão regular para nome
		    
		    if (cr_nome_completo_usuario == "" || cr_cpf_usuario == "" || cr_telefone_usuario == "") {
		    	$("#mensagemErro").text('Preencha todos os campos!');
		        $("#modalErro").modal('show');
		        $("#cr_nome_completo_usuario").focus();
		        return false;
		    }
		    else if(!nomeRegex.test(cr_nome_completo_usuario)){
		    	$("#mensagemErro").text('Digite o nome corretamente!');
		        $("#modalErro").modal('show');
		        $("#cr_nome_completo_usuario").focus();
		        return false;
		    }
		    else if (validarCPF(cr_cpf_usuario) == false) {
		    	$("#mensagemErro").text('Insira um CPF valido!');
		        $("#modalErro").modal('show');
		        $("#cr_cpf_usuario").focus();
		        return false;
		    }
		    else if (!/\(\d{2}\)\s\d{4,5}-\d{4}/.test(cr_telefone_usuario)) {
		    	$("#mensagemErro").text('Insira um telefone valido!');
		        $("#modalErro").modal('show');
		        $("#cr_telefone_usuario").focus();
		        return false;
		    }
		    else {
		        $(".div_cadastro").toggle('slide');
		        $(".div_cadastro_dois").toggle('slide');
		    }						   
		}
		
		//Chama a segunda tela de cadastro
		function chamaCadastroTres(){   									    
			var cr_cep_usuario = $("#cr_cep_usuario").val();
			var cr_nrmcasa_usuario = $("#cr_nrmcasa_usuario").val();
			var cr_endereco_usuario = $("#cr_endereco_usuario").val();
			var cr_complemento = $("#cr_endcomplemento_usuario").val();	
			var cr_referencia = $("#cr_pontoreferencia_usuario").val();	
			var nrmcasaRegex = /^[0-9]+$/; //expressão regular para numero da casa
			var complementeereferenciaRegex = /^[a-zA-Z0-9]*$/; //expressão regular para complemento e referencia
			var campoNumero = document.getElementById("cr_nrmcasa_usuario"); //elemento do campo numero para limpar após verificar
			var campoComplemento = document.getElementById("cr_endcomplemento_usuario");//elemento do campo complemento para limpar após verificar
			var campoReferencia = document.getElementById("cr_pontoreferencia_usuario");//elemento do campo referencia para limpar após verificar
			
			if(cr_cep_usuario == "" || cr_nrmcasa_usuario == "" || cr_endereco_usuario == ""){
				$("#mensagemErro").text('Preencha todos os campos!');
		        $("#modalErro").modal('show');
		        $("#cr_cep_usuario").focus();
			}
			else if(!nrmcasaRegex.test(cr_nrmcasa_usuario)){
				campoNumero.value = "";
				$("#mensagemErro").text('Preencha o campo Nº somente com numeros!');
		        $("#modalErro").modal('show');
		        $("#cr_cep_usuario").focus();
		        
			}else{
			    $(".div_cadastro_dois").toggle('slide');
			    $(".div_cadastro_tres").toggle('slide');		  
			}
		}
		
		//Chama a terceira e ultima tela de cadastro
		function salvarRegistro(){
			var cr_email_usuario = $("#cr_email_usuario").val();
			var cr_senha_usuario = $("#cr_senha_usuario").val();
			var cr_senha_usuario_confirm = $("#cr_senha_usuario_confirm").val();	
			var emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/; //expressão regular para email
			var senhaRegex = /^\w{6,}$/; //expressão regular para senha
			  
			
			if(cr_email_usuario == "" || cr_senha_usuario == ""){
				$("#mensagemErro").text('Preencha todos os campos!');
		        $("#modalErro").modal('show');
				$("#cr_email_usuario").focus();
				return false;
			}
			if(!emailRegex.test(cr_email_usuario)){
				$("#mensagemErro").text('Insira um email Valido!');
		        $("#modalErro").modal('show');
				$("#cr_email_usuario").focus();
				return false;
			}
			if(!senhaRegex.test(cr_senha_usuario) && !senhaRegex.test(cr_senha_usuario_confirm)){
				$("#mensagemErro").text('Senha de no minimo 6 caracteres!');
		        $("#modalErro").modal('show');
				$("#cr_email_usuario").focus();
				return false;
			}
			if(cr_senha_usuario != cr_senha_usuario_confirm){
				$("#mensagemErro").text('Preencha as senhas igualmente!');
		        $("#modalErro").modal('show');
				$("#cr_senha_usuario").focus();
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
						$("#mensagemErro").text('Erro inesperado ao salvar registro!');
				        $("#modalErro").modal('show');
						$("#cr_senha_usuario").focus();
						return false;
					}
				}
			);			
		}
		
		//Função para validação de CPF
		function validarCPF(cpf) {
			  cpf = cpf.replace(/[^\d]+/g,'');
			  // Elimina CPFs invalidos conhecidos
			  if (cpf.length != 11 ||
			    cpf == "00000000000" ||
			    cpf == "11111111111" ||
			    cpf == "22222222222" ||
			    cpf == "33333333333" ||
			    cpf == "44444444444" ||
			    cpf == "55555555555" ||
			    cpf == "66666666666" ||
			    cpf == "77777777777" ||
			    cpf == "88888888888" ||
			    cpf == "99999999999")
			        return false;
			  // Valida 1o digito
			  add = 0;
			  for (i=0; i < 9; i ++)
			    add += parseInt(cpf.charAt(i)) * (10 - i);
			  rev = 11 - (add % 11);
			  if (rev == 10 || rev == 11)
			      rev = 0;
			  if (rev != parseInt(cpf.charAt(9)))
			      return false;
			  // Valida 2o digito
			  add = 0;
			  for (i = 0; i < 10; i ++)
			    add += parseInt(cpf.charAt(i)) * (11 - i);
			  rev = 11 - (add % 11);
			  if (rev == 10 || rev == 11)
			      rev = 0;
			  if (rev != parseInt(cpf.charAt(10)))
			      return false;
			  return true;
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
					$("#mensagemErro").text('Formato de CEP inválido!');
			        $("#modalErro").modal('show');
			        $("#cr_cpf_usuario").focus();
				}
			} else {
				//cep sem valor, limpa formulário.
				limpaCamposCEP();
				$("#mensagemErro").text('Insira um CEP válido!');
		        $("#modalErro").modal('show');
		        $("#cr_cpf_usuario").focus();
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
				$("#mensagemErro").text('CEP não encontrado!');
		        $("#modalErro").modal('show');
		        $("#cr_cep_usuario").focus();
			}
		}	      
		
		//Função que Limpa os campos do CEP
		function limpaCamposCEP() {			
			$("#cr_cep_usuario").val("");
			$("#cr_endereco_usuario").val("");
			$("#cr_nrmcasa_usuario").val("");
		}
		
		//Função que Limpa todos os campos ao Salvar Registro
		function limpaCamposCadastro() {			
			$("#cr_id_usuario").val("");
			$("#cr_email_usuario").val("");
			$("#cr_senha_usuario").val("");
			$("#cr_senha_usuario_confirm").val("");
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
		
		function esqueciSenha(){
			var email_esqueci_senha = $("#email_esqueci_senha").val();
			 
			if(email_esqueci_senha == ""){
			 	// Remove a classe input-error se já estiver presente
			  	$("#email_esqueci_senha").removeClass('input-error');

			  	// Adiciona a classe input-error para acionar a animação e destaque vermelho
			  	$("#email_esqueci_senha").addClass('input-error');

			  	// Foca no input de email
			  	$("#email_esqueci_senha").focus();
				
			    // Remove o elemento de mensagem de erro existente
			    $(".error-message").remove();
			    
			 	// Cria um elemento para exibir a mensagem de erro
			 	var errorElement = $('<div class="error-message">Email em branco, digite algo antes de enviar!</div>');
			  	$("#email_esqueci_senha_error").parent().append(errorElement);
				return false;
			}
			
			$.postJSON("./jsonservlet",{opc_servlet:'envia_email',email_esqueci_senha:email_esqueci_senha},
				function(emailretorno){				
					var retorno = emailretorno.retorno;
					if(retorno == 0){											        										      					 					
					    // Remove o elemento de mensagem de sucesso existente
					    $(".success-message").remove();
					    
					 	// Cria um elemento para exibir a mensagem de sucesso
					 	$("#email_esqueci_senha").val("");
					 	var successElement = $('<div class="success-message">Pronto! Siga os passos que foram enviados para o seu email para prosseguir com a redefinição da sua senha.</div>');
					  	$("#email_esqueci_senha_error").parent().append(successElement);									        
					}else{	
						// Remove a classe input-error se já estiver presente
					  	$("#email_esqueci_senha").removeClass('input-error');

					  	// Adiciona a classe input-error para acionar a animação e destaque vermelho
					  	$("#email_esqueci_senha").addClass('input-error');

					  	// Foca no input de email
					  	$("#email_esqueci_senha").focus();
						
					    // Remove o elemento de mensagem de erro existente
					    $(".error-message").remove();
					    
					 	// Cria um elemento para exibir a mensagem de erro
					 	var errorElement = $('<div class="error-message">Erro! O email informado não está cadastrado!</div>');
					  	$("#email_esqueci_senha_error").parent().append(errorElement);														        									
					}											        		
				}
			);	
		}
		
		function limpaError(){
			// Remove a classe input-error se já estiver presente
		  	$("#email_esqueci_senha").removeClass('input-error');
		  	 // Remove o elemento de mensagem de erro existente
		    $(".error-message").remove();
		    $(".success-message").remove();
		}
			
	</script>
		
	<body>
		<!-- Modal de mensagem de tratamento de Alerta -->
		<div class="modal fade" id="modalErro" tabindex="-1" role="dialog" aria-labelledby="modalErroLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header text-white" style="background-color:#b1463c;">
		        <h5 class="modal-title" id="modalErroLabel">Alerta</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
		          <span aria-hidden="true" class="text-white">&times;</span>
		        </button>
		      </div>
		      <div class="mt-3 modal-body">    			      	   	  		        			    
	       		 <p id="mensagemErro"></p>			         
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-outline-dark" data-dismiss="modal">Fechar</button>
		      </div>
		    </div>
		   </div>
		 </div>
		 
		 <!-- Modal de mensagem de tratamento de Sucesso -->
		<div class="modal fade" id="modalSucesso" tabindex="-1" role="dialog" aria-labelledby="modalSucessoLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header text-white" style="background-color:#636f61;">
		        <h5 class="modal-title" id="modalSucessoLabel">Comunicado</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
		          <span aria-hidden="true" class="text-white">&times;</span>
		        </button>
		      </div>
		      <div class="mt-3 modal-body">    			      	   	  		        			    
	       		 <p id="mensagemSucesso"></p>			         
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-outline-dark" data-dismiss="modal">Fechar</button>
		      </div>
		    </div>
		   </div>
		 </div>
			 
			 
		<form id="login_cadastro" name="login_cadastro" method="post" action="loginservlet">	
			<input type="hidden" id="cr_id_usuario" name="cr_id_usuario" value="0"/>
			<input type="hidden" id="cr_nivel_usuario" name="cr_nivel_usuario" value="2"/>
			<input type="hidden" id="opc_servlet" name="opc_servlet" value="salva_usuario"/>			
						 
			<!-- DIV LOGIN -->
			<div class="div_login">
				<div class="login-box">			
					 <h2><strong>Bem vindo <br> de volta!</strong></h2>									
						<div class="user-box">
							<input type="text" name="cr_email_usuario_login" id="cr_email_usuario_login" placeholder="&nbsp;"/>							
							<label for="cr_email_usuario_login">Email</label> 
						</div>
						
						<div class="user-box">
							<input type="password" name="cr_senha_usuario_login" id="cr_senha_usuario_login" placeholder="&nbsp;"/>
							<label for="cr_senha_usuario_login">Senha</label> 
						</div>			
																
						<a class="esquecer_senha" data-toggle="modal" href="#modalsenha" onclick="limpaError();">Esqueceu sua senha?</a>
						
						<button type="button" class="btn_entrar" onclick="validaLogin();">
							Entrar&nbsp;<i class="fas fa-sign-in-alt"></i> 
						</button> 													
					
					<hr noshade="noshade" style="border: 0.5px solid; color: #636f61;">	
					
					<div class="row justify-content-center">
						Não tem uma conta?&nbsp;
						<a class="esquecer_senha" href="#" onclick="chamaCadastro();">Cadastre-se</a>
					</div>	
					
					<hr noshade="noshade" style="border: 0.5px solid; color: #636f61;">		
										
					<a class="esquecer_senha" href="#" onclick="voltarHome();"><i class="fas fa-home"></i>&nbsp; Voltar para Home</a>		
				</div>	
			</div>				
			
			 <!-- DIV CADASTRO CONTA - PRIMEIRA PARTE -->
			<div class="div_cadastro">
				<div class="login-box">			
					<h5><strong>Criando sua conta<br/>Preencha os dados abaixo:</strong></h5>	
					<br>								
					<div class="user-box">
						<input type="text" name="cr_nome_completo_usuario" id="cr_nome_completo_usuario" maxlength="255" placeholder="&nbsp;"/>												
						<label for="cr_nome_completo_usuario">Nome Completo</label> 
					</div>
					
					<div class="user-box">						
						<input type="text" name="cr_cpf_usuario" id="cr_cpf_usuario" maxlength="14" onkeydown="javascript:return aplica_mascara_cpfcnpj(this,18,event)" onkeyup="javascript:return aplica_mascara_cpfcnpj(this,18,event)" placeholder="&nbsp;"/>
						<label for="cr_cpf_usuario">CPF</label> 
					</div>
					
					<div class="user-box">												
						<input type="text" onkeypress="$(this).mask('(99) 99999-9999');" name="cr_telefone_usuario" maxlength="16" id="cr_telefone_usuario" placeholder="&nbsp;"/>																																													
						<label for="cr_telefone_usuario">Telefone</label> 
					</div>
									
					<hr noshade="noshade" style="border: 0.5px solid; color: #636f61;">
					
					<div class="row">						
						<div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-6">
							<button type="button" class="btn_entrar" onclick="voltarLogin();">								
								<i class="fa fa-chevron-left" aria-hidden="true"></i>&nbsp;Voltar
							</button> 							
						</div>							
						<div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-6">
							<button type="button" class="btn_entrar" onclick="chamaCadastroDois();">
								Continuar&nbsp;<i class="fa fa-chevron-right" aria-hidden="true"></i>
							</button> 
						</div>																												
					</div>					
				</div>
			</div>
		
			<!-- DIV CADASTRO CONTA - SEGUNDA PARTE -->
			<div class="div_cadastro_dois">
				<div class="login-box">			
					<h5><strong>Criando sua conta<br/>Preencha os dados abaixo:</strong></h5>	
					<br>								
					<div class="user-box">																	
						<input type="text" name="cr_cep_usuario" id="cr_cep_usuario" maxlength="20" onkeypress="$(this).mask('00000-000')" onchange="pesquisaCEP();" placeholder="&nbsp;"/>
						<label for="cr_cep_usuario">CEP</label> 
					</div>
					
					<div style="display:flex;">	
						<div class="user-box" style="width: 80%;">																																										
							<input type="text" name="cr_endereco_usuario" id="cr_endereco_usuario" placeholder="&nbsp;" maxlength="200" readonly/>
							<label for="cr_endereco_usuario">Endereço</label> 																									
						</div>
						&nbsp;
						<div class="user-box" style="width: 18%;">
							<input type="text" name="cr_nrmcasa_usuario" id="cr_nrmcasa_usuario" placeholder="&nbsp;" maxlength="5"/>
							<label for="cr_nrmcasa_usuario">Nº</label>
						</div>
					</div>
					 
					<div class="user-box">												
						<input type="text" name="cr_endcomplemento_usuario" id="cr_endcomplemento_usuario" placeholder="&nbsp;" maxlength="200">
						<label for="cr_endcomplemento_usuario">Complemento</label> 						
					</div>
					
					<div class="user-box">																		
						<input type="text" name="cr_pontoreferencia_usuario" placeholder="&nbsp;" id="cr_pontoreferencia_usuario" maxlength="200"/>
						<label for="cr_pontoreferencia_usuario">Ponto de Referência</label> 						
					</div>									
					
									
					<hr noshade="noshade" style="border: 0.5px solid; color: #636f61;">
					
					<div class="row">						
						<div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-6">
							<button type="button" class="btn_entrar" onclick="voltarCadastroUm();">								
								<i class="fa fa-chevron-left" aria-hidden="true"></i>&nbsp;Voltar
							</button> 							
						</div>							
						<div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-6">
							<button type="button" class="btn_entrar" onclick="chamaCadastroTres();">
								Continuar&nbsp;<i class="fa fa-chevron-right" aria-hidden="true"></i>
							</button> 
						</div>																												
					</div>					
				</div>
			</div>
		
			<!-- DIV CADASTRO CONTA - TERCEIRA PARTE -->
			<div class="div_cadastro_tres">	
				<div class="login-box">			
					<h5><strong>Criando sua conta<br/>Preencha os dados abaixo:</strong></h5>	
					<br>								
					<div class="user-box">																							
						<input type="email" name="cr_email_usuario" id="cr_email_usuario" placeholder="&nbsp;"/>
						<label for="cr_cep_usuario">Email</label> 						
					</div>					
					 
					<div class="user-box">												
						<input type="password" name="cr_senha_usuario" id="cr_senha_usuario" placeholder="&nbsp;"/>					
						<label for="cr_senha_usuario">Senha</label> 							 																																										  															
					</div>
					
					<div class="user-box">																								
						<input type="password" name="cr_senha_usuario_confirm" id="cr_senha_usuario_confirm" placeholder="&nbsp;"/>						
						<label for="cr_senha_usuario_confirm">Confirme a Senha</label> 						 																																											  														
					</div>									
														
					<hr noshade="noshade" style="border: 0.5px solid; color: #636f61;">
					
					<div class="row">						
						<div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-6">
							<button type="button" class="btn_entrar" onclick="voltarCadastroDois();">								
								<i class="fa fa-chevron-left" aria-hidden="true"></i>&nbsp;Voltar
							</button> 							
						</div>							
						<div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-6">
							<button type="button" class="btn_entrar" onclick="salvarRegistro();">
								Cadastrar&nbsp;<i class="fa fa-save" aria-hidden="true"></i>
							</button> 
						</div>																												
					</div>					
				</div>
			</div>												
			
			<!-- DIV CADASTRO CONTA - CONTA CRIADA COM SUCESSO -->
			<div class="div_cadastro_sucesso">
				<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">					
					<br>								
						<h2><strong>Sua conta foi criada com sucesso!</strong></h2>					
					<br>					
					<br/>			
					<div class="row mt-3 justify-content-center">															
						<button type="button" class="btn btn-success btn-lg float-center" id="btnLogin" style="font-size: 15px; padding-top:10px; padding-bottom:10px; padding-left:50px; padding-right:50px;"  onclick="voltarLoginSucesso();">
							<strong>Entrar</strong>
						</button>	
					</div>																				
				</div>
			</div>					
		</form>
		
		<!-- MODAL ESQUECI SENHA -->
		<div class="modal fade" id="modalsenha" tabindex="-1" role="dialog" aria-labelledby="modalsenhaLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">		      
		      <div class="modal-header text-white" style="background-color:#636f61;">
		        <h5 class="modal-title" id="modalErroLabel">Esqueci a Senha</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
		          <span aria-hidden="true" class="text-white">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
	        	<p>Informe seu email abaixo para receber os próximos passos:</p>
	        	<div class="input-group">
				  <input id="email_esqueci_senha" name="email_esqueci_senha" type="text" class="form-control" placeholder="Email">
				  <div class="input-group-append">
				    <button class="btn btn-success" type="button" onclick="javascript:esqueciSenha();">Enviar</button>
				  </div>
				</div>				
			    <input type="hidden" id="email_esqueci_senha_error"  name="email_esqueci_senha_error">				  				
				
				<div class="row mt-2 justify-content-center text-center" id="sucesso" style="display:none;">
		          <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
		            <h5>Pronto! Siga os passos que foram enviados para o seu email para prosseguir com a redefinição da sua senha.</h5>
		          </div>
		        </div>
		
		        <div class="row mt-2 justify-content-center text-center" id="erro" style="display:none; color:#ff0000">
		          <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
		            <h5>Erro! O email informado não está cadastrado.</h5>
		          </div>
		        </div>	
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-outline-dark" id="fecha_modal_esqueci_senha" data-dismiss="modal">Fechar</button>
		      </div>
		    </div>
		   </div>
		 </div>			 	
	</body>
</html>