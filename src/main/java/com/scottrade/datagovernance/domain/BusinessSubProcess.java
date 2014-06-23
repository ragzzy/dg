/**
 * 
 */
package com.scottrade.datagovernance.domain;

import java.io.Serializable;

/**
 * @author rnandakumar
 * 
 */
public class BusinessSubProcess implements Serializable {

	private static final long serialVersionUID = -1L;
	private int subBpId;
	private String subBpNm;
	private int bpId;
	private int applId;
	private int applScrId;
	private char crudCreateFlg;
	private char crudReadFlg;
	private char crudUpdateFlg;
	private char crudDeleteFlg;
	private int jobTitleId;

	public BusinessSubProcess() {
		super();
	}

	/**
	 * @return the subBpId
	 */
	public int getSubBpId() {
		return subBpId;
	}

	/**
	 * @param subBpId
	 *            the subBpId to set
	 */
	public void setSubBpId(int subBpId) {
		this.subBpId = subBpId;
	}

	/**
	 * @return the subBpNm
	 */
	public String getSubBpNm() {
		return subBpNm;
	}

	/**
	 * @param subBpNm
	 *            the subBpNm to set
	 */
	public void setSubBpNm(String subBpNm) {
		this.subBpNm = subBpNm;
	}

	/**
	 * @return the bpId
	 */
	public int getBpId() {
		return bpId;
	}

	/**
	 * @param bpId
	 *            the bpId to set
	 */
	public void setBpId(int bpId) {
		this.bpId = bpId;
	}

	/**
	 * @return the applId
	 */
	public int getApplId() {
		return applId;
	}

	/**
	 * @param applId
	 *            the applId to set
	 */
	public void setApplId(int applId) {
		this.applId = applId;
	}

	/**
	 * @return the applScrId
	 */
	public int getApplScrId() {
		return applScrId;
	}

	/**
	 * @param applScrId
	 *            the applScrId to set
	 */
	public void setApplScrId(int applScrId) {
		this.applScrId = applScrId;
	}

	/**
	 * @return the crudCreateFlg
	 */
	public char getCrudCreateFlg() {
		return crudCreateFlg;
	}

	/**
	 * @param crudCreateFlg
	 *            the crudCreateFlg to set
	 */
	public void setCrudCreateFlg(char crudCreateFlg) {
		this.crudCreateFlg = crudCreateFlg;
	}

	/**
	 * @return the crudReadFlg
	 */
	public char getCrudReadFlg() {
		return crudReadFlg;
	}

	/**
	 * @param crudReadFlg
	 *            the crudReadFlg to set
	 */
	public void setCrudReadFlg(char crudReadFlg) {
		this.crudReadFlg = crudReadFlg;
	}

	/**
	 * @return the crudUpdateFlg
	 */
	public char getCrudUpdateFlg() {
		return crudUpdateFlg;
	}

	/**
	 * @param crudUpdateFlg
	 *            the crudUpdateFlg to set
	 */
	public void setCrudUpdateFlg(char crudUpdateFlg) {
		this.crudUpdateFlg = crudUpdateFlg;
	}

	/**
	 * @return the crudDeleteFlg
	 */
	public char getCrudDeleteFlg() {
		return crudDeleteFlg;
	}

	/**
	 * @param crudDeleteFlg
	 *            the crudDeleteFlg to set
	 */
	public void setCrudDeleteFlg(char crudDeleteFlg) {
		this.crudDeleteFlg = crudDeleteFlg;
	}

	/**
	 * @return the jobTitleId
	 */
	public int getJobTitleId() {
		return jobTitleId;
	}

	/**
	 * @param jobTitleId
	 *            the jobTitleId to set
	 */
	public void setJobTitleId(int jobTitleId) {
		this.jobTitleId = jobTitleId;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "BusinessSubProcess [getSubBpId()=" + getSubBpId()
				+ ", getSubBpNm()=" + getSubBpNm() + ", getBpId()=" + getBpId()
				+ ", getApplId()=" + getApplId() + ", getApplScrId()="
				+ getApplScrId() + ", getCrudCreateFlg()=" + getCrudCreateFlg()
				+ ", getCrudReadFlg()=" + getCrudReadFlg()
				+ ", getCrudUpdateFlg()=" + getCrudUpdateFlg()
				+ ", getCrudDeleteFlg()=" + getCrudDeleteFlg()
				+ ", getJobTitleId()=" + getJobTitleId() + "]";
	}

}
