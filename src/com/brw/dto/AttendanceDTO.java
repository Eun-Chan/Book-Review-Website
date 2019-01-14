package com.brw.dto;

import java.io.Serializable;

public class AttendanceDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private int atNo;
	private String atContent;
	private String atUserId;
	private int atTotal;
	private int atSerial;
	private String atDate;
	
	// user테이블과 쪼인해서 담을 데이터
	private String userNickName;
	private int userGrade;
	
	public AttendanceDTO() {}
	
	public AttendanceDTO(String atContent, String atUserId) {
		this.atContent = atContent;
		this.atUserId = atUserId;
	}
	
	public int getAtNo() {
		return atNo;
	}
	public void setAtNo(int atNo) {
		this.atNo = atNo;
	}
	public String getAtContent() {
		return atContent;
	}
	public void setAtContent(String atContent) {
		this.atContent = atContent;
	}
	public String getAtUserId() {
		return atUserId;
	}
	public void setAtUserId(String atUserId) {
		this.atUserId = atUserId;
	}
	public int getAtTotal() {
		return atTotal;
	}
	public void setAtTotal(int atTotal) {
		this.atTotal = atTotal;
	}
	public int getAtSerial() {
		return atSerial;
	}
	public void setAtSerial(int atSerial) {
		this.atSerial = atSerial;
	}
	public String getAtDate() {
		return atDate;
	}
	public void setAtDate(String atDate) {
		this.atDate = atDate;
	}
	public String getUserNickName() {
		return userNickName;
	}
	public void setUserNickName(String userNickName) {
		this.userNickName = userNickName;
	}
	public int getUserGrade() {
		return userGrade;
	}
	public void setUserGrade(int userGrade) {
		this.userGrade = userGrade;
	}
	
	
	
}
