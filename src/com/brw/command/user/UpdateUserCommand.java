package com.brw.command.user;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;

public class UpdateUserCommand implements Command{

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
		
		//파라미터 처리
		String userId = request.getParameter("userId");
		String userPassword= request.getParameter("userPassword");
		String userEmail = request.getParameter("userEmail");
		String userNickName = request.getParameter("userNickName");
		
		
		DAO dao = DAO.getInstance();
		int result = dao.updateUser(userId,userPassword,userEmail,userNickName);
		
		
		
		Gson gson = new Gson();
		try {
			gson.toJson(result,response.getWriter());
		} catch (JsonIOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
		//아아 채워넣으시오
		
	}
	
}
