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
import projeto.email.EmailEsqueciSenha;
import projeto.util.FormatUtils;
import projeto.util.ProjetoDatabase;

/*
CREATE TABLE cr_usuario
(
   cr_id_usuario int auto_increment primary key not null,
   cr_email_usuario varchar(255) NOT NULL,
   cr_senha_usuario varchar(200) NOT NULL,
   cr_nome_completo_usuario varchar(255) NOT NULL,
   cr_cpf_usuario varchar(14) NOT NULL,
   cr_telefone_usuario varchar(16) NOT NULL,
   cr_cep_usuario varchar(20) NOT NULL,
   cr_endereco_usuario varchar(200) NOT NULL,
   cr_nrmcasa_usuario varchar(10) NOT NULL,
   cr_endcomplemento_usuario varchar(200) NOT NULL,
   cr_pontoreferencia_usuario varchar(200) NOT NULL
);

ALTER TABLE cr_usuario
ADD COLUMN cr_nivel_usuario varchar(1) DEFAULT ''

ALTER TABLE cr_usuario
ADD COLUMN cr_senha_alterada varchar(1) DEFAULT ''

*/

/**
 * 
 * @author Davi Maia Da Silva Sobrinho
 * Este é o início da definição de uma classe Java chamada "Cr_usuario". 
 * Ela possui várias variáveis ​​de instância (também conhecidas como campos) que armazenam informações sobre um usuário, incluindo o ID do usuário, e-mail, senha, nome completo, CPF, telefone, CEP, endereço, número da casa, complemento de endereço, ponto de referência e nível de acesso. 
 */

public class Cr_usuario {
	int cr_id_usuario = 0;
	String cr_email_usuario = "";
	String cr_senha_usuario = "";
	String cr_nome_completo_usuario = "";
	String cr_cpf_usuario = "";
	String cr_telefone_usuario = "";
	String cr_cep_usuario = "";
	String cr_endereco_usuario = "";
	String cr_nrmcasa_usuario = "";
	String cr_endcomplemento_usuario = "";
	String cr_pontoreferencia_usuario = "";
	String cr_nivel_usuario = "";
	String cr_senha_alterada = "";
	
	
	public static String SEL_PADRAO =   " SELECT " +
										" cr_id_usuario, " +
										" cr_email_usuario, " +
										" cr_senha_usuario, " +
										" cr_nome_completo_usuario, " +
										" cr_cpf_usuario, " +
										" cr_telefone_usuario, " +
										" cr_cep_usuario, " +
										" cr_endereco_usuario, " +
										" cr_nrmcasa_usuario, " +
										" cr_endcomplemento_usuario, " +
										" cr_pontoreferencia_usuario, " +
										" cr_nivel_usuario, " +
										" cr_senha_alterada " +
										" FROM cr_usuario "+ 
										" where 1=1 "; 

	public String INS_PADRAO =  " INSERT INTO cr_usuario " +
							  //" cr_id_usuario, " +
							 	" ( cr_email_usuario, " +
							 	" cr_senha_usuario, " +
								" cr_nome_completo_usuario, " +
								" cr_cpf_usuario, " +
								" cr_telefone_usuario, " +
								" cr_cep_usuario, " +
								" cr_endereco_usuario, " +
								" cr_nrmcasa_usuario, " +
								" cr_endcomplemento_usuario, " +
								" cr_pontoreferencia_usuario, " +
								" cr_nivel_usuario " +
							    " ) VALUES " +
							    " (?,MD5(?),?,?,?,?,?,?,?,?,?) ";

	public String UPD_PADRAO =	" UPDATE cr_usuario SET " +
								//" cr_id_usuario = ?, " +
								" cr_email_usuario = ?, " +
								//" cr_senha_usuario = ?, " +
								" cr_nome_completo_usuario = ?, " +
								" cr_cpf_usuario = ?, " +
								" cr_telefone_usuario = ?, " +
								" cr_cep_usuario = ?, " +
								" cr_endereco_usuario = ?, " +
								" cr_nrmcasa_usuario = ?, " +
								" cr_endcomplemento_usuario = ?, " +
								" cr_pontoreferencia_usuario = ?, " +
								" cr_nivel_usuario = ? " +
								" WHERE cr_id_usuario = ? ";
	
	public String DEL_PADRAO = " DELETE FROM cr_usuario WHERE cr_id_usuario = ?";
	
	public int getCr_id_usuario() {
		return cr_id_usuario;
	}

	public void setCr_id_usuario(int cr_id_usuario) {
		this.cr_id_usuario = cr_id_usuario;
	}

	public String getCr_email_usuario() {
		return cr_email_usuario;
	}

	public void setCr_email_usuario(String cr_email_usuario) {
		this.cr_email_usuario = cr_email_usuario;
	}

	public String getCr_senha_usuario() {
		return cr_senha_usuario;
	}

	public void setCr_senha_usuario(String cr_senha_usuario) {
		this.cr_senha_usuario = cr_senha_usuario;
	}

	public String getCr_nome_completo_usuario() {
		return cr_nome_completo_usuario;
	}

	public void setCr_nome_completo_usuario(String cr_nome_completo_usuario) {
		this.cr_nome_completo_usuario = cr_nome_completo_usuario;
	}

	public String getCr_cpf_usuario() {
		return cr_cpf_usuario;
	}

	public void setCr_cpf_usuario(String cr_cpf_usuario) {
		this.cr_cpf_usuario = cr_cpf_usuario;
	}

	public String getCr_telefone_usuario() {
		return cr_telefone_usuario;
	}

	public void setCr_telefone_usuario(String cr_telefone_usuario) {
		this.cr_telefone_usuario = cr_telefone_usuario;
	}

	public String getCr_cep_usuario() {
		return cr_cep_usuario;
	}

	public void setCr_cep_usuario(String cr_cep_usuario) {
		this.cr_cep_usuario = cr_cep_usuario;
	}

	public String getCr_endereco_usuario() {
		return cr_endereco_usuario;
	}

	public void setCr_endereco_usuario(String cr_endereco_usuario) {
		this.cr_endereco_usuario = cr_endereco_usuario;
	}

	public String getCr_nrmcasa_usuario() {
		return cr_nrmcasa_usuario;
	}

	public void setCr_nrmcasa_usuario(String cr_nrmcasa_usuario) {
		this.cr_nrmcasa_usuario = cr_nrmcasa_usuario;
	}

	public String getCr_endcomplemento_usuario() {
		return cr_endcomplemento_usuario;
	}

	public void setCr_endcomplemento_usuario(String cr_endcomplemento_usuario) {
		this.cr_endcomplemento_usuario = cr_endcomplemento_usuario;
	}

	public String getCr_pontoreferencia_usuario() {
		return cr_pontoreferencia_usuario;
	}

	public void setCr_pontoreferencia_usuario(String cr_pontoreferencia_usuario) {
		this.cr_pontoreferencia_usuario = cr_pontoreferencia_usuario;
	}

	public String getCr_nivel_usuario() {
		return cr_nivel_usuario;
	}

	public void setCr_nivel_usuario(String cr_nivel_usuario) {
		this.cr_nivel_usuario = cr_nivel_usuario;
	}	

	public String getCr_senha_alterada() {
		return cr_senha_alterada;
	}

	public void setCr_senha_alterada(String cr_senha_alterada) {
		this.cr_senha_alterada = cr_senha_alterada;
	}

	/**
	 * Este é o construtor da classe "Cr_usuario". Ele recebe como entrada um conjunto de parâmetros que correspondem às 
	 * variáveis de instância da classe e atribui esses valores aos campos correspondentes. Em outras palavras, ele é 
	 * usado para criar um objeto "Cr_usuario" com os valores fornecidos para cada um dos campos do objeto.
	 */
	public Cr_usuario(int cr_id_usuario, String cr_email_usuario, String cr_senha_usuario, String cr_nome_completo_usuario, String cr_cpf_usuario,
					  String cr_telefone_usuario, String cr_cep_usuario, String cr_endereco_usuario, String cr_nrmcasa_usuario, String cr_endcomplemento_usuario, 
					  String cr_pontoreferencia_usuario, String cr_nivel_usuario, String cr_senha_alterada) {
		super();
		this.cr_id_usuario = cr_id_usuario;
		this.cr_email_usuario = cr_email_usuario;
		this.cr_senha_usuario = cr_senha_usuario;
		this.cr_nome_completo_usuario = cr_nome_completo_usuario;
		this.cr_cpf_usuario = cr_cpf_usuario;
		this.cr_telefone_usuario = cr_telefone_usuario;
		this.cr_cep_usuario = cr_cep_usuario;
		this.cr_endereco_usuario = cr_endereco_usuario;
		this.cr_nrmcasa_usuario = cr_nrmcasa_usuario;
		this.cr_endcomplemento_usuario = cr_endcomplemento_usuario;
		this.cr_pontoreferencia_usuario = cr_pontoreferencia_usuario;
		this.cr_nivel_usuario = cr_nivel_usuario;
		this.cr_senha_alterada = cr_senha_alterada;
		
	}
	
	public Cr_usuario(List listObj) {
		super();
		int ind = 0;
		this.cr_id_usuario = listObj.size()>ind?(int)listObj.get(ind):0;ind++;
		this.cr_email_usuario = listObj.size()>ind?(null!=listObj.get(ind)?listObj.get(ind).toString():""):"";ind++;
		this.cr_senha_usuario = listObj.size()>ind?(null!=listObj.get(ind)?listObj.get(ind).toString():""):"";ind++;
		this.cr_nome_completo_usuario = listObj.size()>ind?(null!=listObj.get(ind)?listObj.get(ind).toString():""):"";ind++;
		this.cr_cpf_usuario = listObj.size()>ind?(null!=listObj.get(ind)?listObj.get(ind).toString():""):"";ind++;		
		this.cr_telefone_usuario = listObj.size()>ind?(null!=listObj.get(ind)?listObj.get(ind).toString():""):"";ind++;	
		this.cr_cep_usuario = listObj.size()>ind?(null!=listObj.get(ind)?listObj.get(ind).toString():""):"";ind++;	
		this.cr_endereco_usuario = listObj.size()>ind?(null!=listObj.get(ind)?listObj.get(ind).toString():""):"";ind++;	
		this.cr_nrmcasa_usuario = listObj.size()>ind?(null!=listObj.get(ind)?listObj.get(ind).toString():""):"";ind++;	
		this.cr_endcomplemento_usuario = listObj.size()>ind?(null!=listObj.get(ind)?listObj.get(ind).toString():""):"";ind++;	
		this.cr_pontoreferencia_usuario = listObj.size()>ind?(null!=listObj.get(ind)?listObj.get(ind).toString():""):"";ind++;
		this.cr_nivel_usuario = listObj.size()>ind?(null!=listObj.get(ind)?listObj.get(ind).toString():""):"";ind++;
		this.cr_senha_alterada = listObj.size()>ind?(null!=listObj.get(ind)?listObj.get(ind).toString():""):"";
		
	}

	public Cr_usuario(Map<String, String> mapParams) {
		super();
		int ind = 0;
		this.cr_id_usuario = mapParams.containsKey("cr_id_usuario")?Cast.toInt(mapParams.get("cr_id_usuario")):0;
		this.cr_email_usuario = mapParams.containsKey("cr_email_usuario")?mapParams.get("cr_email_usuario").trim():"";
		this.cr_senha_usuario = mapParams.containsKey("cr_senha_usuario")?mapParams.get("cr_senha_usuario").trim():"";
		this.cr_nome_completo_usuario = mapParams.containsKey("cr_nome_completo_usuario")?mapParams.get("cr_nome_completo_usuario").trim():"";
		this.cr_cpf_usuario = mapParams.containsKey("cr_cpf_usuario")?mapParams.get("cr_cpf_usuario").trim():"";
		this.cr_telefone_usuario = mapParams.containsKey("cr_telefone_usuario")?mapParams.get("cr_telefone_usuario").trim():"";
		this.cr_cep_usuario = mapParams.containsKey("cr_cep_usuario")?mapParams.get("cr_cep_usuario").trim():"";
		this.cr_endereco_usuario = mapParams.containsKey("cr_endereco_usuario")?mapParams.get("cr_endereco_usuario").trim():"";
		this.cr_nrmcasa_usuario = mapParams.containsKey("cr_nrmcasa_usuario")?mapParams.get("cr_nrmcasa_usuario").trim():"";
		this.cr_endcomplemento_usuario = mapParams.containsKey("cr_endcomplemento_usuario")?mapParams.get("cr_endcomplemento_usuario").trim():"";
		this.cr_pontoreferencia_usuario = mapParams.containsKey("cr_pontoreferencia_usuario")?mapParams.get("cr_pontoreferencia_usuario").trim():"";
		this.cr_nivel_usuario = mapParams.containsKey("cr_nivel_usuario")?mapParams.get("cr_nivel_usuario").trim():"";
		this.cr_senha_alterada = mapParams.containsKey("cr_senha_alterada")?mapParams.get("cr_senha_alterada").trim():"";
		
	}

	/**
	 * Este é um método Java que deleta um registro de um banco de dados usando o ID de usuário fornecido como entrada. 
	 * Ele retorna 0 se a operação for bem-sucedida e -1 se ocorrer algum erro, e imprime a exceção correspondente.
	 * @return
	 */
	public int apaga_registro(int id_usuario) {
		int idRetorno = 0;
		
		String delSql = DEL_PADRAO;
		System.out.println("Classe: Cr_usuario - Método: apaga_registro DELETE :: "+delSql);
		try {
			Connection c = ProjetoDatabase.getConnection(); // c = Connection.
			PreparedStatement ps = c.prepareStatement(delSql);			
			ps.setInt(1, id_usuario);	
			ps.executeUpdate();
			if(null!=ps) {
				ps.close();
				ps=null;
			}			
			if(null!=c) {
				c.close();
				c=null;
			}
		}catch(Exception e) {
			e.printStackTrace();
			idRetorno = -1;
		}
		
		return idRetorno;
	}
	
	/**
	 * @author Davi Maia Da Silva Sobrinho
	 * 
	 * Este método "salva_registro()" salva os dados de um objeto "Cr_usuario" em um banco de dados. 
	 * Ele faz isso abrindo uma conexão com o banco de dados e, em seguida, construindo e executando uma declaração SQL 
	 * adequada para inserir ou atualizar os dados do objeto na tabela "cr_usuario".
     * Se o objeto já existe no banco de dados, ele é atualizado usando a declaração SQL de atualização, caso contrário, 
     * a declaração SQL de inserção é usada para adicionar um novo registro ao banco de dados. 
     * Quando os dados são adicionados com sucesso, o método retorna o ID do usuário adicionado ou atualizado.
	 * @return o metodo salva_registro é responsavel por inserir ou alterar o registro na tabela cr_usuario
	 */
	public int salva_registro() {
		int idRetorno = 0;
		
		try {
			Connection c = ProjetoDatabase.getConnection();
			
			String ins = INS_PADRAO;
			if(this.getCr_id_usuario() != 0) {
				ins = UPD_PADRAO;
			}
			
				int icol = 1 ;
				PreparedStatement pins = c.prepareStatement(ins);
				//pins.setInt(icol, this.cr_id_usuario);icol++;
				pins.setString(icol, this.cr_email_usuario);icol++;
				if(this.getCr_id_usuario() == 0) {
					pins.setString(icol, this.cr_senha_usuario);icol++;
				}				
				pins.setString(icol, this.cr_nome_completo_usuario);icol++;
				pins.setString(icol, this.cr_cpf_usuario);icol++;
				pins.setString(icol, this.cr_telefone_usuario);icol++;
				pins.setString(icol, this.cr_cep_usuario);icol++;
				pins.setString(icol, this.cr_endereco_usuario);icol++;
				pins.setString(icol, this.cr_nrmcasa_usuario);icol++;
				pins.setString(icol, this.cr_endcomplemento_usuario);icol++;
				pins.setString(icol, this.cr_pontoreferencia_usuario);icol++;
				pins.setString(icol, this.cr_nivel_usuario);
								
				if(this.getCr_id_usuario() != 0) {
					icol++;
					pins.setInt(icol, this.cr_id_usuario);
				}
				
				pins.executeUpdate();
				
				if(null!=pins) {
					pins.close();
					pins=null;
				}
				
				if(this.cr_id_usuario != 0) {
					idRetorno = this.cr_id_usuario;
				}else {
					String sqlMax = " select max(cr_id_usuario) from cr_usuario ";
					Statement st = c.createStatement();
					ResultSet rs = st.executeQuery(sqlMax);
					if(rs.next()) {
						idRetorno = null!=rs.getObject(1)?rs.getInt(1):0;
						this.cr_id_usuario = idRetorno;
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
	
	/**
	 * Este é um código Java que retorna um objeto JSONArray com resultados de uma consulta SQL. 
	 * O código recebe dois arrays, um com os parâmetros da consulta e outro com os valores desses parâmetros. 
	 * A consulta é construída dinamicamente usando os parâmetros e seus respectivos valores. 
	 * Os resultados da consulta são convertidos em objetos JSON e adicionados a um JSONArray que é retornado pelo método. 
	 * O código também faz algumas formatações nos resultados, como formatar valores numéricos e datas.
	 * @return retorna e trata os dados do select padrão para que seja possível exibir a informação na consulta.
	 */
	public static JSONArray listarJSON(Object[] params, Object[] values) {
		JSONArray arrayRetorno = new JSONArray();
		String sql = SEL_PADRAO;
		if(params.length > 0 && values.length > 0) {
			for(int ob = 0; ob < params.length; ob++) {
				sql += " and "+params[ob]+" = ?";
			}
		}
		sql+= " order by cr_id_usuario ";
		System.out.println("Query="+sql);
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
			int cols =	rsmd.getColumnCount();
			while(r.next()) {
				JSONObject jsonObj = new JSONObject();
				for(int xc = 1;xc<=cols;xc++){
					if(java.sql.Types.TIMESTAMP== rsmd.getColumnType(xc)){
						try {
							jsonObj.put(rsmd.getColumnLabel(xc), null!=Cast.toDate(r.getObject(xc))?FormatUtils.dataHoraMinutoSegundoBr(r.getObject(xc)):"");
						}catch(Exception e) {
							jsonObj.put(rsmd.getColumnLabel(xc), "");
						} 
					}else if(java.sql.Types.VARCHAR == rsmd.getColumnType(xc)||
							java.sql.Types.CHAR == rsmd.getColumnType(xc)||		
							java.sql.Types.LONGVARCHAR == rsmd.getColumnType(xc)||
							java.sql.Types.NCHAR == rsmd.getColumnType(xc)||
							java.sql.Types.NVARCHAR == rsmd.getColumnType(xc)||
							java.sql.Types.LONGNVARCHAR == rsmd.getColumnType(xc)){
							jsonObj.put(rsmd.getColumnLabel(xc), null!=r.getObject(xc)?r.getString(xc).trim():"");
					}else if(java.sql.Types.DECIMAL == rsmd.getColumnType(xc) || java.sql.Types.DOUBLE == rsmd.getColumnType(xc)){
						jsonObj.put(rsmd.getColumnLabel(xc), null!=r.getObject(xc)?FormatUtils.formataValorDigitos(r.getObject(xc),2):"");
					}else if(java.sql.Types.DATE == rsmd.getColumnType(xc)){
						jsonObj.put(rsmd.getColumnLabel(xc), null!=r.getObject(xc)?FormatUtils.dateformat(r.getString(xc)):"");
					}else{
						jsonObj.put(rsmd.getColumnLabel(xc), r.getObject(xc));
					}
				}
				arrayRetorno.put(jsonObj);
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

		return arrayRetorno;
	}
	
	/**
	 *	A função valida_login recebe um email e uma senha como argumentos e retorna um inteiro que representa o 
	 *	id do usuário se as credenciais forem válidas ou 0 se forem inválidas. A função constrói uma consulta SQL para 
	 *	selecionar o id do usuário correspondente ao email e à senha fornecidos. Em seguida, ele executa a consulta 
	 *	usando um objeto Statement e retorna o resultado. Se ocorrer algum erro, a função retorna -1. 
	 * @return
	 */
	public static int valida_login(String cr_email_usuario, String cr_senha_usuario) {
		int idRetorno = 0;
		
		String loginSql = "select cr_id_usuario from cr_usuario where cr_email_usuario = '"+cr_email_usuario+"' and cr_senha_usuario = MD5('"+cr_senha_usuario+"') ";
		
		try {
			Connection c = ProjetoDatabase.getConnection(); // c = Connection.
			Statement st = c.createStatement();
			ResultSet rs = st.executeQuery(loginSql);
	
			if(rs.next()) {
				idRetorno = null!=rs.getObject(1)?rs.getInt(1):0;				
			}
			if(null!=rs) {
				rs.close();
				rs=null;
			}
			if(null!=st) {
				st.close();
				st=null;
			}			
			if(null!=c) {
				c.close();
				c=null;
			}
		}catch(Exception e) {
			e.printStackTrace();
			idRetorno = -1;
		}		
		return idRetorno;
	}
		
	/**
	 * Colocar Descrição aqui ARTHUR
	 * @return
	 */
	public static List<Cr_usuario> listUsuarios(Object[] params, Object[] values) {
		List<Cr_usuario> listaUsuarios = new ArrayList<Cr_usuario>();
		String sql = SEL_PADRAO;
	
		if(params.length > 0 && values.length > 0) {
			for(int ob = 0; ob < params.length; ob++) {
				sql += " and "+params[ob]+" = ?";
			}
		}
		
		sql+= " order by cr_id_usuario ";
		
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
				Cr_usuario r1u = new Cr_usuario(linhaDado);
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

	/**
	 * Colocar Descrição aqui ARTHUR 2
	 * @return
	 */
	public static Cr_usuario listUsuarioParam(String param, Object value) {
		List<Cr_usuario> listaUsuarios = new ArrayList<Cr_usuario>();
		Cr_usuario r1u = new Cr_usuario();
		Object[] params = new Object[1];
		params[0] = param;
		Object[] values = new Object[1];
		values[0] = value;
		listaUsuarios = Cr_usuario.listUsuarios(params,values);
		if(listaUsuarios.size() > 0) {
			r1u = listaUsuarios.get(0);	
		}
		return r1u;
	}
	
	public static int verificaEmail(String email) {
		int idRetorno = 0;
		String emailSql = "";
		String emailRetorno = "";
		String nomeRetorno = "";
		
		emailSql =  " SELECT " +									
					" cr_email_usuario, " +			
					" cr_nome_completo_usuario " +
					" FROM cr_usuario " +
					" where 1=1"+
					" and cr_email_usuario = '"+email+"'";
		
		try {
			Connection c = ProjetoDatabase.getConnection();
			Statement st = c.createStatement();
			ResultSet rs = st.executeQuery(emailSql);
			if(rs.next()) {
				emailRetorno = null!=rs.getObject(1)?rs.getString(1).trim():"";	
				nomeRetorno = null!=rs.getObject(2)?rs.getString(2).trim():"";	
			}
			System.out.println("@@@@@ VENDO SE O DADO ESTÁ DENTRO DO EMAIL RETORNO :: "+emailRetorno);
			if(!emailRetorno.equals("")) {
				idRetorno = 0;
				EmailEsqueciSenha ees = new EmailEsqueciSenha(); 
				ees.envioEmailEsqueciSenha(email, nomeRetorno);
				System.out.println("Não está vazio :: "+idRetorno);
			}else {
				idRetorno = -1;		
				System.out.println("Está vazio :: "+idRetorno);
			}
			if(null!=rs) {
				rs.close();
				rs=null;
			}
			if(null!=st) {
				st.close();
				st=null;
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
	
	public static int verificaEmailRecibo(String email) {
		int idRetorno = 0;
		String emailSql = "";
		String emailRetorno = "";
		String nomeRetorno = "";
		
		emailSql =  " SELECT " +									
					" cr_email_usuario, " +			
					" cr_nome_completo_usuario " +
					" FROM cr_usuario " +
					" where 1=1"+
					" and cr_email_usuario = '"+email+"'";
		
		try {
			Connection c = ProjetoDatabase.getConnection();
			Statement st = c.createStatement();
			ResultSet rs = st.executeQuery(emailSql);
			if(rs.next()) {
				emailRetorno = null!=rs.getObject(1)?rs.getString(1).trim():"";	
				nomeRetorno = null!=rs.getObject(2)?rs.getString(2).trim():"";	
			}
			System.out.println("@@@@@ VENDO SE O DADO ESTÁ DENTRO DO EMAIL RETORNO :: "+emailRetorno);
			if(!emailRetorno.equals("")) {
				idRetorno = 0;
				EmailEsqueciSenha ees = new EmailEsqueciSenha(); 
				ees.envioEmailReciboIngredientes(email, nomeRetorno);
				System.out.println("Não está vazio :: "+idRetorno);
			}else {
				idRetorno = -1;		
				System.out.println("Está vazio :: "+idRetorno);
			}
			if(null!=rs) {
				rs.close();
				rs=null;
			}
			if(null!=st) {
				st.close();
				st=null;
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
	
	public static int atualizaSenha(int id_usuario, String senha, String opc_senha_alterada) {
		int idRetorno = 0;

		String UPD_SENHA =	" UPDATE cr_usuario SET " +
				    		" cr_senha_usuario = MD5(?), "+	
				    		" cr_senha_alterada = ? "+	
				    		" WHERE cr_id_usuario = ? ";
		
		try {
			Connection co = ProjetoDatabase.getConnection();		
			PreparedStatement ps = co.prepareStatement(UPD_SENHA);			
			ps.setString(1, senha);
			ps.setString(2, opc_senha_alterada);
			ps.setInt(3, id_usuario);
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

	public Cr_usuario() {
		// TODO Auto-generated constructor stub
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		//Cr_usuario cru = new Cr_usuario();		
		//JSONArray retornolistar = new JSONArray();			
		//retornolistar = cru.listarJSON(args, args);		
		//System.out.println("Retorno da lista de Cr_usuario :: "+retornolistar);
			
	}
	
}