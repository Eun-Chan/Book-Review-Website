package com.brw.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BookInfomationCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
		String isbn13 = request.getParameter("isbn13");
		
		System.out.println("isbn13@command: "+isbn13);//book.isbn13
		
		request.setAttribute("isbn13", isbn13);

	}

}
