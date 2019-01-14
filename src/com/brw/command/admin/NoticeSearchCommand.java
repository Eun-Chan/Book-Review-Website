package com.brw.command.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;
import com.brw.dto.NoticeDTO;

public class NoticeSearchCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		DAO dao = DAO.getInstance();
		
		// 파라미터 및 변수 처리
		int cPage = 0;
		try {
		cPage = Integer.parseInt(request.getParameter("cPage"));
		} catch(NumberFormatException e) {
			cPage = 1;
		}
		
		// 검색어
		String searchKeyword = request.getParameter("searchKeyword");
		
		// numPerPage는 변할 일이 없으니 그냥 고정
		int numPerPage = 10;
		
		// 공지사항 가져오기 (allowview = Y이고 delflag = N 인 것만)
		List<NoticeDTO> ntcList = dao.noticeListSearch(searchKeyword, cPage, numPerPage);

		
		// 페이지바 작업
		int totalContents = dao.countNoticeSearch(searchKeyword);
		
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
				pageBar += "<li class='page-item'><a class='page-link' href='" + request.getContextPath() + "/admin/noticeList.do?cPage=" + (pageNo-1)
							+ "'>이전</a></li>";
			}
			
			// 페이지 숫자 영역
			while(!(pageNo > endPage || pageNo > totalPages)) {
				if(pageNo == cPage) {
					pageBar += "<li class='page-item active'><a class='page-link' href='#'>" + pageNo + "</a></li>";
				}
				else {
					pageBar += "<li class='page-item'><a class='page-link' href='" + request.getContextPath() + "/admin/noticeList.do?cPage=" + pageNo
							+ "'>" + pageNo + "</a></li>";
				}
				pageNo++;
			}
	
			// [다음] 영역
			if(pageNo > totalPages) {
				pageBar += "<li class='page-item disabled'><a class='page-link'>다음</a></li>";
			}
			else {
				pageBar += "<li class='page-item'><a class='page-link' href='" + request.getContextPath() + "/admin/noticeList.do?cPage=" 
							+ pageNo + "'>다음</a>";
			}
	
		
		pageBar += "</ul>";
		
		
		
		
		request.setAttribute("ntcList", ntcList);
		request.setAttribute("pageBar", pageBar);

	}

}
