package com.brw.command.filter;

import java.nio.charset.Charset;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

public class EncryptWrapper extends HttpServletRequestWrapper {
	
	public EncryptWrapper(HttpServletRequest request) {
		super(request);
	}
	
	@Override
	public String getParameter(String key) {
		String value = "";
		
		if(key != null && 
			("userPassword".equals(key) || "userPassword_new".equals(key))) {
			System.out.println("암호화전 : "+super.getParameter(key));
			
			value = getSha512(super.getParameter(key));
			
			System.out.println("암호화후 : "+value);
		}
		else {
			value = super.getParameter(key);
		}
		
		return value;
	}
	/**
	 * 암호화처리 메소드
	 */
	private String getSha512(String password) {
		String encPwd = null;
		MessageDigest md = null; 
		
		//1.암호화객체 생성 sha-512
		try {
			md = MessageDigest.getInstance("SHA-512");
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		//2.사용자가 입력한 password를 바이트배열로 변환
		byte[] bytes = password.getBytes(Charset.forName("utf-8"));
		
		//3.md객체에 바이트배열전달해서 갱신.
		md.update(bytes);
		
		//4.암호화처리
		byte[] encBytes = md.digest();
		
		//5.Base64인코더를 사용해서 암호화된 바이트배열을 문자열로 변환
		encPwd = Base64.getEncoder().encodeToString(encBytes);
		
		return encPwd;
	}
	
}
