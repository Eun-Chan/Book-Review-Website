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
import com.brw.listener.SessionListener;

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
				
				HttpSession session = request.getSession(true);
				
				// 이미 접속한 아이디인지 체크
				// 현재 접속자들 보여주기
				SessionListener.getInstance().printloginUsers();
				if(SessionListener.getInstance().isUsing(userId)) {
					System.out.println("이미 아이디가 접속중 입니다.");
					out.append("already");
					return;
				}
				
				// 접속 하고자 하는 아이디의 세션을 담는다
				UserDTO userDTO = new UserDTO();
				userDTO = dao.selectOneUser(userId);
				
				session.setMaxInactiveInterval(60*10);
				session.setAttribute("user", userDTO);
								
				SessionListener.getInstance().setSession(session, userId);
				
				int changeDate = dao.checkDate(userId);
				if(changeDate > 90)
					out.append("oldPwdChangeOrLater");
				else
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
