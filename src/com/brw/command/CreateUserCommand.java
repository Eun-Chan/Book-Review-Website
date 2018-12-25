package com.brw.command;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.dao.DAO;
import com.brw.dto.UserDTO;

public class CreateUserCommand implements Command{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
		String userId = request.getParameter("userId");
		String userPassword = request.getParameter("userPassword");
		String userName = request.getParameter("userName");
		String userEmail = request.getParameter("userEmail");
		
		UserDTO user = new UserDTO(userId, userPassword, userName, userEmail);
		
		System.out.println(userId);
		System.out.println(userPassword);
		System.out.println(userName);
		System.out.println(userEmail);
		
		DAO dao = DAO.getInstance();
		try {
			dao.createUser(user);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
}
