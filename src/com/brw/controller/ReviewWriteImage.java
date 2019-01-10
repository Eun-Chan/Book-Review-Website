package com.brw.controller;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class ReviewWriteImage implements Command  {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
		// 이미지 업로드할 경로
        String saveDir = request.getServletContext().getRealPath("/") + "upload/reviewImage/";
		//String saveDir = "/Users/mhjung/git/brw/WebContent/upload/reviewImage";
		System.out.println(saveDir);
		// 경로가 왜 아래처럼 잡히지? metadata에 왜 들어가는 걸까?
		// /Users/mhjung/khJavaAcamey/workspaces/webserver_workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp3/wtpwebapps/BookReviewWebSite/upload/reviewImage/soulG019.jpeg
		//String saveDir = request.getContextPath() + "/upload/reviewImage/";
	    int maxSize = 10 * 1024 * 1024;  // 업로드 사이즈 제한 10M 이하
		
		String fileName = ""; // 파일명
		
		try{
	        // 파일업로드 및 업로드 후 파일명 가져옴
			MultipartRequest multi = new MultipartRequest(request, saveDir, maxSize, "utf-8", new DefaultFileRenamePolicy());
			Enumeration files = multi.getFileNames();
			String file = (String)files.nextElement(); 
			fileName = multi.getFilesystemName(file); 
		}catch(Exception e){
			e.printStackTrace();
		}
		
	    // 업로드된 경로와 파일명을 통해 이미지의 경로를 생성
		String loadingPath = request.getContextPath() + "/upload/reviewImage/" + fileName;
		System.out.println(loadingPath);
		
	    // 생성된 경로를 JSON 형식으로 보내주기 위한 설정
//		JSONObject jobj = new JSONObject();
//		jobj.put("url", uploadPath_);
		
		response.setContentType("application/json"); // 데이터 타입을 json으로 설정하기 위한 세팅
		try {
			new Gson().toJson(loadingPath, response.getWriter());
		} catch (JsonIOException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}



	}

}
