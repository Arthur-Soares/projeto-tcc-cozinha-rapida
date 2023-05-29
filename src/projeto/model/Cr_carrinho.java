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
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.json.JSONArray;
import org.json.JSONObject;

import br.com.neorelato.util.Cast;
import projeto.util.AppSecrets;
import projeto.util.FormatUtils;
import projeto.util.ProjetoDatabase;

/*
 
CREATE TABLE cr_carrinho(
	cr_id_carrinho int auto_increment primary key not null,
	cr_id_usuario int,
	cr_id_receita int,
	cr_id_ingrediente int,
	cr_quantidade int,
	cr_valor_ingrediente numeric(14,2),
	cr_valor_total numeric(14,2)
);

/**
 * 
 * @author Gabriela Cattin Gomes
 * A classe Cr_carrinho é responsável por parametrizar a tabela cr_carrinho 
 */

public class Cr_carrinho {
	int cr_id_carrinho = 0;
	int cr_id_usuario = 0;	
	int cr_id_receita = 0;
	int cr_id_ingrediente = 0;
	int cr_quantidade = 0;
	BigDecimal cr_valor_ingrediente = BigDecimal.ZERO;
	BigDecimal cr_valor_total = BigDecimal.ZERO;
	
	BigDecimal cr_valor_receita = BigDecimal.ZERO;
	
	
	public static String SEL_PADRAO =   " SELECT " +
										" cr_id_carrinho, " +
										" cr_id_usuario, " +										
										" cr_id_receita, " +
										" cr_id_ingrediente, " +
										" cr_quantidade, " +
										" cr_valor_ingrediente, " +
										" cr_valor_total " +
										" FROM cr_carrinho "+ 
										" where 1=1 "; 

	public String INS_PADRAO =  " INSERT INTO cr_carrinho " +
							  //" cr_id_carrinho, " +
							 	" (cr_id_usuario, " +
							 	" cr_id_receita, " +
							 	" cr_id_ingrediente, " +
							 	" cr_quantidade, " +
							 	" cr_valor_ingrediente, " +
								" cr_valor_total " +							 	
							    " ) VALUES " +
							    " (?,?,?,?,?,?)";

	public String UPD_PADRAO =	" UPDATE cr_carrinho SET " +
								//" cr_id_carrinho = ?, " +
								" cr_id_usuario = ?, " +
								" cr_id_receita = ?, " +
								" cr_id_ingrediente = ?, " +
								" cr_quantidade = ?, " +
								" cr_valor_ingrediente = ?, " +
								" cr_valor_total = ? " +								
								" WHERE cr_id_carrinho = ? ";
	
	public String DEL_PADRAO = " DELETE FROM cr_carrinho WHERE cr_id_carrinho = ?";		

	public int getCr_id_carrinho() {
		return cr_id_carrinho;
	}

	public void setCr_id_carrinho(int cr_id_carrinho) {
		this.cr_id_carrinho = cr_id_carrinho;
	}

	public int getCr_id_usuario() {
		return cr_id_usuario;
	}

	public void setCr_id_usuario(int cr_id_usuario) {
		this.cr_id_usuario = cr_id_usuario;
	}

	public int getCr_id_receita() {
		return cr_id_receita;
	}

	public void setCr_id_receita(int cr_id_receita) {
		this.cr_id_receita = cr_id_receita;
	}

	public int getCr_id_ingrediente() {
		return cr_id_ingrediente;
	}

	public void setCr_id_ingrediente(int cr_id_ingrediente) {
		this.cr_id_ingrediente = cr_id_ingrediente;
	}

	public int getCr_quantidade() {
		return cr_quantidade;
	}

	public void setCr_quantidade(int cr_quantidade) {
		this.cr_quantidade = cr_quantidade;
	}

	public BigDecimal getCr_valor_ingrediente() {
		return cr_valor_ingrediente;
	}

	public void setCr_valor_ingrediente(BigDecimal cr_valor_ingrediente) {
		this.cr_valor_ingrediente = cr_valor_ingrediente;
	}

	public BigDecimal getCr_valor_total() {
		return cr_valor_total;
	}

	public void setCr_valor_total(BigDecimal cr_valor_total) {
		this.cr_valor_total = cr_valor_total;
	}

	public BigDecimal getCr_valor_receita() {
		return cr_valor_receita;
	}

	public void setCr_valor_receita(BigDecimal cr_valor_receita) {
		this.cr_valor_receita = cr_valor_receita;
	}

	public Cr_carrinho(int cr_id_carrinho, int cr_id_usuario, int cr_id_receita, int cr_id_ingrediente, int cr_quantidade, BigDecimal cr_valor_ingrediente, BigDecimal cr_valor_total) {
		super();
		this.cr_id_carrinho = cr_id_carrinho;
		this.cr_id_usuario = cr_id_usuario;
		this.cr_id_receita = cr_id_receita;
		this.cr_id_ingrediente = cr_id_ingrediente;
		this.cr_quantidade = cr_quantidade;
		this.cr_valor_ingrediente = cr_valor_ingrediente;
		this.cr_valor_total = cr_valor_total;		
	}
	
	public Cr_carrinho(List listObj) {
		super();
		int ind = 0;
		this.cr_id_carrinho = listObj.size()>ind?(int)listObj.get(ind):0;ind++;
		this.cr_id_usuario = listObj.size()>ind?(int)listObj.get(ind):0;ind++;
		this.cr_id_receita = listObj.size()>ind?(int)listObj.get(ind):0;ind++;
		this.cr_id_ingrediente = listObj.size()>ind?(int)listObj.get(ind):0;ind++;
		this.cr_quantidade = listObj.size()>ind?(int)listObj.get(ind):0;ind++;		
		this.cr_valor_ingrediente = listObj.size()>ind?(BigDecimal)listObj.get(ind):BigDecimal.ZERO;ind++;
		this.cr_valor_total = listObj.size()>ind?(BigDecimal)listObj.get(ind):BigDecimal.ZERO;
	}
	

	public Cr_carrinho(Map<String, String> mapParams) {
		super();
		
		this.cr_id_carrinho = mapParams.containsKey("cr_id_carrinho")?Cast.toInt(mapParams.get("cr_id_carrinho")):0;
		this.cr_id_usuario = mapParams.containsKey("cr_id_usuario")?Cast.toInt(mapParams.get("cr_id_usuario")):0;
		this.cr_id_receita = mapParams.containsKey("cr_id_receita")?Cast.toInt(mapParams.get("cr_id_receita")):0;
		this.cr_id_ingrediente = mapParams.containsKey("cr_id_ingrediente")?Cast.toInt(mapParams.get("cr_id_ingrediente")):0;
		this.cr_quantidade = mapParams.containsKey("cr_quantidade")?Cast.toInt(mapParams.get("cr_quantidade")):0;		
		this.cr_valor_ingrediente = mapParams.containsKey("cr_valor_ingrediente")?Cast.toBigDecimal((!"".equals(mapParams.get("cr_valor_ingrediente"))?mapParams.get("cr_valor_ingrediente"):0)):BigDecimal.ZERO;
		this.cr_valor_total = mapParams.containsKey("cr_valor_total")?Cast.toBigDecimal((!"".equals(mapParams.get("cr_valor_total"))?mapParams.get("cr_valor_total"):0)):BigDecimal.ZERO;
	}

	/**
	 * Essa classe recebe o Id do usuario como parametro verifica se o Id é diferente de 0, caso seja é apagado da tabela no banco.
	 * @return
	 */
	public int apaga_registro(int cr_id_carrinho) {
		int idRetorno = 0;
		
		String delSql = DEL_PADRAO;
		System.out.println("Classe: Cr_carrinho - Método: apaga_registro DELETE :: "+delSql+" cr_id_carrinho :: "+cr_id_carrinho);
		try {
			Connection c = ProjetoDatabase.getConnection(); // c = Connection.
			PreparedStatement ps = c.prepareStatement(delSql);			
			ps.setInt(1, cr_id_carrinho);	
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
	 * @return o metodo salva_registro é responsavel por inserir ou alterar o registro na tabela cr_carrinho
	 */
	public int salva_registro() {
		int idRetorno = 0;
		
		try {
			Connection c = ProjetoDatabase.getConnection();
			
			String ins = INS_PADRAO;
			if(this.getCr_id_carrinho() != 0) {
				ins = UPD_PADRAO;
			}
			
				int icol = 1 ;
				PreparedStatement pins = c.prepareStatement(ins);
				//pins.setInt(icol, this.cr_id_carrinho);icol++;
				pins.setInt(icol, this.cr_id_usuario);icol++;
				pins.setInt(icol, this.cr_id_receita);icol++;
				pins.setInt(icol, this.cr_id_ingrediente);icol++;
				pins.setInt(icol, this.cr_quantidade);icol++;			
				pins.setBigDecimal(icol, this.cr_valor_ingrediente);icol++;	
				pins.setBigDecimal(icol, this.cr_valor_total);
				
				if(this.getCr_id_carrinho() != 0) {
					icol++;
					pins.setInt(icol, this.cr_id_carrinho);
				}
				
				pins.executeUpdate();
				
				if(null!=pins) {
					pins.close();
					pins=null;
				}
				
				if(this.cr_id_carrinho != 0) {
					idRetorno = this.cr_id_carrinho;
				}else {
					String sqlMax = " select max(cr_id_carrinho) from cr_carrinho ";
					Statement st = c.createStatement();
					ResultSet rs = st.executeQuery(sqlMax);
					if(rs.next()) {
						idRetorno = null!=rs.getObject(1)?rs.getInt(1):0;
						this.cr_id_carrinho = idRetorno;
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
			sql+= " order by cr_id_carrinho ";
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
		
		public static JSONArray listarJSONCarrinho(int id_usuario_logado) {
			JSONArray arrayRetorno = new JSONArray();
			
			String sql = " SELECT " +
						 " cr_carrinho.cr_id_carrinho, " +
						 " cr_carrinho.cr_id_usuario, " +
						 " cr_carrinho.cr_id_receita, " +
						 " cr_carrinho.cr_id_ingrediente, " +
						 " cr_carrinho.cr_quantidade, " +
						 " cr_carrinho.cr_valor_ingrediente, " +
						 " cr_carrinho.cr_valor_total, " +						 
						 " cr_ingredientes.cr_desc_ingrediente " +						 
						 " FROM cr_carrinho "+ 
						 " left outer join cr_ingredientes on cr_ingredientes.cr_id_ingrediente = cr_carrinho.cr_id_ingrediente " +
						 " where cr_carrinho.cr_id_usuario = "+id_usuario_logado;
				
			sql+= " order by cr_carrinho.cr_id_carrinho ";
			
			System.out.println("listarJSONCarrinho Query="+sql);
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
		
		public int salvaCarrinho(int cr_id_usuario, int p_cr_id_receita, String ids_ingredientes, String qtds_ingredientes) {
			Set<Integer> setIdsSQL = new HashSet<Integer>();
			int idRetorno = 0;
			//String ids_del = ids_empresas_pag;
			
			String sql_ins = INS_PADRAO;
			
			String sql_upd = UPD_PADRAO;
			
			String sql = SEL_PADRAO;
				  sql += " and cr_id_usuario = "+cr_id_usuario;					
			
			System.out.println(" query sql :: "+sql);
			try {
				Connection c = ProjetoDatabase.getConnection();
				Statement st = c.createStatement();
				ResultSet rs = st.executeQuery(sql);
				while(rs.next()) {
					int id_ingrediente_car = null!=rs.getObject(4)?rs.getInt(4):0;
					setIdsSQL.add(id_ingrediente_car);
				}
				
				String[] idsseparadosing = null;
				idsseparadosing = ids_ingredientes.split(",");
				String[] qtdsseparadosing = null;
				qtdsseparadosing = qtds_ingredientes.split(",");
				for(int i=0; i< idsseparadosing.length; i++){
				
					int iding = Cast.toInt(idsseparadosing[i]);
					int qtding = Cast.toInt(qtdsseparadosing[i]);
					
					String sql_val_ingrediente = " SELECT " +
												 " cr_ingredientes.cr_valor_ingrediente, " +
												 " cr_carrinho.cr_quantidade, " +
												 " cr_carrinho.cr_id_carrinho " +
												 " FROM cr_ingredientes " +
												 " left outer join cr_carrinho on cr_carrinho.cr_id_ingrediente = cr_ingredientes.cr_id_ingrediente and cr_carrinho.cr_id_usuario = "+cr_id_usuario+							
												 " where cr_ingredientes.cr_id_ingrediente = "+iding;		
					
					BigDecimal cr_valor_ingrediente = BigDecimal.ZERO;
					int cr_qtd_ingrediente_car = 0;
					int cr_id_carrinho = 0;
					
					Statement stval = c.createStatement();
					ResultSet rsval = stval.executeQuery(sql_val_ingrediente);
					while(rsval.next()) {
						cr_valor_ingrediente = null!=rsval.getObject(1)?rsval.getBigDecimal(1):BigDecimal.ZERO;
						cr_qtd_ingrediente_car = null!=rsval.getObject(2)?rsval.getInt(2):0;
						cr_id_carrinho = null!=rsval.getObject(3)?rsval.getInt(3):0;
					}
					
					if(null!=rsval) {
						rsval.close();
						rsval=null;
					}
					if(null!=stval) {
						stval.close();
						stval=null;
					}

					qtding = qtding + cr_qtd_ingrediente_car;
					
					BigDecimal cr_valor_total = BigDecimal.ZERO;
					
					if(!setIdsSQL.contains(iding)) {						
						cr_valor_total = cr_valor_ingrediente.multiply(Cast.toBigDecimal(qtding));
						
						PreparedStatement pupd = c.prepareStatement(sql_ins);						
						pupd.setInt(1, cr_id_usuario);
						pupd.setInt(2, p_cr_id_receita);
						pupd.setInt(3, iding);
						pupd.setInt(4, qtding);
						pupd.setBigDecimal(5, cr_valor_ingrediente);
						pupd.setBigDecimal(6, cr_valor_total);
						pupd.executeUpdate();
						if(null != pupd) {
							pupd.close();
							pupd = null;
						}					
					}else {						
						cr_valor_total = cr_valor_ingrediente.multiply(Cast.toBigDecimal(qtding));
						
						PreparedStatement pupd = c.prepareStatement(sql_upd);						
						pupd.setInt(1, cr_id_usuario);
						pupd.setInt(2, p_cr_id_receita);
						pupd.setInt(3, iding);
						pupd.setInt(4, qtding);
						pupd.setBigDecimal(5, cr_valor_ingrediente);
						pupd.setBigDecimal(6, cr_valor_total);
						pupd.setInt(7, cr_id_carrinho);
						pupd.executeUpdate();
						if(null != pupd) {
							pupd.close();
							pupd = null;
						}	
					}
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
		
	public Cr_carrinho() {
		// TODO Auto-generated constructor stub
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		//Cr_usuario cru = new Cr_usuario();		
		//JSONArray retornolistar = new JSONArray();			
		//retornolistar = cru.listarJSON(args, args);		
	}
	
}