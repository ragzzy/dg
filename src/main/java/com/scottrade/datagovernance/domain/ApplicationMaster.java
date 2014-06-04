package com.scottrade.datagovernance.domain;

import java.io.Serializable;
import java.sql.Date;

/**
 * The class that represents an Application and its information.
 * @author rnandakumar
 *
 */
public class ApplicationMaster implements Serializable {
	private static final long serialVersionUID = -1L;

	private int applId;
	private String applNm;
	private String applDsc;
	private int applTierId;
	private String applTierPolicyDefnTxt;
	private char applRbacControlledFlg;
	private char applHasBpsInBlueworksFlg;
	private char applLiveFlg;
	private Date applDecommDate;
	private String developedBy;
	private String hostedAt;
	private String authenticationMode;
	private String authorizedBy;
	private String vendorNm;
	private int propsdBAOdeptId;
	private String propsdBAOdeptNm;
	private String propsdBAOtitle;
	private int propsdITAOdeptId;
	private String propsdITAOdeptNm;
	private int drbcId;
	private String drBcDsc;
	private char containsCustInfoFlg;

	public ApplicationMaster() {
		super();
	}

	/**
	 * @return the applId
	 */
	public int getApplId() {
		return applId;
	}

	/**
	 * @param applId the applId to set
	 */
	public void setApplId(int applId) {
		this.applId = applId;
	}

	/**
	 * @return the applNm
	 */
	public String getApplNm() {
		return applNm;
	}

	/**
	 * @param applNm the applNm to set
	 */
	public void setApplNm(String applNm) {
		this.applNm = applNm;
	}

	/**
	 * @return the applDsc
	 */
	public String getApplDsc() {
		return applDsc;
	}

	/**
	 * @param applDsc the applDsc to set
	 */
	public void setApplDsc(String applDsc) {
		this.applDsc = applDsc;
	}

	/**
	 * @return the applRbacControlledFlg
	 */
	public char getApplRbacControlledFlg() {
		return applRbacControlledFlg;
	}

	/**
	 * @param applRbacControlledFlg the applRbacControlledFlg to set
	 */
	public void setApplRbacControlledFlg(char applRbacControlledFlg) {
		this.applRbacControlledFlg = applRbacControlledFlg;
	}

	/**
	 * @return the applHasBpsInBlueworksFlg
	 */
	public char getApplHasBpsInBlueworksFlg() {
		return applHasBpsInBlueworksFlg;
	}

	/**
	 * @param applHasBpsInBlueworksFlg the applHasBpsInBlueworksFlg to set
	 */
	public void setApplHasBpsInBlueworksFlg(char applHasBpsInBlueworksFlg) {
		this.applHasBpsInBlueworksFlg = applHasBpsInBlueworksFlg;
	}

	/**
	 * @return the applLiveFlg
	 */
	public char getApplLiveFlg() {
		return applLiveFlg;
	}

	/**
	 * @param applLiveFlg the applLiveFlg to set
	 */
	public void setApplLiveFlg(char applLiveFlg) {
		this.applLiveFlg = applLiveFlg;
	}

	/**
	 * @return the applDecommDate
	 */
	public Date getApplDecommDate() {
		return applDecommDate;
	}

	/**
	 * @param applDecommDate the applDecommDate to set
	 */
	public void setApplDecommDate(Date applDecommDate) {
		this.applDecommDate = applDecommDate;
	}

	/**
	 * @return the developedBy
	 */
	public String getDevelopedBy() {
		return developedBy;
	}

	/**
	 * @param developedBy the developedBy to set
	 */
	public void setDevelopedBy(String developedBy) {
		this.developedBy = developedBy;
	}

	/**
	 * @return the hostedAt
	 */
	public String getHostedAt() {
		return hostedAt;
	}

	/**
	 * @param hostedAt the hostedAt to set
	 */
	public void setHostedAt(String hostedAt) {
		this.hostedAt = hostedAt;
	}

	/**
	 * @return the authenticationMode
	 */
	public String getAuthenticationMode() {
		return authenticationMode;
	}

	/**
	 * @param authenticationMode the authenticationMode to set
	 */
	public void setAuthenticationMode(String authenticationMode) {
		this.authenticationMode = authenticationMode;
	}

	/**
	 * @return the authorizedBy
	 */
	public String getAuthorizedBy() {
		return authorizedBy;
	}

	/**
	 * @param authorizedBy the authorizedBy to set
	 */
	public void setAuthorizedBy(String authorizedBy) {
		this.authorizedBy = authorizedBy;
	}

	/**
	 * @return the vendorNm
	 */
	public String getVendorNm() {
		return vendorNm;
	}

	/**
	 * @param vendorNm the vendorNm to set
	 */
	public void setVendorNm(String vendorNm) {
		this.vendorNm = vendorNm;
	}

	/**
	 * @return the propsdBAOdeptId
	 */
	public int getPropsdBAOdeptId() {
		return propsdBAOdeptId;
	}

	/**
	 * @param propsdBAOdeptId the propsdBAOdeptId to set
	 */
	public void setPropsdBAOdeptId(int propsdBAOdeptId) {
		this.propsdBAOdeptId = propsdBAOdeptId;
	}

	/**
	 * @return the propsdBAOdeptNm
	 */
	public String getPropsdBAOdeptNm() {
		return propsdBAOdeptNm;
	}

	/**
	 * @param propsdBAOdeptNm the propsdBAOdeptNm to set
	 */
	public void setPropsdBAOdeptNm(String propsdBAOdeptNm) {
		this.propsdBAOdeptNm = propsdBAOdeptNm;
	}

	/**
	 * @return the propsdBAOtitle
	 */
	public String getPropsdBAOtitle() {
		return propsdBAOtitle;
	}

	/**
	 * @param propsdBAOtitle the propsdBAOtitle to set
	 */
	public void setPropsdBAOtitle(String propsdBAOtitle) {
		this.propsdBAOtitle = propsdBAOtitle;
	}

	/**
	 * @return the propsdITAOdeptId
	 */
	public int getPropsdITAOdeptId() {
		return propsdITAOdeptId;
	}

	/**
	 * @param propsdITAOdeptId the propsdITAOdeptId to set
	 */
	public void setPropsdITAOdeptId(int propsdITAOdeptId) {
		this.propsdITAOdeptId = propsdITAOdeptId;
	}

	/**
	 * @return the propsdITAOdeptNm
	 */
	public String getPropsdITAOdeptNm() {
		return propsdITAOdeptNm;
	}

	/**
	 * @param propsdITAOdeptNm the propsdITAOdeptNm to set
	 */
	public void setPropsdITAOdeptNm(String propsdITAOdeptNm) {
		this.propsdITAOdeptNm = propsdITAOdeptNm;
	}

	/**
	 * @return the drbcId
	 */
	public int getDrbcId() {
		return drbcId;
	}

	/**
	 * @param drbcId the drbcId to set
	 */
	public void setDrbcId(int drbcId) {
		this.drbcId = drbcId;
	}

	/**
	 * @return the drBcDsc
	 */
	public String getDrBcDsc() {
		return drBcDsc;
	}

	/**
	 * @param drBcDsc the drBcDsc to set
	 */
	public void setDrBcDsc(String drBcDsc) {
		this.drBcDsc = drBcDsc;
	}

	/**
	 * @return the containsCustInfoFlg
	 */
	public char getContainsCustInfoFlg() {
		return containsCustInfoFlg;
	}

	/**
	 * @param containsCustInfoFlg the containsCustInfoFlg to set
	 */
	public void setContainsCustInfoFlg(char containsCustInfoFlg) {
		this.containsCustInfoFlg = containsCustInfoFlg;
	}

	/**
	 * @return the applTierId
	 */
	public int getApplTierId() {
		return applTierId;
	}

	/**
	 * @param applTierId the applTierId to set
	 */
	public void setApplTierId(int applTierId) {
		this.applTierId = applTierId;
	}

	/**
	 * @return the applTierPolicyDefnTxt
	 */
	public String getApplTierPolicyDefnTxt() {
		return applTierPolicyDefnTxt;
	}

	/**
	 * @param applTierPolicyDefnTxt the applTierPolicyDefnTxt to set
	 */
	public void setApplTierPolicyDefnTxt(String applTierPolicyDefnTxt) {
		this.applTierPolicyDefnTxt = applTierPolicyDefnTxt;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "ApplicationMaster [getApplId()=" + getApplId()
				+ ", getApplNm()=" + getApplNm() + ", getApplDsc()="
				+ getApplDsc() + ", getApplRbacControlledFlg()="
				+ getApplRbacControlledFlg()
				+ ", getApplHasBpsInBlueworksFlg()="
				+ getApplHasBpsInBlueworksFlg() + ", getApplLiveFlg()="
				+ getApplLiveFlg() + ", getApplDecommDate()="
				+ getApplDecommDate() + ", getDevelopedBy()="
				+ getDevelopedBy() + ", getHostedAt()=" + getHostedAt()
				+ ", getAuthenticationMode()=" + getAuthenticationMode()
				+ ", getAuthorizedBy()=" + getAuthorizedBy()
				+ ", getVendorNm()=" + getVendorNm()
				+ ", getPropsdBAOdeptId()=" + getPropsdBAOdeptId()
				+ ", getPropsdBAOdeptNm()=" + getPropsdBAOdeptNm()
				+ ", getPropsdBAOtitle()=" + getPropsdBAOtitle()
				+ ", getPropsdITAOdeptId()=" + getPropsdITAOdeptId()
				+ ", getPropsdITAOdeptNm()=" + getPropsdITAOdeptNm()
				+ ", getDrbcId()=" + getDrbcId() + ", getDrBcDsc()="
				+ getDrBcDsc() + ", getContainsCustInfoFlg()="
				+ getContainsCustInfoFlg() + ", getApplTierId()="
				+ getApplTierId() + ", getApplTierPolicyDefnTxt()="
				+ getApplTierPolicyDefnTxt() + "]";
	}


}
