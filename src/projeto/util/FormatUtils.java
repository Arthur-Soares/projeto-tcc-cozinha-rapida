package projeto.util;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;



public class FormatUtils {

	public static Locale pt_BR = new Locale("pt", "BR");
	public static NumberFormat df = NumberFormat.getCurrencyInstance(pt_BR);
	public static NumberFormat dfn = NumberFormat.getNumberInstance(pt_BR);
	public static DateFormat df1 = DateFormat.getDateInstance(DateFormat.MEDIUM, new Locale("en", "US"));   
	public static DateFormat df2 = DateFormat.getDateInstance(DateFormat.MEDIUM, pt_BR );
	public static DateFormat dtfbr = DateFormat.getDateTimeInstance(DateFormat.MEDIUM,DateFormat.MEDIUM, pt_BR);
	static SimpleDateFormat sdhms = new SimpleDateFormat("HH:mm:ss");
	public static SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	
	
	public static String dateformat(Object date){
		return dateformat(Cast.toDate(date));
	}

	public static String dateformat(Date date){
		if (date != null)
			return sdf.format(date);
		return "";
	} 
	
	public static String dataHoraMinutoSegundo(Object date){
		try{
			Date data = Cast.toDate(date);
			if (date != null)
				return sdhms.format(date);
		}catch(Exception e){
			return Cast.toString(date);
		}
		return "";
	}
	
	public static String retitabarrcolocatraco(String dataMicrosiga){
		String anoNumerico = dataMicrosiga.substring(6,10);
		String mesNumerico = dataMicrosiga.substring(3,5);
		String diaNumerico = dataMicrosiga.substring(0,2);
		String retorno = anoNumerico+"-"+mesNumerico+"-"+diaNumerico;
				
	    return retorno;
	}
	
	public static String dataHoraMinutoSegundoBr(Object date){
		try{
			Date data = Cast.toDate(date);
			if (date != null)
				return new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(date);
		}catch(Exception e){
			return Cast.toString(date);
		}
		return "";
	} 
	
	public static String dataHoraMinutoBr(Object date){
		try{
			Date data = Cast.toDate(date);
			if (date != null)
				return new SimpleDateFormat("dd/MM/yyyy HH:mm").format(date);
		}catch(Exception e){
			return Cast.toString(date);
		}

		return "";
	}
	
	public static String formataValor( double value ) {
		String valor = dfn.format(Cast.toBigDecimal(value).setScale(2,BigDecimal.ROUND_HALF_EVEN));
		return valor.replaceAll("R\\$ ", "");
	}
	
	public static String formataValor( Object value ) {
		String valor = dfn.format(Cast.toBigDecimal(value).setScale(2,BigDecimal.ROUND_HALF_EVEN));
		return valor.replaceAll("R\\$ ", "");
	}
	
	public static String formataValor( BigDecimal value ) {
		String valor = dfn.format(Cast.toBigDecimal(value).setScale(2,BigDecimal.ROUND_HALF_EVEN));
		return valor.replaceAll("R\\$ ", "");
	}
	
	public static String formataValorQtd( BigDecimal value ) {
		String valor = dfn.format(Cast.toBigDecimal(value).setScale(0,BigDecimal.ROUND_HALF_EVEN));
		return valor.replaceAll("R\\$ ", "");
	}
	
	public static String formataValor1( double value ) {
		dfn.setMinimumFractionDigits(0);
		String valor = dfn.format(Cast.toBigDecimal(value).setScale(0,BigDecimal.ROUND_HALF_EVEN));
		return valor.replaceAll("\\.","").replaceAll("\\,",".");
	}
	
	public static String formataValor1( Object value ) {
		dfn.setMinimumFractionDigits(0);
		String valor = dfn.format(Cast.toBigDecimal(value).setScale(0,BigDecimal.ROUND_HALF_EVEN));
		return valor.replaceAll("\\.","").replaceAll("\\,",".");
	}
	
	public static String formataValor3( Object value ) {
		dfn.setMinimumFractionDigits(3);
		dfn.setMaximumFractionDigits(3);
		String valor = dfn.format(Cast.toBigDecimal(value).setScale(3,BigDecimal.ROUND_HALF_EVEN));
		return valor;
	}
	
	public static String formataValor4( BigDecimal value ) {
		dfn.setMinimumFractionDigits(4);
		String valor = dfn.format(Cast.toBigDecimal(value).setScale(4,BigDecimal.ROUND_HALF_EVEN));
		return valor;
	}

	public static String formataValorDigitos( Object value , int digitos) {
		dfn.setMinimumFractionDigits(digitos);
		String valor = dfn.format(Cast.toBigDecimal(value).setScale(digitos,BigDecimal.ROUND_HALF_EVEN));
		return valor;
	}

	public static int diferencaEmDias(Date d1, Date d2) {
			long m1 = d1.getTime();
			long m2 = d2.getTime(); 
			
			return (int) ((m2 - m1) / (24*60*60*1000));
	}
	
	public static String adicionaBarrasExpressaoData(String dataMicrosiga) {
			//01234567
			//yyyyMMdd ( transforma a data microsiga colocando barras Exemplo: 20050617 -> 17/06/2005
			String dataBarras = dataMicrosiga.substring(6,8) + "/" +
	                            dataMicrosiga.substring(4,6) + "/" +
	                            dataMicrosiga.substring(0,4);
	        return dataBarras;
	}                        
		
	public static String reverteDataBr(String dataEuropa) {
		//01234567
		//yyyyMMdd ( transforma a data microsiga colocando barras Exemplo: 20050617 -> 17/06/2005
		String dataBarras = "";
		if(dataEuropa.length() >=9) {
		dataBarras = dataEuropa.substring(8,10) + "/" +
							dataEuropa.substring(5,7) + "/" +
							dataEuropa.substring(0,4);
		}
        return dataBarras;
	}                        
	
	public static String retiraBarrasExpressaoData(String dataMicrosiga) {
			//01234567
			//yyyyMMdd ( transforma a data microsiga colocando barras Exemplo: 17/06/2005 -> 20050617
			String dataBarras = dataMicrosiga.substring(6,10) +
								dataMicrosiga.substring(3,5) + 		
								dataMicrosiga.substring(0,2) ;
	        return dataBarras;
	 }                        
	
	public static String mudaCor(String cClasseLinha){
	    if (cClasseLinha.equals("tableRowOdd")) 
	    	cClasseLinha = "tableRowEven"; 
	    else 
	    	cClasseLinha = "tableRowOdd";
	    return cClasseLinha;
	}	
	
	public static Date tresMesesAntes() {
		return tresMesesAntes(new Date());
	} 

	public static Date tresMesesAntes(Date dtRef) {

	    Calendar cldr = java.util.Calendar.getInstance();
		
		if ( dtRef != null ) cldr.setTime(dtRef);
	    cldr.add(Calendar.MONTH, -3);
	    //System.out.println( "Primeiro dia do mês atual = " + cldr.getTime());
		Date dtRet = cldr.getTime();
		return dtRet;
	}

	public static String dateformatdoisdias(Object date){
		if (date != null){


			Date data = Cast.toDate(date);

			Calendar c = Calendar.getInstance(); 
			c.setTime(data); 
			c.add(Calendar.DATE, 2);
			Date dateRet = c.getTime();
			
			String dataRet = new SimpleDateFormat("dd-MM-yyyy").format(dateRet);
			//String dataRet = dateRet.toString(dateRet);
			

			return dataRet;
			
		}else{
			return "";
		}
			
	}
	
	public static String retiraBarrasExpressaoDataTraco(String dataMicrosiga) {
		//01234567
		//yyyyMMdd ( transforma a data microsiga colocando barras Exemplo: 17/06/2005 -> 2005-06-17
		String dataBarras = dataMicrosiga.substring(6,10) + "-" +
							dataMicrosiga.substring(3,5) + "-" +
							dataMicrosiga.substring(0,2) ;
	    return dataBarras;
	}                        

	public static String retiraExpressaoData(String dataMicrosiga) {
		//01234567
		//yyyyMMdd ( transforma a data microsiga colocando barras Exemplo: 20050617 -> 17-06-2005
		String dataBarras = dataMicrosiga.substring(0,4) + "-" +
							dataMicrosiga.substring(4,6) + "-" +
							dataMicrosiga.substring(6,8) ;
	    return dataBarras;
	}   
	
	
	public static String retiraExpressaoDataInvertido(String dataMicrosiga) {
		//01234567
		//yyyyMMdd ( transforma a data microsiga colocando barras Exemplo: 20050617 -> 2005-06-17)
		String dataBarras = dataMicrosiga.substring(6,8) + "-" +
							dataMicrosiga.substring(4,6) + "-" +
							dataMicrosiga.substring(0,4) ;
							
							
	    return dataBarras;
	}  

	public static String formataDataHora(Object date) {
		Date data = Cast.toDate(date);
		if (date != null)
			return dtfbr.format(date);
		return "";
	}

	public static String formataDataHora(Date date) {
		if (date != null)
			return dtfbr.format(date);
		return "";
	}
	
	

	public static String verificaMes(Object mes) {
		String varMes = "";
		
		if(Cast.toDouble(mes) == 1d){
			varMes = "Janeiro";
		}
		if(Cast.toDouble(mes) == 2d){
			varMes = "Fevereiro";
		}
		if(Cast.toDouble(mes) == 3d){
			varMes = "Março";
		}
		if(Cast.toDouble(mes) == 4d){
			varMes = "Abril";
		}
		if(Cast.toDouble(mes) == 5d){
			varMes = "Maio";
		}
		if(Cast.toDouble(mes) == 6d){
			varMes = "Junho";
		}
		if(Cast.toDouble(mes) == 7d){
			varMes = "Julho";
		}
		if(Cast.toDouble(mes) == 8d){
			varMes = "Agosto";
		}
		if(Cast.toDouble(mes) == 9d){
			varMes = "Setembro";
		}
		if(Cast.toDouble(mes) == 10d){
			varMes = "Outubro";
		}
		if(Cast.toDouble(mes) == 11d){
			varMes = "Novembro";
		}
		if(Cast.toDouble(mes) == 12d){
			varMes = "Dezembro";
		}
		return varMes;
	}

	public static String verificaMesResumido(Object mes) {
		
		String varMes = "";
		
		if(Cast.toDouble(mes) == 1d){
			varMes = "Jan";
		}
		if(Cast.toDouble(mes) == 2d){
			varMes = "Fev";
		}
		if(Cast.toDouble(mes) == 3d){
			varMes = "Mar";
		}
		if(Cast.toDouble(mes) == 4d){
			varMes = "Abr";
		}
		if(Cast.toDouble(mes) == 5d){
			varMes = "Mai";
		}
		if(Cast.toDouble(mes) == 6d){
			varMes = "Jun";
		}
		if(Cast.toDouble(mes) == 7d){
			varMes = "Jul";
		}
		if(Cast.toDouble(mes) == 8d){
			varMes = "Ago";
		}
		if(Cast.toDouble(mes) == 9d){
			varMes = "Set";
		}
		if(Cast.toDouble(mes) == 10d){
			varMes = "Out";
		}
		if(Cast.toDouble(mes) == 11d){
			varMes = "Nov";
		}
		if(Cast.toDouble(mes) == 12d){
			varMes = "Dez";
		}
		return varMes;
	}

	public static String retornaDataBr(String dataTxt) {
		//01/jan/21 -- Formato original
		//01/01/2021 -- Formato retornado
		if(dataTxt.length() == 9) {
			dataTxt = dataTxt.replaceAll("jan", "01");
			dataTxt = dataTxt.replaceAll("fev", "02");
			dataTxt = dataTxt.replaceAll("mar", "03");
			dataTxt = dataTxt.replaceAll("abr", "04");
			dataTxt = dataTxt.replaceAll("mai", "05");
			dataTxt = dataTxt.replaceAll("jun", "06");
			dataTxt = dataTxt.replaceAll("jul", "07");
			dataTxt = dataTxt.replaceAll("ago", "08");
			dataTxt = dataTxt.replaceAll("set", "09");
			dataTxt = dataTxt.replaceAll("out", "10");
			dataTxt = dataTxt.replaceAll("nov", "11");
			dataTxt = dataTxt.replaceAll("dez", "12");
			dataTxt = dataTxt.substring(0,6)+"20"+dataTxt.substring(6,8);
		}
		return dataTxt;
	}

	/**
	 * Formata ano mês. Ex: 201402 -> Fev/2014 
	**/
	public static String formataAnoMes(String anoMes){
		String anoNumerico = anoMes.substring(0,4);
		String mesNumerico = anoMes.substring(4,6);
		String mesSingla = verificaMesResumido(mesNumerico); 
		return mesSingla + "/" + anoNumerico;
	}
	
	public static String formataAnoResumido(Date dtParam) {
		SimpleDateFormat sdfares = new SimpleDateFormat("yy");
		return sdfares.format(dtParam);
	}
	
}
