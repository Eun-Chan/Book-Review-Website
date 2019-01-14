/**
 * 
 */
package com.brw.command.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.brw.command.Command;
import com.brw.dao.DAO;
import com.brw.dto.UserDTO;

/**
 * 작성자 : 김은찬 
 * 내용 : 로그인 시 아이디 저장 및 세션에 유저 정보 저장
 */
public class LoginCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		String userId = request.getParameter("userId");
		String userPassword = request.getParameter("userPassword");
		
		DAO dao = DAO.getInstance();
		int result = dao.loginCheck(userId , userPassword);
		
		try {
			PrintWriter out = response.getWriter();
			
			// 로그인 성공 !
			if(result == 1) {
				// 로그인 성공 했을 경우 쿠키 저장
				String saveId = request.getParameter("saveId");
				
				// (아이디 저장 체크시)쿠키 생성  , 쿠키의 생성은 server  , 보관은 클라
				if(saveId.equals("true")) {
					Cookie c = new Cookie("saveId", userId);
					// 쿠키 유효시간 1일 , 
					c.setMaxAge(24*60*60);
					c.setPath("/brw");
					response.addCookie(c);
				}
				// (아이디 저장 체크 X) , 저장된 쿠키 삭제
				else {
					Cookie c = new Cookie("saveId", userId);
					c.setMaxAge(0);
					c.setPath("/brw");
					response.addCookie(c);
				}
				
				UserDTO userDTO = new UserDTO();
				userDTO = dao.selectOneUser(userId);
				
				HttpSession session = request.getSession(true);
				
				session.setMaxInactiveInterval(60*10);
				session.setAttribute("user", userDTO);
				out.append("true");
			}
				
			// 로그인 실패 !
			else
				out.append("false");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
