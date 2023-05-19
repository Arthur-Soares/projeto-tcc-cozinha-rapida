package projeto.model;

import java.io.File;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;

import br.com.neorelato.util.Cast;
import projeto.util.AppSecrets;
import projeto.util.FormatUtils;
import projeto.util.ProjetoDatabase;

/*
 
CREATE TABLE cr_ingredientes
(
   cr_id_ingrediente int auto_increment primary key not null,
   cr_ingrediente_nome_img varchar(255),
   cr_desc_ingrediente varchar(200) default '',
   cr_valor_ingrediente decimal(14,2),
   cr_nome_fornecedor varchar(200) default ''
);

 */

public class Cr_ingredientes {
	int cr_id_ingrediente = 0;
	String cr_ingrediente_nome_img = "";
	String cr_desc_ingrediente = "";
	BigDecimal cr_valor_ingrediente = BigDecimal.ZERO;
	String cr_nome_fornecedor = "";
	
	
	public static String SEL_PADRAO =   " SELECT " +
										" cr_id_ingrediente, " +
										" cr_ingrediente_nome_img," +
										" cr_desc_ingrediente, " +
										" cr_valor_ingrediente, " +
                                        " cr_nome_fornecedor " +
										" FROM cr_ingredientes "+ 
										" where 1=1 "; 

	public String INS_PADRAO =  " INSERT INTO cr_ingredientes " +
							  //" cr_id_ingrediente, " +
							  	" (cr_ingrediente_nome_img, " +
							 	" cr_desc_ingrediente, " +
							 	" cr_valor_ingrediente, " +
							 	" cr_nome_fornecedor " +
							    " ) VALUES " +
							    " (?,?,?,?)";

	public String UPD_PADRAO =	" UPDATE cr_ingredientes SET " +
								//" cr_id_ingrediente = ?, " +
								" cr_ingrediente_nome_img = ?, " +
								" cr_desc_ingrediente = ?, " +
								" cr_valor_ingrediente = ?, " +
								" cr_nome_fornecedor = ? " +
								" WHERE cr_id_ingrediente = ? ";
	
	public String DEL_PADRAO = " DELETE FROM cr_ingredientes WHERE cr_id_ingrediente = ?";
	
    //id
	public int getcr_id_ingrediente() {
		return cr_id_ingrediente;
	}

	public void setcr_id_ingrediente(int cr_id_ingrediente) {
		this.cr_id_ingrediente = cr_id_ingrediente;
	}

    //descrição
	public String getCr_desc_ingrediente() {
		return cr_desc_ingrediente;
	}

	public void setCr_desc_ingrediente(String cr_desc_ingrediente) {
		this.cr_desc_ingrediente = cr_desc_ingrediente;
	}    

    //valor
	public BigDecimal getCr_valor_ingrediente() {
		return cr_valor_ingrediente;
	}

	public void setCr_valor_ingrediente(BigDecimal cr_valor_ingrediente) {
		this.cr_valor_ingrediente = cr_valor_ingrediente;
	}

    //fornecedor
    public String getcr_nome_fornecedor() {
		return cr_nome_fornecedor;
	}

	public void setcr_nome_fornecedor(String cr_nome_fornecedor) {
		this.cr_nome_fornecedor = cr_nome_fornecedor;
	}

    //imagem
	public String getcr_ingrediente_nome_img() {
		return cr_ingrediente_nome_img;
	}

	public void setcr_ingrediente_nome_img(String cr_ingrediente_nome_img) {
		this.cr_ingrediente_nome_img = cr_ingrediente_nome_img;
	}

	public Cr_ingredientes() {
		// TODO Auto-generated constructor stub
	}

	public Cr_ingredientes(int cr_id_ingrediente, String cr_ingrediente_nome_img, String cr_desc_ingrediente, BigDecimal cr_valor_ingrediente, String cr_nome_fornecedor) {
		super();
		this.cr_id_ingrediente = cr_id_ingrediente;
		this.cr_ingrediente_nome_img = cr_ingrediente_nome_img;		
		this.cr_desc_ingrediente = cr_desc_ingrediente;
		this.cr_valor_ingrediente = cr_valor_ingrediente;
        this.cr_nome_fornecedor = cr_nome_fornecedor;
	}
	
	public Cr_ingredientes(List listObj) {
		super();
		int ind = 0;
		this.cr_id_ingrediente = listObj.size()>ind?(int)listObj.get(ind):0;ind++;
		this.cr_ingrediente_nome_img = listObj.size()>ind?(null!=listObj.get(ind)?listObj.get(ind).toString():""):"";ind++;
		this.cr_desc_ingrediente = listObj.size()>ind?(null!=listObj.get(ind)?listObj.get(ind).toString():""):"";ind++;
		this.cr_valor_ingrediente = listObj.size()>ind?(BigDecimal)listObj.get(ind):BigDecimal.ZERO;ind++;
        this.cr_nome_fornecedor = listObj.size()>ind?(null!=listObj.get(ind)?listObj.get(ind).toString():""):"";
	}
	

	public Cr_ingredientes(Map<String, String> mapParams) {
		super();
		
		this.cr_id_ingrediente = mapParams.containsKey("cr_id_ingrediente")?Cast.toInt(mapParams.get("cr_id_ingrediente")):0;
		this.cr_ingrediente_nome_img = mapParams.containsKey("cr_ingrediente_nome_img")?mapParams.get("cr_ingrediente_nome_img").trim():"";
		this.cr_desc_ingrediente = mapParams.containsKey("cr_desc_ingrediente")?mapParams.get("cr_desc_ingrediente").trim():"";
		this.cr_valor_ingrediente = mapParams.containsKey("cr_valor_ingrediente")?Cast.toBigDecimal((!"".equals(mapParams.get("cr_valor_ingrediente"))?mapParams.get("cr_valor_ingrediente"):0)):BigDecimal.ZERO;
		this.cr_nome_fornecedor = mapParams.containsKey("cr_nome_fornecedor")?mapParams.get("cr_nome_fornecedor").trim():"";
	}

	/**
	 * @author Gabriela Cattin
	 * @return o metodo salva_registro é responsavel por inserir ou alterar o registro na tabela cr_ingrediente
	 */
	public int salva_registro() {
		int idRetorno = 0;
		
		try {
			Connection c = ProjetoDatabase.getConnection();
			
			String ins = INS_PADRAO;
			if(this.getcr_id_ingrediente() != 0) {
				ins = UPD_PADRAO;
			}
			
				int icol = 1 ;
				PreparedStatement pins = c.prepareStatement(ins);
				//pins.setInt(icol, this.cr_id_ingrediente);icol++;
				pins.setString(icol, this.cr_ingrediente_nome_img);icol++;
				pins.setString(icol, this.cr_desc_ingrediente);icol++;
				pins.setBigDecimal(icol, this.cr_valor_ingrediente);icol++;
				pins.setString(icol, this.cr_nome_fornecedor);
				
				if(this.getcr_id_ingrediente() != 0) {
					icol++;
					pins.setInt(icol, this.cr_id_ingrediente);
				}
				
				pins.executeUpdate();
				
				if(null!=pins) {
					pins.close();
					pins=null;
				}
				
				if(this.cr_id_ingrediente != 0) {
					idRetorno = this.cr_id_ingrediente;
				}else {
					String sqlMax = " select max(cr_id_ingrediente) from cr_ingredientes ";
					Statement st = c.createStatement();
					ResultSet rs = st.executeQuery(sqlMax);
					if(rs.next()) {
						idRetorno = null!=rs.getObject(1)?rs.getInt(1):0;
						this.cr_id_ingrediente = idRetorno;
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
	 * Essa classe recebe o Id do usuario como parametro verifica se o Id é diferente de 0, caso seja é apagado da tabela no banco.
	 * @return
	 */
	public int apaga_registro(int id_ingrediente) {
		int idRetorno = 0;
		
		String delSql = DEL_PADRAO;
		System.out.println("Classe: Cr_ingrediente - Método: apaga_registro DELETE :: "+delSql+" id_ingrediente :: "+id_ingrediente);
		try {
			Connection c = ProjetoDatabase.getConnection(); // c = Connection.
			PreparedStatement ps = c.prepareStatement(delSql);			
			ps.setInt(1, id_ingrediente);	
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
		sql+= " order by cr_id_ingrediente ";
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
	
}

