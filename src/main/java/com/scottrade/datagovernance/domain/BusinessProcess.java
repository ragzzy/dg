/**
 * 
 */
package com.scottrade.datagovernance.domain;

import java.io.Serializable;
import java.util.List;

/**
 * Domain class for Business Process (Space in Blueworks).
 * 
 * @author rnandakumar
 * 
 */
public class BusinessProcess implements Serializable {

	private static final long serialVersionUID = -1L;

	private int bpId;
	private String bpNm;
	private int deptId;
	private int deptTeamId;
	private String deptFuncNm;
	private char bpInBlueworksFlg;
	private String bpBlueworksUrl;
	private String bpOpenText;
	private List<BusinessSubProcess> subProcessList;

	public BusinessProcess() {
		super();
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
	 * @return the bpNm
	 */
	public String getBpNm() {
		return bpNm;
	}

	/**
	 * @param bpNm
	 *            the bpNm to set
	 */
	public void setBpNm(String bpNm) {
		this.bpNm = bpNm;
	}

	/**
	 * @return the deptId
	 */
	public int getDeptId() {
		return deptId;
	}

	/**
	 * @param deptId
	 *            the deptId to set
	 */
	public void setDeptId(int deptId) {
		this.deptId = deptId;
	}

	/**
	 * @return the deptTeamId
	 */
	public int getDeptTeamId() {
		return deptTeamId;
	}

	/**
	 * @param deptTeamId
	 *            the deptTeamId to set
	 */
	public void setDeptTeamId(int deptTeamId) {
		this.deptTeamId = deptTeamId;
	}

	/**
	 * @return the deptFuncNm
	 */
	public String getDeptFuncNm() {
		return deptFuncNm;
	}

	/**
	 * @param deptFuncNm
	 *            the deptFuncNm to set
	 */
	public void setDeptFuncNm(String deptFuncNm) {
		this.deptFuncNm = deptFuncNm;
	}

	/**
	 * @return the bpInBlueworksFlg
	 */
	public char getBpInBlueworksFlg() {
		return bpInBlueworksFlg;
	}

	/**
	 * @param bpInBlueworksFlg
	 *            the bpInBlueworksFlg to set
	 */
	public void setBpInBlueworksFlg(char bpInBlueworksFlg) {
		this.bpInBlueworksFlg = bpInBlueworksFlg;
	}

	/**
	 * @return the bpBlueworksUrl
	 */
	public String getBpBlueworksUrl() {
		return bpBlueworksUrl;
	}

	/**
	 * @param bpBlueworksUrl
	 *            the bpBlueworksUrl to set
	 */
	public void setBpBlueworksUrl(String bpBlueworksUrl) {
		this.bpBlueworksUrl = bpBlueworksUrl;
	}

	/**
	 * @return the bpOpenText
	 */
	public String getBpOpenText() {
		return bpOpenText;
	}

	/**
	 * @param bpOpenText
	 *            the bpOpenText to set
	 */
	public void setBpOpenText(String bpOpenText) {
		this.bpOpenText = bpOpenText;
	}

	/**
	 * @return the subProcessList
	 */
	public List<BusinessSubProcess> getSubProcessList() {
		return subProcessList;
	}

	/**
	 * @param subProcessList
	 *            the subProcessList to set
	 */
	public void setSubProcessList(List<BusinessSubProcess> subProcessList) {
		this.subProcessList = subProcessList;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "BusinessProcess [getBpId()=" + getBpId() + ", getBpNm()="
				+ getBpNm() + ", getDeptId()=" + getDeptId()
				+ ", getDeptTeamId()=" + getDeptTeamId() + ", getDeptFuncNm()="
				+ getDeptFuncNm() + ", getBpInBlueworksFlg()="
				+ getBpInBlueworksFlg() + ", getBpBlueworksUrl()="
				+ getBpBlueworksUrl() + ", getBpOpenText()=" + getBpOpenText()
				+ ", getSubProcessList()=" + getSubProcessList() + "]";
	}

}
