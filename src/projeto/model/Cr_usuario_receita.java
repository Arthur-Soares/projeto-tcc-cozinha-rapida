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
create table cr_usuario_receita(
	cr_id_usuario_receita int auto_increment primary key not null,
	cr_id_usuario int,
	cr_id_receita int
);

create index ix_cr_usuario_receita_01 on cr_usuario_receita (cr_id_usuario);

create index ix_cr_usuario_receita_02 on cr_usuario_receita (cr_id_receita);

*/

public class Cr_usuario_receita {
	
	int cr_id_usuario_receita = 0;
	int cr_id_usuario = 0;
	int cr_id_receita = 0;
	
	public static String SQL_PADRAO = 	" SELECT " +
										" cr_id_usuario_receita, " +
										" cr_id_usuario, " +
										" cr_id_receita " +
										" FROM cr_usuario_receita " +
										" WHERE 1=1 " ;

	public String INS_PADRAO = 	" INSERT INTO cr_usuario_receita " +
								//" ( cr_id_usuario_receita, " +
								" ( cr_id_usuario, " +
								" cr_id_receita " +
								" ) VALUES  " +
								" (?,?) ";
	
	public String DEL_PADRAO =  " DELETE from cr_usuario_receita where cr_id_usuario = ? and cr_id_receita = ?" ;	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
	}	
	
	public int getCr_id_usuario_receita() {
		return cr_id_usuario_receita;
	}

	public void setCr_id_usuario_receita(int cr_id_usuario_receita) {
		this.cr_id_usuario_receita = cr_id_usuario_receita;
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

	public Cr_usuario_receita() {
		super();
	}
	
	public Cr_usuario_receita(int cr_id_usuario_receita, int cr_id_usuario, int cr_id_receita) {
		super();
		this.cr_id_usuario_receita = cr_id_usuario_receita;
		this.cr_id_usuario = cr_id_usuario;
		this.cr_id_receita = cr_id_receita;		
	}
	
	public Cr_usuario_receita(List listObj) {
		super();
		int ind = 0;
		this.cr_id_usuario_receita = listObj.size()>ind?(int)listObj.get(ind):0;ind++;
		this.cr_id_usuario = listObj.size()>ind?(int)listObj.get(ind):0;ind++;
		this.cr_id_receita = listObj.size()>ind?(int)listObj.get(ind):0;
	}

	public Cr_usuario_receita(Map<String, String> mapParams) {
		super();
		int ind = 0;
		this.cr_id_usuario_receita = mapParams.containsKey("cr_id_usuario_receita")?Cast.toInt(mapParams.get("cr_id_usuario_receita")):0;
		this.cr_id_usuario = mapParams.containsKey("cr_id_usuario")?Cast.toInt(mapParams.get("cr_id_usuario")):0;
		this.cr_id_receita = mapParams.containsKey("cr_id_receita")?Cast.toInt(mapParams.get("cr_id_receita")):0;		
	}	

	public int salva_registro() {
		int idRetorno = 0;
		
		try {
			Connection c = ProjetoDatabase.getConnection();
			
			String ins = INS_PADRAO;
			if(this.getCr_id_usuario_receita() != 0) {
				ins = "";
			}
			
				int icol = 1 ;
				PreparedStatement pins = c.prepareStatement(ins);
				//pins.setInt(icol, this.cr_id_usuario_receita);icol++;				
				pins.setInt(icol, this.cr_id_usuario);icol++;
				pins.setInt(icol, this.cr_id_receita);
				if(this.getCr_id_usuario_receita() != 0) {
					icol++;
					pins.setInt(icol, this.cr_id_usuario_receita);
				}
				pins.executeUpdate();
				if(null!=pins) {
					pins.close();
					pins=null;
				}
				
				if(this.cr_id_usuario_receita != 0) {
					idRetorno = this.cr_id_usuario_receita;
				}else {
					String sqlMax = "select max(cr_id_usuario_receita) from cr_usuario_receita";
					Statement st = c.createStatement();
					ResultSet rs = st.executeQuery(sqlMax);
					if(rs.next()) {
						idRetorno = null!=rs.getObject(1)?rs.getInt(1):0;
						this.cr_id_usuario_receita = idRetorno;
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
	

	public static JSONArray listarJSON(int id_usuario) {
		JSONArray arrayRetorno = new JSONArray();
		
		String sql = " SELECT " +
					 " r1_usuario.id_usuario, " +
					 " r1_usuario.nome_completo " +
					 " from r1_usuario " +
					 " left outer join digitador_supervisor on digitador_supervisor.id_supervisor = r1_usuario.id_usuario " +					 
					 " where digitador_supervisor.id_digitador = "+id_usuario;
		
		sql+= " order by r1_usuario.nome_completo ";
		
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
	
	public int favoritarReceita(int cr_id_receita, int cr_id_usuario) {
		int retorno = 0;
		
		String sql = INS_PADRAO;
		
		try {
			Connection c = ProjetoDatabase.getConnection();
			PreparedStatement p = c.prepareStatement(sql);
			p.setInt(1, cr_id_usuario);
			p.setInt(2, cr_id_receita);
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
	
	public int desfavoritarReceita(int cr_id_receita, int cr_id_usuario) {
		int retorno = 0;
		
		String sql = DEL_PADRAO;
		
		try {
			Connection c = ProjetoDatabase.getConnection();
			PreparedStatement p = c.prepareStatement(sql);
			p.setInt(1, cr_id_usuario);
			p.setInt(2, cr_id_receita);
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
	
	public String pintarCoracao(int cr_id_receita, int cr_id_usuario) {
		String retorno = "";
		
		String sql = SQL_PADRAO;
		
		sql +=  " and cr_id_usuario = "+cr_id_usuario +
				" and cr_id_receita = "+cr_id_receita ;
		
		try {
			Connection c = ProjetoDatabase.getConnection();
			PreparedStatement p = c.prepareStatement(sql);
			ResultSet rs = p.executeQuery();
			if(rs.next()){
				retorno = "favorita";
			}else {
				retorno = "desfavorita";
			}
			
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
		}
		
		return retorno;
	}
	
	public int salvaRelacionamento(String ids_supervisores, int id_usuario) {
		Set<Integer> setIdsSQL = new HashSet<Integer>();
		int idRetorno = 0;
		String ids_del = ids_supervisores;
		
		String sql_ins = INS_PADRAO;
		
		String sql = SQL_PADRAO;
		sql += " and id_digitador = "+id_usuario;
		
		System.out.println(" query sql :: "+sql);
		try {
			Connection c = ProjetoDatabase.getConnection();
			Statement st = c.createStatement();
			ResultSet rs = st.executeQuery(sql);
			while(rs.next()) {
				int id_supervisor = null!=rs.getObject(3)?rs.getInt(3):0;		
				setIdsSQL.add(id_supervisor);
			}

			String[] idsseparados = null;
			idsseparados = ids_supervisores.split(",");
			for(int i=0; i< idsseparados.length; i++){
				int idsup = Cast.toInt(idsseparados[i]);
				if(!setIdsSQL.contains(idsup)) {
					PreparedStatement pupd = c.prepareStatement(sql_ins);
					pupd.setInt(1, id_usuario);
					pupd.setInt(2, idsup);
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
			sql_sec +=  " and id_digitador = "+id_usuario +
						" and id_supervisor not in ("+ids_del+")";
			
			String del = " delete from digitador_supervisor " +
						 " where id_digitador_supervisor = ? " +
						 " and id_supervisor = ? " ;
			
			System.out.println(" query sql_sec :: "+sql_sec);
			Statement stsec = c.createStatement();
			ResultSet rssec = stsec.executeQuery(sql_sec);
			while(rssec.next()) {
				int id_digitador_supervisor = null!=rssec.getObject(1)?rssec.getInt(1):0;	
				int id_digitador = null!=rssec.getObject(2)?rssec.getInt(2):0;	
				int id_supervisor = null!=rssec.getObject(3)?rssec.getInt(3):0;
				
				PreparedStatement pdel = c.prepareStatement(del);
				pdel.setInt(1, id_digitador_supervisor);
				pdel.setInt(2, id_supervisor);
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
