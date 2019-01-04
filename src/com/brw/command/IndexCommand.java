package com.brw.command;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
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
		System.out.println("indexCommand 호출됨");
		DAO dao = DAO.getInstance();
		
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			System.out.println("인코딩됨");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		//업무로직 처리
		List<ReviewBoardDTO> reviewRecentList = dao.selectReviewRecentList();
		
		JsonArray result = new JsonArray();
		ReviewBoardDTO rb = null;
		
		for(int i=0; i<reviewRecentList.size(); i++)
		{
			rb = reviewRecentList.get(i);
			System.out.println(rb.getRbBookTitle());
			JsonObject jobj = new JsonObject();
		    jobj.addProperty("rbNo",rb.getRbNo());
		    jobj.addProperty("rbTitle", rb.getRbTitle());
		    jobj.addProperty("rbWriter", rb.getRbWriter());
		    jobj.addProperty("rbBookTitle", rb.getRbBookTitle());
		    jobj.addProperty("rbIsbn", rb.getRbIsbn());
		    jobj.addProperty("rbContent", rb.getRbContent());
		    jobj.addProperty("rbDate", rb.getRbDate().toString());
		    jobj.addProperty("rbStarscore", rb.getRbStarscore());
		    jobj.addProperty("rbReadCnt", rb.getRbReadCnt());
		    jobj.addProperty("rbRecommend", rb.getRbRecommend());
		    jobj.addProperty("rbOriginalFilename", rb.getRbOriginalFilename());
		    jobj.addProperty("rbRenamedFilename", rb.getRbRenamedFilename());
		    jobj.addProperty("rbReport", rb.getRbReport());
			 
			result.add(jobj);
		
		}
		
		System.out.println("최근리뷰 5건@Command : " + reviewRecentList);
		try {
			response.getWriter().print(result);
		} catch (IOException e) {
			System.out.println("json전송실패");
			e.printStackTrace();
		}
		/*request.setAttribute("ReviewRecentList", reviewRecentList);*/
		/*try {
			request.getRequestDispatcher("/").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}*/
	}
}
