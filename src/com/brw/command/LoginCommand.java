/**
 * 
 */
package com.brw.command;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.dao.DAO;

/**
 * @author EunChan
 *
 */
public class LoginCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		String userId = request.getParameter("userId");
		String userPassword = request.getParameter("userPassword");
		System.out.println("userId = "+userId);
		System.out.println("userPassword = "+userPassword);
		
		DAO dao = DAO.getInstance();
		int result = dao.loginCheck(userId , userPassword);
		
		try {
			PrintWriter out = response.getWriter();
			
			// 로그인 성공 !
			if(result == 1)
				out.append("true");
			// 로그인 실패 !
			else
				out.append("false");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
