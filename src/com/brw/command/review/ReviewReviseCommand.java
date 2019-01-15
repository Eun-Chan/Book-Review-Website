package com.brw.command.review;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;
import com.brw.dto.ReviewBoardViewDTO;

public class ReviewReviseCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		int rbNo = Integer.parseInt(request.getParameter("rbNo"));
		System.out.println(rbNo);
		
		DAO dao = DAO.getInstance();
		
		ReviewBoardViewDTO rbv = dao.getReviewSelectOne(rbNo);
		System.out.println(rbv);
		
		request.setAttribute("rbv", rbv);
	}

}
