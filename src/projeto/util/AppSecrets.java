package projeto.util;

import java.math.BigDecimal;

public interface AppSecrets {
	
	//BANCO DE DADOS
	static final String DB_USER = "root";
	static final String DB_PASS = "netsucesso";
	static final String DB_URL = "jdbc:mysql:///cozinharapida";	

	//URL DE ACESSO DO SISTEMA
	static final String SISTEMA_URL = "http://localhost/projeto-tcc-cozinha-rapida";
	static final String EMAIL_URL = "http://localhost/projeto-tcc-cozinha-rapida";
	
	//GERAL
	static final String USER_KEY = "projeto.model.Cr_usuario";
	
	//CAMINHOS DE PASTA DO SISTEMA
	static final String PATH_IMG = "C:\\cozinha_rapida\\img\\";
	
	//CRIPTOGRAFIA
	static final boolean DEBUG_MODE = false;
	static final String MAIL_USER_LOGIN = "suportecozinharapida@gmail.com";
	static final String MAIL_USER = "suportecozinharapida@gmail.com";
	static final String MAIL_PASS = "zbhirwyzqlneezsy";
}