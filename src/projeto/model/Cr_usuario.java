package projeto.model;

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

import org.json.JSONArray;
import org.json.JSONObject;

import br.com.neorelato.util.Cast;
import projeto.util.FormatUtils;
import projeto.util.ProjetoDatabase;

/*
CREATE TABLE cr_usuario
(
   cr_id_usuario int auto_increment primary key not null,
   cr_codigo_usuario varchar(255) NOT NULL,
   cr_senha_usuario varchar(255) NOT NULL,
   cr_nome_completo varchar(255) NOT NULL,
   cr_email_usuario varchar(255) NOT NULL
);


*/

public class Cr_usuario {
	int cr_id_usuario = 0;
	String cr_codigo_usuario = "";
	String cr_senha_usuario = "";
	String cr_nome_completo = "";
	String cr_email_usuario = "";
	
	public Cr_usuario(int cr_id_usuario, String cr_codigo_usuario, String cr_senha_usuario, String cr_nome_completo, String cr_email_usuario) {
		super();
		this.cr_id_usuario = cr_id_usuario;
		this.cr_codigo_usuario = cr_codigo_usuario;
		this.cr_senha_usuario = cr_senha_usuario;
		this.cr_nome_completo = cr_nome_completo;
		this.cr_email_usuario = cr_email_usuario;
	}
	
	public Cr_usuario(List listObj) {
		super();
		int ind = 0;
		this.cr_id_usuario = listObj.size()>ind?(int)listObj.get(ind):0;ind++;
		this.cr_codigo_usuario = listObj.size()>ind?(null!=listObj.get(ind)?listObj.get(ind).toString():""):"";ind++;
		this.cr_senha_usuario = listObj.size()>ind?(null!=listObj.get(ind)?listObj.get(ind).toString():""):"";ind++;
		this.cr_nome_completo = listObj.size()>ind?(null!=listObj.get(ind)?listObj.get(ind).toString():""):"";ind++;
		this.cr_email_usuario = listObj.size()>ind?(null!=listObj.get(ind)?listObj.get(ind).toString():""):"";		
	}

	public Cr_usuario(Map<String, String> mapParams) {
		super();
		int ind = 0;
		this.cr_id_usuario = mapParams.containsKey("cr_id_usuario")?Cast.toInt(mapParams.get("cr_id_usuario")):0;
		this.cr_codigo_usuario = mapParams.containsKey("cr_codigo_usuario")?mapParams.get("cr_codigo_usuario").trim():"";
		this.cr_senha_usuario = mapParams.containsKey("cr_senha_usuario")?mapParams.get("cr_senha_usuario").trim():"";
		this.cr_nome_completo = mapParams.containsKey("cr_nome_completo")?mapParams.get("cr_nome_completo").trim():"";
		this.cr_email_usuario = mapParams.containsKey("cr_email_usuario")?mapParams.get("cr_email_usuario").trim():"";
	}

	public int getCr_id_usuario() {
		return cr_id_usuario;
	}

	public void setCr_id_usuario(int cr_id_usuario) {
		this.cr_id_usuario = cr_id_usuario;
	}

	public String getCr_codigo_usuario() {
		return cr_codigo_usuario;
	}

	public void setCr_codigo_usuario(String cr_codigo_usuario) {
		this.cr_codigo_usuario = cr_codigo_usuario;
	}

	public String getCr_senha_usuario() {
		return cr_senha_usuario;
	}

	public void setCr_senha_usuario(String cr_senha_usuario) {
		this.cr_senha_usuario = cr_senha_usuario;
	}

	public String getCr_nome_completo() {
		return cr_nome_completo;
	}

	public void setCr_nome_completo(String cr_nome_completo) {
		this.cr_nome_completo = cr_nome_completo;
	}

	public String getCr_email_usuario() {
		return cr_email_usuario;
	}

	public void setCr_email_usuario(String cr_email_usuario) {
		this.cr_email_usuario = cr_email_usuario;
	}

	public static JSONArray arrayUsuarios(Object[] params, Object[] values) {
		JSONArray arrayUsuarios = new JSONArray();
		String sql = " select " +
					 " cr_id_usuario, " +
					 " cr_codigo_usuario, " +
					 " cr_senha_usuario, " +
					 " cr_nome_completo, " +
					 " cr_email_usuario " +
					 " from cr_usuario ";
		
		if(params.length > 0 && values.length > 0) {
			for(int ob = 0; ob < params.length; ob++) {
				sql += " and "+params[ob]+" = ?";
			}
		}
		
		sql+=		" order by cr_id_usuario ";
		try {
			Connection c = ProjetoDatabase.getConnection();
			System.out.println("SQL arrayUsuarios()\n"+sql);
			PreparedStatement p = c.prepareStatement(sql);
			if(params.length > 0 && values.length > 0) {
				for(int ob = 0, pind=1; ob < values.length; ob++, pind++) {
					p.setObject(pind, values[ob]);
				}
			}
			
			ResultSet r = p.executeQuery();
			ResultSetMetaData rsmd = r.getMetaData();
			int cols =	rsmd.getColumnCount();
			while(r.next()) {
				JSONObject jsonObj = new JSONObject();
				for(int xc = 1;xc<=cols;xc++){
					if(java.sql.Types.VARCHAR == rsmd.getColumnType(xc)||
						java.sql.Types.CHAR == rsmd.getColumnType(xc)||		
						java.sql.Types.LONGVARCHAR == rsmd.getColumnType(xc)||
						java.sql.Types.NCHAR == rsmd.getColumnType(xc)||
						java.sql.Types.NVARCHAR == rsmd.getColumnType(xc)||
						java.sql.Types.LONGNVARCHAR == rsmd.getColumnType(xc)){
						jsonObj.put(rsmd.getColumnLabel(xc), null!=r.getObject(xc)?r.getString(xc).trim():"");
					}else if(java.sql.Types.DATE == rsmd.getColumnType(xc)){
						jsonObj.put(rsmd.getColumnLabel(xc), null!=r.getObject(xc)?FormatUtils.dateformat(r.getString(xc)):"");
					}else if(java.sql.Types.TIMESTAMP== rsmd.getColumnType(xc)){
						jsonObj.put(rsmd.getColumnLabel(xc), null!=r.getObject(xc)?FormatUtils.dataHoraMinutoSegundoBr(r.getString(xc)):"");
					}else{
						jsonObj.put(rsmd.getColumnLabel(xc), r.getObject(xc));	
					}
				}
				arrayUsuarios.put(jsonObj);
			}
			if(null!=r) {
				r.close();
				r=null;
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
		return arrayUsuarios;
	}	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		//JSONArray jsonArray = new JSONArray();
		//jsonArray = Cr_usuario.arrayUsuarios(new Object[0], new Object[0]);
		
		//System.out.println("Retorno do banco de dados :: "+jsonArray);
		
	}
	
}