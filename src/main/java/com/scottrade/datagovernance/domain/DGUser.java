package com.scottrade.datagovernance.domain;

import java.io.Serializable;
 
public class DGUser implements Serializable{
 
    private static final long serialVersionUID = -7788619177798333712L;

    private int userId;
    private String userNm;
    private String userPwd; 
    private String userFirstNm; 
    private String userLastNm; 
    private String userNickNm; 
    private String userEmailId;
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getUserPwd() {
		return userPwd;
	}
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
	public String getUserFirstNm() {
		return userFirstNm;
	}
	public void setUserFirstNm(String userFirstNm) {
		this.userFirstNm = userFirstNm;
	}
	public String getUserLastNm() {
		return userLastNm;
	}
	public void setUserLastNm(String userLastNm) {
		this.userLastNm = userLastNm;
	}
	public String getUserNickNm() {
		return userNickNm;
	}
	public void setUserNickNm(String userNickNm) {
		this.userNickNm = userNickNm;
	}
	public String getUserEmailId() {
		return userEmailId;
	}
	public void setUserEmailId(String userEmailId) {
		this.userEmailId = userEmailId;
	}
    
    
}