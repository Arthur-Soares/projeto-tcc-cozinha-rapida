<%@page import="projeto.util.MenuUtils"%>
<%@page import="projeto.util.Cast"%>
<%@page import="projeto.util.AppSecrets"%>
<%@page import="projeto.model.Cr_usuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<%	
	String p_cr_id_receita = null!=request.getParameter("cr_id_receita")?request.getParameter("cr_id_receita"):"";
	Cr_usuario cru = null!=session.getAttribute(AppSecrets.USER_KEY)?(Cr_usuario)session.getAttribute(AppSecrets.USER_KEY):null;
	int cuserid = null!=cru?cru.getCr_id_usuario():0;
	String cuseradmin = null!=cru?cru.getCr_nivel_usuario():"";
	String cusername = null!=cru?cru.getCr_nome_completo_usuario():"";
	String cuseremail = null!=cru?cru.getCr_email_usuario():"";
	String redir = null!=request.getParameter("redir")?request.getParameter("redir"):"";
	String opclogoff = null!=request.getParameter("logoff")?request.getParameter("logoff"):"";
	//logoff=S
	String msgIndex = null != session.getAttribute("errologin") ? (String) session.getAttribute("errologin") : "";
	
	//System.out.println("VENDO O ID DO USUÁRIO :: "+cuserid);
			
	if("S".equals(opclogoff) || !"".equals(msgIndex)){
		session.setAttribute("errologin", null);
		session.setAttribute("projeto.model.Cr_usuario", null);		
	}
	
	System.out.println("p_cr_id_receita :: "+p_cr_id_receita);
	%>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="icon" href="imagens/cr_logo_guia_ret_arredondado.png" type="image/png">			
		<title>Cozinha Rápida - Pagamento</title>
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="fontawesome/css/all.min.css" rel="stylesheet">
		<link href="css/bootstrap-datepicker.css" rel="stylesheet"/>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
		<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		<script type="text/javascript" src="fontawesome/js/all.min.js"></script>
		<script type="text/javascript" src="js/bootstrap-autocomplete.js"></script>
		<script type="text/javascript" src="./js/carrinho.js"></script>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
		<script type="text/javascript" src="js/popper.js"></script>
		<script src="js/bootstrap-datepicker.min.js"></script>
		<script src="js/bootstrap-datepicker.pt-BR.min.js"></script>
		<!-- <script src="js/jquery.maskMoney.min.js" type="text/javascript"></script>       
		 data-thousands="." data-decimal="," data-prefix="R$ "  -->
		
		<!-- Data Tables -->
		<script src="js/datatables/jquery.dataTables.min.js"></script>
		<script src="js/datatables/dataTables.bootstrap4.min.js"></script>
		<script src="js/datatables/dataTables.fixedHeader.min.js"></script>
		<script src="js/datatables/dataTables.responsive.min.js"></script>
		<script src="js/datatables/responsive.bootstrap.min.js"></script>

		<link rel="stylesheet" href="css/datatables/dataTables.bootstrap4.min.css">
		<link rel="stylesheet" href="css/datatables/fixedHeader.bootstrap4.min.css">
		<link rel="stylesheet" href="css/datatables/responsive.bootstrap.min.css">
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
				color: #b1463c;
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
			
			@media(max-width: 1000px) {
    			.sugestao {
        			display: none;
    			}
			}
					

			#btnCompra {	
				border: none;						
				color: #FFFFFF;				
				border-radius: 40px;
				transition: 0.2s;
				cursor: pointer;			
				transition: 0.2s;
				font-size: 20px;
			}
			.div-com-fundo-transparente {
			  background-color: rgba(0, 0, 0, 0.4); /* Valor alfa de 0.5 representa 50% de transparência */
			}
			
			#img_pix {
			  max-width: 30%;
			  border-radius: 30px;
			}
			
			@media (max-width: 1000px) {
			  #img_pix {
			  	max-width: 100%;
			 	border-radius: 30px;
				}
			}
			
			#copyButton {	
				border: none;						
				color: #FFFFFF;				
				border-radius: 40px;
				transition: 0.2s;
				cursor: pointer;			
				transition: 0.2s;
				font-size: 20px;
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
			
			carregaListaCarrinhodeCompras('<%=cuserid%>');
			enviaEmailReciboIngredientes('<%=cuseremail%>');
			
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
					$.getJSON("./jsonservlet",{opc_servlet:'find_receita',cr_id_receita:item.value}, 
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
					
			//Lógica do Carrinho de Compras
			const btnAbrirCarrinho = $('#abrir-carrinho');
		    const btnFecharCarrinho = $('#fechar-carrinho');
		    const carrinho = $('.carrinho');
		    carrinho.hide();

		    btnAbrirCarrinho.click(function() {
		        carrinho.show();
		        carrinho.addClass('aberto');
		    });

		    btnFecharCarrinho.click(function() {
		        carrinho.removeClass('aberto');
		        carrinho.hide();
		    });
		});
			
		function enviaEmailReciboIngredientes(email_usuario){			
			var id_usuario = '<%=cuserid%>';
			$.postJSON("./jsonservlet",{opc_servlet:'envia_email_recibo_ingredientes',email_usuario:email_usuario},
				function(emailretorno){				
					var retorno = emailretorno.retorno;
					if(retorno == 0){											        										      					 					
						console.log("Email enviado, tudo certo!");
						carregaListaCarrinhodeCompras(id_usuario);									        
					}else{	
						console.log("Erro ao enviar Email!");													        								
					}											        		
				}
			);	
		}
		
	    function copyTextToClipboard(text) {
	        const textarea = document.createElement('textarea');
	        textarea.value = text;
	        document.body.appendChild(textarea);
	        textarea.select();
	        document.execCommand('copy');
	        document.body.removeChild(textarea);
	        //alert('Texto copiado para a área de transferência: ' + text);
	        $("#mensagemSucessoDesfavoritar").text('Chave PIX copiada para a área de transferência!');
	        $("#modalSucessoDesfavoritar").modal('show');
	    }
	    
	  	
		function voltarHome(){   								
			$("#tela_home").submit();			    
		}
		
	</script>

	<body>		
	<%=MenuUtils.buildMenu("usuario", cru)%>
									
	<form id="frmreceita" name="frmreceita" method="post" action="cr_receita.jsp">
		<input type="hidden" id="cr_id_receita" name="cr_id_receita"/>
	</form>	
	<form id="tela_home" name="tela_home" method="post" action="cr_home.jsp">
	</form>								
	<form id="frm_tela_receita" name="frm_tela_receita" method="post" action="cr_lista_receitas.jsp">	
			
		<div id="div_tela">
			<div class="row mt-3">
				<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12" align="center">
					<div class="row mt-3">
						<div class="container rounded col-xl-11 col-lg-11 col-md-11 col-sm-12 col-12 div-com-fundo-transparent" align="center">
							<br>
							<div class="row mt-3">
								<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12" align="center">
									<h1>Pagamento</h1>
									
									<img src="imagens/PIX_COZINHA_RAPIDA.jpg" alt="Pix_CR" id="img_pix" border="0">
									
									<div class="col-xl-10 col-lg-10 col-md-10 col-sm-10 col-10" align="center">
									<h6>Foi enviado um recibo com os ingredientes para o seu email, caso queira finalizar o pagamento
										escaneie o QRCODE acima ou copie a chave PIX abaixo, e efetue o pagamento.																													
									</h6>
									<br>							
									<h4 style="color: #FF8100;"><strong>79e765ef-df91-489e-819d-c70962393f4b</strong></h4>						            
									
									<div class="row mt-3 justify-content-center text-center">
										<div class="mt-3 col-xl-4 col-lg-4 col-md-4 col-sm-12 col-12 text-center">		
											 <button type="button" class="btn btn-lg btn-block" id="copyButton" onclick="copyTextToClipboard('79e765ef-df91-489e-819d-c70962393f4b')" style="padding-top:10px; padding-bottom:10px; padding-left:50px; padding-right:50px; background-color: #e97500;">
										     	<strong><i class="fas fa-copy"></i> Copiar chave PIX</strong>
										    </button>	
										</div>
										<div class="mt-3 col-xl-4 col-lg-4 col-md-4 col-sm-12 col-12 text-center">		
											 <button type="button" class="btn btn-lg btn-block" id="copyButton" onclick="voltarHome();" style="padding-top:10px; padding-bottom:10px; padding-left:50px; padding-right:50px; background-color: #636f61;">
										     	<strong><i class="fas fa-home"></i> Voltar para Home</strong>
										    </button>	
										</div>
									</div>	
									 <br>			
									 <h6><strong>Obrigado por usar o sistema Cozinha Rápida!</strong></h6>	
									</div>
								</div>
							</div>
							
							<!-- 
								<div class="div_receitas_favoritas row mt-3 justify-content-center text-center col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">				
								</div>
							 -->
							<br>							
						</div>
					</div>
				</div>
			</div>					
 		</div>
	</form>		
			  
<!--   	<footer class="text-light" style="background-color: #636f61; padding: 20px;margin-top: 4%">	    
		    <div class="text-center">
		      &copy 2023 Copyright: <a href="#" style="color:white">Cozinha Rapida</a>
		    </div>
  		</footer> -->
  		
  		<!-- Modal de mensagem de tratamento de Sucesso -->
		<div class="modal fade" id="modalSucessoDesfavoritar" tabindex="-1" role="dialog" aria-labelledby="modalSucessoLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header text-white" style="background-color:#636f61;">
		        <h5 class="modal-title" id="modalSucessoLabel">Alerta</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
		          <span aria-hidden="true" class="text-white">&times;</span>
		        </button>
		      </div>
		      <div class="mt-3 modal-body">    			      	   	  		        			    
	       		 <p id="mensagemSucessoDesfavoritar"></p>			         
		      </div>
		      <div class="modal-footer sucesso">
		        <button type="button" class="btn btn-outline-dark" data-dismiss="modal">Fechar</button>
		      </div>
		    </div>
		   </div>
		 </div>
		 
		 <!-- Modal de mensagem de Confirmação --> 
		<div class="modal fade" id="modalConfirm" tabindex="-1" role="dialog" aria-labelledby="modalErroLabel" aria-hidden="true"> 
		  <div class="modal-dialog" role="document"> 
		    <div class="modal-content"> 
		      <div class="modal-header text-white" style="background-color:#636f61;"> 
		        <h5 class="modal-title" id="modalErroLabel">Confirma?</h5> 
		        <button type="button" class="close" data-dismiss="modal" aria-label="Fechar"> 
		          <span aria-hidden="true" class="text-white">&times;</span> 
		        </button> 
		      </div> 
		      <div class="mt-3 modal-body"> 
	       		 <p id="mensagemConfirm"></p> 
		      </div> 
		      <div class="modal-footer confirm"> 
		        <button type="button" class="btn btn-outline-dark" data-dismiss="modal">Não</button> 
		        <button type="button" class="btn btn-dark" id="btnSimConfirm" value="0" onclick="desfavoritarReceita(this.value)">Sim</button> 
		      </div> 
		    </div> 
		   </div> 
		 </div> 
			 
</body>
</html>
