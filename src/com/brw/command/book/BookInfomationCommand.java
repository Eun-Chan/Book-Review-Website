package com.brw.command.book;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;
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
		boolean basketCheck = dao.isChecked(user, isbn13);
		
		request.setAttribute("isbn13", isbn13);
		request.setAttribute("basketCheck", basketCheck);

	}

}
