package projeto.security;

import java.io.IOException;
import java.util.Properties;
import projeto.services.ResourceLocatorService;

/**
 * Carrega restrições de segurança da aplicação.
 */
public class LoadSecurity {
	static Properties queries;
	static final String QUERIES_RESOURCE ="/WEB-INF/security.properties";
	protected static String getParametro(String key) throws IOException {
		if(queries == null) {
			System.out.println("Iniciando LoadSecurity...");
			queries = ResourceLocatorService
				.getInstance()
				.getResourceProperties(QUERIES_RESOURCE);
			if(queries == null)
				throw new IOException("Não foi possível iniciar LoadSecurity...");
		}
		return queries.getProperty(key);	
	}
	public static void reloadQueries() {
		queries = null;
	}
}