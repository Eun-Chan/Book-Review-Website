/**
 * 
 */
package com.brw.command.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;

/**
 * 작성자 : 김은찬
 * 내용 : 아이디 찾기 시 , 해당 아이디로 등록된 이메일이 있는지 확인
 */
public class FindEmailCheckCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// 아이디 찾기 할 때, 회원이 입력한 이메일 받아오기
		String userEmail = request.getParameter("userEmail");
		
		DAO dao = DAO.getInstance();
		// 해당 이메일로 회원가입이 되었는지 확인
		int result = dao.emailCheck(userEmail);
		PrintWriter out;
		
		try {
			out = response.getWriter();
			// 해당 이메일로 가입 된 아이디가 있다면, 이메일로 아이디를 알려줌 ㅇㅈ? ㅇ ㅇㅈ
			
			
			if(result == 1) {
				out.append("true");
				return;
			}
			else {
				out.append("false");
				return;
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
}
