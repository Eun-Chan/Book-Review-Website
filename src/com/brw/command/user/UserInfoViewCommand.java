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
		int pageNum = Integer.parseInt((request.getParameter("cPage"))==null?"1":(request.getParameter("cPage")));
		System.out.println("ㅎㅎ" + pageNum);
		JsonArray postWriteList = new JsonArray();
		postWriteList = dao.postListLookup(userId);
		JsonArray commentWriteList = new JsonArray();
		commentWriteList = dao.commentListLookup(userId);
		
		/*페이징 처리*/
		int listViewCnt = 10;
		int postListTotalSize = postWriteList.size();
		int postTotalPage = postListTotalSize/listViewCnt;
		if(postListTotalSize%listViewCnt > 0) postTotalPage++;
		
		int commentListTotalSize = commentWriteList.size();
		int commentTotalPage = commentListTotalSize/listViewCnt;
		if(commentListTotalSize%listViewCnt > 0) commentTotalPage++;
		
		String postHtml = "";
		String endHtml = "<li class='paging-index'><a href=''>다음</a></li>";
		for(int i=1; i<=postTotalPage; i++)
		{
			postHtml += "<li class='paging-index'><a id='cPage"+i+"'>"+ i +"</a></li>";
		}
		JsonArray html_result = new JsonArray();
		JsonObject postHtml_result = new JsonObject();
		postHtml_result.addProperty("postHtml", postHtml+endHtml);
		html_result.add(postHtml_result);
		
		
		JsonArray result = new JsonArray();
		result.add(postWriteList);
		result.add(commentWriteList);
		result.add(html_result);
		try {
			response.getWriter().print(result);
		} catch (IOException e) {
			System.out.println("내 정보보기에서 json데이터 전송에 실패했습니다.@광준-UserInfoViewCommand");
			e.printStackTrace();
		}
		
	}

}
