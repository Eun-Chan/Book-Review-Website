package com.brw.command.review;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;
import com.brw.dto.ReviewBoardComment;
import com.brw.dto.ReviewBoardDTO;
import com.brw.dto.ReviewBoardViewDTO;

public class ReviewReviseEndCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		int rbNo = Integer.parseInt(request.getParameter("rbNo"));
		String rbTitle = request.getParameter("rbTitle");
		String rbWriter = request.getParameter("rbWriter");
		String rbBookTitle = request.getParameter("rbBookTitle");
		String rbContent = request.getParameter("rbContent");
		String rbIsbn = request.getParameter("rbIsbn");
		double rbStarscore = Double.parseDouble(request.getParameter("rbStarscore"));
		System.out.println(rbNo+","+rbTitle+","+rbWriter+","+rbBookTitle+","+rbContent+","+rbIsbn+","+rbStarscore);
		
		// book 테이블 저장용 파라미터
		String bookAuthor = request.getParameter("bookAuthor");
		int bookPriceStandard = 0;
		try {
			bookPriceStandard = Integer.parseInt(request.getParameter("bookPriceStandard"));
		} catch(NumberFormatException e) {
			bookPriceStandard = -1; // 도서가격정보가 없을 경우 -1
		}
		String bookPublisher = request.getParameter("bookPublisher");
		
		DAO dao = DAO.getInstance();
		
		// 가져온 ISBN이 book테이블에 존재하는 지 검사 후 없다면 등록
		// dao 1번 사용
		boolean isIsbnExist = dao.isIsbnExist(rbIsbn);
		
		if(!isIsbnExist) {
			// dao 2번 사용
			int result = dao.insertBook(rbBookTitle, bookAuthor, rbIsbn, bookPriceStandard, bookPublisher);
			
			if(result > 0) {
				System.out.println("ISBN 등록 성공!");
			}
			else {
				System.out.println("ISBN 등록 실패!");
			}
		}
		
		// 객체에 담기
		ReviewBoardDTO rb = new ReviewBoardDTO(rbNo,rbTitle,rbWriter,rbBookTitle,rbIsbn,rbContent,rbStarscore);
		
		// dao 갔다오기
		// dao 3번 사용
		int result = dao.reviewUpdate(rb);
		
		if(result > 0) {
			System.out.println("도서 리뷰 글 수정 성공");
		}
		else {
			System.out.println("도서 리뷰 글 수정 실패");
		}
		
		
		request.setAttribute("rbNo", rbNo); // 프론트컨트롤러에서 사용할 것
		
	}

}
