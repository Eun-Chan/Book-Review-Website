package com.brw.dto;

import java.io.Serializable;
import java.sql.Date;

/**
 * 
 * @author mhjung
 *	리뷰게시판 dto
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
	private long rbIsbn;
	private String rbContent;
	private String rbDate;
	private double rbStarscore;
	private int rbReadCnt;
	private int rbRecommend;
	private String rbOriginalFilename;
	private String rbRenamedFilename;
	private int rbReport;
	
	public ReviewBoardDTO() {}

	public ReviewBoardDTO(int rbNo, String rbTitle, String rbWriter, String rbBookTitle, long rbIsbn, String rbContent, String rbDate,
			double rbStarscore, int rbReadCnt, int rbRecommend, String rbOriginalFilename, String rbRenamedFilename, int rbReport) {
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
		this.rbOriginalFilename = rbOriginalFilename;
		this.rbRenamedFilename = rbRenamedFilename;
		this.rbReport = rbReport;
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

	public long getRbIsbn() {
		return rbIsbn;
	}

	public String getRbBookTitle() {
		return rbBookTitle;
	}

	public void setRbBookTitle(String rbBookTitle) {
		this.rbBookTitle = rbBookTitle;
	}

	public void setRbIsbn(long rbIsbn) {
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

	public String getRbOriginalFilename() {
		return rbOriginalFilename;
	}

	public void setRbOriginalFilename(String rbOriginalFilename) {
		this.rbOriginalFilename = rbOriginalFilename;
	}

	public String getRbRenamedFilename() {
		return rbRenamedFilename;
	}

	public void setRbRenamedFilename(String rbRenamedFilename) {
		this.rbRenamedFilename = rbRenamedFilename;
	}

	public int getRbReport() {
		return rbReport;
	}

	public void setRbReport(int rbReport) {
		this.rbReport = rbReport;
	}

	@Override
	public String toString() {
		return "ReviewBoardDTO [rbNo=" + rbNo + ", rbTitle=" + rbTitle + ", rbWriter=" + rbWriter + ", rbBookTitle=" + rbBookTitle + ", rbIsbn=" + rbIsbn
				+ ", rbContent=" + rbContent + ", rbDate=" + rbDate + ", rbStarscore=" + rbStarscore + ", rbReadCnt="
				+ rbReadCnt + ", rbRecommend=" + rbRecommend + ", rbOriginalFilename=" + rbOriginalFilename
				+ ", rbRenamedFilename=" + rbRenamedFilename + ", rbReport=" + rbReport + "]";
	}
	
	
	
	
	
}
