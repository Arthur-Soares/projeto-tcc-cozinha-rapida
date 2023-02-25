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
			font-weight: bold;
			font-family: 'Open Sans', sans-serif;
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
		
		</style>
	</head>

	<body style="background-color: #636f61; margin: 0px;">	
		<form action="restrito/lista_usuarios.jsp">
		<div class="d-flex justify-content-center">
			<div class="container">
				<font style="font-size: 15px">						
				<h1>Bem Vindo de Volta!</h1>
				<br>									
					<label for="cod_usuario"><strong>Usuário </strong><i class="fas fa-user"></i></label> 
					<input type="text" class="form-control form-control-lg rounded-50" name="cod_usuario" id="cod_usuario" style="color: white; background: rgba(0,0,0,0.5);  border-radius: 10px;"/>									
					<br/>
					<label for="pwd_usuario"><strong>Senha </strong><i class="fas fa-key"></i></label> 
					<input type="password" class="form-control form-control-lg rounded-50" name="pwd_usuario" id="pwd_usuario" style="color: white; background: rgba(0,0,0,0.5); border-radius: 10px;"/>
					<br/>
					<button type="submit" class="btn btn-success btn-lg float-center" id="btnLogin">
						<strong>ENTRAR</strong> <i class="fas fa-sign-in-alt"></i> 
					</button>														
				</font>				
			</div>
		</div>
		</form>
	</body>
</html>