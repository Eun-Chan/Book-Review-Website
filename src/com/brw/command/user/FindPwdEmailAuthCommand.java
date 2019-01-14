package com.brw.command.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;

/**
 * 작성자 : 김은찬
 * 내용 : 비밀번호 찾기 시 아이디가 정확히 있는지 검사 후 이메일로 인증번호 전송
 */
public class FindPwdEmailAuthCommand implements Command {
	// 인증번호로 사용할 변수
	private static int authNum;
	// 랜덤 번호 생성 메섣,
	private static int getAuthNum() {return (int)(Math.random()*100000);};  
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		String userId = request.getParameter("userId");
		
		int result = DAO.getInstance().idCheck(userId);
		String to = DAO.getInstance().searchEmailForId(userId);
		System.out.println("FindPwdEmailAuthCommand$to"+to);
		try {
			PrintWriter out = response.getWriter();
			// 아이디가 존재하니 이메일로 보내면 됨
			if(result == 1 && to != null) {
				authNum = getAuthNum();
				out.append(String.valueOf(authNum));
				new EmailSend().emailSend(to, "책 읽는 사람들 인증번호 입니다.", String.valueOf(authNum));
			}
			// 아이디가 존재하지 않거나, to 에 null(아이디를 통해 이메일 검색시 안나올 때) 경우
			else {
				out.append("true");
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
	}

}
