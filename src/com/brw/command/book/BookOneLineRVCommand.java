package com.brw.command.book;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;
import com.brw.dto.OneLineReviewDTO;
import com.brw.dto.UserDTO;
import com.google.gson.Gson;
import com.google.gson.JsonIOException;

public class BookOneLineRVCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setContentType("application/json; charset=utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//파라미터 핸들러
		UserDTO user = (UserDTO) request.getSession().getAttribute("user");
		double starScore = Double.parseDouble(request.getParameter("starScore"));
		String oneLineRV = request.getParameter("oneLineRV");
		String isbn13 = request.getParameter("isbn13");
		List<OneLineReviewDTO> list = null;
		
		DAO dao = DAO.getInstance();
		
		int result = dao.insertOneLineRV(user.getUserId(), starScore, oneLineRV, isbn13);
		
		if(result > 0) {
			System.out.println("한 줄 리뷰 등록 성공");
			list = dao.selectAllOneLineRV();
			
		}else {
			System.out.println("한 줄 리뷰 등록 실패");
		}

		System.out.println("list@onelinecommand"+list);
		try {
			new Gson().toJson(list, response.getWriter());
		} catch (JsonIOException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
