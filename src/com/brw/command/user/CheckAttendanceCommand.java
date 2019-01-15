package com.brw.command.user;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;
import com.brw.dto.AttendanceDTO;

public class CheckAttendanceCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		DAO dao = DAO.getInstance();
		
		// 오늘 날짜
		List<String> today =  dao.getDayList();
		
		// 오늘 기준 출석체크 리스트 가져오기
		List<AttendanceDTO> atList = dao.atList();
		
		request.setAttribute("today", today);
		request.setAttribute("atList", atList);
	}

}
