/**
 * 
 */
package com.brw.command.user;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.brw.command.Command;

/**
 * 작성자 : 김은찬
 * 내용 : 유저 로그아웃
 */
public class LogoutCommand implements Command {


	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(false);
		
		if(session != null) {
			session.invalidate();
		}
		
		try {
			response.sendRedirect(request.getContextPath());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
