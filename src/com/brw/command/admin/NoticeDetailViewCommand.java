package com.brw.command.admin;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;
import com.brw.dto.NoticeDTO;

/*
 * 작성자 : 장선웅
 * 내용 : 해당번호 리뷰 가져오기
 */
public class NoticeDetailViewCommand implements Command{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		int ntcNo = Integer.parseInt(request.getParameter("ntcNo"));
		DAO dao = DAO.getInstance();
		
		//조회수 +1 해주기
		int ntcReadcntUp = dao.noticeReadcntUp(ntcNo);
		
		NoticeDTO notice = null;
		//셀렉트 원해서 하나 가져오기
		if(ntcReadcntUp>0) {
			notice = dao.selectNoticeOne(ntcNo);
		}
		
		request.setAttribute("notice", notice);
	}
}
