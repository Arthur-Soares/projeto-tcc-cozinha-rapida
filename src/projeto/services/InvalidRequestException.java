package projeto.services;

public class InvalidRequestException extends RuntimeException{
	public InvalidRequestException() {}

	public InvalidRequestException(String message) {
		super(message);
	}

	public InvalidRequestException(String message, Throwable cause) {
		super(message, cause);
	}

	public InvalidRequestException(Throwable t) {
		super(t);
	}
}