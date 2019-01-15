/**
 * 
 */
package com.brw.command.user;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;

/**
 * 작성자 : 김은찬
 * 내용 : 회원가입 시 이메일 중복 확인 및 이메일 인증번호 전송
 */
public class EmailAuthCommand implements Command {
   // 인증번호로 사용할 변수
   private static int authNum;
   // 랜덤번호 생성 메서드
   private static int getAuthNum() {return (int)(Math.random()*100000);};
   
   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) {
      // TODO Auto-generated method stub
      
      // 중복되는 이메일 인지 확인 하는 소스
      String email = request.getParameter("userEmail");
      email = email.toLowerCase();
      System.out.println("email = "+email);
      DAO dao = DAO.getInstance();
      int result = dao.emailCheck(email);
      System.out.println("이메일 중복확인용 "+result);
      PrintWriter out;
      try {
         out = response.getWriter();
         // 이미 회원가입 된 이메일 인 경우 , 아이디 생성 불가
         if(result == 1) {
            out.append("false");
            return;
         }
         // 처음 회원가입 하는 이메일 인 경우 , 아이디 생성 가능 , ==> 밑에 소스가 쭈욱 실행되면 됨   
      } catch (IOException e1) {
         // TODO Auto-generated catch block
         e1.printStackTrace();
      }
      
      authNum = getAuthNum();
      
      new EmailSend().emailSend(email, "책 읽는 사람들 인증번호 입니다.", String.valueOf(authNum));
	  
	 try {
		out = response.getWriter();
		out.append(String.valueOf(authNum));
	} catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} 
   }
}
      

