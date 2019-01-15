package com.brw.command.user;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;

public class DeleteMemberCommand implements Command{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String userId = request.getParameter("userId");
		
		DAO dao = DAO.getInstance();
		
		int result = dao.deleteMember(userId);
		
		
	}

}
