package com.brw.command.admin;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;
import com.brw.dto.NoticeDTO;

public class NoticeReviseCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		int ntcNo = Integer.parseInt(request.getParameter("ntcNo"));
		
		DAO dao = DAO.getInstance();
		
		NoticeDTO ntc = dao.selectNoticeOne(ntcNo);
		
		request.setAttribute("ntc", ntc);
	}

}
