package com.brw.command.user;

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
/**
 * 작성자 : 정지수..?
 * 내용    : 90일지난 사용자 비밀번호 변경페이지
 *
 */
public class OldPwdChangeOrLaterCommand implements Command{
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
		String userId = request.getParameter("userId");
		String userPassword = request.getParameter("userPassword");
		
		DAO dao = DAO.getInstance();
				
		dao.passwordAndSysdateUpdate(userId, userPassword);	
		
		
	}
}
