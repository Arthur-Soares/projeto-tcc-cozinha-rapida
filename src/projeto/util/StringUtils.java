package projeto.util;

import java.io.UnsupportedEncodingException;

public class StringUtils {
	

	public static String toUTF8(String isoString) {   
	    String utf8String = null;   
	    if (null != isoString && !isoString.equals(""))   
	    {   
	        try   
	        {   
	            byte[] stringBytesISO = isoString.getBytes("ISO-8859-1");   
	            utf8String = new String(stringBytesISO, "UTF-8");   
	        }   
	        catch(UnsupportedEncodingException e)   
	        {   
	            // Mostra exceção mas devolve a mesma String   
	            System.out.println("UnsupportedEncodingException: " + e.getMessage());   
	            utf8String = isoString;   
	        }   
	    }   
	    else   
	    {   
	        utf8String = isoString;   
	    }   
	    return utf8String;   
	} 

	public static String toISO(String isoString) {   
	    String utf8String = null;   
	    if (null != isoString && !isoString.equals(""))   
	    {   
	        try   
	        {   
	            byte[] stringBytesISO = isoString.getBytes("UTF-8");   
	            utf8String = new String(stringBytesISO, "ISO-8859-1");   
	        }   
	        catch(UnsupportedEncodingException e)   
	        {   
	            // Mostra exceção mas devolve a mesma String   
	            System.out.println("UnsupportedEncodingException: " + e.getMessage());   
	            utf8String = isoString;   
	        }   
	    }   
	    else   
	    {   
	        utf8String = isoString;   
	    }   
	    return utf8String;   
	} 

	public static String strZeros( int id, int qtdDigitos ) {

		String valorId = String.valueOf(id);
		int qtdString = valorId.length(); 
		if ( qtdString < qtdDigitos ) {
			int qtdZeros = qtdDigitos - qtdString;
			StringBuffer sb = new StringBuffer();
			for ( int i = 0; i < qtdZeros; i++ ) 
				sb.append("0");			
			return sb.toString().concat(valorId);	
		} else {
			return valorId;
		}
		
	}	

	public static String strZeros(String valorId, int qtdDigitos ) {

		//String valorId = String.valueOf(id);
		int qtdString = valorId.length(); 
		if ( qtdString < qtdDigitos ) {
			int qtdZeros = qtdDigitos - qtdString;
			StringBuffer sb = new StringBuffer();
			for ( int i = 0; i < qtdZeros; i++ ) 
				sb.append("0");			
			return sb.toString().concat(valorId);	
		} else {
			return valorId;
		}
		
	}	

	public static boolean checkStringUpper(String str) {
	    char ch;
	    boolean capitalFlag = false;
	    boolean lowerCaseFlag = false;
	    boolean numberFlag = false;
	    for(int i=0;i < str.length();i++) {
	        ch = str.charAt(i);
	        if( Character.isDigit(ch)) {
	            numberFlag = true;
	        }
	        else if (Character.isUpperCase(ch)) {
	            capitalFlag = true;
	        } else if (Character.isLowerCase(ch)) {
	            lowerCaseFlag = true;
	        }
	        if(capitalFlag)
	            return true;
	    }
	    return false;
	}

	public static boolean checkStringLower(String str) {
	    char ch;
	    boolean capitalFlag = false;
	    boolean lowerCaseFlag = false;
	    boolean numberFlag = false;
	    for(int i=0;i < str.length();i++) {
	        ch = str.charAt(i);
	        if( Character.isDigit(ch)) {
	            numberFlag = true;
	        }
	        else if (Character.isUpperCase(ch)) {
	            capitalFlag = true;
	        } else if (Character.isLowerCase(ch)) {
	            lowerCaseFlag = true;
	        }
	        if(lowerCaseFlag)
	            return true;
	    }
	    return false;
	}

	public static boolean checkStringNumber(String str) {
	    char ch;
	    boolean capitalFlag = false;
	    boolean lowerCaseFlag = false;
	    boolean numberFlag = false;
	    for(int i=0;i < str.length();i++) {
	        ch = str.charAt(i);
	        if( Character.isDigit(ch)) {
	            numberFlag = true;
	        }
	        else if (Character.isUpperCase(ch)) {
	            capitalFlag = true;
	        } else if (Character.isLowerCase(ch)) {
	            lowerCaseFlag = true;
	        }
	        if(numberFlag)
	            return true;
	    }
	    return false;
	}

	public static boolean checkStringPass(String str) {
	    char ch;
	    boolean capitalFlag = false;
	    boolean lowerCaseFlag = false;
	    boolean numberFlag = false;
	    for(int i=0;i < str.length();i++) {
	        ch = str.charAt(i);
	        if( Character.isDigit(ch)) {
	            numberFlag = true;
	        }
	        else if (Character.isUpperCase(ch)) {
	            capitalFlag = true;
	        } else if (Character.isLowerCase(ch)) {
	            lowerCaseFlag = true;
	        }
	        if(numberFlag && capitalFlag && lowerCaseFlag)
	            return true;
	    }
	    return false;
	}

	public static String capitalizeWord(String str){  
		String words[]=str.split("\\s");  
		String capitalizeWord="";  
		for(String w:words){
			w = w.toLowerCase();
			if(w.length() > 1) {
				String first=w.substring(0,1);
				String afterfirst = "";
				if("(".equals(first)) {
					first = w.substring(0,2);
					afterfirst=w.substring(2);
				}else {
					afterfirst=w.substring(1);
				}
				capitalizeWord+=first.toUpperCase()+afterfirst+" ";
			}
			  
	    }  
		return capitalizeWord.trim();  
	}  
	
}
