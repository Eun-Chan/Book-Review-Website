package com.brw.command;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.dao.DAO;
import com.brw.dto.ReviewBoardComment;
import com.brw.dto.ReviewBoardDTO;

public class GetReviewSelectOne implements Command{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
//		int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int rbNo = Integer.parseInt(request.getParameter("rbNo"));
		DAO dao = DAO.getInstance();
		
		ReviewBoardDTO review = dao.getReviewSelectOne(rbNo);
		
		//해당 게시물 댓글 가져오기
		List<ReviewBoardComment> reviewComment = dao.getReviewBoardCommentList(rbNo);
		//해당 게시물 댓글갯수 가져오기
		int count = dao.getReivewBoardCommentAllCount(rbNo);
		//제일 마지막 댓글 가져오기
		ReviewBoardComment lastReviewComment = dao.getReviewBoardCommentLast(rbNo);
		
		request.setAttribute("lastReviewComment", lastReviewComment);
		request.setAttribute("count",count);
		request.setAttribute("review", review);
		request.setAttribute("reviewComment", reviewComment);
	}
}
