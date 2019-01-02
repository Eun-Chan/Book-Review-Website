package com.brw.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.dao.DAO;
import com.brw.dto.ReviewDTO;

public class GetReviewSelectOne implements Command{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
	}
	public ReviewDTO reviewSelectOne(HttpServletRequest request, HttpServletResponse response) {
		String reviewBookId = request.getParameter("reviewBookId");
		DAO dao = DAO.getInstance();
		
		ReviewDTO reivew = dao.getReviewSelectOne(reviewBookId);
		
		return reivew;
	}

}
