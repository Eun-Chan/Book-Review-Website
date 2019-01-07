package com.brw.dto;

public class ReviewBoardLikeDTO {
	private int likeNo;
	private int likeRbNo;
	private String likeUserId;
	private int likeCounter;
	
	
	public ReviewBoardLikeDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ReviewBoardLikeDTO(int likeNo, int likeRbNo, String likeUserId, int likeCounter) {
		super();
		this.likeNo = likeNo;
		this.likeRbNo = likeRbNo;
		this.likeUserId = likeUserId;
		this.likeCounter = likeCounter;
	}
	public int getLikeNo() {
		return likeNo;
	}
	public void setLikeNo(int likeNo) {
		this.likeNo = likeNo;
	}
	public int getLikeRbNo() {
		return likeRbNo;
	}
	public void setLikeRbNo(int likeRbNo) {
		this.likeRbNo = likeRbNo;
	}
	@Override
	public String toString() {
		return "ReviewBoardLikeDTO [likeNo=" + likeNo + ", likeRbNo=" + likeRbNo + ", likeUserId=" + likeUserId
				+ ", likeCounter=" + likeCounter + "]";
	}
	public String getLikeUserId() {
		return likeUserId;
	}
	public void setLikeUserId(String likeUserId) {
		this.likeUserId = likeUserId;
	}
	public int getLikeCounter() {
		return likeCounter;
	}
	public void setLikeCounter(int likeCounter) {
		this.likeCounter = likeCounter;
	}
	
	
}
