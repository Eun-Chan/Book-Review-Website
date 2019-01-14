package com.brw.command.review;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;
import com.brw.dto.ReviewBoardComment;
import com.google.gson.Gson;
import com.google.gson.JsonIOException;

public class DeleteReviewBoardCommentCommand implements Command{

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
		int ud = 0;
		DAO dao = DAO.getInstance();
		List<ReviewBoardComment> commentList = dao.checkRecommend(rbCommentNo,rbNo);
		System.out.println(commentList);
		
		if(!commentList.isEmpty()) {
			ud = 1;
			System.out.println("업데이트");
			result = dao.udReviewBoardComment(rbCommentNo,rbNo,ud);
		}else {
			System.out.println("딜리트");
			ud = 2;
			result = dao.udReviewBoardComment(rbCommentNo,rbNo,ud);
		}
		
		Gson gson = new Gson();
		 
		try {
			gson.toJson(ud , response.getWriter());
		} catch (JsonIOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
