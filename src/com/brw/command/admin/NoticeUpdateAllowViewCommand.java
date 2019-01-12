package com.brw.command.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;
import com.google.gson.Gson;

public class NoticeUpdateAllowViewCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int ntcNo = Integer.parseInt(request.getParameter("ntcNo"));
		String ntcAllowView = request.getParameter("ntcAllowView");
		
		DAO dao = DAO.getInstance();
		int result = dao.noticeUpdateAllowView(ntcAllowView, ntcNo);
		
	}

}
