package com.brw.command.book;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;
import com.brw.dto.OneLineReviewDTO;
import com.brw.dto.UserDTO;

/*
 * 작성자 : 김민우
 * 내용 : Book List 에서 클릭 시 bookInfo(책 상세내용) 이동
 */
public class BookInfomationCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		String isbn13 = request.getParameter("isbn13");
		UserDTO user = (UserDTO) request.getSession().getAttribute("user");
		
		DAO dao = DAO.getInstance();
		
		//즐겨찾기를 한 책인지 아닌지 검사
		boolean basketCheck = false;
		if(user != null) {
			basketCheck = dao.isChecked(user, isbn13);		
		}
		
		//현재 클릭된 책 isbn으로 한 줄 리뷰 작성된 값을 불러와 돌려주는 부분
		List<OneLineReviewDTO> list = dao.selectAllOneLineRV(isbn13);
		
		request.setAttribute("isbn13", isbn13);
		request.setAttribute("basketCheck", basketCheck);
		request.setAttribute("oneLineList", list);

	}

}
