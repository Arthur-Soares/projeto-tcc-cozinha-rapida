package projeto.util;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import projeto.model.R1usuario;

public class MenuVerticalUtils {

	/*
	<!-- Inicio Menu Projeto -->
	<script type="text/javascript">
		function chamaMenu(actionSel){
			$("#frmchama").attr('action', actionSel);
			$("#frmchama").submit();
		}
	</script>
	<form id="frmchama" method="post" action="">
	</form>

	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
		<div class="container">
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarResponsive" aria-controls="navbarResponsive"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<img class="d-flex justify-content-center" src="../imagens/ondamusical-logo-white.png" style="max-height:50px;" />
				<ul class="navbar-nav">
					<li class="nav-item active"><a class="nav-link"
						onclick="javascript:chamaMenu('ondamusical.jsp');"><i class="fas fa-home"></i> Home</a></li>
					<li class="nav-item"><a class="nav-link" onclick="javascript:chamaMenu('lista_usuarios.jsp');">
						<i class="fas fa-user"></i>Usuários</a></li>
				</ul>
				<ul class="navbar-nav" style="float: right; margin-left: auto;">
					<li class="nav-item"><a class="nav-link"
						onclick="return confirm('Deseja sair do ambiente?')"
						href="../index_ondamusical.jsp?logoff=S"><i class="fas fa-sign-out-alt"></i>
							Sair</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- Final Menu Projeto -->
	*/
	public static String buildMenu(String pagAtual, String opcAcesso, R1usuario r1u) {
		String nomeimg = "O".equals(opcAcesso)?"ondamusical":"alphabeat";
		StringBuffer sb = new StringBuffer();
		sb.append("<!-- Inicio Menu Projeto -->");
		sb.append("<script type=\"text/javascript\">");
		sb.append("function chamaMenu(actionSel){");
		sb.append("$(\"#frmchama\").attr('action', actionSel);");
		sb.append("$(\"#frmchama\").submit();");
		sb.append("}");
		sb.append("$(document).ready(function() { ");
		sb.append("		$('#sidebarCollapse').on('click', function () { ");
		sb.append("		$('#sidebar').toggleClass(); ");
		sb.append(" 	});");
		sb.append("});" );
		sb.append("</script>");
		sb.append(" <style> ");
		sb.append(" .wrapper {");
		sb.append("    	display: flex;");
		sb.append("   	width: 100%;");
		sb.append(" 	align-items: stretch;  ");
		sb.append("} ");
		sb.append("#sidebar { ");
		sb.append("		min-width: 250px; ");
		sb.append("		max-width: 250px; ");
		sb.append("		min-height: 100vh; ");
		sb.append("		background: #333333; ");
		sb.append("		color: #fff; ");
		sb.append("		transition: all .5s;" );
		sb.append("} ");										
		sb.append("#content{ ");
		sb.append("		width:100%; ");
		sb.append("} ");
		sb.append("#sidebar.active { ");
		sb.append("  	margin-left: -250px; ");
		sb.append("		transition: all .5s;" );
		sb.append("} ");
		sb.append("body { ");
		sb.append("    font-family: 'Poppins', sans-serif; ");
		sb.append("    background: #fafafa; ");
		sb.append("} ");
		sb.append("p { ");
		sb.append("    font-family: 'Poppins', sans-serif; ");
		sb.append("    font-size: 1.1em; ");
		sb.append("    font-weight: 300; ");
		sb.append("    line-height: 1.7em; ");
		sb.append("    color: #999; ");
		sb.append("} ");
		sb.append("a,  ");
		sb.append("a:hover, ");
		sb.append("a:focus { ");
		sb.append(" 	color: inherit; ");
		sb.append("		text-decoration: none; ");
		sb.append(" 	transition: all 0.3s; ");
		sb.append("} ");	
		sb.append("#sidebar .sidebar-header { ");
		sb.append("		padding: 20px; ");
		sb.append("  	background: #333333; ");
		sb.append("} ");
		sb.append("#sidebar ul.components { ");
		sb.append( "   	padding: 20px 0; ");
		sb.append("   	border-bottom: 1px solid #47748b; ");
		sb.append("} ");
		sb.append("#sidebar ul p { ");
		sb.append("   	color: #fff; ");
		sb.append("   	padding: 10px; ");
		sb.append("} ");
		sb.append("#sidebar ul li a { ");
		sb.append("    padding: 10px; ");
		sb.append("    font-size: 1.1em; ");
		sb.append("    display: block; ");
		sb.append("    background: #333333; ");
		sb.append("} ");					
		sb.append("#sidebar ul li a:hover { ");
		sb.append("    color: #da5d59; ");
		sb.append("    background:  #333333; ");
		sb.append("} ");
		sb.append("#sidebar ul li.active > a, a[aria-expanded=\"true\"] { ");
		sb.append("    color: #7386D5; ");
		sb.append("    background:  #333333; ");
		sb.append("} ");
		sb.append("ul ul a { ");
		sb.append("   font-size: 0.9em !important; ");
		sb.append("   padding-left: 30px !important; ");
		sb.append("   background:#333333; }");
		
		sb.append(" a[data-toggle=\"collapse\"] {");
		sb.append("    position: relative;");
		sb.append(" }");
		sb.append(" .dropdown-toggle::after {");
		sb.append("    display: block;");
		sb.append("    position: absolute;");
		sb.append("    top: 50%;");
		sb.append("    right: 20px;");
		sb.append("    transform: translateY(-50%);");
		sb.append(" }");
		sb.append(" #sidebar ul li.active > a, a[aria-expanded=\"true\"] {");
		sb.append("    color: #fff;");
		sb.append("    background: #bf2f0c;");
		sb.append(" }");
		sb.append(" </style> ");
		
		sb.append("<form id=\"frmchama\" method=\"post\" action=\"\">");
		sb.append("</form>");
		
		sb.append("<div id='sidebar' class='active'>");
		sb.append("<div class='sidebar-header'>");
		sb.append("<img class=\"d-flex justify-content-center\" src=\"../imagens/live_talentos_logo_reto.png\" style=\"max-height:70px; display: block; margin: 0px auto; \" />");
		sb.append("</div>");
		sb.append("<ul class='list-unstyled components'>");
		sb.append("<li class=\"nav-item "+(pagAtual.equals(nomeimg)?"active":"")+"\"><a class=\"nav-link\"");
		sb.append("onclick=\"javascript:chamaMenu('"+nomeimg+".jsp');\"><i class=\"fas fa-home\"></i> Home</a></li>");
		//Usuário administrador
		if("1".equals(r1u.getOpc_tipo_acesso())) {
			sb.append("<li class=\"nav-item "+(pagAtual.equals("lista_usuarios")?"active":"")+" \"><a class=\"nav-link\" onclick=\"javascript:chamaMenu('lista_usuarios.jsp');\">");
			sb.append("<i class=\"fas fa-user\"></i> Usuários</a></li>");	
		}
		
		if("P".equals(r1u.getNivel_usuario())) {
			sb.append("<li class=\"nav-item "+(pagAtual.equals("orcamento")?"active":"")+" \"><a onclick=\"javascript:chamaMenu('lista_aprova_orc.jsp');\">");
			sb.append("<i class=\"fab fa-wpforms\"></i> Cadastro Orçamento</a></li>");
		}else if("S".equals(r1u.getNivel_usuario())) {
			sb.append("<li class=\"nav-item "+(pagAtual.equals("orcamento")?"active":"")+" \"><a onclick=\"javascript:chamaMenu('lista_aprova_orc.jsp');\">");
			sb.append("<i class=\"fab fa-wpforms\"></i> Cadastro/Aprovação Orçamento</a></li>");
		}else if("D".equals(r1u.getNivel_usuario())) {
			sb.append("<li class=\"nav-item "+(pagAtual.equals("orcamento")?"active":"")+" \"><a onclick=\"javascript:chamaMenu('lista_aprova_orc.jsp');\">");
			sb.append("<i class=\"fab fa-wpforms\"></i> Aprovação Orçamento</a></li>");
		}else if("F".equals(r1u.getNivel_usuario())) {
			sb.append("<li class=\"nav-item "+(pagAtual.equals("orcamento")?"active":"")+" \"><a onclick=\"javascript:chamaMenu('lista_aprova_orc.jsp');\">");
			sb.append("<i class=\"fab fa-wpforms\"></i> Aprovação/Envio Orçamento</a></li>");
		}else{
			sb.append("<li class=\"nav-item "+(pagAtual.equals("orcamento")?"active":"")+" \"><a onclick=\"javascript:chamaMenu('lista_aprova_orc.jsp');\">");
			sb.append("<i class=\"fab fa-wpforms\"></i> Aprovação Orçamento</a></li>");
		}
		
		sb.append("<li class=\"nav-item\"><a class=\"nav-link\"");
		sb.append("onclick=\"return confirm('Deseja sair do ambiente?')\"");
		sb.append("href=\"../index_livetalentos.jsp?logoff=S\"><i class=\"fas fa-sign-out-alt\"></i>");
		sb.append("Sair</a></li>");
		sb.append("</ul>");
		sb.append("</div>");
		sb.append("<br><br><br><br>");
		sb.append("<!-- Final Menu Projeto -->");
		return sb.toString();
	}
	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		//"+(pagAtual.equals("pagamento")?"active":"")+"
		//"+(pagAtual.equals("payout")?"active":"")+"
	}

}
