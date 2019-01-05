package com.brw.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.BookInfomationCommand;
import com.brw.command.Command;
import com.brw.command.CreateUserCommand;
import com.brw.command.GetReviewSelectOne;

import com.brw.command.IndexCommand;

import com.brw.command.ReviewPaginationCommand;
import com.brw.command.ReviewSearchCommand;
import com.brw.command.bookReviewCommand;
import com.brw.command.ReviewWriteEndCommand;

import com.brw.command.insertComment;

/**
 * Servlet implementation class FrontController
 */
@WebServlet("*.do")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FrontController() {
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
		doGet(req,res);
	}
	
	private void actionDo(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		req.setCharacterEncoding("utf-8");   
		System.out.println("actionDo()");
		
		String uri = req.getRequestURI();
		String conPath = req.getContextPath();
		String command = uri.substring(conPath.length());
		System.out.println(uri);
		System.out.println(conPath);
		System.out.println(command);
		
		// command pattern 을 위한 객체 생성
		Command com = null;
		String viewPage = null;
		
		// frontController로 모든 명렁을 받은 후 여기에서 분기
		if(command.equals("/enrollTest.do")) {
			com = new CreateUserCommand();
			com.execute(req, res);
			viewPage = "index.jsp";
		}
		else if(command.equals("/review/reviewList.do")) {
			com = new ReviewPaginationCommand();
			com.execute(req, res);
			viewPage = "/WEB-INF/views/review/reviewList.jsp";
		}
		else if(command.equals("/review/reviewSearch.do")) {
			com = new ReviewSearchCommand();
			com.execute(req, res);
			viewPage = "/WEB-INF/views/review/reviewSearch.jsp";
		}
		else if(command.equals("/book/bookInfo.do")) {
			com = new BookInfomationCommand();
			com.execute(req, res);
			viewPage = "/WEB-INF/views/book/bookInfo.jsp";
		}
		else if(command.equals("/review/reviewDetail.do")) {
			//해당 게시물 가져오는 쿼리
			com = new GetReviewSelectOne();
			//해당 게시글에 댓글 가져오는 쿼리가 들어와야함.
			com.execute(req, res);
			viewPage = "/WEB-INF/views/review/reviewDetail.jsp";
		}
		//bookInfo하단 댓글보여주기
		else if(command.equals("/book/bookreviewInfo.do")) {
			System.out.println("front성공");
			com = new bookReviewCommand();
			com.execute(req, res);
		}
		else if(command.equals("/book/bookList.do")) {
	         viewPage = "/WEB-INF/views/book/bookList.jsp";
		}
		else if(command.equals("/index.do")) {
			System.out.println("인덱스로 커멘드 호출");
			com = new IndexCommand();
			com.execute(req, res);
		}
		else if(command.equals("/insertComment.do")) {
			com = new insertComment();
			com.execute(req, res);
		}
		else if(command.equals("/review/reviewWrite.do")) {
			viewPage = "/WEB-INF/views/review/reviewWrite.jsp";
		}
		else if(command.equals("/review/reviewWriteEnd.do")) {
			com = new ReviewWriteEndCommand();
			com.execute(req, res);
			viewPage = "";
		}
		else if(command.equals("/review/bookSearch.do")) {
			viewPage = "/WEB-INF/views/review/bookSearch.jsp";
		}
		
		
		
		
		if(viewPage!=null){			
			RequestDispatcher dispatcher = req.getRequestDispatcher(viewPage);
			dispatcher.forward(req, res);	
		}


	}
}
