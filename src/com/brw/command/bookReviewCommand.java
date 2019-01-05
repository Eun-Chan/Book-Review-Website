package com.brw.command;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.dao.DAO;
import com.brw.dto.ReviewBoardDTO;
import com.google.gson.Gson;
import com.google.gson.JsonIOException;

public class bookReviewCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setContentType("application/json; charset=utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		String ISBN13 =request.getParameter("ISBN13");
		System.out.println("reviewCommand="+ISBN13);
		DAO dao  = DAO.getInstance();
		List<ReviewBoardDTO> list = dao.getbookreview(ISBN13);
		System.out.println(list);
		try {
			new Gson().toJson(list,response.getWriter());
		} catch (JsonIOException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
