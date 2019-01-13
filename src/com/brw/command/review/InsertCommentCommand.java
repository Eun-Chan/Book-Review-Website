package com.brw.command.review;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;
import com.brw.dto.ReviewBoardComment;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;

/*
 * 작성자 : 장선웅
 * 내용 : 리뷰 게시판에 대한 댓글입력
 */
public class InsertCommentCommand implements Command{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		response.setContentType("application/json; charset=utf-8");
		//파라미터 처리하기
		int rbNo = Integer.parseInt(request.getParameter("rbNo"));
		String rbCommentContent = request.getParameter("rbCommentContent");
		String rbCommentWriter = request.getParameter("rbCommentWriter");
		String rbCommentWriterNickName = request.getParameter("rbCommentWriterNickName");
		System.out.println(rbNo+","+rbCommentContent+","+rbCommentWriter+","+rbCommentWriterNickName);
		
		ReviewBoardComment comment = new ReviewBoardComment(rbCommentWriter, rbCommentContent, rbNo,rbCommentWriterNickName);
		
		DAO dao = DAO.getInstance();
		int result = dao.insertComment(comment);
		if(result>0) {
			ReviewBoardComment lastComment = dao.getReviewBoardCommentLast(rbNo);
			Gson gson = new GsonBuilder().setDateFormat("YYYY-MM-DD hh:mm:ss").create();
			try {
				gson.toJson(lastComment,response.getWriter());
			} catch (JsonIOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

}
