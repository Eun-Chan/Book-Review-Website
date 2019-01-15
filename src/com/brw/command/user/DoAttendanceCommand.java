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
		
		// atUserId로 출석체크를 오늘 했는지 체크. true면 출첵한 것
		boolean checkValidation = dao.checkTodayAttendance(atUserId);
		
		request.setAttribute("checkValidation", checkValidation);
		
		if(!checkValidation) {
			// 출석 체크 등록
			int result = dao.doAttendance(atUserId,atContent);
		}
		
	}

}
