package com.brw.command.book;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;

/*
 * 작성자 : 김민우
 * 내용 : Book List 에서 클릭 시 bookInfo(책 상세내용) 이동
 */
public class BookInfomationCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
		String isbn13 = request.getParameter("isbn13");
		
		System.out.println("isbn13@command: "+isbn13);//book.isbn13
		
		request.setAttribute("isbn13", isbn13);

	}

}
