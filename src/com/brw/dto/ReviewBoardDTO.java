package com.brw.dto;

import java.io.Serializable;
import java.sql.Date;

/**
 * 
 * @author mhjung
 *	리뷰게시판 dto
 *  insert, update용으로 쓸 것
 */
public class ReviewBoardDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int rbNo;
	private String rbTitle;
	private String rbWriter;
	private String rbBookTitle;
	private String rbIsbn;
	private String rbContent;
	private String rbDate;
	private double rbStarscore;
	private int rbReadCnt;
	private int rbRecommend;
	private int rbReport;
	private String delFlag;
	
	
	public ReviewBoardDTO() {}

	// insert용 생성자
	public ReviewBoardDTO(String rbTitle, String rbWriter, String rbBookTitle, String rbIsbn, String rbContent,
			double rbStarscore) {
		this.rbTitle = rbTitle;
		this.rbWriter = rbWriter;
		this.rbBookTitle = rbBookTitle;
		this.rbIsbn = rbIsbn;
		this.rbContent = rbContent;
		this.rbStarscore = rbStarscore;
	}

	public ReviewBoardDTO(int rbNo, String rbTitle, String rbWriter, String rbBookTitle, String rbIsbn, String rbContent, String rbDate,
			double rbStarscore, int rbReadCnt, int rbRecommend, int rbReport, String delFlag) {
		this.rbNo = rbNo;
		this.rbTitle = rbTitle;
		this.rbWriter = rbWriter;
		this.rbIsbn = rbIsbn;
		this.rbBookTitle = rbBookTitle;
		this.rbContent = rbContent;
		this.rbDate = rbDate;
		this.rbStarscore = rbStarscore;
		this.rbReadCnt = rbReadCnt;
		this.rbRecommend = rbRecommend;
		this.rbReport = rbReport;
		this.delFlag = delFlag;
	}

	public int getRbNo() {
		return rbNo;
	}

	public void setRbNo(int rbNo) {
		this.rbNo = rbNo;
	}

	public String getRbTitle() {
		return rbTitle;
	}

	public void setRbTitle(String rbTitle) {
		this.rbTitle = rbTitle;
	}

	public String getRbWriter() {
		return rbWriter;
	}

	public void setRbWriter(String rbWriter) {
		this.rbWriter = rbWriter;
	}

	public String getRbIsbn() {
		return rbIsbn;
	}

	public String getRbBookTitle() {
		return rbBookTitle;
	}

	public void setRbBookTitle(String rbBookTitle) {
		this.rbBookTitle = rbBookTitle;
	}

	public void setRbIsbn(String rbIsbn) {
		this.rbIsbn = rbIsbn;
	}

	public String getRbContent() {
		return rbContent;
	}

	public void setRbContent(String rbContent) {
		this.rbContent = rbContent;
	}

	public String getRbDate() {
		return rbDate;
	}

	public void setRbDate(String rbDate) {
		this.rbDate = rbDate;
	}

	public double getRbStarscore() {
		return rbStarscore;
	}

	public void setRbStarscore(double rbStarscore) {
		this.rbStarscore = rbStarscore;
	}

	public int getRbReadCnt() {
		return rbReadCnt;
	}

	public void setRbReadCnt(int rbReadCnt) {
		this.rbReadCnt = rbReadCnt;
	}

	public int getRbRecommend() {
		return rbRecommend;
	}

	public void setRbRecommend(int rbRecommend) {
		this.rbRecommend = rbRecommend;
	}

	public int getRbReport() {
		return rbReport;
	}

	public void setRbReport(int rbReport) {
		this.rbReport = rbReport;
	}

	public String getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}

	@Override
	public String toString() {
		return "ReviewBoardDTO [rbNo=" + rbNo + ", rbTitle=" + rbTitle + ", rbWriter=" + rbWriter + ", rbBookTitle=" + rbBookTitle + ", rbIsbn=" + rbIsbn
				+ ", rbContent=" + rbContent + ", rbDate=" + rbDate + ", rbStarscore=" + rbStarscore + ", rbReadCnt="
				+ rbReadCnt + ", rbRecommend=" + rbRecommend + ", rbReport=" + rbReport + ", delFlag=" + delFlag + "]";
	}
	
	
}
