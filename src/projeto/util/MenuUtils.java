package projeto.util;


import projeto.model.Cr_usuario;

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
							"		function sair(){ " +
							"			$(\"#mensagemSucessoLogin\").text('Deseja realmente sair?'); " +
							"			$(\"#modalSucessoLogin\").modal('show');" +
							"			" +
							"			" +
							"			return false;" +
							"		} " +
							"		function redirecionarHome() { " +
							"   		 return window.location.href = \"cr_home.jsp?logoff=S\"; " +
							"  		} " +
							"	</script> " +	
							"	<style> " +	
							" " +
							"			* { " +
							"			 margin: 0; " +
							"			 padding: 0; " +
							"			 box-sizing: border-box; " +
							"			} " +
							" " +
							"			.carrinho { " +
							"			  position: fixed; " +
							"			  top: 0; " +
							"			  right: -400px; " +
							"			  width: 400px; " +
							"			  height: 100vh; " +
							"			  background-color: rgba(0, 0, 0, 0.7); " +
							"			  padding: 35px; " +
							"			  transition: right 0.3s ease-in-out; " +
							"			  display: flex; " +
							"			  flex-direction: column; " +
							"			  justify-content: space-between; " +
							"			} " +
							" " +
							"			.carrinho.aberto { " +
							"			  right: 0; " +
							"			} " +
							" " +
							"			.carrinho .cabecalho-carrinho { " +
							"			  display: flex; " +
							"			  justify-content: space-between; " +
							"			  align-items: center; " +
							"			  margin-bottom: 20px; " +
							"			} " +
							" " +
							"			.carrinho .cabecalho-carrinho h3 { " +
							"			  color: #fff; " +
							"			  font-size: 1.2rem; " +
							"			} " +
							" " +
							"			.carrinho .cabecalho-carrinho button { " +
							"			  color: #fff; " +
							"			  font-size: 1.2rem; " +
							"			  background-color: transparent; " +
							"			  border: none; " +
							"			  cursor: pointer; " +
							"			} " +
							" " +
							"			.carrinho .conteudo-carrinho { " +
							"			  margin: 50px; " +
							"			  display: flex; " +
							"			  flex-direction: column; " +
							"			  justify-content: center; " +
							"			  align-items: center; " +
							"			  color: #fff; " +
							"			  flex-grow: 1; " +
							"			  margin-bottom: 20px; " +
							"			} " +
							" " +
							"			.carrinho .conteudo-carrinho h4 { " +
							"			  margin-bottom: 10px; " +
							"			} " +
							" " +
							"			.carrinho .conteudo-carrinho .lista-produtos { " +
							"			  list-style: none; " +
							"			  padding-left: 0; " +
							"			} " +
							" " +
							"			.carrinho .conteudo-carrinho .lista-produtos li { " +
							"			  margin-bottom: 10px; " +
							"			} " +
							" " +
							"			.carrinho .pagar { " +
							"			  display: block; " +
							"			  width: 100%; " +
							"			  padding: 10px; " +
							"			  border: none; " +
							"			  border-radius: 50px; " +
							"			  background-color: red; " +
							"			  color: #fff; " +
							"			  font-weight: bold; " +
							"			  text-align: center; " +
							"			  cursor: pointer; " +
							"			  transition: background-color 0.3s; " +
							"			  align-self: flex-end; " +
							"			} " +
							" " +
							"			.carrinho .conteudo-carrinho .pagar:hover { " +
							"			  background-color: #cc0000; " +							
							"			} "+
							" " +
							"			.elemento_navbar { " +
							"  				background-color: rgba(99, 111, 97, 0.9); " +	
							"			    backdrop-filter: blur(40px); "+
							"				-webkit-backdrop-filter: blur(40px); " +
							"			} "+
							" " +
							"			@media(min-width: 1000px) { " +
							"				.pesquisa_receita { " +
							"					width: 500px; " +
							"				} " +
							"			} "+
							" 			.div_image_autocomplete img {" +
							" 				width: 80%;" +
							" 				height: auto;" +
							" 				object-fit: cover;" +
							" 				border-radius: 10px;" +
							//"				padding:40px; "+
							" 			}" +
						  //"			.bootstrap-autocomplete .dropdown-item:hover { " +
						  //"  				background-color: #636f61; " +
						  //"			} " +
						  	"			.div_auto {" +
						  	"				margin: 0;"+
						  	"			}"+
							"	</style> " +
							"	<form id='frmchama' method='post' action=''> " +
							"	</form> " +								 							
							"	<!-- Navigation --> " +
							"	<nav class='navbar navbar-expand-lg navbar-light fixed-top elemento_navbar'> " +
							"			<img class='img-fluid' onclick=\"javascript:chamaMenu('cr_home.jsp');\" style='max-width: 200px;' src='./imagens/cr_navbar.png' /> " +
							//"			<a class='navbar-brand' onclick=\"javascript:chamaMenu('cr_home.jsp');\" style='color: #FFFFFF; font-weight: 800;'><strong>Cozinha Rápida</strong></a> " +
							"			<button class='navbar-toggler' type='button' data-toggle='collapse' data-target='#navbarNav' aria-controls='navbarNav' aria-expanded='false' aria-label='Toggle navigation'> " +							
							"				<span class='navbar-toggler-icon'></span> " +
							"			</button> " +																				
							"			<div class='collapse navbar-collapse justify-content-center' id='navbarNav'> "+
							"				<form class='form-inline mt-3 mt-md-0 col-xl-9 col-lg-9 col-md-12 col-sm-12 col-12 justify-content-center'> " +
							"				   <div class='col-xl-8 col-lg-8 col-md-12 col-sm-12 col-12 pesquisa_receita'> "+	
							"    				<div class='input-group rounded'> " +
							"     					 <div class='input-group-append rounded'> " +							
							"       					<span class='input-group-text badge-dark rounded-right-0 rounded-left' id='basic-addon1' style='border: none;'><i class='fas fa-search'></i></span> " +
							"      					</div> " +
							"							<select class='form-control basicAutoSelect rounded-left-0 rounded-right' id='sel_receita' " +
							"								name='sel_receita' " +
							"								placeholder='Pesquise uma Receita...' " +
							"								data-url='./jsonservlet?opc_servlet=sel_pesquisa_receita' " +
							"								autocomplete='off' style='background:#FFFFFF border: none;'> " +
							"							</select> "+
							"    				</div> " +
							"    			  </div> " +
							"  				</form> " +
					        " 		   <div class='col-xl-3 col-lg-3 col-md-3 col-sm-12 col-12'> "+	
							" 				<ul class='navbar-nav justify-content-md-center'> ";
			if(cru == null) {
				menuHtml += "						<li class='nav-item mt-3 mt-md-0 "+(pagAtual.equals("login")?"active":"")+"'> " +
							"							<a class='nav-link' onclick=\"javascript:chamaMenu('cr_login.jsp?logoff=S');\">Entre ou Cadastre-se</a> " +
							"						</li> ";
			}else {
				menuHtml +=	"						<li class='nav-item mt-3 mt-md-0 "+(pagAtual.equals("usuario")?"active":"")+" dropdown'><a class='nav-link dropdown-toggle' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false' href='#'><i class='fas fa-user fa-lg'></i> "+nome_usuario+"</a>  " +						   
			            	"						    <ul class='navbarLinkDropdown dropdown-menu'> "  +
			            	"							    <li class='nav-item'><a class='dropdown-item' onclick=\"javascript:chamaMenu('cr_editar_usuario.jsp');\"> " +
			            	"								    <i class='fas fa-edit'></i> Editar Dados</a> " +
			            	"							    </li> " +
			            	"							    <li class='nav-item'><a class='dropdown-item' onclick=\"javascript:chamaMenu('cr_receitas_favoritas.jsp');\"> " +
			            	"								    <i class='fas fa-heart'></i> Receitas Salvas</a> " +
			            	"							    </li> " +
			            	"							    <li class='nav-item'><a class='dropdown-item' onclick=\"sair();\">" +
			            	"								    <i class='fas fa-sign-out-alt'></i> Sair</a> " +
			            	"							    </li> "+							   
			            	"						    </ul> " +						   
			            	"						</li>";
			}
			
				menuHtml += "						<li class='nav-item mt-3 mt-md-0 "+(pagAtual.equals("carrinho")?"active":"")+"'> " +
							"							<a id='abrir-carrinho' class='nav-link' href='#'><i class='fas fa-shopping-cart fa-lg'></i></a> " +
							"						</li> ";													
			if(cru != null && "1".equals(tipo_acesso)) {			        			            	
				menuHtml += "						<li class='nav-item "+(pagAtual.equals("receita")?"active":"")+"'> " +
							"							<a class='nav-link' onclick=\"javascript:chamaMenu('cr_lista_receitas.jsp');\"><i class='fas fa-receipt'></i> Receita</a> " +
							"						</li> ";
			}							
                menuHtml += "				</ul> "+
            			    "    		 </div> " +
						    "			</div>"+						    
						    " 	</nav>"+
							"	<!-- Fim Navbar Projeto --> ";
                
                menuHtml += "<div class=\"carrinho\" style=\"position: absolute; z-index: 9999;\"> " +
	                		"   <div class=\"cabecalho-carrinho\"> " +
	                		"     <h3>Carrinho de Compras</h3> " +
	                		"     <button id=\"fechar-carrinho\">&times;</button> " +
	                		"   </div> " +
	                		"   <div class=\"conteudo-carrinho\"> " +
	                		"     <!-- Conteúdo do carrinho de compras --> " +
	                		"     <ul class=\"lista-produtos\"> " +
	                		"       <li> " +
	                		"           <p class=\"produto\">Produto 1</p> " +
	                		"           <p class=\"preco\">R$10,00</p> " +
	                		"           <i>............................................................</i> " +
	                		"       </li> " +
	                		"     </ul> " +
	                		"   </div> " +
	                		"   <div class=\"total\"> " +
	                		"       <p id=\"total\">Total: </p> " +
	                		"   </div> " +
	                		"   <button class=\"pagar\">Pagar</button> " +
	                		"</div> ";
                menuHtml += "<!-- Modal de mensagem de tratamento de Alerta --> " +
                		"		<div class=\"modal fade\" id=\"modalSucessoLogin\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"modalErroLabel\" aria-hidden=\"true\"> " +
                		"		  <div class=\"modal-dialog\" role=\"document\"> " +
                		"		    <div class=\"modal-content\"> " +
                		"		      <div class=\"modal-header text-white\" style=\"background-color:#636f61;\"> " +
                		"		        <h5 class=\"modal-title\" id=\"modalErroLabel\">Alerta</h5> " +
                		"		        <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Fechar\"> " +
                		"		          <span aria-hidden=\"true\" class=\"text-white\">&times;</span> " +
                		"		        </button> " +
                		"		      </div> " +
                		"		      <div class=\"mt-3 modal-body\"> " +
                		"	       		 <p id=\"mensagemSucessoLogin\"></p> " +
                		"		      </div> " +
                		"		      <div class=\"modal-footer\"> " +
                	    "		        <button type=\"button\" class=\"btn btn-outline-dark\" data-dismiss=\"modal\">Não</button> " +
                	    "		        <button type=\"button\" class=\"btn btn-dark\" id=\"btnSim\" onclick=\"redirecionarHome()\">Sim</button> " +
                	    "		      </div> " +
                		"		    </div> " +
                		"		   </div> " +
                		"		 </div> ";
			 return menuHtml;		
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}