package com.scottrade.datagovernance.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.scottrade.datagovernance.exception.NotFoundException;
import com.scottrade.datagovernance.service.DashboardService;

/**
 * Handles requests for the Dashboard service.
 */
@Controller
public class DashboardController {
	private static final Logger logger = LoggerFactory
			.getLogger(DashboardController.class);

	/**
	 * URI Constants used by this controller.
	 */
	public static final String GET_ALL = "/dashData/all/";

	DashboardService dashSvc;

	@Autowired
	public DashboardController ( DashboardService dashboardSvc) {
		this.dashSvc = dashboardSvc;
	}

	// --- Error handlers
	@ExceptionHandler(NotFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	@ResponseBody
	public String handleNotFoundException(NotFoundException e) {
		return e.getMessage();
	}

	@RequestMapping(value = GET_ALL, method = RequestMethod.GET)
	public @ResponseBody Map<String, String> getAll() {
		logger.info("Start --> Getting ALL Dashboard data = ");
		if (null != dashSvc.getAll()) {
			return dashSvc.getAll();
		}
		else {
			return null;
		}
	}
}