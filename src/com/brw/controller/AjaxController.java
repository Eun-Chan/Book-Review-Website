package com.brw.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.command.GetReviewList;
import com.brw.dto.ReviewDTO;
import com.google.gson.Gson;

/**
 * Servlet implementation class AjaxController
 */
@WebServlet("*.ajax")
public class AjaxController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		actionDo(req,res);
	}


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(req, res);
	}

	private void actionDo(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub

		req.setCharacterEncoding("utf-8");
		
		System.out.println("ajax");
		
		String uri = req.getRequestURI();
		String conPath = req.getContextPath();
		String command = uri.substring(conPath.length());
		System.out.println(uri);
		System.out.println(conPath);
		System.out.println(command);
		
		// command pattern 을 위한 객체 생성
		Command com = null;
		String viewPage = null;
		Gson gson = new Gson();
		
		// ajax 요청 분기해서 처리
		if(command.equals("/review/getReviewList.ajax")) {
			com = new GetReviewList();
			List<ReviewDTO> reviewList = ((GetReviewList)com).getReviewList(req, res);
			gson.toJson(reviewList, res.getWriter());
		}
		
	}
}
