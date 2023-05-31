package projeto.email;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;

import javax.mail.*; 

import org.json.JSONObject;
import projeto.util.Cast;
import projeto.util.EmailHelperEsqSenha;
import projeto.util.FormatUtils;
import projeto.util.ProjetoDatabase;
import projeto.util.StringUtils;
import java.util.Calendar;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.text.Normalizer;

import projeto.util.AppSecrets;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;



public class EmailReciboIngredientes {
	boolean DEBUG_MODE = AppSecrets.DEBUG_MODE;
	String URL_SISTEMA = AppSecrets.EMAIL_URL;
	String query = "";
	String msgRetorno = "";
	
	public void EmailReciboIngredientes() {
		
	}
	
	public String EmailReciboIngredientes(String email){
		
		msgRetorno += "Email está chegando aqui : "+email+ " \n ";	

		return msgRetorno;
	}

    public static String convertToHtml(String str) {
        // Normaliza a string para remover as variações dos caracteres especiais
        String normalized = Normalizer.normalize(str, Normalizer.Form.NFD);
        // Substitui todos os caracteres especiais pelos seus códigos em HTML correspondentes
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < normalized.length(); i++) {
            char c = normalized.charAt(i);
            if (c < 128) {
                sb.append(c);
            } else {
                sb.append("&#x");
                sb.append(Integer.toHexString((int) c));
                sb.append(";");
            }
        }
        return sb.toString();
    }
	
	public void enviarRecibo(String email, String nomeusuario, int id_usuario) {
		String idsSql = " SELECT " +
						" cr_carrinho.cr_id_carrinho, " +
						" cr_carrinho.cr_id_usuario, " +
						" cr_carrinho.cr_id_receita, " +
						" cr_carrinho.cr_id_ingrediente, " +
						" cr_carrinho.cr_quantidade, " +
						" cr_carrinho.cr_valor_ingrediente, " +
						" cr_carrinho.cr_valor_total, " +
						" cr_ingredientes.cr_desc_ingrediente, " +
						" cr_usuario.cr_cep_usuario, " +
						" cr_usuario.cr_endereco_usuario, " +
						" cr_usuario.cr_nrmcasa_usuario, " +
						" cr_usuario.cr_endcomplemento_usuario, " +
						" cr_usuario.cr_pontoreferencia_usuario " +
						" FROM cr_carrinho " +
						" left outer join cr_ingredientes on cr_ingredientes.cr_id_ingrediente = cr_carrinho.cr_id_ingrediente " +
						" left outer join cr_usuario on cr_usuario.cr_id_usuario = cr_carrinho.cr_id_usuario " +
						" where cr_carrinho.cr_id_usuario = "+id_usuario;
		
		System.out.println("query: "+idsSql);
		try {
			String cr_cep_usuario = "";
			String cr_endereco_usuario = "";
			String cr_nrmcasa_usuario = "";
			String cr_endcomplemento_usuario = "";
			String cr_pontoreferencia_usuario = "";			
			
			Connection c = ProjetoDatabase.getConnection();
			PreparedStatement p = c.prepareStatement(idsSql);
			ResultSet rs = p.executeQuery();
			List<List> listaDados = new ArrayList<List>();
			while(rs.next()) {
				List dados = new ArrayList();
				int cr_id_carrinho = null!=rs.getObject(1)?rs.getInt(1):0;
				int cr_id_usuario = null!=rs.getObject(2)?rs.getInt(2):0;
				int cr_id_receita = null!=rs.getObject(3)?rs.getInt(3):0;
				int cr_id_ingrediente = null!=rs.getObject(4)?rs.getInt(4):0;
				String cr_quantidade = null!=rs.getObject(5)?rs.getString(5):"";
				String cr_valor_ingrediente = null!=rs.getObject(6)?FormatUtils.formataValorDigitos(rs.getBigDecimal(6),2):"";
				BigDecimal cr_valor_total = null!=rs.getObject(7)?rs.getBigDecimal(7):BigDecimal.ZERO;
				String cr_desc_ingrediente = null!=rs.getObject(8)?rs.getString(8):"";
				cr_cep_usuario = null!=rs.getObject(9)?rs.getString(9):"";
				cr_endereco_usuario = null!=rs.getObject(10)?rs.getString(10):"";
			    cr_nrmcasa_usuario = null!=rs.getObject(11)?rs.getString(11):"";
				cr_endcomplemento_usuario = null!=rs.getObject(12)?rs.getString(12):"";
				cr_pontoreferencia_usuario = null!=rs.getObject(13)?rs.getString(13):"";
							
				dados.add(cr_quantidade);				
				dados.add(cr_desc_ingrediente);
				dados.add(cr_valor_total);
				listaDados.add(dados);				
			}
			
			//if(!listaDados.isEmpty()) {
				envioEmailReciboIngredientes(listaDados, email, nomeusuario, id_usuario,cr_cep_usuario, cr_endereco_usuario,
											 cr_nrmcasa_usuario,cr_endcomplemento_usuario,cr_pontoreferencia_usuario);
				//System.out.println(listaDados);
				Thread.sleep(5000);					
			//}			
			
			if(null!=rs) {
				rs.close();
				rs=null;
			}
			if(null!=p) {
				p.close();
				p=null;
			}										
			if(null!=c) {
				c.close();
				c=null;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public String envioEmailReciboIngredientes(List listaDados, String email, String nomeusuario, int id_usuario, String cr_cep_usuario, 
												String cr_endereco_usuario,String cr_nrmcasa_usuario,String cr_endcomplemento_usuario,String cr_pontoreferencia_usuario) {
		
		int indiceEspaco = nomeusuario.indexOf(" ");			
		nomeusuario = (indiceEspaco != -1) ? nomeusuario.substring(0, indiceEspaco) : nomeusuario;

		String htmlEmail = "";										
						
		String assunto = "Cozinha Rápida - Recibo de Ingredientes";										
						
		
		String htmlEmailIni =   "<html> " +
								"	<head> " +
									"<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'> " +
								"</head> " +
								"	<style>" +
								"		table {" +
								"			border-collapse: collapse;" +
								"			width: 100%;" +
								"		}" +
								"		th, td {" +
								"			text-align: center;" +
								"			padding: 8px;" +
								"			border-bottom: 1px solid #ddd;" +
								"		}" +
								"		th {" +
								"			background-color: #ff7f00;" +
								"			color: white;" +
								"		}" +
								"		tr:hover {" +
								"			background-color: #f5f5f5;" +
								"		}" +
								"	</style>" ;
				
		String htmlCorpo =      " <body> " +
								" <div text-align=\"center\"> " +
								" 	<img width=\"100%\" src='cid:image'/> " +
								"   <p style=\"margin:20px 0px 5px 0px; font-size: 18px;\">Ol&aacute; <span style=\"color: #ff7f00;\"><b>"+nomeusuario+"</b></span>, segue abaixo o recibo com os ingredientes:</p> " +
								"   <h2 style=\"margin-top:25px; border-bottom: 1px solid #d6d8db; text-align: center; color: #ff7f00;\"> Recibo de Ingredientes</h2> " +
								" </div>" +
								"     <table> " +
								" 		<thead> " +
								"			<tr>" +
								"				<th width=\"10%\">Quantidade</th>" +
								"				<th width=\"15%\">Descrição</th>" +
								"				<th width=\"20%\">Valor Total Ingrediente</th>" +
								"			</tr>" +
								"		</thead>" +
								" 			<tbody> " ;
				
				Iterator<List> itDados = listaDados.iterator();
				BigDecimal valor_total_recibo = BigDecimal.ZERO;
				while (itDados.hasNext()) {
				List listDados = itDados.next();
				String cr_quantidade = null!= listDados.get(0) ? Cast.toString(listDados.get(0)) :"";
				String cr_desc_ingrediente = null!= listDados.get(1) ? Cast.toString(listDados.get(1)) :"";
				String cr_valor_total = null!= listDados.get(2) ? FormatUtils.formataValorDigitos(listDados.get(2),2) :"";
				
				valor_total_recibo = valor_total_recibo.add(Cast.toBigDecimal(cr_valor_total));
					
				htmlCorpo+=		"									 <tr> " +
					    		"                                        <td style=\"text-align:center;\">"+cr_quantidade+"</td>" +
					    		"                                        <td style=\"text-align:center;\">"+cr_desc_ingrediente+"</td>" +
					    		"                                        <td style=\"text-align:center;\">R$ "+cr_valor_total+"</td>" +
								"									</tr> " ;
				}
					
				htmlCorpo +=	"                                  </tbody> " +							
								"                            </table> " +
								" <div text-align=\"center\"> " +
								" 	<h3 style=\"padding-bottom:20px; font-size:20px; text-align: center;\"><strong>Valor Total Recibo:</strong> <span style=\"color: #ff7f00;\"> R$ "+FormatUtils.formataValorDigitos(valor_total_recibo, 2)+"</span></h3> "+
								" </div>" ;
				
		String htmlEmailFim =	"	</body>" +
								"</html>";


		
					htmlEmail = convertToHtml(htmlEmailIni+htmlCorpo+htmlEmailFim);
										
					String opcEnvio = "cr@cr.com.br";
					
					try {
						assunto = java.net.URLDecoder.decode(assunto,"UTF-8");						
					} catch (UnsupportedEncodingException e1) {
						e1.printStackTrace();
						msgRetorno = "Erro cód. 03:"+e1;						
					}
					final String assuntoMail = assunto;
					final String htmlEmailMail = htmlEmail;
					final String emaildestino = email;
					//final String emaildestino = email;
					/*
					if(DEBUG_MODE) {
						emaildestino = "suporte@r1ti.com.br,elciogoesjr@gmail.com";
					}else {
						emaildestino = email;
					}
					*/					
					Thread t = new Thread() {
						@Override
						public void run() {							
							try {
								EmailHelperEsqSenha em = new EmailHelperEsqSenha(opcEnvio);
								if(DEBUG_MODE) {									
									em.addDest(email);	
								}else {
									if(emaildestino.contains(",")) {
										String[] aFindCols = emaildestino.split(",");
										for(String coluna:aFindCols) {
											em.addDest(coluna);
										}
									}else {
										em.addDest(emaildestino);										
									}
									//em.addDestCopiaOculta("arthur.arthur10@outlook.com");	
									//em.addDestCopiaOculta("erickgamerh2o@gmail.com");	
									//em.addDestCopiaOculta("gabriela.gomes9528@gmail.com");	
								}
								em.enviaHTML(assuntoMail, htmlEmailMail);
								
							}catch (Exception e) {
								// TODO Auto-generated catch block
								e.printStackTrace();	
								msgRetorno = "Erro cód. 04:"+e;								
							}							
						}						
					};
					t.start();		
					//msgRetorno = "Deu certo!";
					msgRetorno = apagaCarrinhoUsuario(id_usuario);
		
		return msgRetorno;
	}
	
	
	public String apagaCarrinhoUsuario(int id_usuario) {
		String retorno = "";
		
		String delSql = "DELETE FROM cr_carrinho WHERE cr_id_usuario = "+id_usuario;

		try {
			Connection c = ProjetoDatabase.getConnection(); // c = Connection.
			PreparedStatement ps = c.prepareStatement(delSql);						
			ps.executeUpdate();
			if(null!=ps) {
				ps.close();
				ps=null;
			}			
			if(null!=c) {
				c.close();
				c=null;
			}
			
			System.out.println("Finalizado Compra, e apagado itens do carrinho do Usuário. SQL :: "+delSql);
		}catch(Exception e) {
			e.printStackTrace();
			retorno = "Erro cód. 05:"+e;
		}
		
		return retorno;
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		EmailReciboIngredientes ees = new EmailReciboIngredientes();		
		
		ees.enviarRecibo("arthur.arthur10@outlook.com","Arthur Soares da Silva", 6);
		

	}
	
}