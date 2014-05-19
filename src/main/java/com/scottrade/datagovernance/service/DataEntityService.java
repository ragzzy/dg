package com.scottrade.datagovernance.service;

import java.util.List;

import com.scottrade.datagovernance.domain.DataEntity;

public interface DataEntityService {

	public List<DataEntity> getAll();
	public DataEntity getById(int id);
	public void addDataEntity (DataEntity de);
	public void editDataEntity (DataEntity de);
	public void deleteDataEntity (int id);
	public List<DataEntity> getDependents(int id);
}
