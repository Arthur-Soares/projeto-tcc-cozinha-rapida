package projeto.util;

import java.text.SimpleDateFormat;
import java.sql.Date;
import java.util.Map;
import java.math.BigDecimal;
import java.util.Calendar;

/**
 *  Classe utilit?ria para efetuar conversoes entre dados
 *
 *@author    Sergio
 *@created    27 de Setembro de 2001
 */
public class Cast {
	/**
	 *  Numero de milisegundos num dia
	 *  1000 msegundos x 60 segundos x 60 minutos x 24 horas
	 */
	private final static long MSEGUNDOS_DIA = 1000L * 60L * 60L * 24L;
	/**
	 *  Formato de datahora
	 */
	private final static SimpleDateFormat dhfmt1 = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
	private final static SimpleDateFormat dhfmt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
	private final static SimpleDateFormat dhfmt3 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	/**
	 *  Formatdo para data
	 */
	private final static SimpleDateFormat dfmt1 = new SimpleDateFormat("dd/MM/yyyy");
	private final static SimpleDateFormat dfmt2 = new SimpleDateFormat("yyyy-MM-dd");
	/**
	 *  Formato para hora
	 */
	private final static SimpleDateFormat hfmt = new SimpleDateFormat("HH:mm:ss");
	/**
	 * Data Zero
	 */
	private final static java.util.Date dtzero = toDate("00:00:00");
		
	/**
	 *  Construtor privado para nao ter que instanciar a classe
	 */
	private Cast() { }


	/**
	 *  Long -> boolean
	 *
	 *@param  o  Descri?ao do parametro
	 *@return    retorno do m?todo
	 */
	public static boolean toBoolean(long o) {
		return o != 0;
	}


	/**
	 *  Date -> boolean
	 *
	 *@param  o  Descri?ao do parametro
	 *@return    retorno do m?todo
	 */
	public static boolean toBoolean(Date o) {
		return false;
	}


	/**
	 *  String -> boolean
	 *
	 *@param  o  Descri?ao do parametro
	 *@return    retorno do m?todo
	 */
	public static boolean toBoolean(String o) {
		if (o == null)
			return false;
		if ("true".equalsIgnoreCase(o))
			return true;
		if ("on".equalsIgnoreCase(o))
			return true;
		if ("yes".equalsIgnoreCase(o))
			return true;
		if ("sim".equalsIgnoreCase(o))
			return true;
		if ("t".equalsIgnoreCase(o))
			return true;
		if ("s".equalsIgnoreCase(o))
			return true;
		if ("y".equalsIgnoreCase(o))
			return true;
		if ("1".equalsIgnoreCase(o))
			return true;
		return false;
	}


	/**
	 *  Object -> boolean
	 *
	 *@param  o  Descri?ao do parametro
	 *@return    retorno do m?todo
	 */
	public static boolean toBoolean(Object o) {
		if (o == null) {
			return false;
		}
		if (o instanceof Boolean) {
			return ((Boolean) o).booleanValue();
		}
		if (o instanceof Number) {
			return toBoolean(toLong(o));
		}
		if (o instanceof java.util.Date) {
			return toBoolean((java.util.Date) o);
		}
		return toBoolean(o.toString());
	}


	/**
	 *  Object -> byte
	 *
	 *@param  o  Descri?ao do parametro
	 *@return    retorno do m?todo
	 */
	public static byte toByte(Object o) {
		if (o != null) {
			if (o instanceof Number) {
				return toByte(toLong(o));
			}
			try {
				return Byte.parseByte((String) o);
			} catch (Exception e) {
			}
		}
		return 0;
	}


	/**
	 *  short -> byte
	 *
	 *@param  o  Descri?ao do parametro
	 *@return    retorno do m?todo
	 */
	public static byte toByte(short o) {
		return (byte) o;
	}


	/**
	 *  int -> byte 
	 *
	 *@param  o  Descri?ao do parametro
	 *@return    retorno do m?todo
	 */
	public static byte toByte(int o) {
		return (byte) o;
	}


	/**
	 *  long -> byte
	 *
	 *@param  o  Descri?ao do parametro
	 *@return    retorno do m?todo
	 */
	public static byte toByte(long o) {
		return (byte) o;
	}


	/**
	 *  float -> byte
	 *
	 *@param  o  Descri?ao do parametro
	 *@return    retorno do m?todo
	 */
	public static byte toByte(float o) {
		return (byte) o;
	}


	/**
	 *  double -> byte
	 *
	 *@param  o  Descri?ao do parametro
	 *@return    retorno do m?todo
	 */
	public static byte toByte(double o) {
		return (byte) o;
	}


	/**
	 *  Object -> short
	 *
	 *@param  o  Descri?ao do parametro
	 *@return    retorno do m?todo
	 */
	public static short toShort(Object o) {
		if (o != null) {
			if (o instanceof Number) {
				return toShort(toLong(o));
			}
			try {
				return Short.parseShort((String) o);
			} catch (Exception e) {
			}
		}
		return 0;
	}


	/**
	 *  int -> short
	 *
	 *@param  o  Descri?ao do parametro
	 *@return    retorno do m?todo
	 */
	public static short toShort(int o) {
		return (short) o;
	}


	/**
	 *  long -> short
	 *
	 *@param  o  Descri?ao do parametro
	 *@return    retorno do m?todo
	 */
	public static short toShort(long o) {
		return (short) o;
	}


	/**
	 *  float -> short
	 *
	 *@param  o  Descri?ao do parametro
	 *@return    retorno do m?todo
	 */
	public static short toShort(float o) {
		return (short) o;
	}


	/**
	 *  double -> short
	 *
	 *@param  o  Descri?ao do parametro
	 *@return    retorno do m?todo
	 */
	public static short toShort(double o) {
		return (short) o;
	}


	/**
	 *  Object -> int
	 *
	 *@param  o  Descri?ao do parametro
	 *@return    retorno do m?todo
	 */
	public static int toInt(Object o) {
		if (o != null) {
			if (o instanceof Integer)
				return ((Integer)o).intValue();
			if (o instanceof Number) {
				return toInt(toLong(o));
			}
			try {
				return Integer.parseInt((String) o);
			} catch (Exception e) {
			}
		}
		return 0;
	}


	/**
	 *  long -> int
	 *
	 *@param  o  Descri?ao do parametro
	 *@return    retorno do m?todo
	 */
	public static int toInt(long o) {
		return (int) o;
	}


	/**
	 *  float -> int
	 *
	 *@param  o  Descri?ao do parametro
	 *@return    retorno do m?todo
	 */
	public static int toInt(float o) {
		return (int) o;
	}


	/**
	 *  double -> int
	 *
	 *@param  o  Descri?ao do parametro
	 *@return    retorno do m?todo
	 */
	public static int toInt(double o) {
		return (int) o;
	}


	/**
	 *  Object -> long
	 *
	 *@param  o  Descri?ao do parametro
	 *@return    retorno do m?todo
	 */
	public static long toLong(Object o) {
		if (o != null) {
			if (o instanceof Byte)
				return ((Byte)o).byteValue();
			if (o instanceof Short)
				return ((Short)o).shortValue();
			if (o instanceof Integer)
				return ((Integer)o).intValue();
			if (o instanceof Long)
				return ((Long)o).longValue();
			if (o instanceof Float)
				return ((Float)o).longValue();
			if (o instanceof Double)
				return ((Double)o).longValue();
			if (o instanceof BigDecimal)
				return ((BigDecimal)o).longValue();
			try {
				return Long.parseLong((String) o);
			} catch (Exception e) {
			}
		}
		return 0;
	}


	/**
	 *  float -> long
	 *
	 *@param  o  Descri?ao do parametro
	 *@return    retorno do m?todo
	 */
	public static long toLong(float o) {
		return (long) o;
	}


	/**
	 *  double -> long
	 *
	 *@param  o  Descri?ao do parametro
	 *@return    retorno do m?todo
	 */
	public static long toLong(double o) {
		return (long) o;
	}


	/**
	 *  Object -> float
	 *
	 *@param  o  Descri?ao do parametro
	 *@return    retorno do m?todo
	 */
	public static float toFloat(Object o) {
		if (o != null) {
			if (o instanceof Number)
				return toFloat(toDouble(o));
				
			try {
				return Float.parseFloat((String) o);
			} catch (Exception e) {
			}
		}
		return 0;
	}


	/**
	 *  double -> float
	 *
	 *@param  o  Descri?ao do parametro
	 *@return    retorno do m?todo
	 */
	public static float toFloat(double o) {
		return (float) o;
	}


	/**
	 *  Object -> double
	 *
	 *@param  o  Descri?ao do parametro
	 *@return    retorno do m?todo
	 */
	public static double toDouble(Object o) {
		if (o != null) {
			if (o instanceof Byte)
				return ((Byte)o).byteValue();
			if (o instanceof Short)
				return ((Short)o).shortValue();
			if (o instanceof Integer)
				return ((Integer)o).intValue();
			if (o instanceof Long)
				return ((Long)o).longValue();
			if (o instanceof Float)
				return ((Float)o).floatValue();
			if (o instanceof Double)
				return ((Double)o).doubleValue();
			if (o instanceof BigDecimal)
				return ((BigDecimal)o).doubleValue();
			try {
				String v = o.toString();
				v = v.replace(',','.');
				return Double.parseDouble(v);
			} catch (Exception e) {
			}
		}
		return 0;
	}

	/**
	 *  Object -> double
	 *
	 *@param  o  Descri?ao do parametro
	 *@return    retorno do m?todo
	 */
	public static BigDecimal toBigDecimal(Object o) {
		if (o != null) {
			if (o instanceof Byte)
				return new BigDecimal(((Byte)o).byteValue());
			if (o instanceof Short)
				return new BigDecimal(((Short)o).shortValue());
			if (o instanceof Integer)
				return new BigDecimal(((Integer)o).intValue());
			if (o instanceof Long)
				return new BigDecimal(((Long)o).longValue());
			if (o instanceof Float)
				return new BigDecimal(((Float)o).floatValue());
			if (o instanceof Double)
				return new BigDecimal(((Double)o).doubleValue());
			try {
				String v = o.toString();
				v = v.replace(',','.');
				return new BigDecimal(v);
			} catch (Exception e) {
			}
		}
		return new BigDecimal(0);
	}

	/**
	 *  Object -> date
	 *
	 *@param  o  Descri?ao do parametro
	 *@return    retorno do m?todo
	 */
	public static Date toDate(Object o) {
		if (o != null) {
			if (o instanceof Number) {
				return new Date(toLong(o));
			}
			if (o instanceof java.util.Date) {
				return new Date(((java.util.Date)o).getTime());
			}
			try {
				try {
					try {
						try {
							try {
								try {
									// Tenta converter dd/MM/yyyy HH:mm:ss
									return new java.sql.Date(dhfmt1.parse((String) o).getTime());
								} catch (Exception e1) {
								}
								// Tenta converter yyyy-MM-dd HH:mm:ss.S
								return new java.sql.Date(dhfmt2.parse((String) o).getTime());
							} catch(Exception e4) {
							}
							// Tenta converter yyyy-MM-dd HH:mm:ss
							return new java.sql.Date(dhfmt3.parse((String) o).getTime());
						} catch(Exception e5) {
						}
						// Tenta converter dd/MM/yyyy
						return new java.sql.Date(dfmt1.parse((String) o).getTime());
					} catch (Exception e2) {
					}
					// Tenta converter yyyy-MM-dd
					return new java.sql.Date(dfmt2.parse((String) o).getTime());
				} catch(Exception e6) {
				}
				// Tenta converter HH:mm:ss
				return new java.sql.Date(hfmt.parse((String) o).getTime());
			} catch (Exception e3) {
			}
		}
		return null;
	}


	/**
	 *  boolean -> String
	 *
	 *@param  o  Descri?ao do parametro
	 *@return    retorno do m?todo
	 */
	public static String toString(boolean o) {
		return o ? "S" : "N";
	}


	/**
	 *  long -> String
	 *
	 *@param  o  Descri?ao do parametro
	 *@return    retorno do m?todo
	 */
	public static String toString(long o) {
		return String.valueOf(o);
	}


	/**
	 *  double -> String
	 *
	 *@param  o  Descri?ao do parametro
	 *@return    retorno do m?todo
	 */
	public static String toString(double o) {
		return String.valueOf(o);
	}


	/**
	 *  Object -> String
	 *
	 *@param  o  Descri?ao do parametro
	 *@return    retorno do m?todo
	 */
	public static String toString(Object o) {
		if (o == null) {
			return "";
		}
		if (o instanceof Boolean)
			return toString(((Boolean)o).booleanValue());
		if (o instanceof java.util.Date) {
			java.util.Calendar cal = java.util.Calendar.getInstance();
			cal.setTime((java.util.Date)o);
			if (cal.get(Calendar.DATE) == 1 && cal.get(Calendar.MONTH) == 0 && cal.get(Calendar.YEAR) == 1970)
				return hfmt.format((java.util.Date)o);
			if (cal.get(Calendar.HOUR) == 0 && cal.get(Calendar.MINUTE) == 0 && cal.get(Calendar.SECOND) == 0)
				return dfmt1.format((java.util.Date)o);
			return dhfmt1.format((java.util.Date)o);
		}
		return o.toString();
	}


	/**
	 *  M?todo para compara??o de dois objetos, geralmente utilizado
	 * para sort.
	 *
	 *@param  o1  Primeiro objeto
	 *@param  o2  Segundo objeto
	 *@return     negativo se o1 &lt; o2, 0 se o1 = o2 e positivo se o1 &gt; o2
	 */
	public static int compare(Object o1, Object o2) {
		// Se for nulo
		if (o1 == null) {
			if (o2 == null) {
				return 0;
			}
			return -1;
		}
		if (o2 == null) {
			return 1;
		}

		// Se for booleano
		if (o1 instanceof Boolean) {
			if (((Boolean) o1).booleanValue()) {
				if (toBoolean(o2) == true) {
					return 0;
				}
				return -1;
			} else {
				if (toBoolean(o2) == true) {
					return 1;
				}
				return 0;
			}
		}

		// Se for byte
		if (o1 instanceof Byte) {
			return ((Byte) o1).byteValue() - toByte(o2);
		}

		// Se for short
		if (o1 instanceof Short) {
			return ((Short) o1).byteValue() - toShort(o2);
		}

		// Se for inteiro
		if (o1 instanceof Integer) {
			return ((Integer) o1).intValue() - toInt(o2);
		}

		// Se for long
		if (o1 instanceof Long) {
			long v = ((Long) o1).longValue() - toLong(o2);
			return (v == 0 ? 0 : v < 0 ? -1 : 1);
		}

		// Se for Float
		if (o1 instanceof Float) {
			float v = ((Float) o1).floatValue() - toFloat(o2);
			return (v == 0 ? 0 : (v < 0 ? -1 : 1));
		}

		// Se for Float
		if (o1 instanceof Double) {
			double v = ((Double) o1).doubleValue() - toDouble(o2);
			return (v == 0 ? 0 : (v < 0 ? -1 : 1));
		}

		// Se for data
		if (o1 instanceof java.util.Date) {
			Date d2 = toDate(o2);
			if (d2 == null) {
				return 1;
			}
			long v = ((java.util.Date) o1).getTime() - d2.getTime();
			return (v == 0 ? 0 : (v < 0 ? -1 : 1));
		}

		return o1.toString().compareTo(o2.toString());
	}

	/**
	 * Retorna string a partir de um Map
	 */	
	public static String toString(Map fields, String name) {
		if (fields == null)
			return "";
		return toString(fields.get(name));
	}
	/**
	 * Retorna int a partir de um Map
	 */	
	public static int toInt(Map fields, String name) {
		if (fields == null)
			return 0;
		return toInt(fields.get(name));
	}

	/**
	 * Retorna long a partir de um Map
	 */	
	public static long toLong(Map fields, String name) {
		if (fields == null)
			return 0L;
		return toLong(fields.get(name));
	}

	/**
	 * Retorna boolean a partir de um Map
	 */	
	public static boolean toBoolean(Map fields, String name) {
		if (fields == null)
			return false;
		return toBoolean(fields.get(name));
	}

	/**
	 * Retorna date a partir de um Map
	 */	
	public static Date toDate(Map fields, String name) {
		if (fields == null)
			return new java.sql.Date(new java.util.Date().getTime());
		return toDate(fields.get(name));
	}


	/**
	 * Retorna double a partir de um Map
	 */	
	public static double toDouble(Map fields, String name) {
		if (fields == null)
			return 0d;
		return toDouble(fields.get(name));
	}

	/**
	 * Retorna byte a partir de um Map
	 */	
	public static byte toByte(Map fields, String name) {
		if (fields == null)
			return 0;
		return toByte(fields.get(name));
	}

	/**
	 * Retorna short a partir de um Map
	 */	
	public static short toShort(Map fields, String name) {
		if (fields == null)
			return 0;
		return toShort(fields.get(name));
	}

	/**
	 * Retorna short a partir de um Map
	 */	
	public static float toFloat(Map fields, String name) {
		if (fields == null)
			return 0;
		return toFloat(fields.get(name));
	}

	/**
	 * Retorna short a partir de um Map
	 */	
	public static BigDecimal toBigDecimal(Map fields, String name) {
		if (fields == null)
			return new BigDecimal(0);
		return toBigDecimal(fields.get(name));
	}
	
	/**
	 * Retorna formato data
	 */
	public static String toDateString(Object value) {
		if (value == null)
			return "";
		return dfmt1.format(toDate(value));
	}
	
	public static String toTimeString(Object value) {
		if (value == null)
			return "";
		return hfmt.format(toDate(value));
	}
	
	public static String toDateTimeString(Object value) {
		if (value == null)
			return "";
		return dhfmt1.format(toDate(value));
	}
	
	public static String toDoubleString(Object value) {
		if (value == null)
			return "";
		return toString(value).replace('.',',');
	}

	public static String choice(String key, String values[], String defs) {
		if (values != null && key != null) {
			for(int p=0; p+1 < values.length; p+=2) {
				if (key.equalsIgnoreCase(values[p]))
					return values[p+1];
			}
		}
		return defs;
	}

	public static String choice(String key, String values[]) {
		return choice(key, values, "");
	}
	
	public static void main(String args[]) {
		String data = args[0];
		java.util.Date dt = Cast.toDate(data);
		System.out.println("Data = " + data);
		System.out.println("Convertida = " + dhfmt1.format(dt));
		System.out.println("P/ Texto   = " + Cast.toString(dt));
	}	
}
