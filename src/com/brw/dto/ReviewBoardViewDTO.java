package com.brw.dto;

import java.io.Serializable;
/*
 * @author mhjung
 *	리뷰게시판에서 보여줘야할 모든 것이 담긴 dto
 *  유저테이블과도 쪼인한 결과도 담을 것임
 *  리뷰보드DTO의 대부분이 필요하므로 상속
 */
public class ReviewBoardViewDTO extends ReviewBoardDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private boolean dateNew; // 새로운 글인지 아닌지 db에서 계산한 값 입력
	private int commentCnt; // 댓글 개수용
	
	// user table과 join하여 가져올 userNickName, userGrade
	private String userNickName;
	private int userGrade;
	
	public ReviewBoardViewDTO() {}

	public boolean isDateNew() {
		return dateNew;
	}

	public void setDateNew(boolean dateNew) {
		this.dateNew = dateNew;
	}

	public int getCommentCnt() {
		return commentCnt;
	}

	public void setCommentCnt(int commentCnt) {
		this.commentCnt = commentCnt;
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
