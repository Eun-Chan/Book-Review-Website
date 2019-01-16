package com.brw.command.admin;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;

public class NoticeReviseEndCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		int ntcNo = Integer.parseInt(request.getParameter("ntcNo"));
		String ntcTitle = request.getParameter("ntcTitle");
		String ntcContent = request.getParameter("ntcContent");
		
		DAO dao = DAO.getInstance();
		
		int result = dao.noticeUpdate(ntcNo, ntcTitle, ntcContent);
		
		if(result > 0) {
			System.out.println("공지사항 수정 완료");
		}
		else {
			System.out.println("공지사항 수정 실패");
		}
		
	}

}
