package com.brw.command.review;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;
import com.google.gson.Gson;
import com.google.gson.JsonIOException;

public class DeleteReviewBoardCommand implements Command{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		//1. 인코딩처리
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//2. 파라미터 처리
		int rbNo =  Integer.parseInt(request.getParameter("rbNo"));
		
		DAO dao = DAO.getInstance();
		
		int result = dao.deleteReviewBoard(rbNo);
		
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
