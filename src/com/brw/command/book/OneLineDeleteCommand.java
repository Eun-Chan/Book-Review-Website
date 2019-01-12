package com.brw.command.book;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;
import com.brw.dto.OneLineReviewDTO;
import com.google.gson.Gson;
import com.google.gson.JsonIOException;

public class OneLineDeleteCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setContentType("application/json; charset=utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		int oneLineNo = Integer.parseInt(request.getParameter("oneLineNo"));
		String userId = request.getParameter("userId");
		String isbn13 = request.getParameter("isbn13");
		List<OneLineReviewDTO> list = null;
		
		DAO dao = DAO.getInstance();
		
		int result = dao.deleteOneLineReview(userId, oneLineNo);
		
		if(result > 0) {
			System.out.println("한 줄 리뷰 삭제 성공");
			list = dao.selectAllOneLineRV(isbn13);
		}else {
			System.out.println("한 줄 리뷰 삭제 실패");
		}
		
		
		try {
			new Gson().toJson(list, response.getWriter());
		} catch (JsonIOException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
