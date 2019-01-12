package com.brw.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.command.admin.NoticeDetailViewCommand;
import com.brw.command.admin.NoticeListCommand;
import com.brw.command.admin.NoticeSearchCommand;
import com.brw.command.book.BasketInsertCommand;
import com.brw.command.book.BookBasketCommand;
import com.brw.command.book.BookInfomationCommand;
import com.brw.command.book.BookOneLineRVCommand;
import com.brw.command.book.BookReviewCommand;
import com.brw.command.book.CheckedBasketCommand;
import com.brw.command.index.IndexCommand;
import com.brw.command.review.DeleteReviewBoardComment;
import com.brw.command.review.GetReviewSelectOneCommand;
import com.brw.command.review.InsertCommentCommand;
import com.brw.command.review.InsertReCommentCommand;
import com.brw.command.review.ReviewBoardLikeCommend;
import com.brw.command.review.ReviewPaginationCommand;
import com.brw.command.review.ReviewSearchCommand;
import com.brw.command.review.ReviewWriteEndCommand;
import com.brw.command.review.ReviewWriteImageCommand;
import com.brw.command.user.CreateUserCommand;
import com.brw.command.user.EmailAuthCommand;
import com.brw.command.user.FindEmailCheckCommand;
import com.brw.command.user.IdCheckCommand;
import com.brw.command.user.LoginCommand;
import com.brw.command.user.LogoutCommand;
import com.brw.command.user.SearchIdForEmailCommand;
import com.brw.command.user.nickNameCheckCommand;

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
		
		// command pattern 을 위한 객체 생성
		Command com = null;
		String viewPage = null;
		
		/*
		 * 1. 유저 생성
		 */
		if(command.equals("/createUser.do")) {
			com = new CreateUserCommand();
			com.execute(req, res);
			viewPage = "index.jsp";
		}
		/*
		 * 2. 로그인 & 아이디 저장 & 유저 정보 세션 저장
		 */
		else if(command.equals("/login.do")) {
			com = new LoginCommand();
			com.execute(req, res);
		}
		/*
         * 3. 이메일 인증 & 이메일 중복 확인 command
         */
		else if(command.equals("/emailAuth.do")) {
			com = new EmailAuthCommand();
			com.execute(req,res);
		}
		/*
		 * 4. 회원가입 시 로그인 중복 확인
		 */
		else if(command.equals("/idCheck.do")) {
			com = new IdCheckCommand();
			com.execute(req, res);
		}
		/*
		 * 5. 회원가입 jsp로 이동
		 */
		else if(command.equals("/signUp.do")) {
			viewPage = "/WEB-INF/views/sign/signUp.jsp";
		}
		/*
		 * 6. 로그아웃
		 */
		else if(command.equals("/logout.do")) {
			com = new LogoutCommand();
			com.execute(req, res);
		}
		/*
		 * 5. index.jsp 최근 리뷰 & 인기 도서
		 */
		else if(command.equals("/index.do")) {
			com = new IndexCommand();
			com.execute(req, res);
		}
		/*
		 * 6. 알라딘 API
		 */
		else if(command.equals("/book/bookList.do")) {
	         viewPage = "/WEB-INF/views/book/bookList.jsp";
		}
		/*
		 * 7. 알라딘 API에서 Book List 중에서 Book 클릭 시 상세 내용
		 */
		else if(command.equals("/book/bookInfo.do")) {
			com = new BookInfomationCommand();
			com.execute(req, res);
			viewPage = "/WEB-INF/views/book/bookInfo.jsp";
		}
		/*
		 * 8. (7.) 상세 내용 밑에 댓글 내용 출력
		 */
		else if(command.equals("/book/bookreviewInfo.do")) {
			System.out.println("front성공");
			com = new BookReviewCommand();
			com.execute(req, res);
		}
		/*
		 * 9. 리뷰 리스트 (리뷰 게시판)
		 */
		else if(command.equals("/review/reviewList.do")) {
			com = new ReviewPaginationCommand();
			com.execute(req, res);
			viewPage = "/WEB-INF/views/review/reviewList.jsp";
		}
		/*
		 * 10. 리뷰 게시판 안에서 검색 결과
		 */
		else if(command.equals("/review/reviewSearch.do")) {
			com = new ReviewSearchCommand();
			com.execute(req, res);
			viewPage = "/WEB-INF/views/review/reviewSearch.jsp";
		}
		/*
		 * 11. 리뷰 게시판에서 리뷰 클릭 시 상세내용 
		 */
		else if(command.equals("/review/reviewDetail.do")) {
			//해당 게시물 가져오는 쿼리
			com = new GetReviewSelectOneCommand();
			//해당 게시글에 댓글 가져오는 쿼리가 들어와야함.
			com.execute(req, res);
			viewPage = "/WEB-INF/views/review/reviewDetail.jsp";
		}
		/*
		 * 12. 리뷰 상세 보기에서의 댓글
		 */
		else if(command.equals("/insertComment.do")) {
			com = new InsertCommentCommand();
			com.execute(req, res);
		}
		/*
		 * 13. 리뷰 상세 보기에서의 댓글의 댓글
		 */
		else if(command.equals("/insertReComment.do")) {
			com = new InsertReCommentCommand();
			com.execute(req, res);
		}
		/*
		 * 14. 리뷰 게시판에서 리뷰 작성 버튼 클릭 시 스마트 에디터를 통한 리뷰 작성
		 */
		else if(command.equals("/review/reviewWrite.do")) {
			viewPage = "/WEB-INF/views/review/reviewWrite.jsp";
		}
		/*
		 * 15. 리뷰 작성에 대한 정보(제목, 내용, 도서명, ISBN, 작성자) 입력 후 리뷰 등록
		 */
	    else if(command.equals("/review/reviewWriteEnd.do")) {
	    	com = new ReviewWriteEndCommand();
			com.execute(req, res);
			int result = (int)req.getAttribute("result");
			if(result > 0) {
				int lastReviewBoardNo = (int)req.getAttribute("lastReviewBoardNo");
				viewPage = "/review/reviewDetail.do?rbNo=" + lastReviewBoardNo;
			}
			else {
				viewPage = "/WEB-INF/views/review/bookList.jsp";
			}
	    }
		/*
		 * 16. BookList에서 책 검색 시 결과
		 */
	    else if(command.equals("/review/bookSearch.do")) {
	       viewPage = "/WEB-INF/views/review/bookSearch.jsp";
	    }
		/*
		 * 17. 아이디 혹은 비밀번호 찾기 페이지 이동
		 */
	    else if(command.equals("/idAndPwdSearch.do")) {
	    	viewPage = "/WEB-INF/views/sign/idAndPwdSearch.jsp";
	    }
		/*
		 * 18. 아이디 찾기 시 이메일이 존재하는지 확인
		 */
	    else if(command.equals("/emailCheck.do")) {
	    	com = new FindEmailCheckCommand();
	    	com.execute(req, res);
	    }
		/**
		 * 19. BookInfo에서 즐겨찾기(장바구니) 클릭시 Book DB저장 및 Basket DB 저장
		 */
	    else if(command.equals("/book/basket.do")) {
	    	com = new BasketInsertCommand();
	    	com.execute(req, res);
	    	String returnIsbnNo = (String) req.getAttribute("returnIsbnNo");
	    	viewPage = "/book/bookInfo.do?isbn13="+returnIsbnNo;
	    	System.out.println("viewPage"+viewPage);
	    }
		
		/*
		 * 20. 좋아요 버튼 클릭시 처리 ajax 
		 */
	    else if(command.equals("/review/reviewLike.do")){
	    	com = new ReviewBoardLikeCommend();
	    	com.execute(req,res);
	    }
		/*
		 * 21. 댓글 삭제 쿼리  
		 */
	    else if(command.equals("/review/reviewCommentDelete.do")) {
	    	com = new DeleteReviewBoardComment();
	    	com.execute(req, res);
	    }
		/*22. 즐겨찾기 보여주는 결과*/
	    else if(command.equals("/book/showBookBasket.do")) {
	    	com = new BookBasketCommand();
	    	com.execute(req, res);
	    }
		/*23. 즐겨찾기로 가버렷*/
	    else if(command.equals("/book/goBasket.do")) {	    	
	    	viewPage = "/WEB-INF/views/book/bookBasket.jsp";
	    }
		/**
		 * 24. 이메일을 통해 아이디 찾아보리기
		 */
	    else if(command.equals("/sign/searchIdForEmail.do")) {
	    	com = new SearchIdForEmailCommand();
	    	com.execute(req, res);
	    }
		/*
		 * 25. 지수킹이 만든 IdSearchEnd.jsp 로 보내버리기 (아이디 찾기 성공시 나오는 view)
		 */
	    else if(command.equals("/sign/idSearchEnd.do")) {
	    	viewPage = "/WEB-INF/views/sign/IdSearchEnd.jsp";
	    }
		/*
		 * 26.check된 책 없애기
		 */
	    else if(command.equals("/book/checkedBasket.do")) {
	    	com = new CheckedBasketCommand();
	    	com.execute(req, res);
	    }

		/*27. 명훈 : 리뷰글 등록시 이미지 저장 ajax*/
	    else if(command.equals("/review/reviewWriteImage.do")) {
	    	com = new ReviewWriteImageCommand();
	    	com.execute(req, res);
	    }
		/*28. 한 줄 리뷰 등록: 김민우*/
	    else if(command.equals("/book/oneLineRV.do")) {
	    	com = new BookOneLineRVCommand();
	    	com.execute(req, res);
	    }
		/*29 . 회원가입시 닉네임 체크*/
		else if(command.equals("/nickNameCheck.do")) {
			com = new nickNameCheckCommand();
			com.execute(req, res);
		}
		/*30. 명훈 : 공지사항 상세보기*/
		else if(command.equals("/admin/noticeDetail.do")) {
			com = new NoticeDetailViewCommand();
			com.execute(req, res);
			viewPage = "/WEB-INF/views/admin/noticeDetail.jsp";
		}
		/*31. 명훈 : 공지사항 관리 페이지*/
		else if(command.equals("/admin/noticeList.do")) {
			com = new NoticeListCommand();
			com.execute(req, res);
			viewPage = "/WEB-INF/views/admin/noticeList.jsp";
		}
		/*31. 명훈 : 공지사항 관리 페이지*/
		else if(command.equals("/admin/noticeSearch.do")) {
			com = new NoticeSearchCommand();
			com.execute(req, res);
			viewPage = "/WEB-INF/views/admin/noticeSearch.jsp";
		}

		if(viewPage!=null){			
			RequestDispatcher dispatcher = req.getRequestDispatcher(viewPage);
			dispatcher.forward(req, res);	
		}
		
	}
}
