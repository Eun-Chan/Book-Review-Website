package com.brw.command.book;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;
import com.brw.dto.UserDTO;

public class BasketInsertCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//파라미터 핸들러
		UserDTO user = (UserDTO) request.getSession().getAttribute("user");
		String title = request.getParameter("title");
		String author = request.getParameter("author");
		String isbn = request.getParameter("isbn13");
		int price = Integer.parseInt(request.getParameter("priceStandard"));
		String publisher = request.getParameter("publisher");
	
		DAO dao = DAO.getInstance();
		
		// 가져온 ISBN이 book테이블에 존재하는 지 검사 후 없다면 등록
		// dao 1번 사용
		boolean isIsbnExist = dao.isIsbnExist(isbn);
		
		if(!isIsbnExist) {
			//책 테이블에 기록
			int result = dao.insertBook(title, author, isbn, price, publisher);
			
			if(result > 0) {
				System.out.println("도서정보 등록 성공!");
			}
			else {
				System.out.println("도서정보 등록 실패!");
			}
		}
		int result = 0;
		//장바구니에 동일한 책이 있는 지 검사
		boolean basketCheck = dao.isChecked(user, isbn);
		
		if(basketCheck == true ) {
			//있는 경우 장바구니 테이블에서 삭제
			dao.deleteBasket(user, isbn);
			
		}else {
			//없는 경우 장바구니 테이블에 등록
			result = dao.insertBasket(user, isbn, title, price);			
		}
		
		if(result > 0) {
			System.out.println("장바구니 등록 성공!");
		}
		else {
			System.out.println("장바구니 등록 실패!");
		}

		String returnIsbnNo = isbn;
		System.out.println("returnIsbnNo"+returnIsbnNo);
		
		request.setAttribute("returnIsbnNo", returnIsbnNo);
	};
		

}


