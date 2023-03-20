package projeto.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import projeto.model.Cr_usuario;
import projeto.services.InvalidRequestException;
import projeto.util.AppSecrets;

public class LoginServlet extends HttpServlet {
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {							
		String cr_email_usuario_login = null!=request.getParameter("cr_email_usuario_login")?request.getParameter("cr_email_usuario_login"):"";
		String cr_senha_usuario_login = null!=request.getParameter("cr_senha_usuario_login")?request.getParameter("cr_senha_usuario_login"):"";
		
		try {													
				Cr_usuario cru = Cr_usuario.listUsuarioParam("cr_email_usuario", cr_email_usuario_login);
				
				if(cru.getCr_id_usuario() == 0) {
					//Usuario ID = 0 - Não há usuário com este código...
					throw new InvalidRequestException("Não há usuário cadastrado com o e-mail digitado.");
				}else {
					String senhaUser = cru.getCr_senha_usuario();					
					System.out.println("VENDO O ID DO USUÁRIO :: "+cru.getCr_id_usuario());
					
					int retorno_login = Cr_usuario.valida_login(cr_email_usuario_login, cr_senha_usuario_login);								
					
					if(retorno_login == -1) {						
						throw new InvalidRequestException("Erro ao Verificar Login!");
					}else if(retorno_login != 0) {
						//Senha OK
						request.getSession().setAttribute(AppSecrets.USER_KEY, cru);						
						response.sendRedirect(AppSecrets.SISTEMA_URL+"/home_cozinharapida.jsp");
					}else {
						//Senha Incorreta
						//throw new InvalidRequestException("Usuário ou senha inválidos!");
						throw new InvalidRequestException("Senha incorreta.");
					}					
				}
			
		}catch(InvalidRequestException i) {
			request.getSession().setAttribute("errologin", i.getMessage());
			request.getSession().setAttribute(AppSecrets.USER_KEY, null);			
			
			response.sendRedirect(AppSecrets.SISTEMA_URL+"/index_cozinharapida.jsp");
		}
	}
}
