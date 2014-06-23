package com.scottrade.datagovernance.dao;

import java.util.Map;

/**
 * DAO for Dashboard data.
 * 
 * @author Raghu Nandakumar
 */
public interface DashboardDAO {

	Map<String, String> getAll();
}