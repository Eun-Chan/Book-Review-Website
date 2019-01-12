package com.brw.command.review;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.common.MyFileRenamePolicy;
import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.oreilly.servlet.MultipartRequest;

public class ReviewWriteImageCommand implements Command  {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
		// 이미지 업로드할 경로
		String saveDir = request.getServletContext().getRealPath("") + "upload" + File.separator + "reviewImage";
		//System.out.println(saveDir);
		// 경로가 왜 아래처럼 잡히지? metadata에 왜 들어가는 걸까? -> 현재 워크스페이스에 프로젝트폴더가 있는 것이 아니라 다른 폴더에 있는 프로젝트폴더를 현재 워크스페이스에 import했기 때문에 경로가 아래처럼 나오게 됨
		// /Users/mhjung/khJavaAcamey/workspaces/webserver_workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp3/wtpwebapps/BookReviewWebSite/upload/reviewImage/soulG019.jpeg

		int maxSize = 10 * 1024 * 1024;  // 업로드 사이즈 제한 10M 이하
		
		String fileName = ""; // 파일명
		
		try{
	        // 로컬경로에 파일 저장 및 저장 후 파일명 가져옴
			MultipartRequest multi = new MultipartRequest(request, saveDir, maxSize, "utf-8", new MyFileRenamePolicy());
			Enumeration files = multi.getFileNames();
			String file = (String)files.nextElement(); 
			fileName = multi.getFilesystemName(file); 
		}catch(Exception e){
			e.printStackTrace();
		}
		
	    // 저장된 로컬경로와 파일명을 통해 이미지태그의 경로를 생성
		String loadingPath = request.getContextPath() + "/upload/reviewImage/" + fileName;
		//System.out.println(loadingPath);
		
	    // 생성된 경로를 JSON 형식으로 보내주기 위한 설정
		response.setContentType("application/json; charset=utf-8");
		
		try {
			// 파일이 저장된 로컬경로를 json으로 보냄
			new Gson().toJson(loadingPath, response.getWriter());
		} catch (JsonIOException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}



	}

}
