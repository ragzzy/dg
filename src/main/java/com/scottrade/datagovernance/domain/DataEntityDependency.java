package com.scottrade.datagovernance.domain;

import java.io.Serializable;
import java.util.List;

public class DataEntityDependency implements Serializable {

	private static final long serialVersionUID = -1L;

	private int dependencyId;
	private int entityId;
	private List<DataEntity> entityDepList;

	public DataEntityDependency() {
		super();
	}

	/**
	 * @return the dependencyId
	 */
	public int getDependencyId() {
		return dependencyId;
	}

	/**
	 * @param dependencyId
	 *            the dependencyId to set
	 */
	public void setDependencyId(int dependencyId) {
		this.dependencyId = dependencyId;
	}

	/**
	 * @return the entityId
	 */
	public int getEntityId() {
		return entityId;
	}

	/**
	 * @param entityId
	 *            the entityId to set
	 */
	public void setEntityId(int entityId) {
		this.entityId = entityId;
	}

	/**
	 * @return the entityDepList
	 */
	public List<DataEntity> getEntityDepList() {
		return entityDepList;
	}

	/**
	 * @param entityDepList
	 *            the entityDepList to set
	 */
	public void setEntityDepList(List<DataEntity> entityDepList) {
		this.entityDepList = entityDepList;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "DataEntityDependency [dependencyId=" + dependencyId
				+ ", entityId=" + entityId + ", entityDepList=" + entityDepList
				+ "]";
	}

}