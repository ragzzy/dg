package com.scottrade.datagovernance.dao;

import com.scottrade.datagovernance.domain.Person;

/**
 * DAO for person database table.
 * 
 * @author Raghu Nandakumar
 */
public interface PersonDao {

	/**
	 * Selects the person record with the given id.
	 * @param id
	 * @return Returns the Person for the given id. Returns null if none found.
	 */
	Person findById(Integer id);

	/**
	 * Inserts a person record using the non-id properties.
	 * The id property is populated with the generated id.
	 * @param person 
	 */
	void insert(Person person);

	/**
	 * Updates the person record with p.getId().
	 * @param p
	 */
	void update(Person p);

}