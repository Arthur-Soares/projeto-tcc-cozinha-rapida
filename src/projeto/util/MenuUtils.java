package projeto.util;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import projeto.model.Cr_usuario;
import projeto.model.R1usuario;

public class MenuUtils { 
	
	public static String buildMenu(String pagAtual, Cr_usuario cru) {			
		
		String nome_usuario = "Fazer login";
		String tipo_acesso = "";
		
		if(cru != null) {
			tipo_acesso = cru.getCr_nivel_usuario();
			int indiceEspaco = cru.getCr_nome_completo_usuario().indexOf(" ");			
			nome_usuario = (indiceEspaco != -1) ? cru.getCr_nome_completo_usuario().substring(0, indiceEspaco) : cru.getCr_nome_completo_usuario();			
			//System.out.println("Vendo se está pegando apenas o primeiro nome do usuário :: "+nome_usuario);
		}
		
		String menuHtml =   "	<!-- Inicio Navbar Projeto --> " +
						    "	<script type='text/javascript'> " +
							"		function chamaMenu(actionSel){ " +
							"			$('#frmchama').attr('action', actionSel); " +
							"			$('#frmchama').submit(); " +
							"		} " +
							"	</script> " +	
							"	<style> " +				
							"	</style> " +
							"	<form id='frmchama' method='post' action=''> " +
							"	</form> " +								 							
							"	<!-- Navigation --> " +
							"	<nav class='navbar navbar-expand-lg navbar-dark fixed-top' style='background-color: #636f61;'> " +							
							"			<a class='navbar-brand' href='/projeto-tcc-cozinha-rapida/home_cozinharapida.jsp' style='color: #FFFFFF; font-weight: 800;'><strong>Cozinha Rápida</strong></a> " +
							"			<button class='navbar-toggler' type='button' data-toggle='collapse' data-target='#navbarNav' aria-controls='navbarNav' aria-expanded='false' aria-label='Toggle navigation'> " +							
							"				<span class='navbar-toggler-icon'></span> " +
							"			</button> " +																				
							"			<div class='collapse navbar-collapse justify-content-center' id='navbarNav'> "+
							"				<form class='form-inline ml-auto mr-0'> " +
							"    				<div class='input-group'> " +
							"      					<input class='form-control' type='search' placeholder='Pesquisar...' style='width: 400px;'>  " +
							"     					 <div class='input-group-append'> " +
							"       					<button class='btn btn-dark' type='submit'><i class='fas fa-search'></i></button> " +
							"      					</div> " +
							"    				</div> " +
							"  				</form> " +	
							" 				<ul class='navbar-nav ml-auto mr-md-5'> ";
			if(cru == null) {
				menuHtml += "						<li class='nav-item "+(pagAtual.equals("login")?"active":"")+"'> " +
							"							<a class='nav-link'  href='/projeto-tcc-cozinha-rapida/index_cozinharapida.jsp?logoff=S'>Entre ou Cadastre-se</a> " +
							"						</li> ";
			}else {
				menuHtml +=	"						<li class='nav-item "+(pagAtual.equals("usuario")?"active":"")+" dropdown'><a class='nav-link dropdown-toggle' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false' href=#><i class='fas fa-user'></i> "+nome_usuario+"</a>  " +						   
			            	"						    <ul class='navbarLinkDropdown dropdown-menu'> "  +
			            	"							    <li class='nav-item'><a class='dropdown-item' href='/projeto-tcc-cozinha-rapida/restrito/cr_lista_usuarios.jsp'> " +
			            	"								    <i class='fas fa-edit'></i> Editar Dados</a> " +
			            	"							    </li> " +
			            	"							    <li class='nav-item'><a class='dropdown-item' href='/projeto-tcc-cozinha-rapida/restrito/cr_lista_receitas.jsp'> " +
			            	"								    <i class='fas fa-heart'></i> Receitas Salvas</a> " +
			            	"							    </li> " +
			            	"							    <li class='nav-item'><a class='dropdown-item' onclick='return confirm(\"Deseja sair do ambiente?\")'  href='/projeto-tcc-cozinha-rapida/home_cozinharapida.jsp?logoff=S'> " +
			            	"								    <i class='fas fa-sign-out-alt'></i> Sair</a> " +
			            	"							    </li> "+							   
			            	"						    </ul> " +						   
			            	"						</li>";
			}
				menuHtml += "						<li class='nav-item "+(pagAtual.equals("carrinho")?"active":"")+"'> " +
							"							<a class='nav-link' href='#'><i class='fas fa-shopping-cart fa-lg'></i></a> " +
							"						</li> ";													
			if(cru != null && "1".equals(tipo_acesso)) {			        			            	
				menuHtml += "	<li class='nav-item "+(pagAtual.equals("receita")?"active":"")+"'> " +
							"		<a class='nav-link' href='/projeto-tcc-cozinha-rapida/restrito/cr_lista_receitas.jsp'><i class='fas fa-receipt'></i> Cadastro de Receitas</a> " +
							"	</li> ";
			}							
//						    "					<li class='nav-item'> "+
//						    " 						<a class='nav-link' onclick='return confirm('Deseja sair do ambiente?')' href='/projeto-tcc-cozinha-rapida/index_cozinharapida.jsp?logoff=S'>"+
//						    "							<i class='fas fa-sign-out-alt'></i> Sair"+
//						    "						</a>" +
//						    "					</li>" +
                menuHtml += "				</ul> "+
						    "			</div>"+						    
						    " 	</nav>"+
							"	<!-- Fim Navbar Projeto --> ";
				
//				menuHtml += " 				<ul class='navbar-nav ml-auto'> "+
//							"					<li class='nav-item "+(pagAtual.equals("usuario")?"active":"")+"'> " +
//							"						<a class='nav-link' href='/projeto-tcc-cozinha-rapida/restrito/cr_lista_usuarios.jsp'><i class='fas fa-user'></i> Usuário</a> " +
//							"					</li> " +
//							"					<li class='nav-item "+(pagAtual.equals("receita")?"active":"")+"'> " +
//							"						<a class='nav-link' href='/projeto-tcc-cozinha-rapida/restrito/cr_lista_receitas.jsp'><i class='fas fa-receipt'></i> Cadastro de Receitas</a> " +
//							"					</li> " +
//						    "					<li class='nav-item'> "+
//						    " 						<a class='nav-link' onclick='return confirm('Deseja sair do ambiente?')' href='/projeto-tcc-cozinha-rapida/index_cozinharapida.jsp?logoff=S'>"+
//						    "							<i class='fas fa-sign-out-alt'></i> Sair"+
//						    "						</a>" +
//						    "					</li>" +
//						    "				</ul> "+
//						    "			</div>"+						    
//						    " 	</nav>"+
//							"	<!-- Fim Navbar Projeto --> ";
	
			 return menuHtml;		
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
