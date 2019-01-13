package com.brw.command.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;
import com.brw.dto.UserDTO;

public class SelectOneUserInfo implements Command{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		//1. 파라미터 처리
		String userId = request.getParameter("userId");
				
		UserDTO user = new UserDTO();
		
		DAO dao = DAO.getInstance();

		user = dao.selectOneUser(userId);
		
		request.setAttribute("user", user);
	}

}
