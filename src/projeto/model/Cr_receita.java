package projeto.model;

import java.io.File;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;

import br.com.neorelato.util.Cast;
import projeto.util.AppSecrets;
import projeto.util.FormatUtils;
import projeto.util.ProjetoDatabase;

/*
 

CREATE TABLE cr_receita
(
   cr_id_receita int auto_increment primary key not null,
   cr_titulo_receita varchar(255) not null,
   cr_desc_receita text
);

ALTER TABLE cr_receita
drop column cr_desc_receita;

ALTER TABLE cr_receita
ADD COLUMN cr_ingrediente_receita varchar(255);

ALTER TABLE cr_receita
ADD COLUMN cr_modo_preparo_receita text;

ALTER TABLE cr_receita
ADD COLUMN cr_tempo_preparo_receita varchar(255);

ALTER TABLE cr_receita
ADD COLUMN cr_rendimento_receita varchar(255);

ALTER TABLE cr_receita
ADD COLUMN cr_valor_receita decimal(11,2);

ALTER TABLE cr_receita
CHANGE COLUMN cr_ingrediente_receita cr_ingrediente_receita text

ALTER TABLE cr_receita
ADD COLUMN cr_receita_nome_img varchar(255);

ALTER TABLE cr_receita
ADD COLUMN cr_receita_view int DEFAULT 0;

/**
 * 
 * @author Erick Rodrigues da Silva
 * A classe Cr_receita é responsável por parametrizar a tabela cr_receita 
 */

public class Cr_receita {
	int cr_id_receita = 0;
	String cr_titulo_receita = "";
	String cr_ingrediente_receita = "";
	String cr_modo_preparo_receita = "";
	String cr_tempo_preparo_receita = "";
	String cr_rendimento_receita = "";
	BigDecimal cr_valor_receita = BigDecimal.ZERO;
	String cr_receita_nome_img = "";
	int cr_receita_view = 0;
	
	
	public static String SEL_PADRAO =   " SELECT " +
										" cr_id_receita, " +
										" cr_titulo_receita, " +
										" cr_ingrediente_receita, " +
										" cr_modo_preparo_receita, " +
										" cr_tempo_preparo_receita, " +
										" cr_rendimento_receita, " +
										" cr_valor_receita, " +
										" cr_receita_nome_img, " +
										" cr_receita_view " +
										" FROM cr_receita "+ 
										" where 1=1 "; 

	public String INS_PADRAO =  " INSERT INTO cr_receita " +
							  //" cr_id_receita, " +
							 	" (cr_titulo_receita, " +
							 	" cr_ingrediente_receita, " +
							 	" cr_modo_preparo_receita, " +
							 	" cr_tempo_preparo_receita, " +
							 	" cr_rendimento_receita, " +
							 	" cr_valor_receita, " +
							 	" cr_receita_nome_img " +
							    " ) VALUES " +
							    " (?,?,?,?,?,?,?)";

	public String UPD_PADRAO =	" UPDATE cr_receita SET " +
								//" cr_id_receita = ?, " +
								" cr_titulo_receita = ?, " +
								" cr_ingrediente_receita = ?, " +
								" cr_modo_preparo_receita = ?, " +
								" cr_tempo_preparo_receita = ?, " +
								" cr_rendimento_receita = ?, " +
								" cr_valor_receita = ?, " +
								" cr_receita_nome_img = ? " +
								" WHERE cr_id_receita = ? ";
	
	public String DEL_PADRAO = " DELETE FROM cr_receita WHERE cr_id_receita = ?";
	
	public String getCr_ingrediente_receita() {
		return cr_ingrediente_receita;
	}

	public void setCr_ingrediente_receita(String cr_ingrediente_receita) {
		this.cr_ingrediente_receita = cr_ingrediente_receita;
	}

	public String getCr_modo_preparo_receita() {
		return cr_modo_preparo_receita;
	}

	public void setCr_modo_preparo_receita(String cr_modo_preparo_receita) {
		this.cr_modo_preparo_receita = cr_modo_preparo_receita;
	}

	public String getCr_tempo_preparo_receita() {
		return cr_tempo_preparo_receita;
	}

	public void setCr_tempo_preparo_receita(String cr_tempo_preparo_receita) {
		this.cr_tempo_preparo_receita = cr_tempo_preparo_receita;
	}

	public String getCr_rendimento_receita() {
		return cr_rendimento_receita;
	}

	public void setCr_rendimento_receita(String cr_rendimento_receita) {
		this.cr_rendimento_receita = cr_rendimento_receita;
	}

	public BigDecimal getCr_valor_receita() {
		return cr_valor_receita;
	}

	public void setCr_valor_receita(BigDecimal cr_valor_receita) {
		this.cr_valor_receita = cr_valor_receita;
	}

	public int getCr_id_receita() {
		return cr_id_receita;
	}

	public void setCr_id_receita(int cr_id_receita) {
		this.cr_id_receita = cr_id_receita;
	}

	public String getCr_titulo_receita() {
		return cr_titulo_receita;
	}

	public void setCr_titulo_receita(String cr_titulo_receita) {
		this.cr_titulo_receita = cr_titulo_receita;
	}

	public String getCr_receita_nome_img() {
		return cr_receita_nome_img;
	}

	public void setCr_receita_nome_img(String cr_receita_nome_img) {
		this.cr_receita_nome_img = cr_receita_nome_img;
	}

	public int getCr_receita_view() {
		return cr_receita_view;
	}

	public void setCr_receita_view(int cr_receita_view) {
		this.cr_receita_view = cr_receita_view;
	}

	public Cr_receita(int cr_id_receita, String cr_titulo_receita, String cr_ingrediente_receita, String cr_modo_preparo_receita, String cr_tempo_preparo_receita, String cr_rendimento_receita, BigDecimal cr_valor_receita, String cr_receita_nome_img, int cr_receita_view) {
		super();
		this.cr_id_receita = cr_id_receita;
		this.cr_titulo_receita = cr_titulo_receita;
		this.cr_ingrediente_receita = cr_ingrediente_receita;
		this.cr_modo_preparo_receita = cr_modo_preparo_receita;
		this.cr_tempo_preparo_receita = cr_tempo_preparo_receita;
		this.cr_rendimento_receita = cr_rendimento_receita;
		this.cr_valor_receita = cr_valor_receita;
		this.cr_receita_nome_img = cr_receita_nome_img;		
		this.cr_receita_view = cr_receita_view;
	}
	
	public Cr_receita(List listObj) {
		super();
		int ind = 0;
		this.cr_id_receita = listObj.size()>ind?(int)listObj.get(ind):0;ind++;
		this.cr_titulo_receita = listObj.size()>ind?(null!=listObj.get(ind)?listObj.get(ind).toString():""):"";ind++;
		this.cr_ingrediente_receita = listObj.size()>ind?(null!=listObj.get(ind)?listObj.get(ind).toString():""):"";ind++;
		this.cr_modo_preparo_receita = listObj.size()>ind?(null!=listObj.get(ind)?listObj.get(ind).toString():""):"";ind++;
		this.cr_tempo_preparo_receita = listObj.size()>ind?(null!=listObj.get(ind)?listObj.get(ind).toString():""):"";ind++;
		this.cr_rendimento_receita = listObj.size()>ind?(null!=listObj.get(ind)?listObj.get(ind).toString():""):"";ind++;
		this.cr_valor_receita = listObj.size()>ind?(BigDecimal)listObj.get(ind):BigDecimal.ZERO;ind++;
		this.cr_receita_nome_img = listObj.size()>ind?(null!=listObj.get(ind)?listObj.get(ind).toString():""):"";ind++;
		this.cr_receita_view = listObj.size()>ind?(int)listObj.get(ind):0;
	}
	

	public Cr_receita(Map<String, String> mapParams) {
		super();
		
		this.cr_id_receita = mapParams.containsKey("cr_id_receita")?Cast.toInt(mapParams.get("cr_id_receita")):0;
		this.cr_titulo_receita = mapParams.containsKey("cr_titulo_receita")?mapParams.get("cr_titulo_receita").trim():"";
		this.cr_ingrediente_receita = mapParams.containsKey("cr_ingrediente_receita")?mapParams.get("cr_ingrediente_receita").trim():"";
		this.cr_modo_preparo_receita = mapParams.containsKey("cr_modo_preparo_receita")?mapParams.get("cr_modo_preparo_receita").trim():"";
		this.cr_tempo_preparo_receita = mapParams.containsKey("cr_tempo_preparo_receita")?mapParams.get("cr_tempo_preparo_receita").trim():"";
		this.cr_rendimento_receita = mapParams.containsKey("cr_rendimento_receita")?mapParams.get("cr_rendimento_receita").trim():"";
		this.cr_valor_receita = mapParams.containsKey("cr_valor_receita")?Cast.toBigDecimal((!"".equals(mapParams.get("cr_valor_receita"))?mapParams.get("cr_valor_receita"):0)):BigDecimal.ZERO;
		this.cr_receita_nome_img = mapParams.containsKey("cr_receita_nome_img")?mapParams.get("cr_receita_nome_img").trim():"";
	}

	/**
	 * Essa classe recebe o Id do usuario como parametro verifica se o Id é diferente de 0, caso seja é apagado da tabela no banco.
	 * @return
	 */
	public int apaga_registro(int id_receita) {
		int idRetorno = 0;
		
		String delSql = DEL_PADRAO;
		System.out.println("Classe: Cr_receita - Método: apaga_registro DELETE :: "+delSql+" id_receita :: "+id_receita);
		try {
			Connection c = ProjetoDatabase.getConnection(); // c = Connection.
			PreparedStatement ps = c.prepareStatement(delSql);			
			ps.setInt(1, id_receita);	
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
	 * @author Erick Rodrigues da Silva
	 * @return o metodo salva_registro é responsavel por inserir ou alterar o registro na tabela cr_receita
	 */
	public int salva_registro() {
		int idRetorno = 0;
		
		try {
			Connection c = ProjetoDatabase.getConnection();
			
			String ins = INS_PADRAO;
			if(this.getCr_id_receita() != 0) {
				ins = UPD_PADRAO;
			}
			
				int icol = 1 ;
				PreparedStatement pins = c.prepareStatement(ins);
				//pins.setInt(icol, this.cr_id_receita);icol++;
				pins.setString(icol, this.cr_titulo_receita);icol++;
				pins.setString(icol, this.cr_ingrediente_receita);icol++;
				pins.setString(icol, this.cr_modo_preparo_receita);icol++;
				pins.setString(icol, this.cr_tempo_preparo_receita);icol++;
				pins.setString(icol, this.cr_rendimento_receita);icol++;
				pins.setBigDecimal(icol, this.cr_valor_receita);icol++;
				pins.setString(icol, this.cr_receita_nome_img);
				
				if(this.getCr_id_receita() != 0) {
					icol++;
					pins.setInt(icol, this.cr_id_receita);
				}
				
				pins.executeUpdate();
				
				if(null!=pins) {
					pins.close();
					pins=null;
				}
				
				if(this.cr_id_receita != 0) {
					idRetorno = this.cr_id_receita;
				}else {
					String sqlMax = " select max(cr_id_receita) from cr_receita ";
					Statement st = c.createStatement();
					ResultSet rs = st.executeQuery(sqlMax);
					if(rs.next()) {
						idRetorno = null!=rs.getObject(1)?rs.getInt(1):0;
						this.cr_id_receita = idRetorno;
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
			sql+= " order by cr_id_receita ";
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
				String ingrediente = "";
				long tamanho_ingrediente = 0L;
				
				String modo_preparo = "";
				long tamanho_modo_preparo = 0L;
				while(r.next()) {
					JSONObject jsonObj = new JSONObject();
					for(int xc = 1;xc<=cols;xc++){
//						if(xc == 3) {
//							ingrediente = null!=r.getObject(3)?r.getString(3):"";
//							tamanho_ingrediente = ingrediente.lines().count();
//						}
//						if(xc == 4) {
//							modo_preparo = null!=r.getObject(4)?r.getString(4):"";
//							if(!modo_preparo.equals("")) {
//								tamanho_modo_preparo = modo_preparo.lines().count();
//								if(modo_preparo.contains("\n")) {
//									String[] linhas = modo_preparo.split("\n");
//									for (String linha : linhas) {
//									    if(linha.length() > 125) {
//									    	tamanho_modo_preparo += 1L;
//									    }
//									}
//								}else if(modo_preparo.contains("\n\n")) {
//									String[] linhas = modo_preparo.split("\n\n");
//									for (String linha : linhas) {
//										if(linha.length() > 125) {
//									    	tamanho_modo_preparo += 1L;
//									    }
//									}
//								}
//							}
//						}

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
					jsonObj.put("tamanho_modo_preparo", tamanho_modo_preparo);
					jsonObj.put("tamanho_ingrediente", tamanho_ingrediente);
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
		
		public static JSONArray listarJSONRecFavoritas(int id_usuario_logado) {
			JSONArray arrayRetorno = new JSONArray();
			String sql = " SELECT " +
						 " cr_receita.cr_id_receita, " +
						 " cr_titulo_receita, " +
						 " cr_ingrediente_receita, " +
						 " cr_modo_preparo_receita, " +
						 " cr_tempo_preparo_receita, " +
						 " cr_rendimento_receita, " +
						 " cr_valor_receita, " +
						 " cr_receita_nome_img, " +
						 " cr_receita_view " +
						 " FROM cr_receita "+ 
						 " left outer join cr_usuario_receita on cr_usuario_receita.cr_id_receita = cr_receita.cr_id_receita " +
						 " where cr_usuario_receita.cr_id_usuario = "+id_usuario_logado;
				
			sql+= " order by cr_receita.cr_id_receita ";
			
			System.out.println("listarJSONRecFavoritas Query="+sql);
			try {
				Connection c = ProjetoDatabase.getConnection();
				PreparedStatement p = c.prepareStatement(sql);				
				
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
		
		
		public static JSONArray listarJSONRecSugestoes(int cr_id_receita) {
			JSONArray arrayRetorno = new JSONArray();
			String sql = " select distinct " +
						 " cr_receita.cr_id_receita, " +
						 " cr_receita.cr_titulo_receita, " +
						 " cr_receita.cr_receita_nome_img " +
						 " from cr_receita " +
						 " left outer join cr_receita_ingrediente on cr_receita_ingrediente.cr_id_receita = cr_receita.cr_id_receita " +
						 " where cr_receita_ingrediente.cr_id_ingrediente in (select " +
						 " cr_ingredientes.cr_id_ingrediente " +
						 " from cr_ingredientes " +
						 " inner join cr_receita_ingrediente on cr_receita_ingrediente.cr_id_ingrediente = cr_ingredientes.cr_id_ingrediente " +
						 " where cr_receita_ingrediente.cr_id_receita = "+cr_id_receita+") and cr_receita_ingrediente.cr_id_receita <> "+cr_id_receita+" LIMIT 2 ";						
			
			System.out.println("listarJSONRecFavoritas Query="+sql);
			try {
				Connection c = ProjetoDatabase.getConnection();
				PreparedStatement p = c.prepareStatement(sql);				
				
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
		
		/*public static Map<Integer,List<List>> listarJSONRecFavoritas(int id_usuario_logado) {		
			Map<Integer,List<List>> Map_dados_rec_favoritas = new LinkedHashMap<Integer,List<List>>();
			
			String sql = " SELECT " +
						 " cr_receita.cr_id_receita, " +
						 " cr_titulo_receita, " +
						 " cr_ingrediente_receita, " +
						 " cr_modo_preparo_receita, " +
						 " cr_tempo_preparo_receita, " +
						 " cr_rendimento_receita, " +
						 " cr_valor_receita, " +
						 " cr_receita_nome_img, " +
						 " cr_receita_view " +
						 " FROM cr_receita "+ 
						 " left outer join cr_usuario_receita on cr_usuario_receita.cr_id_receita = cr_receita.cr_id_receita " +
						 " where cr_usuario_receita.cr_id_usuario = "+id_usuario_logado+
						 " order by cr_receita.cr_id_receita ";						
			
			int cr_id_receita = 0;
			String cr_titulo_receita = "";
			String cr_receita_nome_img = "";
			
			List listDadosRec = new ArrayList<>();
			
			System.out.println("listarJSONRecFavoritas Query="+sql);
			try {
				Connection c = ProjetoDatabase.getConnection();
				PreparedStatement p = c.prepareStatement(sql);			
				
				ResultSet r = p.executeQuery();
				ResultSetMetaData rsmd = r.getMetaData();
				int cols =	rsmd.getColumnCount();
				while(r.next()) {
					cr_id_receita = null!=r.getObject(1)?r.getInt(1):0;
					cr_titulo_receita = null!=r.getObject(3)?r.getString(3):"";
					cr_receita_nome_img = null!=r.getObject(8)?r.getString(8):"";
					//System.out.println("cr_id_receita :: "+cr_id_receita+ " cr_titulo_receita :: "+cr_titulo_receita+ " cr_receita_nome_img :: "+cr_receita_nome_img);
					listDadosRec = cr_titulo_receita;
					Map_dados_rec_favoritas.put(cr_id_receita,listDadosRec);				
				}				
				//System.out.println("Map_dados_rec_favoritas :: "+Map_dados_rec_favoritas);
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
			return Map_dados_rec_favoritas;
		}
		*/
	
	/**
	 * Retorna SQL de Receitas.
	 * @author Arthur Soares da Silva
	 * @param opcaoSelect
	 * @return
	 */
	public static JSONArray alimentaSQLReceitas(String opcaoSelect) {
		JSONArray arrayRetorno = new JSONArray();
		String sql = SEL_PADRAO;	
		
		System.out.println("Query="+sql);
		try {
			Connection c = ProjetoDatabase.getConnection();
			PreparedStatement p = c.prepareStatement(sql);			
			ResultSet r = p.executeQuery();
			ResultSetMetaData rsmd = r.getMetaData();
			int cols =	rsmd.getColumnCount();
			while(r.next()) {
				JSONObject jsonObj = new JSONObject();
				if("S".equals(opcaoSelect)){
					String titulo_receita = (null!=r.getObject(2)?r.getString(2).trim():"");					
					String cr_receita_nome_img = (null!=r.getObject(8)?r.getString(8).trim():"");	
					jsonObj.put("text", 
								"<div class=\"row mt-3 mt-md-0 align-items-center justify-content-center\" style='padding:0px'> " +
								"  <div class=\"col-xl-5 col-lg-5 col-md-5 col-sm-12 col-12 text-center div_auto\"> " +
								"    <div class=\"div_image_autocomplete\"> "
										+cr_receita_nome_img+							
								"    </div> " +
								"  </div> " +
								"  <div class=\"mt-3 mt-md-0 col-xl-6 col-lg-6 col-md-6 col-sm-10 col-10 div_auto\" style=\"color:#b1463c;font-weight:800; font-size:12px;\"> "
										+titulo_receita+
								"  </div> " +
								"  <div class=\"mt-3 mt-md-0 col-xl-1 col-lg-1 col-md-1 col-sm-1 col-1\" style=\"color:#b1463c;font-weight:800; font-size:12px;\"> "
										+"<i class=\"fas fa-chevron-right fa-lg\"></i> "+
								"  </div> " +
								"</div> "				
						);
					jsonObj.put("value", (null!=r.getObject(1)?r.getString(1).trim():""));
					arrayRetorno.put(jsonObj);
				}else {
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
	 * @author Arthur Soares da Silva
	 * @return o metodo salva_arquivo é responsavel por inserir ou alterar o arquivo da imagem na tabela cr_receita
	 * @param Tem como parametros o nome do arquivo e o ID da receita na qual ele será inserido ou atualizado
	 */
	public int salva_arquivo(String cr_receita_nome_img, int cr_id_receita) {
		int idRetorno = 0;
		String nomeArquivo = "";
		
		try {
			Connection c = ProjetoDatabase.getConnection();

			String sqlArq = " select cr_receita_nome_img from cr_receita WHERE cr_id_receita = "+cr_id_receita;
			Statement st = c.createStatement();
			ResultSet rs = st.executeQuery(sqlArq);
			if(rs.next()) {
				nomeArquivo = null!=rs.getObject(1)?rs.getString(1):"";		
				System.out.println("SqulArq Nome do Arquivo :: "+nomeArquivo);
			}
			if(null!=rs) {
				rs.close();
				rs=null;
			}
			if(null!=st) {
				st.close();
				st=null;
			}
			
			/*
			if(!nomeArquivo.equals("")) {
				apagarArquivoPasta(nomeArquivo);
			}
			*/
			
			String ins_arquivo = " UPDATE cr_receita SET " +										  
						 		 " cr_receita_nome_img = ? " +								
						 		 " WHERE cr_id_receita = ? ";				
							
			PreparedStatement ps = c.prepareStatement(ins_arquivo);
			ps.setString(1, cr_receita_nome_img);
			ps.setInt(2, cr_id_receita);								
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
	
	public static int apagarArquivoPasta(String arq_nome) {
		String dir = AppSecrets.PATH_IMG;
		
		int nameIndex = arq_nome.lastIndexOf('.');	
		String extensao = arq_nome.substring(nameIndex+1).trim().toLowerCase();
		
		dir = dir + arq_nome;
		File f = new File(dir);
		
		try {
		if(f.exists()) {			
			arq_nome = arq_nome.substring(0, arq_nome.lastIndexOf("."));
			String dirFOP = AppSecrets.PATH_IMG+arq_nome;
			File fFop = new File(dirFOP);
			if(fFop.exists()) {
				if(fFop.delete()) {
					System.out.println("Arquivo deletado da pasta de imagens");
				}
			}
			if(f.delete()) {
				System.out.println("Arquivo deletado");
			}			
		}
		
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
		}
		return 0;
	}
	
	public int somaViewReceita(int cr_id_receita, int cr_receita_view) {
		int retornaView = 0;
		
		String upd_somaview = " UPDATE cr_receita SET " +										  
					 		  " cr_receita_view = ? " +								
					 		  " WHERE cr_id_receita = ? ";
		
		if(cr_id_receita != 0) {
			cr_receita_view++;
		}else {
			cr_receita_view = 0;
		}
		
		try {
			Connection c = ProjetoDatabase.getConnection();																									
			PreparedStatement ps = c.prepareStatement(upd_somaview);
			ps.setInt(1, cr_receita_view);
			ps.setInt(2, cr_id_receita);								
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
			retornaView = -1;
		}		
		return retornaView;
	}
	
	/**
	 * @return retorna e trata os dados do select padrão para que seja possível exibir a informação na consulta.
	 */
	public static JSONArray listaTopViews(Object[] params, Object[] values) {
		JSONArray arrayRetorno = new JSONArray();
		String sql = SEL_PADRAO;
		if(params.length > 0 && values.length > 0) {
			for(int ob = 0; ob < params.length; ob++) {
				sql += " and "+params[ob]+" = ?";
			}
		}
		sql+= " order by cr_receita_view desc " +
			  "LIMIT 12; ";
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

	
	public Cr_receita() {
		// TODO Auto-generated constructor stub
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		//Cr_usuario cru = new Cr_usuario();		
		//JSONArray retornolistar = new JSONArray();			
		//retornolistar = cru.listarJSON(args, args);
		String txt = "Passados 15 minutos, retire a linguiça, o paio, corte em rodelas, volte eles para a panela com o lombo e carne seca (cortados em";
		System.out.println("Retorno da lista de Cr_usuario :: "+txt.length());
			
	}
	
}