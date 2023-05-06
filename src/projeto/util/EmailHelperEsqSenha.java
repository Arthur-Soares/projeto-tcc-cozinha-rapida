package projeto.util;


import java.util.ArrayList;
import java.util.Date;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

public class EmailHelperEsqSenha {
	
	private Session session;
    private ArrayList dests = new ArrayList();
    private ArrayList destscc = new ArrayList();
    private ArrayList destscopiaoculta = new ArrayList();
	private InternetAddress from;
	private static String sender;
	private static String passwd;
	
	/*
	 * private static String arquivoenvio;
	 * 
	 * public String getArquivoenvio() { return arquivoenvio; }
	 * 
	 * public void setArquivoenvio(String arquivoenvio) {
	 * System.out.println("arquivoenvio==="+arquivoenvio); this.arquivoenvio =
	 * arquivoenvio; }
	 */
	
	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	
	public EmailHelperEsqSenha(String opcRemetente) throws Exception{
		Properties prop = new Properties();
		pegaCredenciais(opcRemetente);
		session = Session.getInstance(getPropriedades(),getAuthenticator());
		from = new InternetAddress(sender);
	}
	
	public void pegaCredenciais(String opcRemetente){
		System.out.println("Sistema EmailHelper enviando via: "+AppSecrets.MAIL_USER);
		setSender(AppSecrets.MAIL_USER);
		setPasswd(AppSecrets.MAIL_PASS);
	}
	
	//M�todo que retorna a autenticação de sua conta de email
	public static Authenticator getAuthenticator(){
		Authenticator autenticacao = new Authenticator() {
			public PasswordAuthentication getPasswordAuthentication() {
				//Preencha com seu email e com sua senha
				//return new PasswordAuthentication(ConstantsKanaflex.USER_RPNC+ConstantsKanaflex.EMAIL_DOMINIO, ConstantsKanaflex.EMAIL_SENHA_RPNC);
				return new PasswordAuthentication(sender, passwd);
	      }
		};
		return autenticacao;
	}

	//M�todo que retorna as propriedades de configura��o do servidor de email
	public static Properties getPropriedades(){

		Properties props = new Properties();
		
		props.put("mail.debug", "false");
		props.put("mail.transport.protocol", "smtp");
		props.put("mail.smtp.host", "smtp.gmail.com"); //SMTP do seu servidor de email
		props.put("mail.smtp.socketFactory.port", "465"); //Porta do servidor smtp
		props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory"); //Define a conex�o do tipo SSL
		props.put("mail.smtp.auth", "true"); //ativa autenticacao
		props.put("mail.smtp.port", "465"); //Porta do seu servidor smtp
		props.put("mail.host", "smtp.gmail.com"); //SMTP do seu servidor de email
		props.put("mail.user", AppSecrets.MAIL_USER);//put your username with domain exp.. asdf@gmail.com
		props.put("mail.password", AppSecrets.MAIL_PASS);//put your password
		props.put("mail.domain", "@gmail.com");
		props.put("mail.smtp.domain", "@gmail.com");
		props.put("mail.smtp.user", AppSecrets.MAIL_USER);//put your username with domain exp.. asdf@gmail.com
		props.put("mail.smtp.password", AppSecrets.MAIL_PASS);//put your password
		props.put("mail.smtp.localhost", "127.0.0.1");
		props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		
		/*
		props.put("mail.debug", "false");
		props.put("mail.transport.protocol", "smtp");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.kinghost.net"); //SMTP do seu servidor de email
		props.put("mail.smtp.auth", "true"); //ativa autenticacao
		props.put("mail.smtp.port", "587"); //Porta do seu servidor smtp
		props.put("mail.smtp.user", AppSecrets.MAIL_USER_LOGIN);//put your username with domain exp.. asdf@gmail.com
		props.put("mail.smtp.password", AppSecrets.MAIL_PASS);//put your password
		props.put("mail.smtp.localhost", "127.0.0.1");
		props.put("mail.host", "smtp.kinghost.net"); //SMTP do seu servidor de email
		props.put("mail.user", AppSecrets.MAIL_USER_LOGIN);//put your username with domain exp.. asdf@gmail.com
		props.put("mail.password", AppSecrets.MAIL_PASS);//put your password
		props.put("mail.domain", "@r1ti.com.br");
		*/
		
		return props;
	}


	public void addDest(String dd) throws MessagingException{
		dests.add(new InternetAddress(dd));
	}
	

	public void addDestCc(String dd) throws MessagingException{
		destscc.add(new InternetAddress(dd));
	}
	
	
	public void addDestCopiaOculta(String dd) throws MessagingException{
		destscopiaoculta.add(new InternetAddress(dd));	
	}
	
	
	public void envia(String subject, String content) throws MessagingException{
            envia(subject, content, "text/plain");
	}
	
	public void enviaHTML(String subject, String content) throws MessagingException{
            envia(subject, content, "text/html");
	}
	
	public void envia(String subject, String content, String contentType) throws MessagingException{
		
		try{ 
			Transport tr;
			tr = session.getTransport("smtp");
			Message message = new MimeMessage(session);
            message.setFrom(from);
            InternetAddress[] dest = (InternetAddress[])dests.toArray(new  InternetAddress[dests.size()]);
            message.setRecipients(Message.RecipientType.TO, dest);
            if(!destscc.isEmpty()){
	            InternetAddress[] destcc = (InternetAddress[])destscc.toArray(new  InternetAddress[destscc.size()]);
	            message.setRecipients(Message.RecipientType.CC, destcc);
            }
            
            if(!destscopiaoculta.isEmpty()){ 
	            InternetAddress[] destbcc = (InternetAddress[])destscopiaoculta.toArray(new  InternetAddress[destscopiaoculta.size()]);
	            message.setRecipients(Message.RecipientType.BCC, destbcc);
            }
            
            // Create the message part
	        //BodyPart messageBodyPart = new MimeBodyPart();
	        // Now set the actual message
	        //messageBodyPart.setText("");
	        // Create a multipar message
	        Multipart multipart = new MimeMultipart();

	         // Set text message part
	         //multipart.addBodyPart(messageBodyPart);
	         BodyPart htmlBodyPart = new MimeBodyPart();
	         htmlBodyPart.setContent(content , "text/html");
	         multipart.addBodyPart(htmlBodyPart);
	         
	         BodyPart messageBodyPart = new MimeBodyPart();
	         
	         //String PATH_IMG = "C:\\r1ti\\livemusik\\img\\";
	         String PATH_IMG = AppSecrets.PATH_IMG;
	         
	         messageBodyPart = new MimeBodyPart();
	         DataSource fds = new FileDataSource(PATH_IMG+"cozinha_rapida_cabelalho_email.jpg");

	         messageBodyPart.setDataHandler(new DataHandler(fds));
	         messageBodyPart.setHeader("Content-ID", "<image>");

	        multipart.addBodyPart(messageBodyPart);

	         // Part two is attachment
	         //messageBodyPart = new MimeBodyPart();
	         //String filename = arquivoenvio;
	         //System.out.println("filename=="+filename);
	         //DataSource source = new FileDataSource(filename);
	         //String nomeArquivo = filename.replaceAll("D:\\\\r1ti\\\\", "");
	         //String nomeArquivo = filename.replaceAll(AppSecrets.PATH_PDF, "");
	         //messageBodyPart.setDataHandler(new DataHandler(source));
	         //messageBodyPart.setFileName(nomeArquivo);
	         //multipart.addBodyPart(messageBodyPart);
            message.setSubject(subject);
            message.setSentDate(new Date());
            message.setContent(multipart);
            //message.setContent(content, contentType);
            
		    tr.send(message);
		}catch(Exception e){
			e.printStackTrace();
		}
	}

	
	public static void main(String args[]){

	}
	
}