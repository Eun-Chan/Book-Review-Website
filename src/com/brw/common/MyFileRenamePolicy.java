package com.brw.common;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.oreilly.servlet.multipart.FileRenamePolicy;

public class MyFileRenamePolicy implements FileRenamePolicy {

	@Override
	public File rename(File oFile) {
		File rFile = null;
		// yyyyMMdd_HHmmssSSS
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
		int rndNum = (int)(Math.random()*1000); // 0~999까지 정수 난수 발생
		
		// 확장자
		String oFileName = oFile.getName(); // 파일명가져오기
		String ext = "";
		int dot = oFileName.lastIndexOf('.');
		if(dot > -1) {
			ext = oFileName.substring(dot);
		}
		
		// 새 파일명 생성
		String rFileName = sdf.format(new Date()) + "_" + rndNum + ext;
		
		// renamed 파일 객체 생성
		rFile = new File(oFile.getParent(), rFileName);
		
		
		try {
			// 실제 파일 생성
			rFile.createNewFile();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return rFile;
	}

}
