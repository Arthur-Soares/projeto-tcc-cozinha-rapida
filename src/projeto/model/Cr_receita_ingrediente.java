package projeto.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.json.JSONArray;
import org.json.JSONObject;

import projeto.util.Cast;
import projeto.util.FormatUtils;
import projeto.util.ProjetoDatabase;

/*
create table cr_receita_ingrediente(
	cr_id_receita_ingrediente int auto_increment primary key not null,
	cr_id_receita int,
	cr_id_ingrediente int
);

create index ix_cr_receita_ingrediente_01 on cr_receita_ingrediente (cr_id_receita);

create index ix_cr_receita_ingrediente_02 on cr_receita_ingrediente (cr_id_ingrediente);

*/

public class Cr_receita_ingrediente {
	
	int cr_id_receita_ingrediente = 0;
	int cr_id_receita = 0;
	int cr_id_ingrediente = 0;
	
	public static String SQL_PADRAO = 	" SELECT " +
										" cr_id_receita_ingrediente, " +
										" cr_id_receita, " +
										" cr_id_ingrediente " +
										" FROM cr_receita_ingrediente " +
										" WHERE 1=1 " ;

	public String INS_PADRAO = 	" INSERT INTO cr_receita_ingrediente " +
								//" ( cr_id_receita_ingrediente, " +
								" ( cr_id_receita, " +
								" cr_id_ingrediente " +
								" ) VALUES  " +
								" (?,?) ";
	
	public String DEL_PADRAO =  " DELETE from cr_receita_ingrediente where cr_id_receita = ? and cr_id_ingrediente = ?" ;	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
	}	
	
	public int getCr_id_receita_ingrediente() {
		return cr_id_receita_ingrediente;
	}

	public void setCr_id_receita_ingrediente(int cr_id_receita_ingrediente) {
		this.cr_id_receita_ingrediente = cr_id_receita_ingrediente;
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

	public Cr_receita_ingrediente() {
		super();
	}
	
	public Cr_receita_ingrediente(int cr_id_receita_ingrediente, int cr_id_receita, int cr_id_ingrediente) {
		super();
		this.cr_id_receita_ingrediente = cr_id_receita_ingrediente;
		this.cr_id_receita = cr_id_receita;
		this.cr_id_ingrediente = cr_id_ingrediente;		
	}
	
	public Cr_receita_ingrediente(List listObj) {
		super();
		int ind = 0;
		this.cr_id_receita_ingrediente = listObj.size()>ind?(int)listObj.get(ind):0;ind++;
		this.cr_id_receita = listObj.size()>ind?(int)listObj.get(ind):0;ind++;
		this.cr_id_ingrediente = listObj.size()>ind?(int)listObj.get(ind):0;
	}

	public Cr_receita_ingrediente(Map<String, String> mapParams) {
		super();
		this.cr_id_receita_ingrediente = mapParams.containsKey("cr_id_receita_ingrediente")?Cast.toInt(mapParams.get("cr_id_receita_ingrediente")):0;
		this.cr_id_receita = mapParams.containsKey("cr_id_receita")?Cast.toInt(mapParams.get("cr_id_receita")):0;
		this.cr_id_ingrediente = mapParams.containsKey("cr_id_ingrediente")?Cast.toInt(mapParams.get("cr_id_ingrediente")):0;		
	}	

	public int salva_registro() {
		int idRetorno = 0;
		
		try {
			Connection c = ProjetoDatabase.getConnection();
			
			String ins = INS_PADRAO;
			if(this.getCr_id_receita_ingrediente() != 0) {
				ins = "";
			}
			
				int icol = 1 ;
				PreparedStatement pins = c.prepareStatement(ins);
				//pins.setInt(icol, this.cr_id_receita_ingrediente);icol++;				
				pins.setInt(icol, this.cr_id_receita);icol++;
				pins.setInt(icol, this.cr_id_ingrediente);
				if(this.getCr_id_receita_ingrediente() != 0) {
					icol++;
					pins.setInt(icol, this.cr_id_receita_ingrediente);
				}
				pins.executeUpdate();
				if(null!=pins) {
					pins.close();
					pins=null;
				}
				
				if(this.cr_id_receita_ingrediente != 0) {
					idRetorno = this.cr_id_receita_ingrediente;
				}else {
					String sqlMax = "select max(cr_id_receita_ingrediente) from cr_receita_ingrediente";
					Statement st = c.createStatement();
					ResultSet rs = st.executeQuery(sqlMax);
					if(rs.next()) {
						idRetorno = null!=rs.getObject(1)?rs.getInt(1):0;
						this.cr_id_receita_ingrediente = idRetorno;
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
	
	public int deletarReceitaIngrediente(int cr_id_receita, int cr_id_ingrediente) {
		int retorno = 0;
		
		String sql = DEL_PADRAO;
		
		try {
			Connection c = ProjetoDatabase.getConnection();
			PreparedStatement p = c.prepareStatement(sql);
			p.setInt(1, cr_id_receita);
			p.setInt(2, cr_id_ingrediente);
			p.executeUpdate();
			
			if(null!=p) {
				p.close();
				p=null;
			}
			if(null!=c) {
				c.close();
				c=null;
			}
		}catch(Exception ex) {
			ex.printStackTrace();
			retorno = -1;
		}
		
		return retorno;
	}

	public static JSONArray listarJSON(int id_receita) {
		JSONArray arrayRetorno = new JSONArray();
		
		String sql = " SELECT " +
					 " cr_ingredientes.cr_id_ingrediente, " +
					 " cr_ingredientes.cr_ingrediente_nome_img, " +
					 " cr_ingredientes.cr_desc_ingrediente, " +
					 " cr_ingredientes.cr_valor_ingrediente, " +
					 " cr_ingredientes.cr_nome_fornecedor " +
					 " from cr_ingredientes " +
					 " left outer join cr_receita_ingrediente on cr_receita_ingrediente.cr_id_ingrediente = cr_ingredientes.cr_id_ingrediente " +					 
					 " where cr_receita_ingrediente.cr_id_receita = "+id_receita;
		
		sql+= " order by cr_ingredientes.cr_desc_ingrediente ";
		
		System.out.println(" query :: "+sql);
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
	
	public int salvaRelacionamento(String ids_ingredientes, int id_receita) {
		Set<Integer> setIdsSQL = new HashSet<Integer>();
		int idRetorno = 0;
		String ids_del = ids_ingredientes;
		
		String sql_ins = INS_PADRAO;
		
		String sql = SQL_PADRAO;
		sql += " and cr_id_receita = "+id_receita;
		
		System.out.println(" query sql :: "+sql);
		try {
			Connection c = ProjetoDatabase.getConnection();
			Statement st = c.createStatement();
			ResultSet rs = st.executeQuery(sql);
			while(rs.next()) {
				int cr_id_ingrediente = null!=rs.getObject(3)?rs.getInt(3):0;		
				setIdsSQL.add(cr_id_ingrediente);
			}

			String[] idsseparados = null;
			idsseparados = ids_ingredientes.split(",");
			for(int i=0; i< idsseparados.length; i++){
				int iding = Cast.toInt(idsseparados[i]);
				if(!setIdsSQL.contains(iding)) {
					PreparedStatement pupd = c.prepareStatement(sql_ins);
					pupd.setInt(1, id_receita);
					pupd.setInt(2, iding);
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
			
			String sql_sec = SQL_PADRAO;
			sql_sec +=  " and cr_id_receita = "+id_receita;
					
			if(!ids_del.equals("")) {
				sql_sec += " and cr_id_ingrediente not in ("+ids_del+")";
			}
						
			String del = " delete from cr_receita_ingrediente " +
						 " where cr_id_receita_ingrediente = ? " +
						 " and cr_id_ingrediente = ? " ;
			
			System.out.println(" query sql_sec :: "+sql_sec);
			Statement stsec = c.createStatement();
			ResultSet rssec = stsec.executeQuery(sql_sec);
			while(rssec.next()) {
				int cr_receita_ingrediente = null!=rssec.getObject(1)?rssec.getInt(1):0;	
				//int cr_id_receita = null!=rssec.getObject(2)?rssec.getInt(2):0;	
				int cr_id_ingrediente = null!=rssec.getObject(3)?rssec.getInt(3):0;
				
				PreparedStatement pdel = c.prepareStatement(del);
				pdel.setInt(1, cr_receita_ingrediente);
				pdel.setInt(2, cr_id_ingrediente);
				pdel.executeUpdate();
				if(null != pdel) {
					pdel.close();
					pdel = null;
				}
			}
			
			if(null!=rssec) {
				rssec.close();
				rssec=null;
			}
			if(null!=stsec) {
				stsec.close();
				stsec=null;
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
}
