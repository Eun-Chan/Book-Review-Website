package com.brw.dto;

import java.io.Serializable;

/**
 * 작성자 : 김은찬
 * 내용 : 카카오톡 로그인 이용자 정보 저장
 */
public class KakaoUserDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	// 카카오톡 이용자 고유 아이디
	private String userId;
	// 카카오톡 이용자 별명
	private String userName;
	
	public KakaoUserDTO() {}
	
	public KakaoUserDTO(String userId , String userName) {
		this.userId = userId;
		this.userName = userName;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
