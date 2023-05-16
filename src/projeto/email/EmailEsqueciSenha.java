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



public class EmailEsqueciSenha {
	boolean DEBUG_MODE = AppSecrets.DEBUG_MODE;
	String URL_SISTEMA = AppSecrets.EMAIL_URL;
	String query = "";
	String msgRetorno = "";
	
	public void EmailEsqueciSenha() {
		
	}
	
	public String EmailEsqueciSenha(String email){
		
		msgRetorno += "Email está chegando aqui : "+email+ " \n ";	

		return msgRetorno;
	}
	
    public static String gerarSenhaAleatoria(int qtdeCaracteres) {
        String[] caracteres = { "a", "1", "b", "2", "4", "5", "6", "7", "8",
                "9", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k",
                "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w",
                "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I",
                "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U",
                "V", "W", "X", "Y", "Z" };
      
        StringBuilder senha = new StringBuilder();

        for (int i = 0; i < qtdeCaracteres; i++) {
            int posicao = (int) (Math.random() * caracteres.length);
            senha.append(caracteres[posicao]);
        }
        return senha.toString();
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

	
	public String envioEmailEsqueciSenha(String email, String nomeusuario) {
		
		int indiceEspaco = nomeusuario.indexOf(" ");			
		nomeusuario = (indiceEspaco != -1) ? nomeusuario.substring(0, indiceEspaco) : nomeusuario;

		String htmlEmail = "";		
		
		String senha = gerarSenhaAleatoria(8);						
						
		String assunto = "Cozinha Rápida - Redefinição de Senha";										
						
		String htmlEmailIni =   "<html> " +
								"<head> " +
									"<meta http-equiv='Content-Type' content='text/html; charset='UTF-8'> " +
								"</head> ";
			String htmlCorpo =  " <body> " +
								"    <div> " +
								"        <center style=\"width: 100%; margin: 0; padding-bottom: 5% !important; background-color: #eeeeee;\"> " +
								"            <table cellspacing=\"0\" width=\"90%\" role=\"presentation\"> " +
								"                <tbody> " +
								"                    <tr> " +
								"                        <td style=\"text-align:center;\"> " ;
				   htmlCorpo += "          		 			<img width=\"100%\" src='cid:image'/>" ;
				   htmlCorpo += "     		  			</td> " +
								"                    </tr> " +
								"                    <tr> " +
								"                        <td style=\"margin:auto; padding: 0; background-color: #ffffff; color:#4a4a4a; border-radius: 4px;\"> " +
								"                            <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" role=\"presentation\" style=\"border-top:5px solid #ff7f00; border-radius: 4px;\"> " +
								"                                <tbody> " +
								"                                    <tr> " +
								"                                        <td style=\"padding: 0 4%;\"> " +
							  //"                                            <h4 style=\"margin-top:25px; padding-bottom:20px; border-bottom: 1px solid #d6d8db; text-align: center;\"> Solicitação de redefinição de senha do email: "+email+"</h4> " +
								"                                            <p style=\"margin:20px 0px 5px 0px; font-size: 20px;\">Olá <b>"+nomeusuario+"</b>, </p> " +
								"                                        </td> " +
								"                                    </tr> " +
								"                                    <tr> " +
								"                                        <td style=\"padding: 0 4%;\"> " +
								//"                                            <p style=\"padding-bottom:20px; font-size:17px\">Segue nova senha para redefinição: <b>"+senha+"</b> </p> " +
								"                                            <p style=\"padding-bottom:20px; font-size:17px\">Recebemos sua solicitação para redefinir a senha da sua conta: <b>"+email+"</b> </p> " +
								"                                            <p style=\"padding-bottom:20px; font-size:17px\">Para redefinir sua senha, siga as instruções abaixo: </p> " +
								"                                            <p style=\"padding-bottom:20px; font-size:17px\">Segue sua nova senha: <b>"+senha+"</b> </p> " +
								"                                            <p style=\"padding-bottom:20px; font-size:17px\">Basta copia-la e ao logar ele irá pedir para definir uma nova senha de acesso. </p> " +
								"                                            <p style=\"padding-bottom:20px; font-size:17px\">Se você não solicitou uma redifinação de senha, por favor, ignore este e-mail.</p> " +
								"                                        </td> " +
								"                                    </tr> <br/><br/>" +
							    "                                    <tr> " +
								"                                        <td style=\"padding: 0 4%;\"> " +							
								"                                            <p style=\"margin-top:25px; padding-bottom:20px; font-size:17px\">Atenciosamente,<br><b>Cozinha Rápida</b></p> " +								
								"                                        </td> " +
								"                                    </tr> <br/><br/>" ;
				   htmlCorpo += "                                </tbody> " +
								"                            </table> " +
								"                        </td> " +
								"                    </tr> " +
								"        </center> " +
								"    </div> <br/>";
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
					msgRetorno = atualizaRecuperaSenha(email, senha);
					//msgRetorno = "Deu certo!";
		
		return msgRetorno;
	}
	
	
	public  String atualizaRecuperaSenha(String email, String senha) {
		String retorno = "";
		String opc_senha_alterada = "S";

		String UPD_SENHA =	" UPDATE cr_usuario SET " +
				    		" cr_senha_usuario = MD5(?), "+	
				    		" cr_senha_alterada = ? "+
				    		" WHERE cr_email_usuario = '"+email+"'";
		
		try {
			Connection co = ProjetoDatabase.getConnection();		
			PreparedStatement ps = co.prepareStatement(UPD_SENHA);			
			ps.setString(1, senha);
			ps.setString(2, opc_senha_alterada);		
			ps.executeUpdate();
			
			if(null!=ps) {
				ps.close();
				ps=null;
			}
			if(null!=co) {
				co.close();
				co=null;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			retorno = "Erro cód. 05:"+e;
		}
				
		
		System.out.println("atualizaSenhaRecuperacao =="+retorno);
		return retorno;
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		EmailEsqueciSenha ees = new EmailEsqueciSenha();		
		
		System.out.println(ees.envioEmailEsqueciSenha("arthur.arthur10@outlook.com","Arthur"));
		

	}
	
}