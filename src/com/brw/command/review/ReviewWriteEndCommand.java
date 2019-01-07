package com.brw.command.review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;
import com.brw.dto.ReviewBoardDTO;

/*
 * 작성자 : 정명훈
 * 내용 : 리뷰등록
 */
public class ReviewWriteEndCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		DAO dao = DAO.getInstance();
		
		// 파라미터 처리
		String rbTitle = request.getParameter("rbTitle");
		String rbWriter = request.getParameter("rbWriter");
		String rbBookTitle = request.getParameter("rbBookTitle");
		String rbContent = request.getParameter("rbContent");
		String rbIsbn = request.getParameter("rbIsbn");
		double rbStarscore = Double.parseDouble(request.getParameter("rbStarscore"));
		// book 테이블 저장용 파라미터
		String bookAuthor = request.getParameter("bookAuthor");
		int bookPriceStandard = Integer.parseInt(request.getParameter("bookPriceStandard"));
		String bookPublisher = request.getParameter("bookPublisher");
		
		
		// 객체 확인용
		System.out.println(rbTitle);
		System.out.println(rbWriter);
		System.out.println(rbBookTitle);
		System.out.println(rbIsbn);
		System.out.println(rbStarscore);
		
		// 가져온 ISBN이 book테이블에 존재하는 지 검사 후 없다면 등록
		// dao 1번 사용
		boolean isIsbnExist = dao.isIsbnExist(rbIsbn);
		
		if(!isIsbnExist) {
			int result = dao.insertBook(rbBookTitle, bookAuthor, rbIsbn, bookPriceStandard, bookPublisher);
			
			if(result > 0) {
				System.out.println("ISBN 등록 성공!");
			}
			else {
				System.out.println("ISBN 등록 실패!");
			}
		}
		
		// 객체에 담기
		ReviewBoardDTO rb = new ReviewBoardDTO();
		rb.setRbTitle(rbTitle);
		rb.setRbWriter(rbWriter);
		rb.setRbBookTitle(rbBookTitle);
		rb.setRbContent(rbContent);
		rb.setRbIsbn(rbIsbn);
		rb.setRbStarscore(rbStarscore);
		
		// dao 갔다오기
		// dao 3번 사용
		int result = dao.reviewWrite(rb);
		// 결과 req객체에 저장
		request.setAttribute("result", result);
		
		// 등록 확인
		if(result > 0) {
			System.out.println("글 등록 완료");
			// 등록 완료되면 등록한 글 번호 가져오기
			// dao 4번 사용
			int lastReviewBoardNo = dao.getLastReviewBoardNo();
			// req객체에 저장
			request.setAttribute("lastReviewBoardNo", lastReviewBoardNo);
		}
		else {
			System.out.println("글 등록 실패");
		}
		
	}

}
