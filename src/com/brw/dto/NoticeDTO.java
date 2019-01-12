package com.brw.dto;

import java.io.Serializable;

public class NoticeDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private int ntcNo;
	private String ntcTitle;
	private String ntcContent;
	private String ntcDate;
	private int ntcReadcnt;
	private String ntcAllowview;
	private String ntcDelflag;
	
	private boolean dateNew;
	
	public NoticeDTO() {}
	
	// 공지사항 글 등록용 생성자
	public NoticeDTO(int ntcNo, String ntcTitle, String ntcContent) {
		this.ntcNo = ntcNo;
		this.ntcTitle = ntcTitle;
		this.ntcContent = ntcContent;
	}
	
	public NoticeDTO(int ntcNo, String ntcTitle, String ntcContent, String ntcDate, int ntcReadcnt, String ntcAllowview, String ntcDelflag) {
		this.ntcNo = ntcNo;
		this.ntcTitle = ntcTitle;
		this.ntcContent = ntcContent;
		this.ntcDate = ntcDate;
		this.ntcReadcnt = ntcReadcnt;
		this.ntcAllowview = ntcAllowview;
		this.ntcDelflag = ntcDelflag;
	}

	public int getNtcNo() {
		return ntcNo;
	}

	public void setNtcNo(int ntcNo) {
		this.ntcNo = ntcNo;
	}

	public String getNtcTitle() {
		return ntcTitle;
	}

	public void setNtcTitle(String ntcTitle) {
		this.ntcTitle = ntcTitle;
	}

	public String getNtcContent() {
		return ntcContent;
	}

	public void setNtcContent(String ntcContent) {
		this.ntcContent = ntcContent;
	}

	public String getNtcDate() {
		return ntcDate;
	}

	public void setNtcDate(String ntcDate) {
		this.ntcDate = ntcDate;
	}

	public int getNtcReadcnt() {
		return ntcReadcnt;
	}

	public void setNtcReadcnt(int ntcReadcnt) {
		this.ntcReadcnt = ntcReadcnt;
	}

	public String getNtcAllowview() {
		return ntcAllowview;
	}

	public void setNtcAllowview(String ntcAllowview) {
		this.ntcAllowview = ntcAllowview;
	}

	public String getNtcDelflag() {
		return ntcDelflag;
	}

	public void setNtcDelflag(String ntcDelflag) {
		this.ntcDelflag = ntcDelflag;
	}

	public boolean isDateNew() {
		return dateNew;
	}

	public void setDateNew(boolean dateNew) {
		this.dateNew = dateNew;
	}
	
	
	
}
