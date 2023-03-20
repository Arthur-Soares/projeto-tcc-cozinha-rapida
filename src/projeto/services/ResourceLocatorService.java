package projeto.services;

import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Properties;
import javax.servlet.ServletContext;

/**
 * Serviço para localização de recursos.
 * 
 * Use esta classe em vez de abrir arquivos diretamente ou usar o ClassLoader.
 */
public class ResourceLocatorService {
	private static ResourceLocatorService locator;
	private ServletContext ctx;

	private ResourceLocatorService() {
	}
	
	
	private ResourceLocatorService(ServletContext ctx) {
		this.ctx = ctx;
	}

	public static synchronized void init(ServletContext ctx) {
		if(locator == null)
			locator = new ResourceLocatorService(ctx);
	}

	public static synchronized ResourceLocatorService getInstance() {
		if(locator == null)
			throw new RuntimeException("no resource locator initialized");
		return locator;
	}
	
	public URL getResourceURL(String id) throws MalformedURLException{
		return ctx.getResource(id);
	}
	
	public InputStream getResourceStream(String id) throws IOException {
		return ctx.getResourceAsStream(id);
	}	
	
	public Properties getResourceProperties(String id) throws IOException {
		Properties props = new Properties();
		InputStream in = getResourceStream(id);
		if(in == null)
			return null; 
		props.load(in);
		return props;
	}
}
