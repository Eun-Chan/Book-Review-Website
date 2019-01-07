package com.brw.command.review;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;
import com.brw.dto.ReviewBoardComment;
import com.google.gson.Gson;
import com.google.gson.JsonIOException;

/*
 * 작성자 : 장선웅
 * 내용 : 리뷰 게시판에 대한 댓글에 대한 대댓글
 */
public class InsertReCommentCommand implements Command{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		//인코딩 처리
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		response.setContentType("application/json; charset=utf-8");
		//파라미터 처리
		int rbCommentNo = Integer.parseInt(request.getParameter("rbCommentNo"));
		String rbCommentContent= request.getParameter("rbCommentContent");
		String rbCommentWriter = request.getParameter("rbCommentWriter");
		int rbNo = Integer.parseInt(request.getParameter("rbNo"));
	
		DAO dao = DAO.getInstance();
		int result = dao.insertReComment(rbCommentNo,rbCommentContent,rbCommentWriter,rbNo);
		if(result>0) {
			Gson gson = new Gson();
			ReviewBoardComment lastReComment = dao.getReviewBoardReCommentLast(rbCommentNo,rbNo);
			try {
				gson.toJson(lastReComment,response.getWriter());
			} catch (JsonIOException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		
	}

}
