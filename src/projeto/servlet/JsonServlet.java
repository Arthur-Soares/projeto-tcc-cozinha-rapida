package projeto.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.util.SystemOutLogger;
import org.json.JSONArray;
import org.json.JSONObject;

import br.com.neorelato.util.Cast;
import projeto.model.Cr_receita;
import projeto.model.Cr_usuario;
import projeto.model.Cr_usuario_receita;

import projeto.util.AppSecrets;

public class JsonServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	response.setContentType("application/json");
    	response.setCharacterEncoding("UTF-8");
    	
    	HttpSession session = request.getSession();
    	    	
    	Cr_usuario userLogado = null!=session.getAttribute(AppSecrets.USER_KEY)?(Cr_usuario)session.getAttribute(AppSecrets.USER_KEY):null;    	
    	String opcServlet = null!=request.getParameter("opc_servlet")?request.getParameter("opc_servlet"):"";
    	String filtro_q = null != request.getParameter("q") ? request.getParameter("q") : "";
    	JSONArray jsonArray = new JSONArray();
    	JSONObject jsonObj = new JSONObject();
		Object[] params = new Object[1]; 
		Object[] values = new Object[1];
		HttpSession s = request.getSession();

    	//JSONArray jsonRet = new JSONArray();
    	
    	PrintWriter out = response.getWriter();
    	//out.print(jsonArray);	
    	Enumeration<String> reqNames = request.getParameterNames();
    	Map<String,String> mapParams = new HashMap<String,String>();
		while (reqNames.hasMoreElements()) {
			String name = reqNames.nextElement();
			String value = request.getParameter(name);
			//Aqui estudar se precisar formatar id vindo do form...
			//value = StringUtils.toUTF8(value).trim();
			//System.out.println(name+" x=x '"+value+"'");
			mapParams.put(name, value);
		}
		
		if("salva_usuario".equals(opcServlet)) {
			Cr_usuario cru = new Cr_usuario(mapParams);
			int id_usuario = cru.salva_registro();
			jsonObj= new JSONObject();
			jsonObj.put("id_usuario", id_usuario);
			out = response.getWriter();
    		out.print(jsonObj);
		}else if("apaga_usuario".equals(opcServlet)) {
			int id_usuario = null!=request.getParameter("id_usuario")?Cast.toInt(request.getParameter("id_usuario")):0;
			Cr_usuario cru = new Cr_usuario();
			int retorno_login = cru.apaga_registro(id_usuario);
			jsonObj = new JSONObject();	
			if(retorno_login == -1) {
				jsonObj.put("ERRO", "Erro ao apagar usuário!");
			}else{
				jsonObj.put("ERRO", "");
			}			
			out = response.getWriter();
    		out.print(jsonObj);
		}else if("find_login".equals(opcServlet)) {
			String cr_email_usuario_login = null!=request.getParameter("cr_email_usuario_login")?request.getParameter("cr_email_usuario_login"):"";
			String cr_senha_usuario_login = null!=request.getParameter("cr_senha_usuario_login")?request.getParameter("cr_senha_usuario_login"):"";
			int retorno_login = Cr_usuario.valida_login(cr_email_usuario_login, cr_senha_usuario_login);			
			JSONObject jsonRet = new JSONObject();
			
			if(retorno_login == -1) {
				jsonRet.put("ERRO", "Erro ao Verificar Login!");
			}else if(retorno_login != 0) {
				jsonRet.put("ERRO", "");
			}else {
				jsonRet.put("ERRO", "Usuário ou senha inválidos!");
			}
			
			out = response.getWriter();
    		out.print(jsonRet);
		}else if("list_usuarios".equals(opcServlet)) {	
			jsonArray = Cr_usuario.listarJSON(new Object[0], new Object[0]);
			out = response.getWriter();
    		out.print(jsonArray);
		}else if("find_usuario".equals(opcServlet)) { 
			int cr_id_usuario = null!=request.getParameter("cr_id_usuario")?Cast.toInt(request.getParameter("cr_id_usuario")):0; 
			params[0]="cr_id_usuario";
			values[0]= cr_id_usuario;
			jsonArray = Cr_usuario.listarJSON(params,values); 
			jsonObj = !jsonArray.isEmpty()?jsonArray.getJSONObject(0):new JSONObject();
			out = response.getWriter();
			out.print(jsonObj);
		}//else if("atualiza_senha".equals(opcServlet)) {			
//			int id_usuario = userLogado.getId_usuario();		
//			String senha = null!=request.getParameter("senha")?Cast.toString(request.getParameter("senha")):"";
//			int retornasenha = Cr_usuario.atualizaSenha(id_usuario, senha);
//			out = response.getWriter();
//			jsonObj.put("retorno",retornasenha);
//        	out.print(jsonObj);    		
	  	else if("list_receitas".equals(opcServlet)) {	
			jsonArray = Cr_receita.listarJSON(new Object[0], new Object[0]);
			out = response.getWriter();
    		out.print(jsonArray);
	  	}else if("apaga_receita".equals(opcServlet)) {
			int id_receita = null!=request.getParameter("id_receita")?Cast.toInt(request.getParameter("id_receita")):0;
			Cr_receita crr = new Cr_receita();
			int retorno_receita = crr.apaga_registro(id_receita);
			jsonObj = new JSONObject();	
			if(retorno_receita == -1) {
				jsonObj.put("ERRO", "Erro ao apagar receita!");
			}else{
				jsonObj.put("ERRO", "");
			}			
			out = response.getWriter();
    		out.print(jsonObj);
		}else if("salva_receita".equals(opcServlet)) {
			String cr_valor_receita = mapParams.containsKey("cr_valor_receita")?mapParams.get("cr_valor_receita").trim():"";
			cr_valor_receita = cr_valor_receita.replace(".","");
			cr_valor_receita = cr_valor_receita.replaceAll(",",".");
			mapParams.put("cr_valor_receita",Cast.toString(cr_valor_receita));			
			Cr_receita crr = new Cr_receita(mapParams);
			int id_receita = crr.salva_registro();
			jsonObj= new JSONObject();
			jsonObj.put("id_receita", id_receita);
			out = response.getWriter();
    		out.print(jsonObj);
		}else if("find_receita".equals(opcServlet)) { 
			int cr_id_receita = null!=request.getParameter("cr_id_receita")?Cast.toInt(request.getParameter("cr_id_receita")):0; 
			params[0]="cr_id_receita";
			values[0]= cr_id_receita;
			jsonArray = Cr_receita.listarJSON(params,values); 
			jsonObj = !jsonArray.isEmpty()?jsonArray.getJSONObject(0):new JSONObject();
			out = response.getWriter();
			out.print(jsonObj);
	   }else if("list_receitas_favoritas".equals(opcServlet)) { 
			int cuserid = null!=request.getParameter("cuserid")?Cast.toInt(request.getParameter("cuserid")):0; 			
			jsonArray = Cr_receita.listarJSONRecFavoritas(cuserid); 			
			out = response.getWriter();
			out.print(jsonArray);
	   }else if("list_top_receitas".equals(opcServlet)) {	
			jsonArray = Cr_receita.listaTopViews(new Object[0], new Object[0]);
			out = response.getWriter();
			out.print(jsonArray);
	  	}else if("soma_receita_view".equals(opcServlet)) { 
			int cr_id_receita = null!=request.getParameter("cr_id_receita")?Cast.toInt(request.getParameter("cr_id_receita")):0; 
			int cr_receita_view = null!=request.getParameter("cr_receita_view")?Cast.toInt(request.getParameter("cr_receita_view")):0; 
			Cr_receita crr = new Cr_receita();
			int retornaview = crr.somaViewReceita(cr_id_receita, cr_receita_view);
			jsonObj= new JSONObject();
			jsonObj.put("retorno_view", retornaview);
			out = response.getWriter();
			out.print(jsonObj);
	   }else if("pintar_coracao".equals(opcServlet)) { 
		   	int userId = userLogado.getCr_id_usuario();
			int cr_id_receita = null!=request.getParameter("cr_id_receita")?Cast.toInt(request.getParameter("cr_id_receita")):0; 
			Cr_usuario_receita cur = new Cr_usuario_receita();
			String retorno = cur.pintarCoracao(cr_id_receita, userId);
			jsonObj= new JSONObject();
			jsonObj.put("retorno", retorno);
			out = response.getWriter();
			out.print(jsonObj);
	   }else if("favoritar_receita".equals(opcServlet)) { 
		   	int userId = userLogado.getCr_id_usuario();
			String opc_favorito = null!=request.getParameter("opc_favorito")?Cast.toString(request.getParameter("opc_favorito")):""; 
			int cr_id_receita = null!=request.getParameter("cr_id_receita")?Cast.toInt(request.getParameter("cr_id_receita")):0; 
			Cr_usuario_receita cur = new Cr_usuario_receita();
			int retorno = 0;
			if(opc_favorito.equals("favoritar")) {
				retorno = cur.favoritarReceita(cr_id_receita, userId);
			}else if(opc_favorito.equals("desfavoritar")) {
				retorno = cur.desfavoritarReceita(cr_id_receita, userId);
			}
			jsonObj= new JSONObject();
			jsonObj.put("retorno", retorno);
			out = response.getWriter();
			out.print(jsonObj);
	   }else if("find_pesquisa_receita".equals(opcServlet)) { 			
		   	JSONArray jsonRet = new JSONArray();
		   	String nome_receita = null!=request.getParameter("nome_receita")?request.getParameter("nome_receita"):"";
		   	
			if (null != s.getAttribute("_JSON_REC_FIND")) {
				jsonRet = (JSONArray) s.getAttribute("_JSON_REC_FIND");
			} else {
				jsonRet = Cr_receita.alimentaSQLReceitas("");
			}			
			s.setAttribute("_JSON_REC_FIND", jsonRet);
			
			if (!"".equals(nome_receita) || !"".equals(filtro_q)) {
				if(!"".equals(nome_receita)) {
					//System.out.println("xxx Param query filtro_q:: "+nome_receita);
					jsonRet = filtraReceitasFind(jsonRet, nome_receita);
				}else {
					//System.out.println("xxx Param query filtro_q:: "+filtro_q);
					jsonRet = filtraReceitasFind(jsonRet, filtro_q);
				}		
				System.out.println("jsonRet :: "+jsonRet);
				out.print(jsonRet);
			} else {
				out.print(jsonRet);
			}
	   }else if("sel_pesquisa_receita".equals(opcServlet)) {
		   JSONArray jsonRet = new JSONArray();
		   String nome_receita = null!=request.getParameter("nome_receita")?request.getParameter("nome_receita"):"";
		   if (null != s.getAttribute("_JSON_REC_SEL")) {
				jsonRet = (JSONArray) s.getAttribute("_JSON_REC_SEL");
			} else {
				jsonRet = Cr_receita.alimentaSQLReceitas("S");
			}			
			s.setAttribute("_JSON_REC_SEL", jsonRet);
			if (!"".equals(nome_receita) || !"".equals(filtro_q)) {
				if(!"".equals(nome_receita)) {			
					jsonRet = filtrarSelect(jsonRet, nome_receita);
				}else {
					jsonRet = filtrarSelect(jsonRet, filtro_q);
				}
				out.print(jsonRet);
			} else {
				out.print(jsonRet);
			}
	   }else{
			out.print(jsonArray);
		}
    }
    
    public JSONArray filtraReceitasFind(JSONArray jsonRet, String nome_receita) {
		JSONArray jsonArray = new JSONArray();
		for (int i = 0; i < jsonRet.length(); i++) {
			JSONObject jsonobject = jsonRet.getJSONObject(i);
			String jsonText = jsonobject.getString("cr_titulo_receita").toUpperCase().trim();
			if (jsonText.equals(nome_receita.toUpperCase().trim())) {
				jsonArray.put(jsonobject);
				break;
			}
		}
		return jsonArray;
	}
    
    
    public JSONArray filtrarSelect(JSONArray jsonRet, String query) {
		JSONArray jsonArray = new JSONArray();
		for (int i = 0; i < jsonRet.length(); i++) {
			JSONObject jsonobject = jsonRet.getJSONObject(i);
			String jsonText = jsonobject.getString("text").toUpperCase();
			if (jsonText.contains(query.toUpperCase())) {
				jsonArray.put(jsonobject);
			}
		}
		return jsonArray;
	}
		
    
    public JSONArray filtraLabelFind(JSONArray jsonRet, String label) {
		JSONArray jsonArray = new JSONArray();
		for (int i = 0; i < jsonRet.length(); i++) {
			JSONObject jsonobject = jsonRet.getJSONObject(i);
			String jsonText = jsonobject.getString("label").toUpperCase().trim();
			if (jsonText.equals(label.toUpperCase().trim())) {
				jsonArray.put(jsonobject);
				break;
			}
		}
		return jsonArray;
	}
}
