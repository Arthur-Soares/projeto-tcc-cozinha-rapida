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
CREATE TABLE r1_usuario
(
   id_usuario int auto_increment primary key not null,
   codigo_usuario varchar(255) NOT NULL,
   senha_usuario varchar(255) NOT NULL,
   nome_completo varchar(255) NOT NULL,
   email_usuario varchar(255) NOT NULL,
   opc_tipo_acesso char(1) NOT NULL,
   opc_ativo_usuario char(1) NOT NULL,
   opc_acesso_alphabeat char(1) NOT NULL,
   opc_acesso_onda char(1) NOT NULL,
   dhd_atualizacao timestamp DEFAULT now()
);



ALTER TABLE r1_usuario
ADD COLUMN supervisor_usuario int(11) DEFAULT 0

ALTER TABLE r1_usuario
ADD COLUMN nivel_usuario varchar(4) DEFAULT ''
*/

public class R1usuario {
	int id_usuario = 0;
	String codigo_usuario = "";
	String senha_usuario = "";
	String nome_completo = "";
	String email_usuario = "";
	String opc_tipo_acesso = "";
	String opc_ativo_usuario = "";
	String opc_acesso_alphabeat = "";
	String opc_acesso_onda = "";
	Date dhd_atualizacao = new Date();
	int supervisor_usuario = 0;
	String nivel_usuario = "";
	
	public R1usuario() {
		super();
	}
	
	public R1usuario(int id_usuario, String codigo_usuario, String senha_usuario, String nome_completo,
			String email_usuario, String opc_tipo_acesso, String opc_ativo_usuario, String opc_acesso_alphabeat,
			String opc_acesso_onda, Date dhd_atualizacao, int supervisor_usuario, String nivel_usuario) {
		super();
		this.id_usuario = id_usuario;
		this.codigo_usuario = codigo_usuario;
		this.senha_usuario = senha_usuario;
		this.nome_completo = nome_completo;
		this.email_usuario = email_usuario;
		this.opc_tipo_acesso = opc_tipo_acesso;
		this.opc_ativo_usuario = opc_ativo_usuario;
		this.opc_acesso_alphabeat = opc_acesso_alphabeat;
		this.opc_acesso_onda = opc_acesso_onda;
		this.dhd_atualizacao = dhd_atualizacao;
		this.supervisor_usuario = supervisor_usuario;
		this.nivel_usuario = nivel_usuario;
	}
	
	public R1usuario(List listObj) {
		super();
		int ind = 0;
		this.id_usuario = listObj.size()>ind?(int)listObj.get(ind):0;ind++;
		this.codigo_usuario = listObj.size()>ind?(null!=listObj.get(ind)?listObj.get(ind).toString():""):"";ind++;
		this.senha_usuario = listObj.size()>ind?(null!=listObj.get(ind)?listObj.get(ind).toString():""):"";ind++;
		this.nome_completo = listObj.size()>ind?(null!=listObj.get(ind)?listObj.get(ind).toString():""):"";ind++;
		this.email_usuario = listObj.size()>ind?(null!=listObj.get(ind)?listObj.get(ind).toString():""):"";ind++;
		this.opc_tipo_acesso = listObj.size()>ind?(null!=listObj.get(ind)?listObj.get(ind).toString():""):"";ind++;
		this.opc_ativo_usuario = listObj.size()>ind?(null!=listObj.get(ind)?listObj.get(ind).toString():""):"";ind++;
		this.opc_acesso_alphabeat = listObj.size()>ind?(null!=listObj.get(ind)?listObj.get(ind).toString():""):"";ind++;
		this.opc_acesso_onda = listObj.size()>ind?(null!=listObj.get(ind)?listObj.get(ind).toString():""):"";ind++;
		this.dhd_atualizacao = listObj.size()>ind?(null!=listObj.get(ind)?(Date)listObj.get(ind):null):null;ind++;
		this.supervisor_usuario = listObj.size()>ind?(int)listObj.get(ind):0;ind++;
		this.nivel_usuario = listObj.size()>ind?(null!=listObj.get(ind)?listObj.get(ind).toString():""):"";
	}

	public R1usuario(Map<String, String> mapParams) {
		super();
		int ind = 0;
		this.id_usuario = mapParams.containsKey("id_usuario")?Cast.toInt(mapParams.get("id_usuario")):0;
		this.codigo_usuario = mapParams.containsKey("codigo_usuario")?mapParams.get("codigo_usuario").trim():"";
		this.senha_usuario = mapParams.containsKey("senha_usuario")?mapParams.get("senha_usuario").trim():"";
		this.nome_completo = mapParams.containsKey("nome_completo")?mapParams.get("nome_completo").trim():"";
		this.email_usuario = mapParams.containsKey("email_usuario")?mapParams.get("email_usuario").trim():"";
		this.opc_tipo_acesso = mapParams.containsKey("opc_tipo_acesso")?mapParams.get("opc_tipo_acesso").trim():"";
		this.opc_ativo_usuario = mapParams.containsKey("opc_ativo_usuario")?mapParams.get("opc_ativo_usuario").trim():"";
		this.opc_acesso_alphabeat = mapParams.containsKey("opc_acesso_alphabeat")?mapParams.get("opc_acesso_alphabeat").trim():"";
		this.opc_acesso_onda = mapParams.containsKey("opc_acesso_onda")?mapParams.get("opc_acesso_onda").trim():"";
		this.dhd_atualizacao = mapParams.containsKey("dhd_atualizacao")?Cast.toDate(mapParams.get("dhd_atualizacao")):null;
		this.supervisor_usuario = mapParams.containsKey("supervisor_usuario")?Cast.toInt(mapParams.get("supervisor_usuario")):0;
		this.nivel_usuario = mapParams.containsKey("nivel_usuario")?mapParams.get("nivel_usuario").trim():"";
		//dat_boleto = mapParams.containsKey("dat_boleto")?Cast.toDate(mapParams.get("dat_boleto")):new Date();
    	//val_boleto = mapParams.containsKey("val_boleto")?Cast.toBigDecimal( (mapParams.get("val_boleto").replaceAll("\\.", "")) ):BigDecimal.ZERO;
	}

	public int getId_usuario() {
		return id_usuario;
	}
	public void setId_usuario(int id_usuario) {
		this.id_usuario = id_usuario;
	}
	public String getCodigo_usuario() {
		return codigo_usuario;
	}
	public void setCodigo_usuario(String codigo_usuario) {
		this.codigo_usuario = codigo_usuario;
	}
	public String getSenha_usuario() {
		return senha_usuario;
	}
	public void setSenha_usuario(String senha_usuario) {
		this.senha_usuario = senha_usuario;
	}
	public String getNome_completo() {
		return nome_completo;
	}
	public void setNome_completo(String nome_completo) {
		this.nome_completo = nome_completo;
	}
	public String getEmail_usuario() {
		return email_usuario;
	}
	public void setEmail_usuario(String email_usuario) {
		this.email_usuario = email_usuario;
	}
	public String getOpc_tipo_acesso() {
		return opc_tipo_acesso;
	}
	public void setOpc_tipo_acesso(String opc_tipo_acesso) {
		this.opc_tipo_acesso = opc_tipo_acesso;
	}
	public String getOpc_ativo_usuario() {
		return opc_ativo_usuario;
	}
	public void setOpc_ativo_usuario(String opc_ativo_usuario) {
		this.opc_ativo_usuario = opc_ativo_usuario;
	}
	public String getOpc_acesso_alphabeat() {
		return opc_acesso_alphabeat;
	}
	public void setOpc_acesso_alphabeat(String opc_acesso_alphabeat) {
		this.opc_acesso_alphabeat = opc_acesso_alphabeat;
	}
	public String getOpc_acesso_onda() {
		return opc_acesso_onda;
	}
	public void setOpc_acesso_onda(String opc_acesso_onda) {
		this.opc_acesso_onda = opc_acesso_onda;
	}
	public Date getDhd_atualizacao() {
		return dhd_atualizacao;
	}
	public void setDhd_atualizacao(Date dhd_atualizacao) {
		this.dhd_atualizacao = dhd_atualizacao;
	}
	public int getSupervisor_usuario() {
		return supervisor_usuario;
	}
	public void setSupervisor_usuario(int supervisor_usuario) {
		this.supervisor_usuario = supervisor_usuario;
	}
	public String getNivel_usuario() {
		return nivel_usuario;
	}
	public void setNivel_usuario(String nivel_usuario) {
		this.nivel_usuario = nivel_usuario;
	}

	public static List<R1usuario> listUsuarios(Object[] params, Object[] values) {
		List<R1usuario> listaUsuarios = new ArrayList<R1usuario>();
		String sql =" SELECT " +
					" id_usuario, " +
					" codigo_usuario, " +
					" senha_usuario, " +
					" nome_completo, " +
					" email_usuario, " +
					" opc_tipo_acesso, " +
					" opc_ativo_usuario, " +
					" opc_acesso_alphabeat, " +
					" opc_acesso_onda, " +
					" dhd_atualizacao, " +
					" supervisor_usuario, " +
					" nivel_usuario " +
					" FROM r1_usuario " +
					" where 1=1";
	
		if(params.length > 0 && values.length > 0) {
			for(int ob = 0; ob < params.length; ob++) {
				sql += " and "+params[ob]+" = ?";
			}
		}
		
		sql+=		" order by id_usuario ";
		try {
			Connection c = ProjetoDatabase.getConnection();
			PreparedStatement p = c.prepareStatement(sql);
			if(params.length > 0 && values.length > 0) {
				for(int ob = 0, pind=1; ob < values.length; ob++, pind++) {
					p.setObject(pind, values[ob]);
				}
			}
			
			ResultSet r = p.executeQuery();
			ResultSetMetaData rsmd = r.getMetaData();
			while(r.next()) {
				List linhaDado = new ArrayList();
				for(int col=1;col<=rsmd.getColumnCount();col++) {
					linhaDado.add(r.getObject(col));
				}
				R1usuario r1u = new R1usuario(linhaDado);
				listaUsuarios.add(r1u);
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
		return listaUsuarios;
	}

	public static R1usuario listUsuarioParam(String param, Object value) {
		List<R1usuario> listaUsuarios = new ArrayList<R1usuario>();
		R1usuario r1u = new R1usuario();
		Object[] params = new Object[1];
		params[0] = param;
		Object[] values = new Object[1];
		values[0] = value;
		listaUsuarios = R1usuario.listUsuarios(params,values);
		if(listaUsuarios.size() > 0) {
			r1u = listaUsuarios.get(0);	
		}
		return r1u;
	}
	

	public static JSONArray arrayUsuarios(Object[] params, Object[] values) {
		JSONArray arrayUsuarios = new JSONArray();
		String sql =" SELECT " +
					" id_usuario, " +
					" codigo_usuario, " +
					" senha_usuario, " +
					" nome_completo, " +
					" email_usuario, " +
					" opc_tipo_acesso, " +
					" opc_ativo_usuario, " +
					" opc_acesso_alphabeat, " +
					" opc_acesso_onda, " +
					" dhd_atualizacao, " +
					" supervisor_usuario, " +
					" nivel_usuario " +
					" FROM r1_usuario " +
					" where 1=1";
		
		if(params.length > 0 && values.length > 0) {
			for(int ob = 0; ob < params.length; ob++) {
				sql += " and "+params[ob]+" = ?";
			}
		}
		
		sql+=		" order by id_usuario ";
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
	
	public static JSONObject jsonUsuarioParam(String param, Object value) {
		JSONArray arrayUsuarios = new JSONArray();
		JSONObject jsonObj = new JSONObject();
		Object[] params = new Object[1];
		params[0] = param;
		Object[] values = new Object[1];
		values[0] = value;
		arrayUsuarios = R1usuario.arrayUsuarios(params,values);
		if(!arrayUsuarios.isEmpty()) {
			jsonObj = arrayUsuarios.getJSONObject(0);	
		}
		return jsonObj;
	}

	public int salvaRegistro() {
		int idRetorno = 0;
		String psSql = "";
		if(this.id_usuario != 0) {
			psSql =		" 	update r1_usuario set "+
						"	codigo_usuario = ?," + 
						"	senha_usuario = ?," + 
						"	nome_completo = ?," + 
						"	email_usuario = ?," + 
						"	opc_tipo_acesso = ?," + 
						"	opc_ativo_usuario = ?," + 
						"	opc_acesso_alphabeat = ?," + 
						"	opc_acesso_onda = ?," +
						"	dhd_atualizacao = ?, "+	
						"	supervisor_usuario = ?, "+	
						"	nivel_usuario = ? "+
						"	where id_usuario = ? ";
		}else {
			psSql =	    " insert into r1_usuario ("+
						" codigo_usuario, " +
						" senha_usuario, " +
						" nome_completo, " +
						" email_usuario, " +
						" opc_tipo_acesso, " +
						" opc_ativo_usuario, " +
						" opc_acesso_alphabeat, " +
						" opc_acesso_onda, " +
						" dhd_atualizacao, " +
						" supervisor_usuario, "+
						" nivel_usuario "+
						")"+
						"values (?,?,?,?,?,?,?,?,?,?,?) ";
		}
		try {
			Connection c = ProjetoDatabase.getConnection();
			PreparedStatement ps = c.prepareStatement(psSql);
			int icol = 1;
			ps.setString(icol, this.codigo_usuario);icol++;
			ps.setString(icol, this.senha_usuario);icol++;
			ps.setString(icol, this.nome_completo);icol++;
			ps.setString(icol, this.email_usuario);icol++;
			ps.setString(icol, this.opc_tipo_acesso);icol++;
			ps.setString(icol, this.opc_ativo_usuario);icol++;
			ps.setString(icol, this.opc_acesso_alphabeat);icol++;
			ps.setString(icol, this.opc_acesso_onda);icol++;
			ps.setTimestamp(icol, new Timestamp(new java.util.Date().getTime()));icol++;
			ps.setInt(icol, this.supervisor_usuario);icol++;
			ps.setString(icol, this.nivel_usuario);
			if(this.id_usuario != 0) {
				icol++;
				ps.setInt(icol, this.id_usuario);
			}
			ps.executeUpdate();
			if(null!=ps) {
				ps.close();
				ps=null;
			}
			if(this.id_usuario != 0) {
				idRetorno = this.id_usuario;
			}else {
				String sqlMax = " select max(id_usuario) from r1_usuario ";
				Statement st = c.createStatement();
				ResultSet rs = st.executeQuery(sqlMax);
				if(rs.next()) {
					idRetorno = null!=rs.getObject(1)?rs.getInt(1):0;
					this.id_usuario = idRetorno;
				}
				if(null!=rs) {
					rs.close();
					rs=null;
				}
				if(null!=st) {
					st.close();
					st=null;
				}
			}
			if(null!=c) {
				c.close();
				c=null;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return idRetorno;
	}
		
	public static int atualizaSenha(int id_usuario, String senha) {
		int idRetorno = 0;

		String UPD_SENHA =	" UPDATE r1_usuario SET " +
				    		" senha_usuario = ? "+			    				   
				    		" WHERE id_usuario= "+id_usuario;
		
		try {
			Connection co = ProjetoDatabase.getConnection();		
			PreparedStatement ps = co.prepareStatement(UPD_SENHA);			
			ps.setString(1, senha);			
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
			idRetorno = -1;	
		}				
		return idRetorno;
	}
	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		//EmailPagamento ep = new EmailPagamento();
		//ep.EmailPagamento(1501,"O");
		
		//R1usuario r1 = new R1usuario();
		//r1.verificaEmail("teste@teste.gmail.com");
	}
	
	
	/*
	insert into r1_usuario
	(
	   codigo_usuario,
	   senha_usuario,
	   nome_completo,
	   email_usuario,
	   opc_tipo_acesso,
	   opc_ativo_usuario,
	   opc_acesso_alphabeat,
	   opc_acesso_onda
	)
	values
	('admin','live@2021','Administrador','rafael.lima@r1ti.com.br','1','S','S','S')	
	*/
	
}
