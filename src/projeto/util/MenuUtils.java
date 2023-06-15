package projeto.util;


import projeto.model.Cr_usuario;

public class MenuUtils { 
	
	public static String buildMenu(String pagAtual, Cr_usuario cru) {			
		
		String nome_usuario = "Fazer login";
		String tipo_acesso = "";			
		int id_user_nav = 0;
		if(cru != null) {
			tipo_acesso = cru.getCr_nivel_usuario();
			int indiceEspaco = cru.getCr_nome_completo_usuario().indexOf(" ");
			id_user_nav = cru.getCr_id_usuario();
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
							"		function redirecionarPagamento() { " +
							"			var id = "+id_user_nav+"; " +
							"			if(id == 0){ " +
							"    			$(\"#mensagemErro\").text('Faça o login para realizar a compra!'); " +
							"    			$(\"#modalErro\").modal('show'); " +
							"    			return false; " +
							"			}else if(valor_total_carrinho_global == 0){ " +
							"				$(\"#mensagemErro\").text('Carrinho de compras vazio!'); " +
							"				$(\"#modalErro\").modal('show'); " +
							"				return false; " +							
							"			}else{ " +
							"				return window.location.href = \"cr_pagamento.jsp\"; " +
							"			} "+
							"  		} " +
							"	</script> " +	
							"	<style> " +	
							" " +
							"	* { " +
							"		margin: 0; " +
							"		padding: 0; " +
							"		box-sizing: border-box; " +
							"	} " +
							" " +
							".modal-direita { " +
							"  position: fixed; " +
							"  top: 0; " +
							"  right: 0; " +
							"  bottom: 0; " +
							"  z-index: 9998; " +
							"  background: linear-gradient(135deg, rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)); " +
							"  -webkit-backdrop-filter: blur(40px); " +
							"  backdrop-filter: blur(40px); " +
							"  display: none; " +
							"  overflow-y: auto; " +
							"} " +
							" " +
							".conteudinho { " +
							"  position: relative; " +
							"  background-color: #fff; " +
							"  border-radius: 5px; " +
							"  max-height: calc(100% - 40px); /* Defina uma altura máxima para o modal */ " +
							"  overflow-y: auto; /* Adicione a propriedade de rolagem apenas ao conteúdo */ " +
							"} " +
							" " +
							"	#modalSucessoCarrinho, #modalConfirmCarrinho, #modalErro { " +
							"  		z-index: 9999; /* Valor alto para garantir que fique acima dos outros modais */ " +
							"	} "+
							" " +
							".modalCarrinho{ " +
							"  background-color: rgba(0, 0, 0, 0.5)  !important; " +
							" } " +
							" " +
							" .circulo { " +
							"    width: 50px; " +
							"    height: 50px; " +
							"    border-radius: 50%; " +
							"    overflow: hidden; " +
							"    float: left; " +
							//"    margin: 15px; " +
							"    transition: 0.3s ease; " +
							"    background-color: #fff; " +
							"    text-align: center; " +
							"    line-height: 50px; /* Igual à altura da div */ " +
							" } "+
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
						  	"	#btncomprarIngredientes { " +
						  	"		border: none; " +
						  	"		color: #FFFFFF; " +
						  	"		transition: 0.2s; " +
						  	"		cursor: pointer; " +
						  	"		transition: 0.2s; " +
						  	"		font-size: 20px; " +
						  	"	} "+
						  	"	"+
						  	"	li:hover { " +
						  	"  	cursor: pointer; " +
						  	"	} "+
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
			            	"								    <i class='fas fa-heart'></i> Favoritas</a> " +
			            	"							    </li> " +
			            	"							    <li class='nav-item'><a class='dropdown-item' onclick=\"sair();\">" +
			            	"								    <i class='fas fa-sign-out-alt'></i> Sair</a> " +
			            	"							    </li> "+							   
			            	"						    </ul> " +						   
			            	"						</li>";
			}
			
				menuHtml += "						<li class='nav-item mt-3 mt-md-0 "+(pagAtual.equals("carrinho")?"active":"")+"'> " +
							"  							<button class='nav-link btn' id='abrir-carrinho' data-toggle='modal' data-target='#modalCarrinho'> " +
							"    							<i class='fas fa-shopping-cart fa-lg'></i> " +
							"  							</button> " +
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
                
                menuHtml += "<!-- MODAL CARRINHO --> " +
	                		"<div class=\"modal-direita\" id=\"modalCarrinho\"> " +
	                		"	<div class=\"modal-dialog modal-md modal-dialog-centered modal-notify modal-info modal-fluid 1\" role=\"document\"> " +
	                		"		<div class=\"modal-content conteudinho\" style=\"display: flex; flex-wrap: wrap; background-color:transparent; border: none;\"> " +
	                		"			<div class=\"modal-header\" style=\"border: none;\"> " +
	                		"			  <div class=\"row col-xl-11 col-lg-11 col-md-11 col-sm-11 col-11 justify-content-center text-center\"> " +
	                		"					<h5 class=\"modal-title\" id=\"ModalTitle\" style=\"font-weight: 800; color: #fff;\"><i class='fas fa-shopping-cart fa-lg'></i> Carrinho de Compras</h5> " +
	                		"				</div> " +
	                		"				<button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Fechar\" style=\"color: #fff;\"> " +
	                		"					<span aria-hidden=\"true\"><i class=\"fas fa-times\"></i></span> " +
	                		"				</button> " +
	                		"			</div> " +
	                		" " +
	                		"			<div class=\"modal-body justify-content-center\" style=\"display: flex; flex-wrap: wrap;\"> " +
	                		"				 <div class=\"div_carrinho_compra row justify-content-center text-center col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12\"> " +
	                		"				 </div> " +
	                		"				 <div class=\"div_carrinho_compra_total row justify-content-center text-center col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12\"> " +
	                		"					 <div class=\"container align-items-center justify-content-center\"> " +
	                		"						<h4 class=\"modal-title\" id=\"ModalTitle\" style=\"margin-left: 8px; margin-right: 8px; font-weight: 800; color: #B1463C;\">Valor Total:</h4> " +
	                		"						<div class=\"valor_total_carrinho_compra\" style=\"font-size: 20px; font-weight: 800; color: #FFF; \"></div> " +
	                		"					</div> " +
	                		"					<hr class=\"dashed-hr\"> " +
	                		"				</div> " +
	                		"			</div> " +
	                		" " +
	                		"			<div class=\"modal-footer justify-content-center text-center\" style=\"border: none;\"> " +
	                		"				<button type=\"button\" class=\"btn btn-lg btn-block\" id=\"btncomprarIngredientes\" style=\"padding-top:10px; padding-bottom:10px; padding-left:50px; padding-right:50px; background-color: #e97500;\" onclick=\"redirecionarPagamento()\"><strong>Finalizar Compra <i class=\"bi bi-cash-coin\"></i></strong></button> " +
	                		"			</div> " +
	                		"		</div> " +
	                		"	</div> " +
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
                		"		 </div> "+
		                "<!-- Modal de mensagem de tratamento de Alerta Confirmação --> " +
		        		"		<div class=\"modal fade\" id=\"modalConfirmCarrinho\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"modalErroLabel\" aria-hidden=\"true\"> " +
		        		"		  <div class=\"modal-dialog\" role=\"document\"> " +
		        		"		    <div class=\"modal-content\"> " +
		        		"		      <div class=\"modal-header text-white\" style=\"background-color:#636f61;\"> " +
		        		"		        <h5 class=\"modal-title\" id=\"modalErroLabel\">Alerta</h5> " +
		        		"		        <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Fechar\"> " +
		        		"		          <span aria-hidden=\"true\" class=\"text-white\">&times;</span> " +
		        		"		        </button> " +
		        		"		      </div> " +
		        		"		      <div class=\"mt-3 modal-body\"> " +
		        		"	       		 <p id=\"mensagemConfirmCarrinho\"></p> " +
		        		"		      </div> " +
		        		"		      <div class=\"modal-footer\"> " +
		        	    "		        <button type=\"button\" class=\"btn btn-outline-dark\" data-dismiss=\"modal\">Não</button> " +
		        	    "				<button type=\"button\" class=\"btn btn-dark\" id=\"btnSimConfirmCarrinho\" value=\"0\" onclick=\"ApagarIngredienteCarrinho(this.value)\">Sim</button> "+
		        	    "		      </div> " +
		        		"		    </div> " +
		        		"		   </div> " +
		        		"		 </div> "+
		        		"<!-- Modal de mensagem de tratamento de Sucesso --> " +
		        		"<div class=\"modal fade\" id=\"modalSucessoCarrinho\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"modalSucessoLabel\" aria-hidden=\"true\"> " +
		        		"  <div class=\"modal-dialog\" role=\"document\"> " +
		        		"    <div class=\"modal-content\"> " +
		        		"      <div class=\"modal-header text-white\" style=\"background-color:#636f61;\"> " +
		        		"        <h5 class=\"modal-title\" id=\"modalSucessoLabel\">Alerta</h5> " +
		        		"        <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Fechar\"> " +
		        		"          <span aria-hidden=\"true\" class=\"text-white\">&times;</span> " +
		        		"        </button> " +
		        		"      </div> " +
		        		"      <div class=\"mt-3 modal-body\"> " +
		        		"  		 <p id=\"mensagemSucessoCarrinho\"></p> " +
		        		"      </div> " +
		        		"      <div class=\"modal-footer sucesso\"> " +
		        		"        <button type=\"button\" class=\"btn btn-outline-dark\" data-dismiss=\"modal\">Fechar</button> " +
		        		"      </div> " +
		        		"    </div> " +
		        		"   </div> " +
		        		" </div> ";
                
			 return menuHtml;		
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}