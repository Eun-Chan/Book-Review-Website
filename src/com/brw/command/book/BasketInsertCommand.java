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
		
		UserDTO user = (UserDTO) request.getAttribute("user");
		String title = request.getParameter("title");
		String author = request.getParameter("author");
		String isbn = request.getParameter("isbn");
		int price = Integer.parseInt(request.getParameter("priceStandard"));
		String publisher = request.getParameter("publisher");
		
		DAO dao = DAO.getInstance();
		
		int result = dao.insertBook(title, author, isbn, price, publisher);
		
		if(result > 0) {
			
		}
		else {
			
		};
		

	}

}
