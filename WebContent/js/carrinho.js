
	var id_usuario_global = 0;		
	var valor_total_carrinho_global = 0;
	function carregaListaCarrinhodeCompras(cr_id_usuario) {    
			id_usuario_global = cr_id_usuario;
		    var div_carrinho_compra = $(".div_carrinho_compra");
		    var valor_total_carrinho_compra = $(".valor_total_carrinho_compra");		    
		    var num = 1;
		    var valorTotalCarrinho = 0;
		    var valorTotalIngrediente = 0;		    
		    
		    $.postJSON("./jsonservlet",{opc_servlet:'find_carrinho_usuario',cr_id_usuario:cr_id_usuario}, function(datalin, statuslin) {
			 	div_carrinho_compra.empty();
		    	if (datalin.length > 0) {
					valor_total_carrinho_global = 1;
		            // Limpa o conteúdo existente dentro da div caso seja chamada novamente
		            div_carrinho_compra.empty();
		            valor_total_carrinho_compra.empty();
					var cr_qtd_receita = $("#cr_qtd_receita_"+num).val;		            		          		           
		            for (var cx = 0; cx < datalin.length; cx++) {		            			           		            	
		            	var cr_id_carrinho = datalin[cx].cr_id_carrinho;
		                var cr_id_ingrediente = datalin[cx].cr_id_ingrediente;
		                var cr_quantidade = datalin[cx].cr_quantidade;
		            	var cr_desc_ingrediente = datalin[cx].cr_desc_ingrediente;
		            	var cr_valor_total = datalin[cx].cr_valor_total;
		
		                var divContainer = $("<div>").addClass("container align-items-center justify-content-center");
		                var divRow = $("<div>").addClass("row align-items-center justify-content-center").css({
		            	  borderRadius: "10px",
		            	  border: "rgba(99, 111, 97, .4) 1px solid",
		            	  padding: "10px" // Adicione a margem interna desejada aqui
		            	});		               
		                
		                var divColQtd = $("<div>").addClass("mt-3 mt-md-0 col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3 justify-content-center align-items-center")		             		              
		                var inputElement = $("<div>").addClass("circulo");		                
		                inputElement.append("<strong>"+cr_quantidade+"</strong>");		                
		                divColQtd.append(inputElement);
		                
		                var divColTitulo = $("<div>").addClass("mt-3 mt-md-0 col-xl-7 col-lg-7 col-md-7 col-sm-7 col-7").attr("id", "cr_desc_ingrediente_" + num).css({
		                    border: "none",
		                    background: "transparent",		                    
		                    textAlign: "left",
		                    fontWeight: "bold",		                    
		                    pointerEvents: "none" // Desabilita eventos de clique
		                });	                		             		              
		                divColTitulo.append("<span style='color: #fff; font-size: 20px;'>" + cr_desc_ingrediente + "</span> <br> <span style='font-size: 15px; color:#fff;'>R$ " + cr_valor_total + "</span>");	
		                
		                var divColTrash = $("<div>").addClass("col-xl-1 col-lg-1 col-md-1 col-sm-1 col-1 justify-content-center align-items-center").attr("id", "cr_trash_" + num);
		                var divIcon = $("<div>").addClass("div_icon btn btn-link");
		                var trashIcon = $("<i>").addClass("fas fa-trash-alt").css({
		                  color: "#fff",		                  
		                });
		
		                divIcon.append(trashIcon);		                
		                divColTrash.append(divIcon);
		                
		                divIcon.click(createApagarIngredienteFunction(cr_id_carrinho));
		                
		                valorTotalIngrediente = parseFloat(cr_valor_total.replace(",", ".")); // Substituir vírgula por ponto
		                //console.log("valorTotalIngrediente :: "+valorTotalIngrediente);
		                
		                valorTotalCarrinho = valorTotalCarrinho + valorTotalIngrediente; 
		                //console.log("valorTotalCarrinho :: "+valorTotalCarrinho);
		                
		                var hrElement = $("<hr>").addClass("dashed-hr");		                	                   		                		              
		                
		                divRow.append(divColQtd, divColTitulo, divColTrash);
		                divContainer.append(divRow,hrElement);
		                div_carrinho_compra.append(divContainer);	
		                
		                num++;
		            }
		        }else{
					valor_total_carrinho_global = 0;
		        	var divColCarrinhoVazio = $("<div>").addClass("col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12").attr("id", "carrinho_vazio").css({
		                border: "none",
		                background: "transparent",		                    
		                textAlign: "center",
		                fontWeight: "bold",		                    
		                pointerEvents: "none", // Desabilita eventos de clique
		                margin: "35%"
		            });	                		             		              
		        	divColCarrinhoVazio.append("<span style='color: #787878; font-size: 20px;'> Carrinho Vazio.</span>");
		        	
		        	div_carrinho_compra.append(divColCarrinhoVazio);
		        	valor_total_carrinho_compra.empty();
		        }		        
		        valor_total_carrinho_compra.append("R$ "+valorTotalCarrinho.toFixed(2));
		    });
		}
		
		function createApagarIngredienteFunction(cr_id_carrinho) {
		    return function() {
		    	ApagarIngredienteCarrinhoModal(cr_id_carrinho);
		    };
		}  
		
		function ApagarIngredienteCarrinhoModal(cr_id_carrinho){			
			$("#btnSimConfirm").val(cr_id_carrinho);
			$("#mensagemSucessoCarrinho").text('Deseja apagar esse ingrediente do Carrinho?');
		    $("#modalSucessoCarrinho").modal('show');
			return false;		
		}
		
		//Função do efeito favotitar receita no icone Hearth
		function ApagarIngredienteCarrinho(cr_id_carrinho){
			var  cr_id_usuario = id_usuario_global;
			
			$("#modalSucessoCarrinho").modal('hide');
			$.postJSON("./jsonservlet",{opc_servlet:'apaga_ingrediente_carrinho',cr_id_carrinho:cr_id_carrinho},
				function(data,status){
					if(data.ERRO != ""){	
						$("#mensagemErro").text(data.ERRO);
				        $("#modalErro").modal('show');				
					}else{						
						$("#mensagemSucessoCarrinho").text("Ingrediente apagado com sucesso!");
				        $("#modalSucessoCarrinho").modal('show');	
				        carregaListaCarrinhodeCompras(cr_id_usuario)
					}
				}
			);
}	