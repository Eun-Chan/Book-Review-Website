package com.brw.command;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.dao.DAO;
import com.brw.dto.ReviewDTO;
import com.google.gson.Gson;

public class bookReviewCommend implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		try {
			getbookreview(request,response);
			
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public List<ReviewDTO> getbookreview(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String booktitle = req.getParameter("booktitle");
		res.setContentType("application/json; charset=utf-8");
		DAO dao  = DAO.getInstance();
		List<ReviewDTO> list = dao.getbookreview(booktitle);
		System.out.println("commend@"+list);
		//req.setAttribute("list", list);
		/*RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/bookInfo/bookInfo.jsp");
		
		dispatcher.forward(req, res);*/
		new Gson().toJson(list,res.getWriter());
		return list;
	}
}
