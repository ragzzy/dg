package com.scottrade.datagovernance.service;

import java.util.List;

import com.scottrade.datagovernance.domain.ApplicationMaster;

public interface ApplicationMasterService {

	public List<ApplicationMaster> getAll();
	public ApplicationMaster getById(int id);
	public void addAppMaster (ApplicationMaster appM);
	public void editAppMaster (ApplicationMaster appM);
	public void deleteAppMaster (int id);
}
