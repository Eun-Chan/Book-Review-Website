/**
 * 
 */
package com.brw.command.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.brw.command.Command;
import com.brw.dao.DAO;
import com.brw.dto.UserDTO;

/**
 * 작성자 : 김은찬
 * 내용 : 카카오 유저 회원가입 (카카오톡 로그인 기능도 담당)
 */
public class KakaoCreateUserCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// 회원가입이 알맞게 되었는지 확인하는 변수
		int result = 0;
		// 기존 아이디가 있는지 확인하는 변수
		int overRapResult = 0;
		
		
		String userId = request.getParameter("userId");
		String userEmail = request.getParameter("userEmail");
		String userNickName = request.getParameter("userNickName");
		// 카카오톡 유저는 임시 비밀번호를 이용
		String userPassword = UUID.randomUUID().toString();
		
		System.out.println("KakaoCreateUserCommand$userId"+userId);
		System.out.println("KakaoCreateUserCommand$userEmail"+userEmail);
		System.out.println("KakaoCreateUserCommand$userNickName"+userNickName);
		System.out.println("KakaoCreateUserCommand$userNickName"+userPassword);
		
		try {
			PrintWriter out = response.getWriter();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
        // 일단 기존 아이디가 있는지 확인
		overRapResult = DAO.getInstance().idCheck(userId);
		if(overRapResult == 1) {
			System.out.println("아이디가 이미 존재합니다");
			UserDTO userDTO = DAO.getInstance().selectOneUser(userId);
			
			HttpSession session = request.getSession(true);
			session.setMaxInactiveInterval(60*10);
			session.setAttribute("user", userDTO);
			return;
		}
		else {
			System.out.println("카카오톡 회원가입으로 넘어갑니다.");
		}
		
		try {
			result = DAO.getInstance().kakaoCreateUser(new UserDTO(userId,userPassword,userNickName,userEmail,userId));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		// 회원가입 성공
		if(result > 0) {
			System.out.println("회원가입 성공!");
			UserDTO userDTO = DAO.getInstance().selectOneUser(userId);
			
			HttpSession session = request.getSession(true);
			session.setMaxInactiveInterval(60*10);
			session.setAttribute("user", userDTO);
		}
		// 회원가입 실패 ( == 이미 가입된 인원 )
		else {
			System.out.println("회원가입 실패!");
		}
	}
}
