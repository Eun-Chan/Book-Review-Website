package com.brw.command.index;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;
import com.brw.dto.ReviewBoardDTO;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

/*
 * 작성자 : 박광준
 * 내용 : index.jsp 의 최근리뷰 및 도서별 별정정보
 */
public class IndexCommand implements Command {
	String[] bookIsbn_Array = null;
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		DAO dao = DAO.getInstance();
		
		try {
			//1.인코딩 설정
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			response.setContentType("application/json; charset=utf-8");
			
			//2.파라미터 핸들링
			String bookIsbn = request.getParameter("bookIsbn");
			bookIsbn_Array = bookIsbn.split(",");

			
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
		
		String starScore = "";
		
		/**
		 * @광준
		 * ISBN값을 토대로 별점정보를 가져오는 코드
		 */
		List<String> starScoreList = dao.selectStarScoreList(bookIsbn_Array);
		JsonArray result2 = new JsonArray();
		JsonObject jobj2 = new JsonObject();
		if(starScoreList != null && starScoreList.get(0) != "") {
			for(int i=0; i<starScoreList.size(); i++)
			{
				starScore = starScoreList.get(i);
			    jobj2.addProperty("isbn", starScore);
			    result2.add(jobj2);
			}
		}
		
		
		/**
		 * @광준
		 * 최종 두개의 데이터를 jsp로 전송한다. (최근리뷰 5개, 별점)
		 */
		JsonArray total_result = new JsonArray();
		total_result.add(result);
		total_result.add(result2);
		
		
		
		try {
			response.getWriter().print(total_result);
		} catch (IOException e) {
			System.out.println("IndexCommand@json데이터 전송에 실패했습니다.");
			e.printStackTrace();
		}
	}
}
