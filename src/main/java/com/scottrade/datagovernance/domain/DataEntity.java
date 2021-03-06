package com.scottrade.datagovernance.domain;

import java.io.Serializable;
import java.util.List;

/**
 * The class that represents a Data Entity and its information.
 * @author rnandakumar
 *
 */
public class DataEntity implements Serializable {

	private static final long serialVersionUID = -1L;

	private int entityId;
	private String entityNm;
	private String entityDefn;
	private String entityExtUrl;
	private String entityExampleTxt;
	private boolean selected;
	private List<DataEntity> subEntityIdList;

	/**
	 * Default constructor.
	 */
	public DataEntity() {
		super();
	}
	
	/**
	 * Overloaded to set on initialization
	 */
	public DataEntity(String nm, String dsc, String ex) {
		super();
		setEntityNm(nm);
		setEntityDefn(dsc);
		setEntityExampleTxt(ex);
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
	 * @return the entityNm
	 */
	public String getEntityNm() {
		return entityNm;
	}

	/**
	 * @param entityNm
	 *            the entityNm to set
	 */
	public void setEntityNm(String entityNm) {
		this.entityNm = entityNm;
	}

	/**
	 * @return the entityDefn
	 */
	public String getEntityDefn() {
		return entityDefn;
	}

	/**
	 * @param entityDefn
	 *            the entityDefn to set
	 */
	public void setEntityDefn(String entityDefn) {
		this.entityDefn = entityDefn;
	}

	/**
	 * @return the entityExtUrl
	 */
	public String getEntityExtUrl() {
		return entityExtUrl;
	}

	/**
	 * @param entityExtUrl
	 *            the entityExtUrl to set
	 */
	public void setEntityExtUrl(String entityExtUrl) {
		this.entityExtUrl = entityExtUrl;
	}


	/**
	 * @return the subEntityIdList
	 */
	public List<DataEntity> getSubEntityIdList() {
		return subEntityIdList;
	}

	/**
	 * @param subEntityIdList the subEntityIdList to set
	 */
	public void setSubEntityIdList(List<DataEntity> subEntityIdList) {
		this.subEntityIdList = subEntityIdList;
	}

	/**
	 * @return the selected
	 */
	public boolean isSelected() {
		return selected;
	}

	/**
	 * @param selected the selected to set
	 */
	public void setSelected(boolean selected) {
		this.selected = selected;
	}

	/**
	 * @return the entityExampleTxt
	 */
	public String getEntityExampleTxt() {
		return entityExampleTxt;
	}

	/**
	 * @param entityExampleTxt the entityExampleTxt to set
	 */
	public void setEntityExampleTxt(String entityExampleTxt) {
		this.entityExampleTxt = entityExampleTxt;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "DataEntity ["
			+ "  entityId=" + entityId
			+ ", entityNm=" + entityNm
			+ ", entityDefn=" + entityDefn
			+ ", entityExtUrl=" + entityExtUrl
			+ ", entityExampleTxt=" + entityExampleTxt
			+ ", subEntityIdList=" + subEntityIdList
			+ ", selected=" + selected
			+ "]";
	}
}
