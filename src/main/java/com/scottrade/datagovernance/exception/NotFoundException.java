package com.scottrade.datagovernance.exception;

/**
 * Thrown when performing an operatoin on a user that does not exist.
 * 
 * @author Raghu Nandakumar
 */
public class NotFoundException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	public NotFoundException() {
		super();
	}

	public NotFoundException(String message, Throwable cause) {
		super(message, cause);
	}

	public NotFoundException(String message) {
		super(message);
	}

	public NotFoundException(Throwable cause) {
		super(cause);
	}

}
