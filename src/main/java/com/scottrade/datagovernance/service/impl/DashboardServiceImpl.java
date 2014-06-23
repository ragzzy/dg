package com.scottrade.datagovernance.service.impl;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.scottrade.datagovernance.service.DashboardService;

@Service
public class DashboardServiceImpl implements DashboardService {
	private static final Logger logger = LoggerFactory
			.getLogger(DashboardServiceImpl.class);

//	private DashboardDAO dashDAO;
//
//	@Autowired
//	public DashboardServiceImpl(DashboardDAO dashboardDAO) {
//		super();
//		this.dashDAO = dashboardDAO;
//	}
//
	@Override
	public Map<String, String> getAll() {
		logger.info("DashboardService.getAll() --> Getting ALL Dashboard Data = ");
		return null;//dashDAO.getAll();
	}
}