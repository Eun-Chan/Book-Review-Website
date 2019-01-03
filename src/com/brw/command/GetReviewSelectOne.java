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
		int reviewNo = 50;
		DAO dao = DAO.getInstance();
		
		ReviewBoardDTO review = dao.getReviewSelectOne(reviewNo);
		
		request.setAttribute("review", review);
	}
}
