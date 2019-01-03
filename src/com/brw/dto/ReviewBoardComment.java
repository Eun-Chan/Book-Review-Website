package com.brw.dto;

import java.io.Serializable;
import java.sql.Date;

public class ReviewBoardComment implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
 	private int rbCommentNo; //댓글 번호
	private String rbCommentWriter; //댓글 작성자
	private String rbCommentContent; //댓글 메인 컨텐츠
	private int rbRef; //댓글이 참조할 게시판 번호
	private Date rbCommentDate; //댓글 작성날짜
	
	
	public int getRbCommentNo() {
		return rbCommentNo;
	}
	public void setRbCommentNo(int rbCommentNo) {
		this.rbCommentNo = rbCommentNo;
	}
	public ReviewBoardComment() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ReviewBoardComment(String rbCommentWriter, String rbCommentContent, int rbRef) {
		super();
		this.rbCommentWriter = rbCommentWriter;
		this.rbCommentContent = rbCommentContent;
		this.rbRef = rbRef;
	}
	public String getRbCommentWriter() {
		return rbCommentWriter;
	}
	public void setRbCommentWriter(String rbCommentWriter) {
		this.rbCommentWriter = rbCommentWriter;
	}
	public String getRbCommentContent() {
		return rbCommentContent;
	}
	public void setRbCommentContent(String rbCommentContent) {
		this.rbCommentContent = rbCommentContent;
	}
	public int getRbRef() {
		return rbRef;
	}
	public void setRbRef(int rbRef) {
		this.rbRef = rbRef;
	}
	public Date getRbCommentDate() {
		return rbCommentDate;
	}
	public void setRbCommentDate(Date rbCommentDate) {
		this.rbCommentDate = rbCommentDate;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}
