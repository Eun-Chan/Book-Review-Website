package com.brw.command.book;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;
import com.brw.dto.BookBasketDTO;
import com.brw.dto.UserDTO;
import com.google.gson.Gson;
import com.google.gson.JsonIOException;

public class checkedBasketCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setContentType("application/json; charset=utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String isbn = request.getParameter("ISBN");
		UserDTO user = (UserDTO) request.getSession().getAttribute("user");
		DAO dao  = DAO.getInstance();
		int result = dao.checkeddelete(user, isbn);
		
		if(result > 0) {
			List<BookBasketDTO> list=dao.bookBasket(user.getUserId());
			try {
				new Gson().toJson(list,response.getWriter());
			} catch (JsonIOException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			System.out.println("checkedbasket="+list);
		}
	}

}
