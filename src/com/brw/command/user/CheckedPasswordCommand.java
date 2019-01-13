package com.brw.command.user;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;
import com.brw.dto.UserDTO;
import com.google.gson.Gson;
import com.google.gson.JsonIOException;

public class CheckedPasswordCommand implements Command{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		//인코딩 처리
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		response.setContentType("application/json; charset=utf-8");
		
		String userId = request.getParameter("userId");
		String userPassword = request.getParameter("userPassword");
		
		UserDTO user = new UserDTO();
		DAO dao = DAO.getInstance();
		user = dao.checkedUserPassword(userId,userPassword);
		
		Gson gson = new Gson();
		try {
			gson.toJson(user,response.getWriter());
		} catch (JsonIOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
