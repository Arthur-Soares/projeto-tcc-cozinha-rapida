<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR, pt">
	<head>
		<title>Cozinha Rápida - Acesso restrito</title>
	    <link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="fontawesome/css/all.min.css" rel="stylesheet">
		<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		<script type="text/javascript" src="fontawesome/js/all.min.js"></script>
		<script type="text/javascript" src="./js/bootstrap-autocomplete.js"></script>
		<script type="text/javascript" src="./js/popper.js"></script>
		<script src="./js/bootstrap-datepicker.min.js"></script>
		<script src="./js/bootstrap-datepicker.pt-BR.min.js"></script>		
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
			session.setAttribute("opc_acesso", null);
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
			font-weight: 800;
			font-family: 'Open Sans', sans-serif;
			font-size: 80px;
		}	
		
		h2 {
			color: #FFFFFF;
			font-weight: 800;
			font-family: 'Open Sans', sans-serif;
			font-size: 60px;
		}
		
		h3 {	
			font-weight: bold;
			font-family: 'Open Sans', sans-serif;
			color: #FFFFFF;
		}	
	
		font {
			color: #323232;
			font-family: 'Open Sans', sans-serif;				
		}
		
		.container{
			width: 100vw;
			height: 100vh;			
			display: flex;
			flex-direction: row;
			justify-content: center;
			align-items: center;
			text-align: center;
		}
		
		#btnLogin{	
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
		
		#btnCadastro{	
			border: none;						
			color: #FFFFFF;
			background: #636f61;
			border-radius: 40px;
			transition: 0.2s;
			cursor: pointer;			
			transition: 0.2s;
			font-size: 15px;
		}
					
		#btnSalvarDados{	
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
			background: url('imagens/fast_kitchen_login.png') no-repeat center center fixed; 
			-webkit-background-size: cover;
			-moz-background-size: cover;
			-o-background-size: cover;
			background-size: cover;
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
		
		.div_cadastro_dados{
			margin: 0px;
		    height: 100vh;
		    display: flex;
			flex-direction: row;
			justify-content: center;
			align-items: center;
			text-align: center;
			float: center;
		}
		
		.div_cadastro_dados_dois{
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
		
		</style>
	</head>	 
		
	<script type="text/javascript">
		jQuery.extend({
	 	   postJSON: function( url, data, callback) {
	 	      return jQuery.post(url, data, callback, "json");
	 	   }
	 	});
				
		$(document).ready(function() {	
			var div_login_cadastro = $('.div_login_cadastro');
		    var div_cadastro_dados = $('.div_cadastro_dados');
		    var div_cadastro_dados_dois = $('.div_cadastro_dados_dois');		    
		    
		    div_login_cadastro.show();
		    div_cadastro_dados.hide();				  			
		    div_cadastro_dados_dois.hide();				  			
		});
										
		function cadastrarUm(){   									    
		    $(".div_login_cadastro").slideUp(200);
		    $(".div_cadastro_dados").slideDown(200);		   
		}
		
		function voltarUm(){   									    
		    $(".div_cadastro_dados_dois").toggle('slide');
		    $(".div_cadastro_dados").toggle('slide');		   
		}
		
		function cadastrarDois(){   									    
		    $(".div_cadastro_dados").toggle('slide');
		    $(".div_cadastro_dados_dois").toggle('slide');		   
		}
		
	</script>
		
	<body>	
		<form id="login_cadastro" name="login_cadastro" method="post" action="restrito/lista_usuarios.jsp">	
			
			<div class="div_login_cadastro">
				<!-- DIV LOGIN -->
				<div class="col-xl-6 col-lg-6 col-md-6 col-sm-12 col-12 login">
					<font style="font-size: 15px">						
					<h1>Bem-vindo<br/> de volta!</h1>
					<br>			
					<h3>Acesse sua conta ou crie uma nova!</h3>
					<br>
					
					<div class="row mt-3">
						<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
							<label for="cod_usuario" style="font-size: 24px;  float: left; font-weight: bold;"><strong>Email</strong></label> 
							<input type="text" class="form-control form-control-lg rounded-50" name="cod_usuario" id="cod_usuario" style="height: 60px; color:black; font-weight: bold; background: #CCCCCC;  border-radius: 10px;"/> 
						</div>					
					</div>
						
					<div class="row mt-3">					
						<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
							<label for="pwd_usuario" style="font-size: 24px;  float: left; font-weight: bold;"><strong>Senha</strong></label> 
						<input type="password" class="form-control form-control-lg rounded-50" name="pwd_usuario" id="pwd_usuario" style="height: 60px; color:black; font-weight: bold; background: #CCCCCC; border-radius: 10px;"/>
						</div>	
					</div>	
					<br/>
					<div class="row mt-3 justify-content-md-center">															
						<button type="submit" class="btn btn-success btn-lg float-center" id="btnLogin" style="font-size: 24px; padding-top:10px; padding-bottom:10px; padding-left:50px; padding-right:50px;">
							<strong>Entrar</strong>
						</button>	
					</div>														
					</font>				
				</div>
				
				<!-- DIV CRIAR CONTA -->
				<div class="col-xl-6 col-lg-6 col-md-6 col-sm-12 col-12 cadastro">
					<font style="font-size: 15px">										
					<br>			
					<h2>Crie sua conta</h2>
					<br>
					
					<div class="row mt-3">
						<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
							<label for="cod_usuario" style="color: #EEEEEE; font-size: 24px;  float: left; font-weight: bold;"><strong>Email</strong></label> 
							<input type="text" class="form-control form-control-lg rounded-50" name="cod_usuario" id="cod_usuario" style="height: 60px; color:black;font-weight: bold;  background: #CCCCCC; opacity: 0.8; border-radius: 10px;"/> 
						</div>					
					</div>
						
					<div class="row mt-3">					
						<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
							<label for="pwd_usuario" style="color: #EEEEEE; font-size: 24px;  float: left; font-weight: bold;"><strong>Senha</strong></label> 
							<input type="password" class="form-control form-control-lg rounded-50" name="pwd_usuario" id="pwd_usuario" style="height: 60px; color:black; background: #CCCCCC; font-weight: bold; opacity: 0.8; border-radius: 10px;"/>
						</div>	
					</div>
					
					<div class="row mt-3">					
						<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
							<label for="pwd_usuario" style="color: #EEEEEE; font-size: 24px;  float: left; font-weight: bold;"><strong>Confirme a Senha</strong></label> 
							<input type="password" class="form-control form-control-lg rounded-50" name="pwd_usuario" id="pwd_usuario" style="height: 60px; color:black; background: #CCCCCC; font-weight: bold; opacity: 0.8; border-radius: 10px;"/>
						</div>	
					</div>	
					<br/>
					<div class="row mt-3 justify-content-md-center">															
						<button type="button" class="btn btn-success btn-lg float-center" id="btnCadastro" style="font-size: 24px; padding-top:10px; padding-bottom:10px; padding-left:50px; padding-right:50px;" onclick="cadastrarUm();">
							<strong>Cadastrar</strong> 
						</button>	
					</div>														
					</font>				
				</div>
			</div>	
			
			<div class="div_cadastro_dados">
				<!-- DIV CADASTRO CONTA -->
				<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
					<font style="font-size: 15px">										
					<br>								
						<h2>Precisamos de mais alguns dados, ok?</h2>					
					<br>
					
					<div class="row mt-3 justify-content-md-center">
						<div class="col-xl-4 col-lg-4 col-md-4 col-sm-12 col-12">
							<label for="cod_usuario" style="color: #EEEEEE; font-size: 24px;  float: left; font-weight: bold;"><strong>Nome</strong></label> 
							<input type="text" class="form-control form-control-lg rounded-50" name="cod_usuario" id="cod_usuario" style="height: 60px; color:black;font-weight: bold;  background: #CCCCCC; opacity: 0.8; border-radius: 10px;"/> 
						</div>					
					</div>
						
					<div class="row mt-3 justify-content-md-center">					
						<div class="col-xl-4 col-lg-4 col-md-4 col-sm-12 col-12">
							<label for="pwd_usuario" style="color: #EEEEEE; font-size: 24px;  float: left; font-weight: bold;"><strong>CPF</strong></label> 
							<input type="password" class="form-control form-control-lg rounded-50" name="pwd_usuario" id="pwd_usuario" style="height: 60px; color:black; background: #CCCCCC; font-weight: bold; opacity: 0.8; border-radius: 10px;"/>
						</div>	
					</div>
					
					<div class="row mt-3 justify-content-md-center">					
						<div class="col-xl-4 col-lg-4 col-md-4 col-sm-12 col-12">
							<label for="pwd_usuario" style="color: #EEEEEE; font-size: 24px;  float: left; font-weight: bold;"><strong>Telefone</strong></label> 
							<input type="password" class="form-control form-control-lg rounded-50" name="pwd_usuario" id="pwd_usuario" style="height: 60px; color:black; background: #CCCCCC; font-weight: bold; opacity: 0.8; border-radius: 10px;"/>
						</div>	
					</div>						
					<br/>
					<div class="row mt-3 justify-content-md-center">															
						<button type="button" style="background: #636f61; border:none; border-radius: 50%;  width: 10px; height: 10px; margin-right: 15px; padding: 10px;" onclick="voltarUm();"></button>
						<button type="button" style="background: #FFFFFF; border:none; border-radius: 50%;  width: 10px; height: 10px; padding: 10px;" onclick="cadastrarDois();"></button>	
					</div>
					<br/>
					<div class="row mt-3 justify-content-md-center">															
						<button type="button" class="btn btn-success btn-lg float-center" id="btnSalvarDados" style="font-size: 24px; padding-top:10px; padding-bottom:10px; padding-left:50px; padding-right:50px;" onclick="cadastrarDois();">
							<strong>Continuar <i class="fa fa-chevron-right" aria-hidden="true"></i></strong> 
						</button>	
					</div>														
					</font>				
				</div>				
			</div>		
			
			
			<div class="div_cadastro_dados_dois">
				<!-- DIV CADASTRO CONTA PARTE DOIS -->
				<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
					<font style="font-size: 15px">	
					<br>								
						<h2>Precisamos de mais alguns dados, ok?</h2>					
					<br>
					
					<div class="row mt-3 justify-content-md-center">
						<div class="col-xl-4 col-lg-4 col-md-4 col-sm-12 col-12">
							<label for="cod_usuario" style="color: #EEEEEE; font-size: 24px;  float: left; font-weight: bold;"><strong>CEP</strong></label> 
							<input type="text" class="form-control form-control-lg rounded-50" name="cod_usuario" id="cod_usuario" style="height: 60px; color:black;font-weight: bold;  background: #CCCCCC; opacity: 0.8; border-radius: 10px;"/> 
						</div>					
					</div>
					
					<div class="row mt-3 justify-content-md-center">					
						<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-12">
							<label for="pwd_usuario" style="color: #EEEEEE; font-size: 24px;  float: left; font-weight: bold;"><strong>Endereço</strong></label> 
							<input type="password" class="form-control form-control-lg rounded-50" name="pwd_usuario" id="pwd_usuario" style="height: 60px; color:black; background: #CCCCCC; font-weight: bold; opacity: 0.8; border-radius: 10px;"/>
						</div>
						<div class="col-xl-1 col-lg-1 col-md-1 col-sm-12 col-12">
							<label for="pwd_usuario" style="color: #EEEEEE; font-size: 24px;  float: left; font-weight: bold;"><strong>Nº</strong></label> 
							<input type="password" class="form-control form-control-lg rounded-50" name="pwd_usuario" id="pwd_usuario" style="height: 60px; color:black; background: #CCCCCC; font-weight: bold; opacity: 0.8; border-radius: 10px;"/>
						</div>		
					</div>		
																		
					<div class="row mt-3 justify-content-md-center">					
						<div class="col-xl-4 col-lg-4 col-md-4 col-sm-12 col-12">
							<label for="pwd_usuario" style="color: #EEEEEE; font-size: 24px;  float: left; font-weight: bold;"><strong>Complemento</strong></label> 
							<input type="password" class="form-control form-control-lg rounded-50" name="pwd_usuario" id="pwd_usuario" style="height: 60px; color:black; background: #CCCCCC; font-weight: bold; opacity: 0.8; border-radius: 10px;"/>
						</div>	
					</div>	
					
					<div class="row mt-3 justify-content-md-center">					
						<div class="col-xl-4 col-lg-4 col-md-4 col-sm-12 col-12">
							<label for="pwd_usuario" style="color: #EEEEEE; font-size: 24px;  float: left; font-weight: bold;"><strong>Ponto de Refêrencia</strong></label> 
							<input type="password" class="form-control form-control-lg rounded-50" name="pwd_usuario" id="pwd_usuario" style="height: 60px; color:black; background: #CCCCCC; font-weight: bold; opacity: 0.8; border-radius: 10px;"/>
						</div>	
					</div>	
					<br/>
					<div class="row mt-3 justify-content-md-center">															
						<button type="button" style="background: #FFFFFF; border:none; border-radius: 50%;  width: 10px; height: 10px; margin-right: 15px; padding: 10px;" onclick="voltarUm();"></button>
						<button type="button" style="background: #636f61; border:none; border-radius: 50%;  width: 10px; height: 10px; padding: 10px;"  onclick="cadastrarDois();"></button>	
					</div>
					<br/>
					<div class="row mt-3 justify-content-md-center">															
						<button type="button" class="btn btn-success btn-lg float-center" id="btnSalvarDados" style="font-size: 24px; padding-top:10px; padding-bottom:10px; padding-left:50px; padding-right:50px;" onclick="cadastrarDados();">
							<strong>Salvar Cadastro</strong> 
						</button>	
					</div>														
					</font>				
				</div>
			</div>				
		</form>
	</body>
</html>