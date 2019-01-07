package com.brw.command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.dao.DAO;
import com.brw.dto.ReviewBoardDTO;

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
		
		// 객체 확인용
		System.out.println(rbTitle);
		System.out.println(rbWriter);
		System.out.println(rbBookTitle);
		System.out.println(rbIsbn);
		System.out.println(rbStarscore);
		
		// 객체에 담기
		ReviewBoardDTO rb = new ReviewBoardDTO();
		rb.setRbTitle(rbTitle);
		rb.setRbWriter(rbWriter);
		rb.setRbBookTitle(rbBookTitle);
		rb.setRbContent(rbContent);
		rb.setRbIsbn(rbIsbn);
		rb.setRbStarscore(rbStarscore);
		
		// dao 갔다오기
		int result = dao.reviewWrite(rb);
		// 결과 req객체에 저장
		request.setAttribute("result", result);
		
		// 등록 확인
		if(result > 0) {
			System.out.println("글 등록 완료");
			// 등록 완료되면 등록한 글 번호 가져오기
			int lastReviewBoardNo = dao.getLastReviewBoardNo();
			// req객체에 저장
			request.setAttribute("lastReviewBoardNo", lastReviewBoardNo);
		}
		else {
			System.out.println("글 등록 실패");
		}
		
		
		
	}

}
