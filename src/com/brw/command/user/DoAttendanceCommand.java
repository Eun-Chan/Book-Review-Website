package com.brw.command.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;

public class DoAttendanceCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String atUserId = request.getParameter("atUserId");
		String atContent = request.getParameter("atContent");
		System.out.println("DoAttendanceCommand atUserId="+atUserId+", atContent="+atContent);
		
		DAO dao = DAO.getInstance();
		
		int result = dao.doAttendance(atUserId,atContent);
		
		request.setAttribute("checkValidation", true);
		
	}

}