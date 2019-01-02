package com.brw.dto;

import java.io.Serializable;
import java.sql.Date;

/**
 * 
 * @author mhjung
 *	테스트용 리뷰dto
 */
public class ReviewDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int reviewNo;
	private String reviewTitle;
	private String reviewWriter;
	private String reviewBookId;
	private String reviewContent;
	private Date reviewDate;
	private int reviewReadCnt;
	private int reviewRecommend;
	
	public ReviewDTO() {}
	
	public ReviewDTO(int reviewNo, String reviewTitle, String reviewWriter, String reviewBookId, String reviewContent,
			Date reviewDate, int reviewReadCnt, int reviewRecommend) {
		this.reviewNo = reviewNo;
		this.reviewTitle = reviewTitle;
		this.reviewWriter = reviewWriter;
		this.reviewBookId = reviewBookId;
		this.reviewContent = reviewContent;
		this.reviewDate = reviewDate;
		this.reviewReadCnt = reviewReadCnt;
		this.reviewRecommend = reviewRecommend;
	}

	public int getReviewNo() {
		return reviewNo;
	}
	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}
	public String getReviewTitle() {
		return reviewTitle;
	}
	public void setReviewTitle(String reviewTitle) {
		this.reviewTitle = reviewTitle;
	}
	public String getReviewWriter() {
		return reviewWriter;
	}
	public void setReviewWriter(String reviewWriter) {
		this.reviewWriter = reviewWriter;
	}
	public String getReviewBookId() {
		return reviewBookId;
	}
	public void setReviewBookId(String reviewBookId) {
		this.reviewBookId = reviewBookId;
	}
	public String getReviewContent() {
		return reviewContent;
	}
	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}
	public Date getReviewDate() {
		return reviewDate;
	}
	public void setReviewDate(Date reviewDate) {
		this.reviewDate = reviewDate;
	}
	public int getReviewReadCnt() {
		return reviewReadCnt;
	}
	public void setReviewReadCnt(int reviewReadCnt) {
		this.reviewReadCnt = reviewReadCnt;
	}
	public int getReviewRecommend() {
		return reviewRecommend;
	}
	public void setReviewRecommend(int reviewRecommend) {
		this.reviewRecommend = reviewRecommend;
	}

	@Override
	public String toString() {
		return "ReviewDTO [reviewNo=" + reviewNo + ", reviewTitle=" + reviewTitle + ", reviewWriter=" + reviewWriter
				+ ", reviewBookId=" + reviewBookId + ", reviewContent=" + reviewContent + ", reviewDate=" + reviewDate
				+ ", reviewReadCnt=" + reviewReadCnt + ", reviewRecommend=" + reviewRecommend + "]";
	}

	
	
	
}
