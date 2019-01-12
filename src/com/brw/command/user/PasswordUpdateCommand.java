/**
 * 
 */
package com.brw.command.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;

/**
 * 작성자 : 김은찬
 * 내용 : 비밀번호 찾기 후 비밀번호 변경하는 소스
 */
public class PasswordUpdateCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		String userId = request.getParameter("userId");	
		String userPassword = request.getParameter("userPassword");
		
		int result = DAO.getInstance().passwordUpdate(userId,userPassword);
		
		// 비밀번호 변경 실패. 알수 없는 오류 일듯 아마 안들어올 거
		if(result == 0) {
			System.out.println("PasswordUpdateCommand비밀번호 변경 실패!");
			return;
		}
		// 비밀번호 변경 성공
		else if(result == 1){
			System.out.println("PasswordUpdateCommand비밀번호 변경 성공! "+result);
		}
	}

}
