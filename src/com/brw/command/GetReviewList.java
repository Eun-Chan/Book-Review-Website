package com.brw.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.dao.DAO;
import com.brw.dto.ReviewDTO;
import com.google.gson.Gson;

public class GetReviewList implements Command {
	
	public String aaa;

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
		
		
	}
	
	public List<ReviewDTO> getReviewList(HttpServletRequest request, HttpServletResponse response){
		
		response.setContentType("application/json; charset=utf-8");
		
		DAO dao = DAO.getInstance();
		
		List<ReviewDTO> list = dao.getReviewList();
		
		return list;
	}

}
