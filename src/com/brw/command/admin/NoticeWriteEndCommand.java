package com.brw.command.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;
import com.brw.dto.NoticeDTO;
import com.brw.dto.ReviewBoardDTO;

public class NoticeWriteEndCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		DAO dao = DAO.getInstance();
		
		// 파라미터 처리
		String ntcTitle = request.getParameter("ntcTitle");
		String ntcContent = request.getParameter("ntcContent");
		
		
		
		// 가져온 ISBN이 book테이블에 존재하는 지 검사 후 없다면 등록
		
		// 객체에 담기
		NoticeDTO ntc = new NoticeDTO(ntcTitle,ntcContent);
		
		// dao 갔다오기
		int result = dao.noticewWrite(ntc);
		// 결과 req객체에 저장
		request.setAttribute("result", result);
		
		// 등록 확인
		if(result > 0) {
			System.out.println("글 등록 완료");
			// 등록 완료되면 등록한 글 번호 가져오기
			int lastNoticeNo = dao.getLastNoticeNo();
			// req객체에 저장
			request.setAttribute("lastNoticeNo", lastNoticeNo);
		}
		else {
			System.out.println("글 등록 실패");
		}
	}

}
