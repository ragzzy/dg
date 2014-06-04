package com.scottrade.datagovernance.controller;

import java.util.List;

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

import com.scottrade.datagovernance.domain.ApplicationMaster;
import com.scottrade.datagovernance.exception.NotFoundException;
import com.scottrade.datagovernance.service.ApplicationMasterService;

/**
 * Handles requests for the Application Master service.
 */
@Controller
public class ApplicationMasterController {
	private static final Logger logger = LoggerFactory
			.getLogger(ApplicationMasterController.class);

	/**
	 * URI Constants used by this controller.
	 */
	public static final String GET_APP_INFO_BY_ID = "/appMaster/{id}";
	public static final String GET_ALL_APPS       = "/appMaster/all";
	public static final String ADD_APP            = "/post/appMaster/add";
	public static final String EDIT_APP           = "/post/appMaster/edit";
	public static final String DELETE_APP         = "/post/appMaster/delete/{id}";

	ApplicationMasterService appMstrSvc;

	@Autowired
	public ApplicationMasterController(ApplicationMasterService appMstrSvc) {
		this.appMstrSvc = appMstrSvc;
	}

	// --- Error handlers
	@ExceptionHandler(NotFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	@ResponseBody
	public String handleNotFoundException(NotFoundException e) {
		return e.getMessage();
	}

	@RequestMapping(value = GET_ALL_APPS, method = RequestMethod.GET)
	public @ResponseBody
	List<ApplicationMaster> getAllApps() {
		logger.info("Start --> Getting ALL Application Information = ");
		if (null != appMstrSvc.getAll()) {
			return appMstrSvc.getAll();
		}
		else {
			return null;
		}
	}

	
}
