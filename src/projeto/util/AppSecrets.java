package projeto.util;

import java.math.BigDecimal;

public interface AppSecrets {
	
	//BANCO DE DADOS
	static final String DB_USER = "root";
	//static final String DB_USER = "r1ti";
	static final String DB_PASS = "netsucesso";
	static final String DB_URL = "jdbc:mysql:///cozinharapida";	
	//static final String DB_URL = "jdbc:mysql:///livetalentos";

	//URL DE ACESSO DO SISTEMA
	static final String SISTEMA_URL = "http://localhost:8080/cozinharapida/";
	static final String EMAIL_URL = "http://localhost:8080/cozinharapida/";
	
	//GERAL
	static final String USER_KEY = "projeto.model.Cr_usuario";	
}