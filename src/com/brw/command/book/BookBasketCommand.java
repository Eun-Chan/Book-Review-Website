package com.brw.command.book;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.brw.command.Command;
import com.brw.dao.DAO;
import com.brw.dto.BookBasketDTO;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonIOException;

public class BookBasketCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// 파라미터 및 변수 처리
		int cPage = 0;
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		} catch(NumberFormatException e) {
			cPage = 1;
		}
		try {
			request.setCharacterEncoding("utf-8");
			response.setContentType("application/json; charset=utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		String userId = request.getParameter("userId");
		System.out.println(userId);
		int numPerPage = 10;
		
		DAO dao  = DAO.getInstance();
		List<BookBasketDTO> list = dao.showBookBasket(userId,cPage,numPerPage);
				
		// 페이지바 작업
		int totalContents = dao.countBasketAll(userId);
		
		//페이징처리!!
		int totalPages = (int)Math.ceil(((double)totalContents/numPerPage));
		int pageBarSize = 5;
		
		int startPage = ((cPage - 1) / pageBarSize) * pageBarSize + 1;
		int endPage = startPage + pageBarSize - 1;
			
		int pageNo = startPage;
		
		// bootstrap 처리위해 리스트로 처리
		String pageBar = "<ul class='pagination'>";
			
		// [이전] 이전
		if(pageNo == 1) {
			pageBar += "<li class='page-item disabled'><a class='page-link' href='#'>이전</a></li>";
		}
		else {
			pageBar += "<li class='page-item'><a class='page-link' href='" + request.getContextPath() + "/book/goBasket.do?cPage=" + (pageNo-1)
						+ "'>이전</a></li>";
		}
		
		// 페이지 숫자 영역
		while(!(pageNo > endPage || pageNo > totalPages)) {
			if(pageNo == cPage) {
				pageBar += "<li class='page-item active'><a class='page-link' href='#'>" + pageNo + "</a></li>";
			}
			else {
				pageBar += "<li class='page-item'><a class='page-link' href='" + request.getContextPath() + "/book/goBasket.do?cPage=" + pageNo
						+ "'>" + pageNo + "</a></li>";
			}
			pageNo++;
		}
		// [다음] 영역
		if(pageNo > totalPages) {
			pageBar += "<li class='page-item disabled'><a class='page-link' href='#'>다음</a></li>";
		}
		else {
			pageBar += "<li class='page-item'><a class='page-link' href='" + request.getContextPath() + "/book/goBasket.do?cPage=" 
							+ pageNo + "'>다음</a>";
		}
		pageBar += "</ul>";
		System.out.println("listbasket="+list);
		JSONObject obj = new JSONObject();
		obj.put("list", list);
		obj.put("totalContents", totalContents);
		obj.put("pageBar", pageBar);
		try {
			new Gson().toJson(obj,response.getWriter());
		} catch (JsonIOException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

}
