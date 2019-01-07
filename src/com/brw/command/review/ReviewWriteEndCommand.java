package com.brw.command.review;

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
		String rbIsbn = request.getParameter("rbIsbn");
		int rbStarscore = Integer.parseInt(request.getParameter("rbStarscore"));
		
		
		ReviewBoardDTO rb = new ReviewBoardDTO();
		rb.setRbTitle(rbTitle);
		rb.setRbWriter(rbWriter);
		rb.setRbBookTitle(rbBookTitle);
		rb.setRbIsbn(rbIsbn);
		rb.setRbStarscore(rbStarscore);
		
	}

}
