package com.brw.command;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.dao.DAO;
import com.brw.dto.ReviewBoardComment;
import com.google.gson.Gson;
import com.google.gson.JsonIOException;

public class insertComment implements Command{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		//파라미터 처리하기
		int rbNo = Integer.parseInt(request.getParameter("rbNo"));
		String rbCommentContent = request.getParameter("rbCommentContent");
		String rbCommentWriter = request.getParameter("rbCommentWriter");
		System.out.println(rbNo+","+rbCommentContent+","+rbCommentWriter);
		
		ReviewBoardComment comment = new ReviewBoardComment(rbCommentWriter, rbCommentContent, rbNo);
		
		DAO dao = DAO.getInstance();
		int result = dao.insertComment(comment);
		if(result>0) {
			Gson gson = new Gson();
			try {
				gson.toJson(result,response.getWriter());
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
