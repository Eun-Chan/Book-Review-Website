package com.brw.command.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;
import com.brw.dto.UserDTO;
/**
 * 작성자 : 정지수..?
 * 내용    : 90일지난 사용자 비밀번호 변경페이지
 *
 */
public class OldPwdChangeOrLaterCommand implements Command{
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String userId = request.getParameter("userId");
		String userPassword = request.getParameter("userPassword");
		
		UserDTO user = DAO.getInstance().selectOneUser(userId);
		String now_userPassword = user.getUserPassword();
		System.out.println("userPassword = "+userPassword);
		System.out.println("now_userPassword = "+now_userPassword);
		if(userPassword.equals(now_userPassword)) {
			System.out.println("$OldPwdChangeOrLaterCommand equals 금방할수 있어요");
			out.append("same");
			return;
		}
		
		int result = DAO.getInstance().passwordAndSysdateUpdate(userId, userPassword);	
		
		System.out.println("$OldPwdChangeOrLaterCommand result = "+result);
		
		
		if(result == 1) {
			out.append("true");
		}
		else
			out.append("false");
	}
}
