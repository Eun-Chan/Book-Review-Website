package com.brw.command;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.dao.DAO;
import com.brw.dto.ReviewBoardDTO;

public class GetReviewSelectOne implements Command{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
//		int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int rbNo = Integer.parseInt(request.getParameter("rbNo"));
		DAO dao = DAO.getInstance();
		
		ReviewBoardDTO review = dao.getReviewSelectOne(rbNo);
		
		request.setAttribute("review", review);
	}
}
