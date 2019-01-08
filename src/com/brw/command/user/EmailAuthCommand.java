/**
 * 
 */
package com.brw.command.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
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
      
      String host = "smtp.gmail.com";
      
      int port = 465;
      
      String subject = "책 읽는 사람들 인증번호 입니다.";
      String body = "인증번호 : "+String.valueOf(authNum);
      Properties props = System.getProperties();
      
      props.put("mail.smtp.host", host); 
      props.put("mail.smtp.port", port); 
      props.put("mail.smtp.auth", "true"); 
      props.put("mail.smtp.ssl.enable", "true"); 
      props.put("mail.smtp.ssl.trust", host);
      
      Authenticator auth = new MyAuthentication(); 
      
      Session session = Session.getDefaultInstance(props,auth);
      session.setDebug(true);
      
      Message mimeMessage = new MimeMessage(session); //MimeMessage 생성
      try {
         mimeMessage.setFrom(new InternetAddress("eunchan2000@gmail.com"));
         mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(email)); //수신자셋팅 //.TO 외에 .CC(참조) .BCC(숨은참조) 도 있음
         mimeMessage.setSubject(subject); //제목셋팅
         mimeMessage.setText(body); //내용셋팅
         Transport.send(mimeMessage); //javax.mail.Transport.send() 이용
         
         try {
			out = response.getWriter();
			out.append(String.valueOf(authNum));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
         
      } catch (AddressException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      } catch (MessagingException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      } 
   }
}

class MyAuthentication extends Authenticator{
   PasswordAuthentication pa;
   
   public MyAuthentication() {
      String id = "eunchan2000";
      // gmail 계정을 2단계 인증으로 등록하고, 위 소스의 pwd란에 gmail용 비밀번호가 아닌 ACCESS 용 비밀번호를 등록해야 한다.
      String pw = "xmzwopmquwnomqrl";
       
      pa = new PasswordAuthentication(id, pw);
   }
   
   // 시스템에서 사용하는 인증정보
   public PasswordAuthentication getPasswordAuthentication() {
      return pa;
      
   }

}