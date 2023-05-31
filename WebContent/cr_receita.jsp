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
	
	//System.out.println("VENDO O ID DO USUÁRIO :: "+cuserid);
			
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
		<title>Cozinha Rápida - Receita</title>
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="fontawesome/css/all.min.css" rel="stylesheet">		
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
		<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		<script type="text/javascript" src="fontawesome/js/all.min.js"></script>
		<script type="text/javascript" src="./js/bootstrap-autocomplete.js"></script>
		<script type="text/javascript" src="./js/carrinho.js"></script>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">		
		<script src="./js/bootstrap-datepicker.min.js"></script>
		<script src="./js/bootstrap-datepicker.pt-BR.min.js"></script>
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
			div.ingQtd{
				height: 80px;
				margin: auto;
			}
			div.ingImg{
				height: 200px;
			}
			div.ingDsc{
				height: 200px;
			}
			.visual_tit_rec {	
				font-size: 2em;			
				font-weight: 800;
				font-family: 'Open Sans', sans-serif;
				color: #b1463c;
			}
			
			@media(max-width: 1000px) {
    			.sugestao {
        			display: none;
    			}
			}
			
			@media(max-width: 993px) {
				.spc {
	        			display: none;
	    		}
			}
			@media(max-width: 575px) {
				.spco {
	        			display: none;
	    		}
	    		
			}							
			
			.hr-line {
			  	border: none;
			  	border-top: 1px solid #CCCCCC; /* Cor mais clara */
			 	height: 0.5px; /* Menor altura */
			  	margin: 10px 0;
			}
			.img_receita {
			    position: relative; /* definir posição relativa para que a imagem possa ser centralizada verticalmente */
			    height: 0; /* definir altura inicial como 0 para o aspect-ratio funcionar */
			    padding-bottom: 56.25%; /* proporção 16:9 (ou 9:16 para retrato) */
			    overflow: hidden; /* esconder a parte da imagem que exceder a div */
			}
			.img_receita img {
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
			#btnAddUsuario {	
				border: none;						
				color: #FFFFFF;				
				border-radius: 40px;
				transition: 0.2s;
				cursor: pointer;			
				transition: 0.2s;
				font-size: 15px;
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
			#btnAddCarrinho {	
				border: none;						
				color: #FFFFFF;								
				transition: 0.2s;
				cursor: pointer;			
				transition: 0.2s;
				font-size: 20px;
			}	
			html {
			  scroll-behavior: smooth;
			  transition-duration: 1.0s;
			}
			
			#modalConfirm, #modalSucessoDesfavoritar, #modalErro {
			  z-index: 9999; /* Valor alto para garantir que fique acima dos outros modais */
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
			carregaReceita('<%=p_cr_id_receita%>');
			carregaListaReceitasSug('<%=p_cr_id_receita%>');
			carregaListaCarrinhodeCompras('<%=cuserid%>');
			
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
		function favoritarReceita(){
			var id = '<%=cuserid%>';
			
			if(id == 0){
				$("#mensagemErro").text('Faça o login para favoritar a receita!');
			    $("#modalErro").modal('show');
			    return false;
			}
			
			var opc_favorito = "";
			var txt = "";
			var cr_id_receita = $("#cr_id_receita").val();
			if(document.getElementById('btnFavoritar').className == 'btn btn-link bi bi-heart'){			
				opc_favorito = "favoritar";
				txt = "favoritada";
			}else{
				opc_favorito = "desfavoritar";
				txt = "desfavoritada";
			}
			
			
			$.postJSON("./jsonservlet",{opc_servlet:'favoritar_receita',opc_favorito:opc_favorito,cr_id_receita:cr_id_receita},
				function(data,status){
					if(data.retorno == -1){
						alert("Erro ao "+opc_favorito+" receita!");						
					}else{
						if(opc_favorito == "favoritar"){
							document.getElementById('btnFavoritar').className = 'btn btn-link bi bi-heart-fill';
						}else if(opc_favorito == "desfavoritar"){
							document.getElementById('btnFavoritar').className = 'btn btn-link bi bi-heart';
						}
						
						$("#mensagemErro").text("Receita "+txt+" com sucesso!");
					    $("#modalErro").modal('show');
					    return false;
					}
				}
			);
		}
			
		function carregaReceita(idrec){
			
			var cr_id_receita = "";
			var cr_titulo_receita = "";
			var cr_ingrediente_receita = "";
			var cr_modo_preparo_receita = "";
			var cr_tempo_preparo_receita = "";
			var cr_rendimento_receita = "";
			var cr_valor_receita = "";
			var cr_receita_view = "";
			var cr_receita_nome_img = "";
			var tamanho_ingrediente = "";
			var tamanho_modo_preparo = "";
			
			if(""!=idrec && "0"!=idrec){
				$.postJSON("./jsonservlet",{opc_servlet:'find_receita',cr_id_receita:idrec},
					function(datalin,statuslin){
						if(datalin){
							cr_id_receita = datalin.cr_id_receita;
							if(cr_id_receita != "0"){								
								cr_titulo_receita = datalin.cr_titulo_receita;
								cr_ingrediente_receita = datalin.cr_ingrediente_receita;
								cr_modo_preparo_receita = datalin.cr_modo_preparo_receita;
								cr_tempo_preparo_receita = datalin.cr_tempo_preparo_receita;
								cr_rendimento_receita = datalin.cr_rendimento_receita;
								cr_valor_receita = datalin.cr_valor_receita;
								cr_receita_view = datalin.cr_receita_view;
								cr_receita_nome_img = datalin.cr_receita_nome_img;	
								tamanho_ingrediente = datalin.tamanho_ingrediente;
								tamanho_modo_preparo = datalin.tamanho_modo_preparo;
							}
						}
						
						//Trazendo Ingredientes em Tópicos abaixo:
						var ingredientes = cr_ingrediente_receita.split("\r\n");
						var listaIngredientes = "<ul style='list-style-type: none; padding-left: 0;'>";
						
						for (var i = 0; i < ingredientes.length; i++) {
						  if (ingredientes[i] !== "") {
						    listaIngredientes += "<li style='margin-bottom: 5px;'><span style='color: #B1463C; font-weight: bold;'>&#8226;</span> " + ingredientes[i] + "</li>";
						  }
						}
						
						listaIngredientes += "</ul>";
						$("#cr_ingrediente_receita").html(listaIngredientes);

						//Trazendo Modo de Preparo:
						var paragrafos = cr_modo_preparo_receita.split("\r\n");
						var modoPreparoHTML = "";						
						for (var i = 0; i < paragrafos.length; i++) {
						  if (paragrafos[i] !== "") {
						    modoPreparoHTML += "<span style='color: #B1463C;  font-weight: bold;'>" + (i + 1) + ".</span> " + paragrafos[i] + "<br>";
						  }
						}						
						$("#cr_modo_preparo_receita").html(modoPreparoHTML);


						$("#cr_id_receita").val(cr_id_receita);
						$("#cr_titulo_receita").html(cr_titulo_receita);											
						//$("#cr_ingrediente_receita").html(cr_ingrediente_receita.replace(/\r\n/g, "<br>"));
						//$("#cr_modo_preparo_receita").html(cr_modo_preparo_receita.replace(/\r\n/g, "<br>"));						
						$("#cr_tempo_preparo_receita").html(cr_tempo_preparo_receita);
						$("#cr_rendimento_receita").html(cr_rendimento_receita);
						$("#cr_valor_receita").html("R$ "+cr_valor_receita);					
						
						var div_image = $("#cr_receita_nome_img");
						
						div_image.append(cr_receita_nome_img);
						
						somaView(idrec, cr_receita_view);
						pintarCoracao(cr_id_receita);
						carregaListaIngredientes(cr_id_receita);						
					}
				);
			}else{								
				$("#cr_id_receita").val("");
				$("#cr_titulo_receita").val("");
				$("#cr_ingrediente_receita").val("");
				$("#cr_modo_preparo_receita").val("");
				$("#cr_tempo_preparo_receita").val("");
				$("#cr_rendimento_receita").val("");
				$("#cr_valor_receita").val("");
					
			}		
		}	
		
		function somaView(id_receita, qtd_view){
			
			$.postJSON("./jsonservlet",{opc_servlet:'soma_receita_view',cr_id_receita:id_receita,cr_receita_view:qtd_view},
				function(data,status){
					if(data.retorno_view != -1){
						console.log("Tudo certo somado mais um na view da receita!");						
					}else{
						console.log("Erro ao somar mais um na view na receita!");
						return false;
					}
				}
			);
		}
	    
		var Num_ingredientes = 0;
	    function carregaListaIngredientes(cr_id_receita) {
		    var num = 1;
		    var div_ingredientes_receita = $(".div_ingredientes_receita");

		    $.postJSON("./jsonservlet",{opc_servlet:'find_receita_ingrediente',cr_id_receita:cr_id_receita}, function(datalin, statuslin) {
		        if (datalin.length > 0) {
		            // Limpa o conteúdo existente dentro da div caso seja chamada novamente
		            div_ingredientes_receita.empty();

		            for (var cx = 0; cx < datalin.length; cx++) {
		                var cr_id_ingrediente = datalin[cx].cr_id_ingrediente;
		                var cr_ingrediente_nome_img = datalin[cx].cr_ingrediente_nome_img;
		            	var cr_desc_ingrediente = datalin[cx].cr_desc_ingrediente;
		            	var cr_valor_ingrediente = datalin[cx].cr_valor_ingrediente;

		                var divContainer = $("<div>").addClass("container align-items-center justify-content-center");
		                var divRow = $("<div>").addClass("row align-items-center justify-content-center").css({
	                	  borderRadius: "10px",
	                	  border: "rgba(99, 111, 97, .4) 1px solid",
	                	  padding: "10px" // Adicione a margem interna desejada aqui
	                	});

		                var inputIdIng = $("<input>").addClass("form-control id_ingrediente_"+num).attr("id", cr_id_ingrediente).attr({type: "hidden"});
		                
		                var divColQtd = $("<div>").addClass("mt-3 col-xl-4 col-lg-4 col-md-4 col-sm-12 col-12 justify-content-center align-items-center")

		                var inputGroup = $("<div>").addClass("input-group mb-3 col-xl-10 col-lg-10 col-md-10 col-sm-12 col-12");
		                var decreaseButton = $("<button>").addClass("btn btn-danger").attr("type", "button").attr("id", "cr_qtd_menos_" + num).append("<i class=\"fas fa-minus\"></i>").click(createMenos( num ));
	                	var increaseButton = $("<button>").addClass("btn btn-danger").attr("type", "button").attr("id", "cr_qtd_mais_" + num).append("<i class=\"fas fa-plus\"></i>").click(createMais( num ));
	                	var inputElement = $("<input>").addClass("form-control").attr({
                		  type: "text",
                		  value: "1",
                		  "aria-label": "",
                		  "aria-describedby": "basic-addon1",
                		  inputmode: "numeric",
                		  pattern: "[0-9]*",
                		  "data-valor": cr_valor_ingrediente, // Adicione o atributo data-valor com o valor do ingrediente
                		}).attr("id", "cr_qtd_receita_" + num).css({
                		  textAlign: "center"
                		}).on("input", function() {
                		  var sanitizedValue = $(this).val().replace(/\D/g, "");
                		  $(this).val(sanitizedValue);
                		});


		                inputGroup.append(
		                  $("<div>").addClass("input-group-prepend").append(decreaseButton),
		                  inputElement,
		                  $("<div>").addClass("input-group-append").append(increaseButton)
		                );

		                divColQtd.append(inputGroup);		               
		                
		                var divColImg = $("<div>").addClass("col-xl-3 col-lg-3 col-md-3 col-sm-12 col-12").attr("id", "cr_ingrediente_nome_img_" + num).css("border-radius", "30px");
		                var divColTitulo = $("<div>").addClass("mt-3 mt-md-0 col-xl-4 col-lg-4 col-md-4 col-sm-10 col-10").attr("id", "cr_desc_ingrediente_" + num).css({
		                    border: "none",
		                    background: "transparent",		                    
		                    textAlign: "left",
		                    fontWeight: "bold",		                    
		                    pointerEvents: "none" // Desabilita eventos de clique
		                });	                		             		              
		                divColTitulo.append("<span style='color: #b1463c; font-size: 20px;'>" + cr_desc_ingrediente + "</span> <br> <span style='font-size: 15px;'>R$ " + cr_valor_ingrediente + "</span>");	
		                
		                var hrElement = $("<hr>").addClass("dashed-hr");		                	                   		                		              
		                
		                divRow.append(divColQtd, divColImg, divColTitulo,inputIdIng);
		                divContainer.append(divRow,hrElement);
		                div_ingredientes_receita.append(divContainer);		              		               
	                    
		                // Adiciona a imagem
		                var imgElement = $(cr_ingrediente_nome_img).css("max-width", "60%");
		                $("#cr_ingrediente_nome_img_" + num).html(imgElement);

		                num++;
		            }		          
		        }else{
		        	div_ingredientes_receita.empty();
		        }
		        AtualizarValorTotalIngrediente();
		        Num_ingredientes = num;
		    });
		}
	    
	    function createMenos(num_input) {
		    return function() {
		    	Menos(num_input);
		    };
		}
	    
	    function createMais(num_input) {
		    return function() {
		    	Mais(num_input);
		    };
		}
	    
	    function Menos(num_input) {
    	  var inputElement = $("#cr_qtd_receita_" + num_input);
    	  var currentValue = parseInt(inputElement.val());
    	  if (currentValue > 0) {
    	    inputElement.val(currentValue - 1);
    	    AtualizarValorTotalIngrediente();
    	  }
    	}

    	function Mais(num_input) {
    	  var inputElement = $("#cr_qtd_receita_" + num_input);
    	  var currentValue = parseInt(inputElement.val());
    	  inputElement.val(currentValue + 1);
    	  AtualizarValorTotalIngrediente();
    	}
    	
    	function AtualizarValorTotalIngrediente() {
   		  var valorTotal = 0;
   		  $("input[id^='cr_qtd_receita_']").each(function() {
   		    var quantidade = parseInt($(this).val());
   		    var valorIngrediente = parseFloat($(this).attr("data-valor").replace(",", ".")); // Substituir vírgula por ponto
   		    valorTotal += quantidade * valorIngrediente;
   		  });
   		  $(".valor_total_ingredientes").text("R$ " + valorTotal.toFixed(2));
   		}
      
    	function addCarrinho() {
			var id = '<%=cuserid%>';			
			if(id == 0){
				$("#modalIngredientes").modal('hide');			
				$("#mensagemErro").text('Faça o login para comprar os ingredientes!');
			    $("#modalErro").modal('show');
			    return false;
			}else{			    	
	    	    $("#modalIngredientes").modal('hide');
	    	    $("#modalCarrinho").modal('show');    
	    	    adicionaIngredientesCarrinho();
			}
    	}
    	
    	    	
    	function adicionaIngredientesCarrinho(){
    		var  cr_id_usuario = '<%=cuserid%>';
    		var  p_cr_id_receita = '<%=p_cr_id_receita%>';
    		var	 arrayIdIngredientes = []; 
    		var	 arrayQtdIngredientes = []; 
		    var num = 1;
		    console.log("Num_ingredientes :: "+Num_ingredientes);    		    	
   			var elemento = "";  
   			var id_ing = "";   			
   			var quantidade_receita = "";   	   			
    		for(var cx = 0; cx < Num_ingredientes; cx++){    			    	
    			if($("#cr_qtd_receita_"+num).val() > 0){
    				//Pegando a quantidade do ingrediente
    				quantidade_receita = $("#cr_qtd_receita_"+num).val();
    				arrayQtdIngredientes.push(quantidade_receita);
    				//console.log(arrayQtdIngredientes.toString());
    				
    				//Pegando o ID do ingrediente
    				elemento = $(".id_ingrediente_" + num);
    				id_ing = elemento.attr("id");    				
    				arrayIdIngredientes.push(id_ing);    				
    				//console.log(arrayIdIngredientes.toString());
        		}
    			num++;
    		}
    		var qtds_ingredientes = arrayQtdIngredientes.toString();
    		var ids_ingredientes = arrayIdIngredientes.toString();
	       	$("#ids_ingredientes").val(ids_ingredientes);	
	       		       	
	       		   
	       	console.log("qtds_ingredientes :: "+arrayQtdIngredientes.length);
	       	if(qtds_ingredientes.length > 0){
		       	$.postJSON("./jsonservlet",{opc_servlet:'insert_carrinho_usuario',cr_id_usuario:cr_id_usuario,p_cr_id_receita:p_cr_id_receita,ids_ingredientes:ids_ingredientes,qtds_ingredientes:qtds_ingredientes},
	       			function(data,status){
						if(data.retorno_insert_car!="-1"){												
								//console.log("Ingredientes adicionados com sucesso!");						
								carregaListaCarrinhodeCompras(cr_id_usuario);
						}else{
								console.log("Problema ao adicionar ingredientes!");	
						}
					}
				);	
	       	}
    	}    
    	
    	function carregaListaReceitasSug(cr_id_receita) {
		    var num = 1;
		    var div_receitas_sugestoes = $(".div_receitas_sugestoes");

		    $.postJSON("./jsonservlet", { opc_servlet: 'list_sugestoes_receitas', cr_id_receita: cr_id_receita }, function(datalin, statuslin) {
		        if (datalin.length > 0) {
		            // Limpa o conteúdo existente dentro da div caso seja chamada novamente
		            div_receitas_sugestoes.empty();

		            for (var cx = 0; cx < datalin.length; cx++) {
		                var cr_id_receita = datalin[cx].cr_id_receita;
		            	var cr_titulo_receita = datalin[cx].cr_titulo_receita;
		                var cr_receita_nome_img = datalin[cx].cr_receita_nome_img;

		                var divContainer = $("<div>").addClass("container");
		                var divRow = $("<div>").addClass("row align-items-center");
		                var divColImg = $("<div>").addClass("col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12").attr("id", "cr_receita_nome_img_" + num).css("border-radius", "10px").click(createVerReceitaFunction(cr_id_receita));;
		                var divColTitulo = $("<div>").addClass("col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12").attr("id", "cr_titulo_receita_" + num).click(createVerReceitaFunction(cr_id_receita));
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
		                    fontSize: "15px",
		                    textAlign: "center",
		                    fontWeight: "bold",
		                    color: "#b1463c",
		                    pointerEvents: "none" // Desabilita eventos de clique
		                }).val(cr_titulo_receita);
		                divColTitulo.append(inputTitulo);
		                
		                divRow.append(divColImg, divColTitulo);
		                divContainer.append(divRow);
		                div_receitas_sugestoes.append(divContainer);

		                // Adiciona um HR pontilhado
		                if (cx < datalin.length - 1) {
		                    var hrElement = $("<hr>").addClass("dashed-hr");
		                    div_receitas_sugestoes.append(hrElement);
		                }

		                // Adiciona a imagem
		                var imgElement = $(cr_receita_nome_img).css({
						  "max-width": "100%",
						  "border-radius": "10px"
						});
		                $("#cr_receita_nome_img_" + num).html(imgElement);

		                num++;
		            }
		        }else{
		        	div_receitas_sugestoes.empty();
		        }

		    });
		}
    	
		function createVerReceitaFunction(idReceita) {
		    return function() {
		    	verReceita(idReceita);
		    };
		}
		
		function verReceita(cr_id_receita){									
			$("#cr_id_receita").val(cr_id_receita);
			$("#frmreceita").submit();		
		}		
    	
    	
	</script>
	

	<body>
	<div id="topo_invisivel" class="topo_invisivel"></div>	
	<%=MenuUtils.buildMenu("receita", cru)%>
									
	<form id="frmreceita" name="frmreceita" method="post" action="cr_receita.jsp">
		<input type="hidden" id="cr_id_receita" name="cr_id_receita"/>
	</form>									
	<form id="frm_tela_receita" name="frm_tela_receita" method="post" action="cr_lista_receitas.jsp">
			<input type="hidden" id="cr_id_receita" name="cr_id_receita" value="0"/>
			<input type="hidden" id="ids_ingredientes" name="ids_ingredientes" value="0"/>
			<input type="hidden" id="opc_servlet" name="opc_servlet" value="salva_receita"/>
			
		<div class="container" style="margin-top: 100px">					
			<div class="row mt-3">			
				<!-- Titulo da Receita -->
				<div class="col-xl-7 col-lg-7 col-md-7 col-sm-9 col-9" style="padding-top:2%;">																												
					<div id="cr_titulo_receita" class="visual_tit_rec"></div>					
				</div>
				
				<!-- Icone da Receita -->
				<div class="col-xl-1 col-lg-1 col-md-1 col-sm-1 col-1">
					<div class="btn btn-link bi bi-heart" id="btnFavoritar" style="color: #b1463c;font-size:50px; border:none;" onclick="favoritarReceita();"></div>
				</div>							
			</div>
			
			<div class="row justify-content-between mt-1">
				<!-- Imagem da Receita -->
				<div class="col-xl-8 col-lg-8 col-md-8 col-sm-12 col-12"> 
					<div class="img_receita" id="cr_receita_nome_img" style="border-radius: 20px;"></div>		
				</div>	
							
				<!-- Div de sugestão a ser implementado -->
				<div class="sugestao" style="border-radius: 20px; border: rgba(99, 111, 97, .4) 1px solid; width: 300px;">
					<label for="cr_rendimento_receita" style="padding: 10px; font-size: 20px; font-weight: bold; color: #b1463c;">
						<strong>Sugestões:</strong>						
					</label> 
					<div class="div_receitas_sugestoes col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">				
					</div>
				</div>
			</div>
			
			<div class="row mt-3 justify-content-md-center text-center col-xl-8 col-lg-8 col-md-8 col-sm-12 col-12">		
				<div class="mt-3 col-xl-4 col-lg-4 col-md-4 col-sm-12 col-12 text-center">
					<label for="cr_rendimento_receita" style="font-size: 20px; font-weight: bold; color: #b1463c;">
						<strong><i class="fas fa-utensils"></i> Rendimento</strong>
					</label> 								
					<div class="cr_rendimento_receita" id="cr_rendimento_receita" style="font-size: 18px;">	
					</div> 
				</div>
				
				<!-- Tempo de preparo da Receita -->
			 	<div class="mt-3 col-xl-4 col-lg-4 col-md-4 col-sm-12 col-12 text-center">
					<label style="font-size: 18px; font-weight: bold; color: #b1463c;"><strong><i class="fas fa-clock"></i> Tempo de Preparo </strong></label>					
					<div class="cr_tempo_preparo_receita" id="cr_tempo_preparo_receita" style="font-size: 18px;">	
					</div> 					
				</div>
				
				<!-- Valor da Receita -->
			 	<div class="mt-3 col-xl-4 col-lg-4 col-md-4 col-sm-12 col-12 text-center">
					<label for="cr_valor_receita" style="font-size: 18px; font-weight: bold; color: #b1463c;">
						<strong><i class="fas fa-dollar-sign"></i> Custo Médio</strong>
					</label> 					
					<div class="cr_valor_receita" id="cr_valor_receita" style="font-size: 18px;">	
					</div> 								
				</div>
		   </div>
			
			<!-- Ingredientes da Receita -->
			<div class="row mt-3 justify-content-between">			
				<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">						
					<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">		
						<label for="cr_ingrediente_receita" style="font-size: 20px; font-weight: bold; background: #FFFFFF; color: #b1463c;">
							<strong>Ingredientes</strong>
						</label>					
						<div class="cr_ingrediente_receita" id="cr_ingrediente_receita" style="font-size: 18px;">	
						</div>													 				
					</div>										
				</div>			
			</div>

			<!-- Modo de preparo da Receita -->
			<div class="row mt-3 justify-content-between">			
				<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">				
					<div class="mt-3 justify-content-md-center">
						<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">	
							<label for="cr_modo_preparo_receita" style="font-size: 20px; font-weight: bold; color: #b1463c;">
								<strong>Modo de preparo</strong>
							</label> 						
							<div class="cr_modo_preparo_receita" id="cr_modo_preparo_receita" style="font-size: 18px;">	
							</div>
						</div>				
					</div>					
				</div>				
			</div>
			
			<!-- Modo de preparo da Receita -->
			<div class="row mt-3 d-flex justify-content-end">
			  <div class="col-xl-4 col-lg-4 col-md-4 col-sm-12 col-12 ml-auto text-right">	
			    <button type="button" class="btn btn-lg btn-block" data-toggle="modal" id="btnCompra" data-target="#modalIngredientes" style="padding-top:10px; padding-bottom:10px; padding-left:50px; padding-right:50px; background-color: #e97500;">
			     	<strong><i class="fas fa-shopping-basket"></i> Comprar Ingredientes</strong>
			    </button>
			  </div>												
			</div>
 			<br>		 	
 			
	 		<!-- MODAL INGREDIENTES -->
			<div class="modal fade bd-example-modal-lgmodal fades" id="modalIngredientes" tabindex="-1" role="dialog" aria-labelledby="Modal" aria-hidden="true">
				<div class="modal-dialog modal-lg modal-dialog-centered modal-notify modal-info modal-fluid 1" role="document">
					<div class="modal-content" style="display: flex; flex-wrap: wrap;">
						<div class="modal-header" style="border: none;">
							<div class="row col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12 justify-content-center text-center">																																												
								<h2 class="modal-title" id="ModalTitle" style="margin-left: 8px; margin-right: 8px; font-weight: 800; color: #e97500;">Ingredientes</h2>								
							</div>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Fechar">
								<span aria-hidden="true"><i class="fas fa-times"></i></span>
							</button>
						</div>
										
						<div class="modal-body justify-content-center" style="display: flex; flex-wrap: wrap;">
							 <div class="div_ingredientes_receita row justify-content-center text-center col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">				
							 </div>
							 <div class="div_ingredientes_receita_total row justify-content-center text-center col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">  
								 <div class="container align-items-center justify-content-center">																											
									<h4 class="modal-title" id="ModalTitle" style="margin-left: 8px; margin-right: 8px; font-weight: 800; color: #B1463C;">Valor Total:</h4>
									<div class="valor_total_ingredientes" style="font-size: 20px; font-weight: 800;"></div>
								</div>									   								
								<hr class="dashed-hr">		 
							</div> 										
   						</div>
   												
						<div class="modal-footer justify-content-center text-center" style="border: none;">														
							<button type="button" class="btn btn-lg btn-block" id="btnAddCarrinho" style="padding-top:10px; padding-bottom:10px; padding-left:50px; padding-right:50px; background-color: #e97500;" onclick="javascript:addCarrinho();"><strong>Adicionar ao Carrinho <i class="fas fa-cart-plus"></i></strong></button>							
						</div>
					</div>
				</div>
			</div>
		</div>			
					
		<div id="div_loading">
			<div class="row h-100">
				<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12 align-self-center" align="center">
					<strong>Processando solicitação... &nbsp;</strong>
					<div class="spinner-border text-primary ml-auto" role="status"
						aria-hidden="true"></div>
				</div>
			</div>
		</div>
	</form>	
		<!-- Modal de mensagem de tratamento de Alerta -->
		<div class="modal fade" id="modalErro" tabindex="-1" role="dialog" aria-labelledby="modalErroLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header text-white" style="background-color:#636f61;">
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
		        <button type="button" class="btn btn-dark" id="btnSimConfirm" value="0" onclick="ApagarIngredienteCarrinho(this.value)">Sim</button> 
		      </div> 
		    </div> 
		   </div> 
		 </div> 			
	  <footer class="bg-dark text-light">	    
	    <div class="text-center" style="background-color: #636f61; padding: 20px;margin-top: 5px" >
	      &copy 2023 Copyright: <a href="#" style="color:white">Cozinha Rapida</a>
	    </div>
	  </footer>
</body>
</html>
