package com.brw.dto;

import java.sql.Date;

public class OneLineReviewDTO {
	private int no;
	private String isbn;
	private String content;
	private double starScore;
	private String userId;
	private Date now;
	private String delFlag;
	private String transfomeNow;
	
	
	


	public OneLineReviewDTO() {}


	public OneLineReviewDTO(int no, String isbn, String content, double starScore, String userId, Date now,
			String delFlag,String transfomeNow) {
		super();
		this.no = no;
		this.isbn = isbn;
		this.content = content;
		this.starScore = starScore;
		this.userId = userId;
		this.now = now;
		this.delFlag = delFlag;
		this.transfomeNow = transfomeNow;
	}


	public int getNo() {
		return no;
	}


	public void setNo(int no) {
		this.no = no;
	}


	public String getIsbn() {
		return isbn;
	}


	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public double getStarScore() {
		return starScore;
	}


	public void setStarScore(double starScore) {
		this.starScore = starScore;
	}


	public String getUserId() {
		return userId;
	}


	public void setUserId(String userId) {
		this.userId = userId;
	}


	public Date getNow() {
		return now;
	}


	public void setNow(Date now) {
		this.now = now;
	}


	public String getDelFlag() {
		return delFlag;
	}


	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}

	public String getTransfomeNow() {
		return transfomeNow;
	}


	public void setTransfomeNow(String transfomeNow) {
		this.transfomeNow = transfomeNow;
	}


	@Override
	public String toString() {
		return "OneLineReviewDTO [no=" + no + ", isbn=" + isbn + ", content=" + content + ", starScore=" + starScore
				+ ", userId=" + userId + ", now=" + now + ", delFlag=" + delFlag + ", transfomeNow=" + transfomeNow
				+ "]";
	}

	
	
	
	
}
