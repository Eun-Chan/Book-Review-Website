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

public class OneLineInsertCommand implements Command {

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
		//book테이블에 저장하기 위한 변수
		String title = request.getParameter("title");
		String author = request.getParameter("author");
		String isbn13 = request.getParameter("isbn13");
		int price = Integer.parseInt(request.getParameter("priceStandard"));
		String publisher = request.getParameter("publisher");
		List<OneLineReviewDTO> list = null;
		
		DAO dao = DAO.getInstance();
		
		//book 테이블에 없는 책일 경우 DB에 등록
		boolean isIsbnExist = dao.isIsbnExist(isbn13);
		
		if(!isIsbnExist) {
			//책 테이블에 기록
			int result = dao.insertBook(title, author, isbn13, price, publisher);
			
			if(result > 0) {
				System.out.println("도서정보 등록 성공!");
			}
			else {
				System.out.println("도서정보 등록 실패!");
			}
		}
		
		//한 줄 리뷰 테이블에 등록
		int result = dao.insertOneLineRV(user.getUserId(), starScore, oneLineRV, isbn13);
		
		if(result > 0) {
			System.out.println("한 줄 리뷰 등록 성공");
			//현재 보고 있는 책에 대해서 작성된 한 줄 리뷰 전부를 받아옴
			list = dao.selectAllOneLineRV(isbn13);
			
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
