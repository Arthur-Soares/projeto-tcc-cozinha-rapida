package projeto.util;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * 
 *  
 */
public class DateUtils {
	public static final int MS_IN_A_DAY = 24 * 3600 * 1000;

	//ROBSON olhe aqui o que eu fiz
	/**
	 * Compara duas datas ignorando a hora.
	 * @param dt1
	 * @param dt2
	 * @return
	 */
	public static int compareToIgnoreHour(Date dt1, Date dt2){
		
		try{
			Calendar cl1 = Calendar.getInstance();
			cl1.setTime(dt1);
			cl1.set(Calendar.HOUR_OF_DAY, 0);
			cl1.set(Calendar.MINUTE, 0);
			cl1.set(Calendar.SECOND, 1);
			cl1.set(Calendar.MILLISECOND, 1);
			dt1 = cl1.getTime();
			Calendar cl2 = Calendar.getInstance();
			cl2.setTime(dt2);
			cl2.set(Calendar.HOUR_OF_DAY, 0);
			cl2.set(Calendar.MINUTE, 0);
			cl2.set(Calendar.SECOND, 1);
			cl2.set(Calendar.MILLISECOND, 1);
			dt2 = cl2.getTime();
			//System.out.println("cl1:"+cl1+" -- cl2"+cl2);
			return dt1.compareTo(dt2);
		}catch(Exception e){
			e.printStackTrace();
			return 0;
		}
	}

	public static int intervalInDays(Date from, Date to) {
		long tf = from.getTime();
		long tt = to.getTime();
		tf = pruneToDays(tf);
		tt = pruneToDays(tt);
		return (int) ((tt - tf) / MS_IN_A_DAY);
	}
	
	public static int intervalInDaysNew(Date from, Date to) {
		long tf = from.getTime();
		long tt = to.getTime();
		tf = pruneToDays(tf);
		tt = pruneToDays(tt);
		return (int) (((tt - tf) / MS_IN_A_DAY) + 1);
	}

	private static long pruneToDays(long tf) {
		if (tf % MS_IN_A_DAY > 0)
			tf -= tf % MS_IN_A_DAY;
		return tf;
	}

	private static final String[] months = new String[] { "janeiro",
			"fevereiro", "março", "abril", "maio", "junho", "julho", "agosto",
			"setembro", "outubro", "novembro", "dezembro", };

	/**
	 * Retorna o nome do mês, índice baseado em zero. Assim funciona legal com
	 * Calendar.
	 */
	public static String getMonth(int i) {
		return months[i];
	}
	/*
	public static boolean validaData(String dtsdata){
		Date dtdajuda = new Date();
		Date dtdhoje = new Date();
		String dtshoje = new SimpleDateFormat("dd/MM/yyyy").format(dtdhoje);
		dtdhoje = Cast.toDate(dtshoje);
		if (null != Cast.toDate(dtsdata))
			dtdajuda = Cast.toDate(dtsdata);
		else
			return false;	
		if (!( new SimpleDateFormat("dd/MM/yyyy").format(dtdajuda) ).equals(dtsdata))
			return false;
		else if((dtdajuda.compareTo(dtdhoje)) < 0){
			Actions.showMessage("Favor colocar data maior ou igual a atual!");
			return false;
		}
		else
			return true;
	}
	*/
	/*
	// recebe um textfield e não permite inserção errada ou com data menor q atual
	public static boolean validaData(Textfield data){
		
		String dtsdata = data.getText();
		Date dtdajuda = new Date();
		Date dtdhoje = new Date();
		String dtshoje = new SimpleDateFormat("dd/MM/yyyy").format(dtdhoje);
		dtdhoje = Cast.toDate(dtshoje);
		if (null != Cast.toDate(dtsdata))
			dtdajuda = Cast.toDate(dtsdata);
		else{
			data.setText("");
			return false;
		}
		if (!( new SimpleDateFormat("dd/MM/yyyy").format(dtdajuda) ).equals(dtsdata)){
			data.setText("");
			return false;
		}

		else if((dtdajuda.compareTo(dtdhoje)) < 0){
			data.setText("");
			Actions.showMessage("Favor colocar data maior ou igual a atual!");
			return false;
		}
		else
			return true;
	}

	// recebe um textfield e não permite inserção errada porém permite com data menor q atual
	public static boolean validaData(Textfield data, String liberaAnterior){
		
		String dtsdata = data.getText();
		Date dtdajuda = new Date();
		Date dtdhoje = new Date();
		String dtshoje = new SimpleDateFormat("dd/MM/yyyy").format(dtdhoje);
		dtdhoje = Cast.toDate(dtshoje);
		if (null != Cast.toDate(dtsdata))
			dtdajuda = Cast.toDate(dtsdata);
		else{
			data.setText("");
			return false;
		}
		if (!( new SimpleDateFormat("dd/MM/yyyy").format(dtdajuda) ).equals(dtsdata)){
			data.setText("");
			return false;
		}
		else
			return true;
	}
	*/
	public static Date primeiroDiaMes(Date dtd){
		int flag = 0;
		Calendar cldr = Calendar.getInstance();
		cldr.setTime(dtd);
		cldr.set(Calendar.DAY_OF_MONTH, 1);
		dtd = cldr.getTime();
		return dtd;
	}
	
	public static Date proximoDiaUtil(Date dtd, int numdias){
		int flag = 0;
		Calendar cldr = Calendar.getInstance();
		cldr.setTime(dtd);
		cldr.add(Calendar.DATE, numdias);
		dtd = cldr.getTime();
		//É Sábado = 6 ou Domingo = 0
		while(flag == 0){
			if(dtd.getDay() == 0 || dtd.getDay() == 6){
				cldr.setTime(dtd);
				cldr.add(Calendar.DATE, +1);
				dtd = cldr.getTime();
			}else{
				flag = 1;
			}
		}
		return dtd;
	}

	public static Date somaDiasUteis(Date dtd, int numdias){
		Calendar cldr = Calendar.getInstance();
		cldr.setTime(dtd);
		for(int d=0;d<numdias;d++) {
			cldr.add(Calendar.DATE, 1);
			while(cldr.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY || cldr.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY) {
				cldr.add(Calendar.DATE, 1);
			}
		}
		dtd = cldr.getTime();
		return dtd;
	}

	public static Date somaDias(Date dtdRefeferencia , int qtiDias) {
        Calendar cldr = java.util.Calendar.getInstance();
		if ( dtdRefeferencia != null ) 
			cldr.setTime(dtdRefeferencia);
        cldr.add(Calendar.DATE, + qtiDias);
		Date dtdRetorno = cldr.getTime();
		return dtdRetorno;
	}

	public static Date somaMeses(Date dtdRefeferencia , int qtiMeses) {
        Calendar cldr = java.util.Calendar.getInstance();
		if ( dtdRefeferencia != null ) 
			cldr.setTime(dtdRefeferencia);
        cldr.add(Calendar.MONTH, + qtiMeses);
		Date dtdRetorno = cldr.getTime();
		return dtdRetorno;
	}
	
	public static Date subtraiMeses(Date dtdRefeferencia , int qtiMeses) {
        Calendar cldr = java.util.Calendar.getInstance();
		if ( dtdRefeferencia != null ) 
			cldr.setTime(dtdRefeferencia);
        cldr.add(Calendar.MONTH, - qtiMeses);
		Date dtdRetorno = cldr.getTime();
		return dtdRetorno;
	}
	
	public static Date mediaData(Date data1, Date data2){
		Date dtdMedia = new Date();
		dtdMedia.setTime(((data1.getTime())+(data2.getTime()))/2);
		return dtdMedia;
	}
	
    /** 
     * Calcula a diferença de duas datas em dias 
     * <br> 
     * <b>Importante:</b> Quando realiza a diferença em dias entre duas datas, este método considera as horas restantes e as converte em fração de dias. 
     * @param dataInicial 
     * @param dataFinal 
     * @return quantidade de dias existentes entre a dataInicial e dataFinal. 
     */  
	
    public static double diferencaEmDias(Date dataInicial, Date dataFinal){  
        double result = 0;  
        long diferenca = dataFinal.getTime() - dataInicial.getTime();  
        double diferencaEmDias = (diferenca /1000) / 60 / 60 /24; //resultado é diferença entre as datas em dias  
        long horasRestantes = (diferenca /1000) / 60 / 60 %24; //calcula as horas restantes  
        result = diferencaEmDias + (horasRestantes /24d); //transforma as horas restantes em fração de dias  
      
        return result;  
    }  
      
    /** 
     * Calcula a diferença de duas datas em horas 
     * <br> 
     * <b>Importante:</b> Quando realiza a diferença em horas entre duas datas, este método considera os minutos restantes e os converte em fração de horas. 
     * @param dataInicial 
     * @param dataFinal 
     * @return quantidade de horas existentes entre a dataInicial e dataFinal. 
     */  
    public static double diferencaEmHoras(Date dataInicial, Date dataFinal){  
        double result = 0;  
        long diferenca = dataFinal.getTime() - dataInicial.getTime();  
        long diferencaEmHoras = (diferenca /1000) / 60 / 60;  
        long minutosRestantes = (diferenca / 1000)/60 %60;  
        double horasRestantes = minutosRestantes / 60d;  
        result = diferencaEmHoras + (horasRestantes);  
          
        return result;  
    }  
      
    /** 
     * Calcula a diferença de duas datas em minutos 
     * <br> 
     * <b>Importante:</b> Quando realiza a diferença em minutos entre duas datas, este método considera os segundos restantes e os converte em fração de minutos. 
     * @param dataInicial 
     * @param dataFinal 
     * @return quantidade de minutos existentes entre a dataInicial e dataFinal. 
     */  
    public static double diferencaEmMinutos(Date dataInicial, Date dataFinal){  
        double result = 0;  
        long diferenca = dataFinal.getTime() - dataInicial.getTime();  
        double diferencaEmMinutos = (diferenca /1000) / 60; //resultado é diferença entre as datas em minutos  
        long segundosRestantes = (diferenca / 1000)%60; //calcula os segundos restantes  
        result = diferencaEmMinutos + (segundosRestantes /60d); //transforma os segundos restantes em minutos  
      
        return result;  
    }  
    
	/**
	 * Retorna um List<Date> com as primeiras datas de cada mês dentro de um intervalo de tempo, mais o próprio mês. <br>
	 * Exemplo: primeiroDiasMesDeIntervalo(data=07/07/07,2)=[01/05/07,01/06/07,01/07/07]
	 * 
	 *  @author Felipe
	**/
	public static List<Date> primeirosDiasMesDeIntervalo(Date dataReferencia, int meses){
		List<Date> ret = new ArrayList<Date>();
		Calendar cal = java.util.Calendar.getInstance();
		for(int i=0;i<=meses;i++){
			cal.setTime(dataReferencia);
			cal.add(Calendar.MONTH, -(meses-i));
			cal.set(Calendar.DAY_OF_MONTH, 1);
			ret.add(cal.getTime());
		}
		return ret;
	}
	
	/**
	 * Retorna um List<Date> com as últimas datas de cada mês dentro de um intervalo de tempo, mais o próprio mês. <br>
	 * Exemplo: ultimosDiasMesDeIntervalo(data=07/07/07,2)=[31/05/07,30/06/07,31/07/07]
	 * 
	 *  @author Felipe
	**/
	public static List<Date> ultimosDiasMesDeIntervalo(Date dataReferencia, int meses){
		List<Date> ret = new ArrayList<Date>();
		Calendar cal = java.util.Calendar.getInstance();
		for(int i=0;i<=meses;i++){
			cal.setTime(dataReferencia);
			cal.add(Calendar.MONTH, -(meses-i));
			cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
			ret.add(cal.getTime());
		}
		return ret;
	}

	public static Date ultimoDiaMes(Date dataReferencia){
		try {
			Calendar cal = java.util.Calendar.getInstance();
			cal.setTime(dataReferencia);
			cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
			return cal.getTime();
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
}