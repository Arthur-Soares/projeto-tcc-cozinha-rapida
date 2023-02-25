package projeto.util;


/**
 * Methods related to actions on URIs. The definition of a URI is taken from
 * <a href="http://www.ietf.org/rfc/rfc2396.txt">RFC 2396: URI Generic Syntax</a>.
 **/
public class URIUtil {

	private static final String ESCAPE_CHARS = "<>%\"{}|\\^[]`";

	/**
	 * Encodes a string according to RFC 2396. According to this spec, any
	 * characters outside the range 0x20 - 0x7E must be escaped because they
	 * are not printable characters. Even within this range a number of
	 * characters must be escaped. This method will perform this escaping.
	 *
	 * @param uri The URI to encode.
	 * @return The encoded URI.
	 **/
	public static String encodeUri(String uri) {
		StringBuffer result = new StringBuffer();
		encodeUri(uri, result);
		return result.toString();
	}

	/**
	 * Encodes a string according to RFC 2396.
	 *
	 * @param uri The URI to encode.
	 * @param buf The StringBuffer that the encoded URI will be appended to.
	 * @see #encodeUri(java.lang.String)
	 **/
	public static void encodeUri(String uri, StringBuffer buf) {
		for (int i = 0; i < uri.length(); i++) {
			char c = uri.charAt(i);
			int cInt = (int)c;

			if (ESCAPE_CHARS.indexOf(c) > 0 || cInt <= 0x20) {
				// Escape character
				buf.append('%');
				String hexVal = Integer.toHexString(cInt);

				// Ensure use of two characters
				if (hexVal.length() == 1) {
					buf.append('0');
				}

				buf.append(hexVal);
			}
			else {
				buf.append(c);
			}
		}
	}


	/**
	 * Decodes a string according to RFC 2396. According to this spec, any
	 * characters outside the range 0x20 - 0x7E must be escaped because they
	 * are not printable characters. This method will translate any escaped
	 * characters back to the original.
	 *
	 * @param uri The URI to decode.
	 * @return The decoded URI.
	 **/
	
	public static String decodeUri(String parseString) {
		if (parseString == null)
		    return null;
		StringBuffer out = new StringBuffer();
		
		for(int i = 0; i < parseString.length(); ++i){
			char c = parseString.charAt(i);
			if(c == '%') {
				++i;
				c = parseString.charAt(i);
				if(c == 'u') {
					String sub = parseString.substring(i + 1, i + 5);
					out.append((char)Integer.parseInt(sub, 16));
					i += 4;
				} else {
					String sub = parseString.substring(i, i + 2);
					out.append((char)Integer.parseInt(sub, 16));
					++i;			
				}
			} else {
				out.append(c);
			}
		}
		return out.toString();

/*		StringBuffer result = new StringBuffer();
		decodeUri(uri, result);
		return result.toString();
*/	}

	
	/**
	 * Decodes a string according to RFC 2396.
	 *
	 * @param uri The URI to decode.
	 * @param buf The StringBuffer that the decoded URI will be appended to.
	 * @see #decodeUri(java.lang.String)
	 **/
	public static void decodeUri(String uri, StringBuffer buf) {
		int percentIdx = uri.indexOf('%');
		int startIdx = 0;

		while (percentIdx != -1) {
			buf.append(uri.substring(startIdx, percentIdx));

			// The two character following the '%' contain a hexadecimal
			// code for the original character, i.e. '%20'
			String xx = uri.substring(percentIdx + 1, percentIdx + 3);

			try {
				int c = Integer.parseInt(xx, 16);
				buf.append( (char)c );
			} catch (Exception e) {
				System.err.println("UriUtil Erro formatando: " + xx);
			}

			startIdx = percentIdx + 3;

			percentIdx = uri.indexOf('%', startIdx);
		}

		buf.append( uri.substring(startIdx) );
	}

	/**
     * decodeURI()
     * this method decodes encoded URI
     * @param uri string to be converted
     * @returns String converted
     * @throws java.io.UnsupportedEncodingException
     */

/*
    public static String decodeUri(String uri) throws UnsupportedEncodingException {
	if (uri == null)
	    return null;
	
	char[] chars = uri.toCharArray();
	byte[] bytes = new byte[chars.length];
	
	if (chars.length > 65000) return "";

	int len=0;
	for (int i=0; i<chars.length; ) {


	try {
		if (i > 65500) break;	

	    if (chars[i] == '%') {
		// parse next two chars as hex integer
			if (chars[i+1] == 'u') {
				bytes[len++] = (byte) Integer.parseInt(new String(chars, i+2, 4), 16);
				i+=6;
				System.out.println("Unicode encontrado = "  + new String(chars, i+2, 4));
			} else {
				bytes[len++] = (byte) Integer.parseInt(new String(chars, i+1, 2), 16);
				i+=3;
			}


    		}
	    	else
			bytes[len++] = (byte) chars[i++];
		
	} catch (java.lang.ArrayIndexOutOfBoundsException e) {
		break;
	} catch (java.lang.StringIndexOutOfBoundsException e) {
		break;
	}
	}
	//return new String(bytes, 0, len, "EUC_KR"); // PT_BR ???
	return new String(bytes, 0, len);  // usa default charset
    }

*/
}
