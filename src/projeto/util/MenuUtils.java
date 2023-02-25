package projeto.util;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import projeto.model.R1usuario;

public class MenuUtils {

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
		sb.append("</script>");
		sb.append("<form id=\"frmchama\" method=\"post\" action=\"\">");
		sb.append("</form>");
		sb.append("<nav class=\"navbar navbar-expand-lg navbar-dark bg-dark fixed-top\">");
		sb.append("<div class=\"container\">");
		sb.append("<button class=\"navbar-toggler\" type=\"button\" data-toggle=\"collapse\"");
		sb.append("data-target=\"#navbarResponsive\" aria-controls=\"navbarResponsive\"");	
		sb.append("aria-expanded=\"false\" aria-label=\"Toggle navigation\">");				
		sb.append("<span class=\"navbar-toggler-icon\"></span>");
		sb.append("</button>");
		sb.append("<div class=\"collapse navbar-collapse\" id=\"navbarResponsive\">");
		sb.append("<img class=\"d-flex justify-content-center\" src=\"../imagens/"+nomeimg+"-logo-white.png\" style=\"max-height:50px;\" />");
		sb.append("<ul class=\"navbar-nav\">");
		sb.append("<li class=\"nav-item "+(pagAtual.equals(nomeimg)?"active":"")+"\"><a class=\"nav-link\"");
		sb.append("onclick=\"javascript:chamaMenu('"+nomeimg+".jsp');\"><i class=\"fas fa-home\"></i> Home</a></li>");
		//Usuário administrador
		if("1".equals(r1u.getOpc_tipo_acesso())) {
			sb.append("<li class=\"nav-item "+(pagAtual.equals("lista_usuarios")?"active":"")+" \"><a class=\"nav-link\" onclick=\"javascript:chamaMenu('lista_usuarios.jsp');\">");
			sb.append("<i class=\"fas fa-user\"></i>Usuários</a></li>");	
		}
		sb.append("<li class=\"nav-item "+(pagAtual.equals("lista_grupo_musical")?"active":"")+" \"><a class=\"nav-link\" onclick=\"javascript:chamaMenu('lista_grupo_musical.jsp');\">");
		sb.append("<i class=\"fas fa-drum\"></i>Grupo</a></li>");	
		
		sb.append("<li class=\"nav-item "+(pagAtual.equals("lista_artista")?"active":"")+" \"><a class=\"nav-link\" onclick=\"javascript:chamaMenu('lista_artista.jsp');\">");
		sb.append("<i class=\"fas fa-microphone-alt\"></i>Artista</a></li>");
		
		sb.append("<li class=\"nav-item "+(pagAtual.equals("lista_musica")?"active":"")+" \"><a class=\"nav-link\" onclick=\"javascript:chamaMenu('lista_musica.jsp');\">");
		sb.append("<i class=\"fas fa-music\"></i>Musicas</a></li>");
		
		sb.append("<li class=\"nav-item "+(pagAtual.equals("label")?"active":"")+" \"><a class=\"nav-link\" onclick=\"javascript:chamaMenu('lista_label.jsp');\">");
		sb.append("<i class=\"fas fa-compact-disc\"></i>Label</a></li>");
		
		sb.append("<li class=\"nav-item "+(pagAtual.equals("distribuidora")?"active":"")+" \"><a class=\"nav-link\" onclick=\"javascript:chamaMenu('lista_distribuidora.jsp');\">");
		sb.append("<i class=\"fas fa-truck\"\"></i>Distribuidora</a></li>");
		
		
		sb.append("</ul>");
		sb.append("<ul class=\"navbar-nav\" style=\"float: right; margin-left: auto;\">");
		sb.append("<li class=\"nav-item\"><a class=\"nav-link\"");
		sb.append("onclick=\"return confirm('Deseja sair do ambiente?')\"");
		sb.append("href=\"../index_"+nomeimg+".jsp?logoff=S\"><i class=\"fas fa-sign-out-alt\"></i>");
		sb.append("Sair</a></li>");
		sb.append("</ul>");
		sb.append("</div>");
		sb.append("</div>");
		sb.append("</nav>");
		sb.append("<br><br><br><br>");
		sb.append("<!-- Final Menu Projeto -->");
		return sb.toString();
	}
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
