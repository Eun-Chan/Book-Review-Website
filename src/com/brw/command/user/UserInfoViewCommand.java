package com.brw.command.user;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;
import com.brw.dto.ReviewBoardComment;
import com.brw.dto.ReviewBoardViewDTO;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

public class UserInfoViewCommand implements Command{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		DAO dao = DAO.getInstance();
		
		try {
			//1.인코딩 설정
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			response.setContentType("application/json; charset=utf-8");
		} catch (UnsupportedEncodingException e) {
			System.out.println("인코딩 처리에 실패했습니다.@UserInfoViewCommand");
			e.printStackTrace();
		}
		
		//2.파라미터 핸들링
		String userId = request.getParameter("nowUser");
		JsonArray postWriteList = new JsonArray();
		postWriteList = dao.postListLookup(userId);
		JsonArray commentWriteList = new JsonArray();
		commentWriteList = dao.commentListLookup(userId);
		
		JsonArray result = new JsonArray();
		result.add(postWriteList);
		result.add(commentWriteList);

		try {
			response.getWriter().print(result);
		} catch (IOException e) {
			System.out.println("내 정보보기에서 json데이터 전송에 실패했습니다.@광준-UserInfoViewCommand");
			e.printStackTrace();
		}
		
	}

}
