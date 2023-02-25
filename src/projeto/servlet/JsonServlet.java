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

import projeto.model.R1usuario;

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
    	    	
    	R1usuario userLogado = null!=session.getAttribute(AppSecrets.USER_KEY)?(R1usuario)session.getAttribute(AppSecrets.USER_KEY):null;
    	String copc_acesso = null!=session.getAttribute("opc_acesso")?Cast.toString(session.getAttribute("opc_acesso")).trim():"";
    	String opcServlet = null!=request.getParameter("opc_servlet")?request.getParameter("opc_servlet"):"";
    	String filtro_q = null != request.getParameter("q") ? request.getParameter("q") : "";
    	JSONArray jsonArray = new JSONArray();
    	JSONObject jsonObj = new JSONObject();
		Object[] params = new Object[1]; 
		Object[] values = new Object[1];

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
			R1usuario r1u = new R1usuario(mapParams);
			int id_usuario = r1u.salvaRegistro();
			jsonObj= new JSONObject();
			jsonObj = R1usuario.jsonUsuarioParam("id_usuario", id_usuario);
			out = response.getWriter();
    		out.print(jsonObj);
		}else if("find_usuario".equals(opcServlet)) {
			int id_usuario = null!=request.getParameter("id_usuario")?Cast.toInt(request.getParameter("id_usuario")):0;
			jsonObj= new JSONObject();
			jsonObj = R1usuario.jsonUsuarioParam("id_usuario", id_usuario);
			out = response.getWriter();
    		out.print(jsonObj);
		}else if("find_login".equals(opcServlet)) {
			String codigo_usuario = null!=request.getParameter("codigo_usuario")?request.getParameter("codigo_usuario"):"";
			System.out.println("find_login :: '"+codigo_usuario+"'");
			R1usuario r1u = R1usuario.listUsuarioParam("codigo_usuario", codigo_usuario); 
			JSONObject jsonRet = new JSONObject();
			if(r1u.getId_usuario() == 0) {
				jsonRet.put("ERRO", "");
			}else {
				jsonRet.put("ERRO", "Usu�rio (ID:'"+r1u.getId_usuario()+"') j� cadastrado com este login.");
			}
			out = response.getWriter();
    		out.print(jsonRet);
		}else if("list_usuarios".equals(opcServlet)) {
			jsonArray = R1usuario.arrayUsuarios(new Object[0], new Object[0]);
			out = response.getWriter();
    		out.print(jsonArray);
		}else if("atualiza_senha".equals(opcServlet)) {			
			int id_usuario = userLogado.getId_usuario();		
			String senha = null!=request.getParameter("senha")?Cast.toString(request.getParameter("senha")):"";
			int retornasenha = R1usuario.atualizaSenha(id_usuario, senha);
			out = response.getWriter();
			jsonObj.put("retorno",retornasenha);
        	out.print(jsonObj);    		
		}else{
			out.print(jsonArray);
		}
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
