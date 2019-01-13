package com.brw.command.book;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;
import com.brw.dto.ReviewBoardDTO;
import com.brw.dto.ReviewBoardViewDTO;
import com.google.gson.Gson;
import com.google.gson.JsonIOException;

/*
 * 작성자 : 박세준
 * 내용 : 책에 대한 상세 내용 및 리뷰
 */
public class BookReviewCommand implements Command {

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
		List<ReviewBoardViewDTO> list = dao.getbookreview(ISBN13);//17
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
