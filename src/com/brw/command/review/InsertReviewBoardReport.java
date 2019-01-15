package com.brw.command.review;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.command.user.EmailSend;
import com.brw.dao.DAO;
import com.brw.dto.ReviewBoardReportDTO;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;

public class InsertReviewBoardReport implements Command{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		//1. 인코딩
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		response.setContentType("application/json; charset=utf-8");
		
		String rbReportTitle = request.getParameter("rbReportTitle"); //신고당한 글제목
		String rbReportSuspect = request.getParameter("rbReportSuspect"); //글작성한 사람
		String rbReportWriter = request.getParameter("rbReportWriter");	// 신고자
		int rbReportNo = Integer.parseInt(request.getParameter("rbReportNo")); //신고당한 글번호
		String reportselect = request.getParameter("reportselect"); //리폿 사유
		String reportTextArea = request.getParameter("reportTextArea"); //리폿 내용
		System.out.println(rbReportTitle+","+rbReportSuspect+","+rbReportWriter+","+rbReportNo+","+reportselect+","+reportTextArea);
		
		if(reportselect.equals("report1")) {
			reportselect="욕설/비방";
		}
		else if(reportselect.equals("report2")) {
			reportselect="도배";
		}
		else if(reportselect.equals("report3")) {
			reportselect="홍보/상업성";
		}
		else if(reportselect.equals("report4")) {
			reportselect="음란성";
		}
		else if(reportselect.equals("report5")) {
			reportselect="기타";
		}
		
		
		ReviewBoardReportDTO report = new ReviewBoardReportDTO(rbReportNo, rbReportTitle, rbReportSuspect, rbReportWriter, reportTextArea, reportselect);
		DAO dao = DAO.getInstance();
		int result = dao.insertReviewBoardReport(report);
		if(result>0) {
			result = dao.updateReviewBoardReport(rbReportNo);
			new EmailSend().emailSend("2019.khproject@gmail.com", "[신고]"+reportselect+"로 해당 게시글을 신고합니다.","작성자 :"+rbReportWriter+"신고당한 게시판의 글번호 :"+rbReportNo+",신고한 아이디 :"+rbReportWriter+"신고 내용 : "+reportTextArea);
			
		}
		
		System.out.println(result);
		Gson gson = new Gson();
		try {
			gson.toJson(result,response.getWriter());
		} catch (JsonIOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
