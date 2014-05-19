package com.scottrade.datagovernance.dto;

import java.io.Serializable;

/**
 * Specialized Application Master DTO for REST layer.
 * 
 * @author Raghu Nandakumar
 */
public class ApplicationMasterDTO implements Serializable {

    private static final long serialVersionUID = -6809049173391335091L;

	private int entityId;
	private String entityNm;
	private String entityDefn;
	private String entityExtUrl;

	/**
	 * @return the entityId
	 */
	public int getEntityId() {
		return entityId;
	}

	/**
	 * @param entityId the entityId to set
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
	 * @param entityNm the entityNm to set
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
	 * @param entityDefn the entityDefn to set
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
	 * @param entityExtUrl the entityExtUrl to set
	 */
	public void setEntityExtUrl(String entityExtUrl) {
		this.entityExtUrl = entityExtUrl;
	}

}
