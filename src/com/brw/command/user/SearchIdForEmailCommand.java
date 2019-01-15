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
 * 내용 : 이메일을 통해 아이디 찾기
 */
public class SearchIdForEmailCommand implements Command {

	
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		String userEmail = request.getParameter("userEmail");
		
		String result = DAO.getInstance().searchIdForEmail(userEmail);
		System.out.println("SearchIdForEmailCommand$result = "+result);
		
		PrintWriter out;
		try {
			out = response.getWriter();
			// 만약 오류로 아이디를 못가져올 시 바로 종료
			if(result == null) {
				out.append("false");
				return;
			}
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		// 아이디 찾았을 시 돌려 보내보리기
		System.out.println("SearchIdForEmailCommand&UserId"+result);
		new EmailSend().emailSend(userEmail, "책 읽는 사람들 - 아이디 찾기", "아이디 조회 결과 : "+result);
		try {
			System.out.println("SearchIdForEmailCommand$result = "+result);
			out = response.getWriter();
			out.append("true");
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
