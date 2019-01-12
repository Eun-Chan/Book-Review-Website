package com.brw.command.book;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;
import com.brw.dto.BookBasketDTO;
import com.google.gson.Gson;
import com.google.gson.JsonIOException;

public class BookBasketCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setContentType("application/json; charset=utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String userId = request.getParameter("userId");
		System.out.println(userId);
		DAO dao  = DAO.getInstance();
		List<BookBasketDTO> list = dao.showBookBasket(userId);
				
		
		System.out.println("listbasket="+list);
		try {
			new Gson().toJson(list,response.getWriter());
		} catch (JsonIOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
