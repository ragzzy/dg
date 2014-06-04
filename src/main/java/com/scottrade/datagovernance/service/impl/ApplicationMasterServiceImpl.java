package com.scottrade.datagovernance.service.impl;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.scottrade.datagovernance.dao.ApplicationMasterDAO;
import com.scottrade.datagovernance.domain.ApplicationMaster;
import com.scottrade.datagovernance.service.ApplicationMasterService;

@Service
public class ApplicationMasterServiceImpl implements ApplicationMasterService {
	private static final Logger logger = LoggerFactory
			.getLogger(ApplicationMasterServiceImpl.class);

	private ApplicationMasterDAO appMstrDAO;

	@Autowired
	public ApplicationMasterServiceImpl(ApplicationMasterDAO appMstrDAO) {
		super();
		this.appMstrDAO = appMstrDAO;
	}

	@Override
	public List<ApplicationMaster> getAll() {
		return appMstrDAO.getAll();
	}

	@Override
	public ApplicationMaster getById(int id) {
		return appMstrDAO.getById(id);
	}

	@Override
	public void addAppMaster(ApplicationMaster appMstr) {
		appMstrDAO.insertAppMaster(appMstr);
	}

	@Override
	public void editAppMaster(ApplicationMaster appMstr) {
		appMstrDAO.updateAppMaster(appMstr);
	}

	@Override
	public void deleteAppMaster(int id) {
		appMstrDAO.deleteAppMaster(id);
	}
}