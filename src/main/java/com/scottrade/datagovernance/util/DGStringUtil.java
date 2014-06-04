package com.scottrade.datagovernance.util;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Custom string utility class.
 * @author rnandakumar
 *
 */
public class DGStringUtil {

	private static final Logger logger = LoggerFactory
			.getLogger(DGStringUtil.class);

	/*
	 * Default Constructor
	 */
	public DGStringUtil() {
		super();
	}

	/*
	 * Method to check input string for NULL and whitespace and return character.
	 */
	public static Character convertStringToChar (String inStr) {

		if (logger.isDebugEnabled()) {
			logger.debug("BEGIN - DGStringUtil.convertStringToChar - String to Char conversion.");
		}

		char outChr = ' ';
		String inStrTrimmed = StringUtils.trimToEmpty(inStr);
		int inStrLen = inStrTrimmed.length();

		if ( inStrLen > 0 && inStrLen == 1 ) {
			outChr = inStrTrimmed.charAt(0);
		}
		else if ( inStrLen > 0 && inStrLen > 1 ) {
			outChr = inStrTrimmed.toCharArray()[0];
		}

		if (logger.isDebugEnabled()) {
			logger.debug("END   - DGStringUtil.convertStringToChar - String to Char conversion.");
		}

		return outChr;
	}
}
