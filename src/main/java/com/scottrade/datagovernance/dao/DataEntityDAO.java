package com.scottrade.datagovernance.dao;

import java.util.List;

import com.scottrade.datagovernance.domain.DataEntity;

/**
 * DAO for Data Entity database table.
 * 
 * @author Raghu Nandakumar
 */
public interface DataEntityDAO {

	List<DataEntity> getAll();
	List<DataEntity> getDependents(int id);

	/**
	 * Selects the Data Entity record with the given id.
	 * @param id
	 * @return Returns the Person for the given id. Returns null if none found.
	 */
	DataEntity getById(int id);

	/**
	 * Inserts a data Data Entity record using the non-id properties.
	 * The id property is populated with the generated id.
	 * @param dataEntity
	 */
	void insertDataEntity(DataEntity dataEntity);

	/**
	 * Updates the Data Entity record with dataEntity.getEntityId().
	 * @param dataEntity
	 */
	void updateDataEntity(DataEntity dataEntity);

	/**
	 * Deletes the Data Entity record with dataEntity.getEntityId().
	 * @param dataEntity
	 */
	void deleteDataEntity(int id);
}