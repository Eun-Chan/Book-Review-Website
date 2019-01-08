package com.brw.command.review;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;
import com.brw.dto.ReviewBoardComment;

public class DeleteReviewBoardComment implements Command{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		int rbCommentNo = Integer.parseInt(request.getParameter("rbCommentNo"));
		int rbNo = Integer.parseInt(request.getParameter("rbNo"));
		int result = 0;		
		DAO dao = DAO.getInstance();
		List<ReviewBoardComment> commentList = dao.checkRecommend(rbCommentNo);
		result = dao.deleteReviewBoardComment(rbCommentNo,rbNo);
//		if(commentList.isEmpty() || commentList==null) {
//			
//		}else {
//			
//		}
	}

}
