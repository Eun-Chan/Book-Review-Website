package com.brw.command;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.dao.DAO;
import com.brw.dto.ReviewBoardDTO;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

public class IndexCommand implements Command {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		DAO dao = DAO.getInstance();
		
		try {
			//1.인코딩 설정
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e1) {
			System.out.println("IndexCommand@인코딩 처리에 실패했습니다.");
			e1.printStackTrace();
		}
		//2.업무로직 처리
		//
		
		//최근 리뷰 5개를 가져온다.
		List<ReviewBoardDTO> reviewRecentList = dao.selectReviewRecentList();
		
		JsonArray result = new JsonArray();
		ReviewBoardDTO rb = null;
		
		for(int i=0; i<reviewRecentList.size(); i++)
		{
			rb = reviewRecentList.get(i);
			JsonObject jobj = new JsonObject();
		    jobj.addProperty("rbTitle", rb.getRbTitle());
		    jobj.addProperty("rbWriter", rb.getRbWriter());
		    jobj.addProperty("rbBookTitle", rb.getRbBookTitle());
		    String dateResult = rb.getRbDate();
		    jobj.addProperty("rbDate", dateResult);
		    jobj.addProperty("rbStarscore", rb.getRbStarscore());
		    
			result.add(jobj);
		}
		//별점 데이터 처리
		JsonArray result_star = new JsonArray();
		
		JsonObject jobj2 = new JsonObject();
		jobj2.addProperty("starScoreBook", 3.5);
		
		result_star.add(jobj2);

		JsonArray total_result = new JsonArray();
		total_result.add(result);
		total_result.add(result_star);
		
		
		
		try {
			response.getWriter().print(total_result);
			/*response.getWriter().print(result_star);*/
		} catch (IOException e) {
			System.out.println("IndexCommand@json데이터 전송에 실패했습니다.");
			e.printStackTrace();
		}
	}
}
