package projeto.security;

import java.io.IOException;
import java.util.Iterator;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import projeto.services.InvalidRequestException;
import projeto.model.Cr_usuario;
import projeto.util.Cast;

/**
 * Classe para buscar permissão de acesso de usuário.
 */
public class Permission extends LoadSecurity{

	public static boolean checkPermission(Cr_usuario user, HttpServletRequest hrequest){
		if ( user != null)
			return false;
		
		try {
			return checkPath(user, hrequest);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return true;
	}
	
	static boolean checkPath(Cr_usuario user, HttpServletRequest hrequest) 
		throws IOException, InvalidRequestException{
		String context= hrequest.getContextPath();
		String url = hrequest.getRequestURI().toLowerCase();
		String path = url.substring(context.length());

		if ( path.indexOf(getParametro("cozinharapida.denied.directories")) 
				!= -1){
			if ( user == null )
				return false;
		}
		return true;
	}
	
	public static boolean isRestrictedArea(HttpServletRequest hrequest) 
		throws IOException, InvalidRequestException{
		String context= hrequest.getContextPath();
		String url = hrequest.getRequestURI().toLowerCase();
		String path = url.substring(context.length());
		
		//System.out.println("isRestrictedArea ? = " + path);

		String areaRestrita = getParametro("cozinharapida.denied.directories");
		if ( path.indexOf(areaRestrita) != -1){
			//System.out.println("area restrita encontrada: " + path + " X -> " + areaRestrita);
			return true;
		}
		return false;
	}
	
	
}