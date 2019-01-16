package com.brw.command.admin;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;

public class NoticeDeleteCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		int ntcNo = Integer.parseInt(request.getParameter("ntcNo"));
		
		DAO dao = DAO.getInstance();
		
		int result = dao.noticeDelete(ntcNo);
		
		if(result > 0) {
			System.out.println("공지사항 삭제 성공");
		}
		else {
			System.out.println("공지사항 삭제 실패");
		}
		
	}

}
