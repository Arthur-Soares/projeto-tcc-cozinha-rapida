package projeto.model;

import java.math.BigDecimal;
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
ADD COLUMN cr_valor_receita decimal(11,2) ;

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
	BigDecimal  cr_valor_receita = BigDecimal.ZERO;
	
	
	public static String SEL_PADRAO =   " SELECT " +
										" cr_id_receita, " +
										" cr_titulo_receita, " +
										" cr_ingrediente_receita, " +
										" cr_modo_preparo_receita, " +
										" cr_tempo_preparo_receita, " +
										" cr_rendimento_receita, " +
										" cr_valor_receita " +
										" FROM cr_receita "+ 
										" where 1=1 "; 

	public String INS_PADRAO =  " INSERT INTO cr_receita " +
							  //" cr_id_receita, " +
							 	" (cr_titulo_receita, " +
							 	" cr_ingrediente_receita, " +
							 	" cr_modo_preparo_receita, " +
							 	" cr_tempo_preparo_receita, " +
							 	" cr_rendimento_receita, " +
							 	" cr_valor_receita " +
							    " ) VALUES " +
							    " (?,?,?,?,?,?)";

	public String UPD_PADRAO =	" UPDATE cr_receita SET " +
								//" cr_id_receita = ?, " +
								" cr_titulo_receita = ?, " +
								" cr_ingrediente_receita = ?, " +
								" cr_modo_preparo_receita = ?, " +
								" cr_tempo_preparo_receita = ?, " +
								" cr_rendimento_receita = ?, " +
								" cr_valor_receita = ? " +
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

	

	public Cr_receita(int cr_id_receita, String cr_titulo_receita, String cr_ingrediente_receita, String cr_modo_preparo_receita, String cr_tempo_preparo_receita, String cr_rendimento_receita, BigDecimal cr_valor_receita) {
		super();
		this.cr_id_receita = cr_id_receita;
		this.cr_titulo_receita = cr_titulo_receita;
		this.cr_ingrediente_receita = cr_ingrediente_receita;
		this.cr_modo_preparo_receita = cr_modo_preparo_receita;
		this.cr_tempo_preparo_receita = cr_tempo_preparo_receita;
		this.cr_rendimento_receita = cr_rendimento_receita;
		this.cr_valor_receita = cr_valor_receita;
		
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
		this.cr_valor_receita = listObj.size()>ind?(BigDecimal)listObj.get(ind):BigDecimal.ZERO;
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
				pins.setBigDecimal(icol, this.cr_valor_receita);
								
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
	 * 
	 * 
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
		//System.out.println("Retorno da lista de Cr_usuario :: "+retornolistar);
			
	}
	
}