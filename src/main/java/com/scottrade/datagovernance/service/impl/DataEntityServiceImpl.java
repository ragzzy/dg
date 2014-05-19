package com.scottrade.datagovernance.service.impl;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.scottrade.datagovernance.dao.DataEntityDAO;
import com.scottrade.datagovernance.domain.DataEntity;
import com.scottrade.datagovernance.service.DataEntityService;

@Service
public class DataEntityServiceImpl implements DataEntityService {
	private static final Logger logger = LoggerFactory
			.getLogger(DataEntityServiceImpl.class);

	private DataEntityDAO deDAO;

	@Autowired
	public DataEntityServiceImpl(DataEntityDAO deDAO) {
		super();
		this.deDAO = deDAO;
	}

	@Override
	public List<DataEntity> getDependents(int id) {
		return deDAO.getDependents(id);
	}

	@Override
	public List<DataEntity> getAll() {
		logger.info("DataEntityService.getAll() --> Getting ALL Data Entities = ");
		return deDAO.getAll();
	}

	@Override
	public DataEntity getById(int id) {
		return deDAO.getById(id);
	}

	@Override
	public void addDataEntity(DataEntity dataEntity) {
		deDAO.insertDataEntity(dataEntity);
	}

	@Override
	public void editDataEntity(DataEntity dataEntity) {
		deDAO.updateDataEntity(dataEntity);
	}

	@Override
	public void deleteDataEntity(int id) {
		deDAO.deleteDataEntity(id);
	}
}