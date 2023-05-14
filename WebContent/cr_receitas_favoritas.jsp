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
		<title>Cozinha Rápida - Receita Favoritas</title>
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="fontawesome/css/all.min.css" rel="stylesheet">
		<link href="css/bootstrap-datepicker.css" rel="stylesheet"/>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
		<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		<script type="text/javascript" src="fontawesome/js/all.min.js"></script>
		<script type="text/javascript" src="js/bootstrap-autocomplete.js"></script>
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
				color: #323232;
			}
			div {
				border-radius: 10px;
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
			
			.visual_tit_rec {	
				font-size: 5vh;			
				font-weight: 800;
				font-family: 'Open Sans', sans-serif;
				color: #b1463c;
				margin-top: 4%;
			}
				
			
			@media(max-width: 1000px) {
    			.sugestao {
        			display: none;
    			}
			}
			
			.img_receita {
			    position: relative; /* definir posição relativa para que a imagem possa ser centralizada verticalmente */
			    height: 0; /* definir altura inicial como 0 para o aspect-ratio funcionar */
			    padding-bottom: 20%; /* proporção 16:9 (ou 9:16 para retrato) */
			    overflow: hidden; /* esconder a parte da imagem que exceder a div */
			}
			
			.img_receita iframe {
			    position: absolute; /* definir posição absoluta para a imagem ficar no topo */
			    top: 0;
			    left: 0;
			    width: 100%; /* ajustar a largura para 100% */
			    height: 100%; /* ajustar a altura para 100% */
			    border: 0; /* remover a borda */
			    object-fit: cover; /* fazer a imagem se ajustar ao tamanho da div pai */
			    background-color: transparent;
			}
			
			.img_receita iframe img {
			  width: 100%;
			  height: 100%;
			  object-fit: cover;
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
			
			carregaListaReceitasFav('<%=cuserid%>');
			
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
		});
		
		function pintarCoracao(cr_id_receita){
			var id = '<%=cuserid%>';
			if(id != 0){
				$.postJSON("./jsonservlet",{opc_servlet:'pintar_coracao',cr_id_receita:cr_id_receita},
					function(data,status){
						if(data.retorno == ""){
							alert("Erro ao pintar o coracao");						
						}else if(data.retorno == "favorita"){
								document.getElementById('btnFavoritar').className = 'btn btn-link bi bi-heart-fill';
						}else if(data.retorno == "desfavorita"){
								document.getElementById('btnFavoritar').className == 'btn btn-link bi bi-heart';
						}
					}	
				);				
			}
		}
			
		//Função do efeito favotitar receita no icone Hearth
		function desfavoritarReceita(cr_id_receita){
			var id = '<%=cuserid%>';
			var opc_favorito = "desfavoritar";
			
			if(id == 0){
				alert("Faça o login antes de prosseguir!");
				return false;
			}				
			
			if(confirm("Deseja desfavoritar essa receita?")){					
				$.postJSON("./jsonservlet",{opc_servlet:'favoritar_receita',opc_favorito:opc_favorito,cr_id_receita:cr_id_receita},
					function(data,status){
						if(data.retorno == -1){
							alert("Erro ao "+opc_favorito+" receita!");						
						}else{						
							alert("Receita desfavoritada com sucesso!");
							carregaListaReceitasFav(id);
						}
					}
				);
			}
		}	
		
		function createDesfavoritarReceitaFunction(idReceita) {
		    return function() {
		        desfavoritarReceita(idReceita);
		    };
		}
		
		function carregaListaReceitasFav(cuserid) {
		    var num = 1;
		    var div_receitas_favoritas = $(".div_receitas_favoritas");

		    $.postJSON("./jsonservlet", { opc_servlet: 'list_receitas_favoritas', cuserid: cuserid }, function(datalin, statuslin) {
		        if (datalin.length > 0) {
		            // Limpa o conteúdo existente dentro da div caso seja chamada novamente
		            div_receitas_favoritas.empty();

		            for (var cx = 0; cx < datalin.length; cx++) {
		                var cr_id_receita = datalin[cx].cr_id_receita;
		            	var cr_titulo_receita = datalin[cx].cr_titulo_receita;
		                var cr_receita_nome_img = datalin[cx].cr_receita_nome_img;

		                var divContainer = $("<div>").addClass("container");
		                var divRow = $("<div>").addClass("row mt-3 align-items-center");
		                var divColImg = $("<div>").addClass("col-xl-4 col-lg-4 col-md-4 col-sm-12 col-12").attr("id", "cr_receita_nome_img_" + num);
		                var divColTitulo = $("<div>").addClass("col-xl-6 col-lg-6 col-md-6 col-sm-9 col-9").attr("id", "cr_titulo_receita_" + num);
		                var inputTitulo = $("<input>").attr({
		                    type: "text",
		                    class: "form-control",
		                    name: "cr_titulo_receita",
		                    id: "cr_titulo_receita_input_" + num,
		                    readonly: "readonly",
		                    onfocus: "this.blur();"
		                }).css({
		                    border: "none",
		                    background: "transparent",
		                    fontSize: "18px",
		                    textAlign: "left",
		                    fontWeight: "bold",
		                    color: "#b1463c",
		                    pointerEvents: "none" // Desabilita eventos de clique
		                }).val(cr_titulo_receita);
		                divColTitulo.append(inputTitulo);

		                var divColHeart = $("<div>").addClass("col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2").attr("id", "cr_heart_" + num);
		                var divHeartIcon = $("<div>").addClass("btn btn-link bi bi-heart-fill").css({
		                    color: "#b1463c",
		                    fontSize: "50px",
		                    border: "none"
		                }).click(createDesfavoritarReceitaFunction(cr_id_receita));

		                divColHeart.append(divHeartIcon);
		                divRow.append(divColImg, divColTitulo, divColHeart);
		                divContainer.append(divRow);
		                div_receitas_favoritas.append(divContainer);

		                // Adiciona um HR pontilhado
		                if (cx < datalin.length - 1) {
		                    var hrElement = $("<hr>").addClass("dashed-hr");
		                    div_receitas_favoritas.append(hrElement);
		                }

		                // Adiciona a imagem
		                var imgElement = $(cr_receita_nome_img).css("max-width", "100%");
		                $("#cr_receita_nome_img_" + num).html(imgElement);

		                num++;
		            }
		        }else{
		        	div_receitas_favoritas.empty();
		        }

		    });
		}

	</script>

	<body>		
	<%=MenuUtils.buildMenu("receita", cru)%>
									
	<form id="frmreceita" name="frmreceita" method="post" action="cr_receita.jsp">
		<input type="hidden" id="cr_id_receita" name="cr_id_receita"/>
	</form>									
	<form id="frm_tela_receita" name="frm_tela_receita" method="post" action="cr_lista_receitas.jsp">	
			
		<div class="container" style="margin-top: 4%">					
			<div class="row">							
				<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
					<div class="row mt-3 justify-content-center">																									
						<div class="visual_tit_rec">Receitas Favoritas</div>
					</div>	
				</div>													
			</div>	
			<div class="div_receitas_favoritas row mt-3 justify-content-center text-center col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">				
			</div>					
	 	</div>
	</form>		
			  
<!--   	<footer class="text-light" style="background-color: #636f61; padding: 20px;margin-top: 4%">	    
		    <div class="text-center">
		      &copy 2023 Copyright: <a href="#" style="color:white">Cozinha Rapida</a>
		    </div>
  		</footer> -->
</body>
</html>
