package com.scottrade.datagovernance.domain;

public class HRDepartmentPositions {

	public int deptId;
	public String deptNm;
	public String deptNmPerPayroll;
	public String jobTitle;
	public String jobPositionTitle;
	public String lineOfBusiness;
	public String division;
	
	public HRDepartmentPositions(
		String strLineOfBusiness,
		String strDivision,
		String strDeptNm,
		String strDeptNmPerPayroll,
		String strJobPositionTitle,
		String strJobTitle
	) {
		this.deptNm = strDeptNm;
		this.deptNmPerPayroll = strDeptNmPerPayroll;
		this.jobTitle = strJobTitle;
		this.jobPositionTitle = strJobPositionTitle;
		this.lineOfBusiness = strLineOfBusiness;
		this.division = strDivision;
	}

	/**
	 * @return the deptId
	 */
	public int getDeptId() {
		return deptId;
	}
	/**
	 * @param deptId the deptId to set
	 */
	public void setDeptId(int deptId) {
		this.deptId = deptId;
	}
	/**
	 * @return the deptNm
	 */
	public String getDeptNm() {
		return deptNm;
	}
	/**
	 * @param deptNm the deptNm to set
	 */
	public void setDeptNm(String deptNm) {
		this.deptNm = deptNm;
	}
	/**
	 * @return the deptNmPerPayroll
	 */
	public String getDeptNmPerPayroll() {
		return deptNmPerPayroll;
	}
	/**
	 * @param deptNmPerPayroll the deptNmPerPayroll to set
	 */
	public void setDeptNmPerPayroll(String deptNmPerPayroll) {
		this.deptNmPerPayroll = deptNmPerPayroll;
	}
	/**
	 * @return the jobTitle
	 */
	public String getJobTitle() {
		return jobTitle;
	}
	/**
	 * @param jobTitle the jobTitle to set
	 */
	public void setJobTitle(String jobTitle) {
		this.jobTitle = jobTitle;
	}
	/**
	 * @return the jobPositionTitle
	 */
	public String getJobPositionTitle() {
		return jobPositionTitle;
	}
	/**
	 * @param jobPositionTitle the jobPositionTitle to set
	 */
	public void setJobPositionTitle(String jobPositionTitle) {
		this.jobPositionTitle = jobPositionTitle;
	}
	/**
	 * @return the lineOfBusiness
	 */
	public String getLineOfBusiness() {
		return lineOfBusiness;
	}
	/**
	 * @param lineOfBusiness the lineOfBusiness to set
	 */
	public void setLineOfBusiness(String lineOfBusiness) {
		this.lineOfBusiness = lineOfBusiness;
	}
	/**
	 * @return the division
	 */
	public String getDivision() {
		return division;
	}
	/**
	 * @param division the division to set
	 */
	public void setDivision(String division) {
		this.division = division;
	}
	
	
}
