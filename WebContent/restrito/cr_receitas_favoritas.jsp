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
	
	//System.out.println("VENDO O ID DO USU�RIO :: "+cuserid);
			
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
		<title>Cozinha R�pida - Receita Favoritas</title>
		<link href="../css/bootstrap.min.css" rel="stylesheet">
		<link href="../fontawesome/css/all.min.css" rel="stylesheet">
		<link href="../css/bootstrap-datepicker.css" rel="stylesheet"/>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
		<script type="text/javascript" src="../js/jquery-3.3.1.js"></script>
		<script type="text/javascript" src="../js/bootstrap.min.js"></script>
		<script type="text/javascript" src="../fontawesome/js/all.min.js"></script>
		<script type="text/javascript" src="../js/bootstrap-autocomplete.js"></script>
		<script type="text/javascript" src="../js/popper.js"></script>
		<script src="../js/bootstrap-datepicker.min.js"></script>
		<script src="../js/bootstrap-datepicker.pt-BR.min.js"></script>
		<!-- <script src="../js/jquery.maskMoney.min.js" type="text/javascript"></script>       
		 data-thousands="." data-decimal="," data-prefix="R$ "  -->
		
		<!-- Data Tables -->
		<script src="../js/datatables/jquery.dataTables.min.js"></script>
		<script src="../js/datatables/dataTables.bootstrap4.min.js"></script>
		<script src="../js/datatables/dataTables.fixedHeader.min.js"></script>
		<script src="../js/datatables/dataTables.responsive.min.js"></script>
		<script src="../js/datatables/responsive.bootstrap.min.js"></script>

		<link rel="stylesheet" href="../css/datatables/dataTables.bootstrap4.min.css">
		<link rel="stylesheet" href="../css/datatables/fixedHeader.bootstrap4.min.css">
		<link rel="stylesheet" href="../css/datatables/responsive.bootstrap.min.css">
		<!-- Final Data Tables -->
		<style type="text/css">
			select[readonly] {
			  background: #eee; /*Simular campo inativo - Sugest�o @GabrielRodrigues*/
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
				font-size: 40px;			
				font-weight: 800;
				font-family: 'Open Sans', sans-serif;
				color: #b1463c;
			}
			
			
			.divpadrao{
				border: rgba(99, 111, 97, .4) 1px solid;
				height:100px;
				padding: 5px;				
			}
			
			@media(max-width: 1000px) {
    			.sugestao {
        			display: none;
    			}
			}
			
			.img_receita {
			    position: relative; /* definir posi��o relativa para que a imagem possa ser centralizada verticalmente */
			    height: 0; /* definir altura inicial como 0 para o aspect-ratio funcionar */
			    padding-bottom: 20%; /* propor��o 16:9 (ou 9:16 para retrato) */
			    overflow: hidden; /* esconder a parte da imagem que exceder a div */
			}
			
			.img_receita iframe {
			    position: absolute; /* definir posi��o absoluta para a imagem ficar no topo */
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
			
			footer {
			    position: absolute;
			    bottom: 0;			    			    
			    width: 100%;			      
			    text-align: center;		
			    background-color: #636f61; 
			    padding: 20px;	    
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
			
			carregaListaReceitasFav('<%=cuserid%>');
			
			//Isto est� definido diretamente no nosso <select> e tem o objetivo de carregar as poss�veis op��es do nosso autocomplete
			//data-url='./jsonservlet?opc_servlet=sel_pesquisa_receita'
			//Implementando componente de AUTOCOMPLETE em um <select com o ID = "sel_receita"
			$('#sel_receita').autoComplete({
			  // configura��es do autocomplete aqui
			  noResultsText: 'Nenhum resultado encontrado'
			});
			//O AUTOCOMPLETE cont�m um evento que � chamado ao selecionarmos uma linha dele = 'autocomplete.select'
			$('#sel_receita').on('autocomplete.select', function (evt, item) {
				//ITEM � o item em espec�fico que selecionamos do nosso autocomplete (possui as propriedades relativas a aquela linha)
				//item.text e item.value
				//Checa se foi selecionada uma LINHA e se ela EXISTE
				console.log('Passei evt :: '+evt+' -- item.value :: '+item.value+' -- item.text :: '+item.text);
				if(item){										
					//CHAMANDO outra URL para buscar os dados espec�ficos do CLIENTE que selecionamos
					//$.getJSON( "./jsonservlet?opc_servlet=find_pesquisa_receita&q="+item.value, function( data ) {
						
					var cr_id_receita = "";
					//TENTANDO OUTRA FORMA DE CHAMAR
					$.getJSON("../jsonservlet",{opc_servlet:'find_receita',cr_id_receita:item.value}, 
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
				$.postJSON("../jsonservlet",{opc_servlet:'pintar_coracao',cr_id_receita:cr_id_receita},
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
			
		//Fun��o do efeito favotitar receita no icone Hearth
		function favoritarReceita(){
			var id = '<%=cuserid%>';
			
			if(id == 0){
				alert("Fa�a o login antes de prosseguir!");
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
			
			
			$.postJSON("../jsonservlet",{opc_servlet:'favoritar_receita',opc_favorito:opc_favorito,cr_id_receita:cr_id_receita},
				function(data,status){
					if(data.retorno == -1){
						alert("Erro ao "+opc_favorito+" receita!");						
					}else{
						if(opc_favorito == "favoritar"){
							document.getElementById('btnFavoritar').className = 'btn btn-link bi bi-heart-fill';
						}else if(opc_favorito == "desfavoritar"){
							document.getElementById('btnFavoritar').className = 'btn btn-link bi bi-heart';
						}
						alert("Receita "+txt+" com sucesso!");
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
				$.postJSON("../jsonservlet",{opc_servlet:'find_receita',cr_id_receita:idrec},
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
						$("#cr_id_receita").val(cr_id_receita);
						$("#cr_titulo_receita").text(cr_titulo_receita);
						$("#cr_titulo_receita").val(cr_titulo_receita);
						$("#cr_ingrediente_receita").val(cr_ingrediente_receita);
						$("#cr_modo_preparo_receita").val(cr_modo_preparo_receita);
						$("#cr_tempo_preparo_receita").val(cr_tempo_preparo_receita);
						$("#cr_rendimento_receita").val(cr_rendimento_receita);
						$("#cr_valor_receita").val("R$ "+cr_valor_receita);
						$("#cr_ingrediente_receita").attr("rows",tamanho_ingrediente);
						$("#cr_modo_preparo_receita").attr("rows",tamanho_modo_preparo);
						
						var div_image = $("#cr_receita_nome_img");
						
						div_image.append(cr_receita_nome_img);
						
						somaView(idrec, cr_receita_view);
						pintarCoracao(cr_id_receita);
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
			
			$.postJSON("../jsonservlet",{opc_servlet:'soma_receita_view',cr_id_receita:id_receita,cr_receita_view:qtd_view},
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
		
		function carregaListaReceitasFav(cuserid){			
			$.postJSON("../jsonservlet",{opc_servlet:'list_receitas_favoritas',cuserid:cuserid},
				function(datalin,statuslin){
					if(datalin.length > 0){
						for(var cx=0;cx<datalin.length;cx++){
							var cr_id_receita = datalin[cx].cr_id_receita;
							var cr_titulo_receita = datalin[cx].cr_titulo_receita;
							var cr_desc_receita = datalin[cx].cr_desc_receita;
													
													
							var arrayRow = [];
			                arrayRow.push(cr_id_receita);
							arrayRow.push(cr_titulo_receita);
							arrayRow.push("<i class='fas fa-edit' onclick='carregaReceita(\""+cr_id_receita+"\")'> </i>");
							arrayRow.push("<i class='fas fa-trash' onclick='apagaReceita(\""+cr_id_receita+"\")'> </i>");
							table.row.add(arrayRow).draw();
						}
					}
				}
			);
		}	
	</script>

	<body>		
	<%=MenuUtils.buildMenu("receita", cru, "S")%>
									
	<form id="frmreceita" name="frmreceita" method="post" action="/projeto-tcc-cozinha-rapida/restrito/cr_receita.jsp">
		<input type="hidden" id="cr_id_receita" name="cr_id_receita"/>
	</form>									
	<form id="frm_tela_receita" name="frm_tela_receita" method="post" action="cr_lista_receitas.jsp">
			<input type="hidden" id="cr_id_receita" name="cr_id_receita" value="0"/>
			<input type="hidden" id="opc_servlet" name="opc_servlet" value="salva_receita"/>
			
		<div class="container" style="margin-top: 100px">					
			<div class="row">							
				<div class="col-xl-6 col-lg-6 col-md-8 col-sm-8 col-8" style="height: 100px; text-align:left;">
					<div class="row mt-3 justify-content-center">																									
						<div class="visual_tit_rec">Receitas Favoritas</div>
					</div>	
				</div>													
			</div>	
			<div class="row mt-3 justify-content-md-center text-center col-xl-8 col-lg-8 col-md-8 col-sm-12 col-12">	
				<!-- Imagem receita favorita -->	
				<div class="col-xl-4 col-lg-4 col-md-4 col-sm-12 col-12 text-center">							
					<div class="img_receita" id="cr_receita_nome_img"></div>
				</div>
				
				<!-- Titulo receita favorita -->
			 	<div class="col-xl-6 col-lg-6 col-md-6 col-sm-12 col-12 text-center">					
					<input disabled type="text" class="form-control" name="cr_titulo_receita" id="cr_titulo_receita" 
					style="border:none; background: #FFFFFF; font-size: 18px; text-align: center; font-weight: bold; color: #b1463c;">					
				</div>
				
				<!-- Desfavoritar receita -->
			 	<div class="col-xl-2 col-lg-2 col-md-2 col-sm-12 col-12 text-center">
					<div class="btn btn-link bi bi-heart" id="btnFavoritar" style="color: #b1463c;font-size:50px; border:none;" onclick="desfavoritarReceita();"></div>								
				</div>
		   </div>			
	 	</div>
	</form>		
			
  	<footer class="text-light">	        	
   	 	&copy 2023 Copyright: <a href="#" style="color:white">Cozinha Rapida</a>    	
  	</footer>
</body>
</html>
