package projeto.security;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import projeto.services.InvalidRequestException;
import projeto.services.ResourceLocatorService;
import projeto.security.Permission;
import projeto.model.Cr_usuario;
import projeto.util.AppSecrets;
import projeto.util.Cast;



/**
 * Filtro de segurança da aplicação.
 */
public class SecurityFilter implements Filter {
	FilterConfig filterConfig;
	private static final String URL_LOGIN = "/";
	
	private static String logUser;
	
	public String getLogUser( ){
	       return logUser;
	}
	public void setLogUser(String lgArtista){
			SecurityFilter.logUser = lgArtista;
	}
	
	public void init(FilterConfig filterConfig) throws ServletException {
		System.out.println("Iniciando SecurityFilter xx...");
		this.filterConfig = filterConfig;
		ServletContext sc= filterConfig.getServletContext();
		ResourceLocatorService.init(sc);
	}
		
	public void doFilter(ServletRequest request,ServletResponse response,FilterChain chain)
	throws IOException, ServletException {

		//boolean BASE_PRODUCAO = EntryPoint.isAmbienteProducao();
		boolean BASE_PRODUCAO = true;
		
		final boolean debug = false; 
		
		long before = System.currentTimeMillis();
		//chain.doFilter(request, response);
		long after = System.currentTimeMillis();
		
		HttpServletRequest hrequest = (HttpServletRequest)request;
		HttpServletResponse httpresponse = (HttpServletResponse) response;

		//session.getAttribute("ITENSMARGEM")) 
		
		//System.out.println( "url no securityfilter ==  "+ hrequest.getRequestURI().toLowerCase());
		
		boolean okdoc = true;
		boolean okfolder = true;
		String msgdoc = "";		
		
		try{

			if (Permission.isRestrictedArea(hrequest)) {
				//System.out.println( "QUANDO EXPIRAR A SESSION  RESULTADO É NULL = " + hrequest.getSession().getAttribute(AppSecrets.USER_KEY) ) ;
				
				/*System.out.println( "VER AQUI = " + AppSecrets.USER_KEY) ;
				System.out.println( "VER AQUI 1 = " +  hrequest ) ;
				System.out.println( "VER AQUI 2 = " + hrequest.getSession() ) ;
				System.out.println( "VER AQUI 3 = " + hrequest.getSession().getId() ) ;
				System.out.println( "VER AQUI 4 = " + hrequest.getSession().getAttributeNames() ) ;
				System.out.println( "VER AQUI 5 = " + hrequest.getSession().getValueNames() ) ;
				System.out.println( "VER AQUI 6 = " + hrequest.getSession().getAttribute(AppSecrets.USER_KEY) ) ;*/
								
				Object o = hrequest.getSession().getAttribute(AppSecrets.USER_KEY);
				
				if (null!=o){	
					setLogUser("");					
					Cr_usuario u = (Cr_usuario) o;	
					if ( !Permission.checkPermission(u, hrequest) ) {
						throw new InvalidRequestException("Usuário sem permissão para acessar este recurso!");
					}
				}else{
					throw new InvalidRequestException("Login expirado. Favor logar novamente.");	
				}
			}
			
		} catch ( InvalidRequestException e ){
			System.out.println("Acesso negado!!");
			hrequest.getSession().setAttribute("errologin", e.getMessage());
			hrequest.getSession().setAttribute(AppSecrets.USER_KEY, null);			
			//String checaUser = getLogUser();
			
			httpresponse.sendRedirect(AppSecrets.SISTEMA_URL+"index_cozinharapida.jsp");
			return;
		}
		chain.doFilter(request, response);
	}

	public void destroy() {
	}

}