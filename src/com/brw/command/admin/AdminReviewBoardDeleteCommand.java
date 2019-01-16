package com.brw.command.admin;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;
import com.google.gson.Gson;
import com.google.gson.JsonIOException;

public class AdminReviewBoardDeleteCommand implements Command{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
	
		//1. 파라미터 처리
		int rbNo = Integer.parseInt(request.getParameter("rbNo"));
		
		DAO dao = DAO.getInstance();
		
		int result = dao.deleteReviewBoard(rbNo);
		
		if(result>0) {
			result = dao.updateReviewReport(rbNo);
		}
		
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
