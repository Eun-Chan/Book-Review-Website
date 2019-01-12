package com.brw.command.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;


public class NickNameCheckCommand implements Command{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
		String userNickName = request.getParameter("nickName");
		
		System.out.println("nickNameCheckCommand() - userNickName = "+userNickName);
		
		DAO dao = DAO.getInstance();
		int result = dao.nickNameCheck(userNickName);
		
		System.out.println("nickNameCheckCommand() - result =" +result);
		
		try {
			PrintWriter out = response.getWriter();
			// 이미 별명 존재 할 경우 , 아이디 생성 불가
			if(result == 1)
				out.append("false");
			// 별명 중복이 아니므로 , 아이디 생성 가능
			else
				out.append("true");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
