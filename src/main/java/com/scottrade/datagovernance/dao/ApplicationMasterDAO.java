package com.scottrade.datagovernance.dao;

import java.util.List;

import com.scottrade.datagovernance.domain.ApplicationMaster;

/**
 * DAO for Application Master database table.
 * 
 * @author Raghu Nandakumar
 */
public interface ApplicationMasterDAO {

	/**
	 * Gets all Application master information from the database. 
	 * @return
	 */
	List<ApplicationMaster> getAll();

	/**
	 * Selects the Application Master record with the given id.
	 * @param id
	 * @return Returns the Person for the given id. Returns null if none found.
	 */
	ApplicationMaster getById(int id);

	/**
	 * Inserts a application master record using the non-id properties.
	 * The id property is populated with the generated id.
	 * @param appMstr
	 */
	void insertAppMaster(ApplicationMaster appMstr);

	/**
	 * Updates the Application Master record with new applicationMaster.
	 * @param appMstr
	 */
	void updateAppMaster(ApplicationMaster appMstr);

	/**
	 * Deletes the Application Master record with applicationMaster.getApplId().
	 * @param id
	 */
	void deleteAppMaster(int id);
}