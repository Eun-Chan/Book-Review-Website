package com.brw.command.review;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;
import com.brw.dto.ReviewBoardReportDTO;
import com.brw.dto.UserDTO;

public class SelectAllReviewBoardReportCommand implements Command{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		//맴버 리스트 가져오기
		DAO dao = DAO.getInstance();
		int cPage = 0;
		try {
		cPage = Integer.parseInt(request.getParameter("cPage"));
		} catch(NumberFormatException e) {
			cPage = 1;
		}
		
		// numPerPage는 변할 일이 없으니 그냥 고정
		int numPerPage = 5;
		
		List<ReviewBoardReportDTO> reportList = new ArrayList<>();
		
		
		reportList = dao.selectAllReviewBoardReport(cPage,numPerPage);
	
		// 페이지바 작업
		int totalContents = dao.countReportAll();
		
		int totalPages = (int)Math.ceil(((double)totalContents/numPerPage));
		int pageBarSize = 5;
		
		int startPage = ((cPage - 1) / pageBarSize) * pageBarSize + 1;
		int endPage = startPage + pageBarSize - 1;
		
		int pageNo = startPage;
		
		// bootstrap 처리위해 리스트로 처리
		String pageBar = "<ul class='pagination'>";
			
			// [이전] 이전
			if(pageNo == 1) {
				pageBar += "<li class='page-item disabled'><a class='page-link'>이전</a></li>";
			}
			else {
				pageBar += "<li class='page-item'><a class='page-link' href='" + request.getContextPath() + "/review/reviewBoardManager.do?cPage=" + (pageNo-1)
							+ "'>이전</a></li>";
			}
			
			// 페이지 숫자 영역
			while(!(pageNo > endPage || pageNo > totalPages)) {
				if(pageNo == cPage) {
					pageBar += "<li class='page-item active'><a class='page-link' href='#'>" + pageNo + "</a></li>";
				}
				else {
					pageBar += "<li class='page-item'><a class='page-link' href='" + request.getContextPath() + "/review/reviewBoardManager.do?cPage=" + pageNo
							+ "'>" + pageNo + "</a></li>";
				}
				pageNo++;
			}
	
			// [다음] 영역
			if(pageNo > totalPages) {
				pageBar += "<li class='page-item disabled'><a class='page-link'>다음</a></li>";
			}
			else {
				pageBar += "<li class='page-item'><a class='page-link' href='" + request.getContextPath() + "/review/reviewBoardManager.do?cPage=" 
							+ pageNo + "'>다음</a>";
			}
	
		
		pageBar += "</ul>";
		
		request.setAttribute("reportList", reportList);
		request.setAttribute("pageBar", pageBar);
		
	}

}
