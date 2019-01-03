package com.brw.command;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.dao.DAO;

/*
 * 작성자 : 김은찬
 * 
 * 내용 : 회원 가입시 아이디 중복 체크
 */
public class IdCheckCommand implements Command{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
		String userId = request.getParameter("userId");
		
		System.out.println("IdCheckCommand() - userId = "+userId);
		
		DAO dao = DAO.getInstance();
		int result = dao.idCheck(userId);
		
		System.out.println("IdCheckCommand() - result =" +result);
		
		try {
			PrintWriter out = response.getWriter();
			// 이미 아이디가 존재 할 경우 , 아이디 생성 불가
			if(result == 1)
				out.append("false");
			// 아이디 중복이 아니므로 , 아이디 생성 가능
			else
				out.append("true");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
