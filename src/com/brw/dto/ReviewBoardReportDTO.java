package com.brw.dto;

public class ReviewBoardReportDTO {
	private int rbReportRbNo; //신고 당하는 글번호
	private String rbReportTitle;//신고 당하는 글 제목
	private String rbReportSuspect; //신고당하는 사람
	private String rbReportWriter; //신고 하는 사람
	private String rbReportContent; //신고내용
	private String rbReportClasses; //신고 분류
	private String reReportDate;//신고당한 날짜
	
	
	public ReviewBoardReportDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ReviewBoardReportDTO(int rbReportRbNo, String rbReportTitle, String rbReportSuspect, String rbReportWriter,
			String rbReportContent, String rbReportClasses) {
		super();
		this.rbReportRbNo = rbReportRbNo;
		this.rbReportTitle = rbReportTitle;
		this.rbReportSuspect = rbReportSuspect;
		this.rbReportWriter = rbReportWriter;
		this.rbReportContent = rbReportContent;
		this.rbReportClasses = rbReportClasses;
	}
	public int getRbReportRbNo() {
		return rbReportRbNo;
	}
	public void setRbReportRbNo(int rbReportRbNo) {
		this.rbReportRbNo = rbReportRbNo;
	}
	public String getRbReportTitle() {
		return rbReportTitle;
	}
	public void setRbReportTitle(String rbReportTitle) {
		this.rbReportTitle = rbReportTitle;
	}
	public String getRbReportSuspect() {
		return rbReportSuspect;
	}
	public void setRbReportSuspect(String rbReportSuspect) {
		this.rbReportSuspect = rbReportSuspect;
	}
	public String getRbReportWriter() {
		return rbReportWriter;
	}
	public void setRbReportWriter(String rbReportWriter) {
		this.rbReportWriter = rbReportWriter;
	}
	public String getRbReportContent() {
		return rbReportContent;
	}
	public void setRbReportContent(String rbReportContent) {
		this.rbReportContent = rbReportContent;
	}
	public String getRbReportClasses() {
		return rbReportClasses;
	}
	public void setRbReportClasses(String rbReportClasses) {
		this.rbReportClasses = rbReportClasses;
	}
	public String getReReportDate() {
		return reReportDate;
	}
	public void setReReportDate(String reReportDate) {
		this.reReportDate = reReportDate;
	}
	@Override
	public String toString() {
		return "ReviewBoardReportDTO [rbReportRbNo=" + rbReportRbNo + ", rbReportTitle=" + rbReportTitle
				+ ", rbReportSuspect=" + rbReportSuspect + ", rbReportWriter=" + rbReportWriter + ", rbReportContent="
				+ rbReportContent + ", rbReportClasses=" + rbReportClasses + "]";
	}
}
