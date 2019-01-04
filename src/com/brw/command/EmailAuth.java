/**
 * 
 */
package com.brw.command;

import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author EunChan
 *
 */
public class EmailAuth implements Command {
	// 인증번호로 사용할 변수
	private static int authNum;
	// 랜덤번호 생성 메서드
	private static int getAuthNum() {return (int)(Math.random()*100000);};
	
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		Properties props = System.getProperties();
		props.put("mail.smtp.user","eunchan2000");
		props.put("mail.smtp.host","smtp,gmail.com");
		props.put("mail.smtp.port","465");
		props.put("mail.smtp.starttls.enable","true");
		props.put("mail.smtp.auth","true");
		props.put("mail.smtp.socketFactory.port","465");
		props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.socketFactory.fallback","false");
		
		Authenticator auth = new MyAuthentication();
		
		// session 생성 및 MimeMessage 생성
		Session session = Session.getDefaultInstance(props, auth);
		MimeMessage msg = new MimeMessage(session);
		
		System.out.println("이메일 전송 준비!");
		try {
			msg.setSentDate(new Date());
			
			InternetAddress from = new InternetAddress("도서리뷰");
			
			// 이메일 발신자
			msg.setFrom(from);
			
			// 이메일 수신자
			String email = request.getParameter("userEmail");
			
			InternetAddress to = new InternetAddress(email);
			msg.setRecipient(Message.RecipientType.TO, to);
			
			// 이메일 제목
			msg.setSubject("도서 리뷰 웹사이트 회원가입 인증번호", "UTF-8");
			
			// 인증번호 생성
			authNum = getAuthNum();
			
			// 이메일 내용
			msg.setText("인증번호 = "+authNum , "UTF-8");
		
			// 이메일 헤더
			msg.setHeader("content-Type", "text/html");
			
			// 이메일 보내기
			javax.mail.Transport.send(msg);
			System.out.println("이메일 전송 완료!");
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
		String pw = "dmscks89!";
		
		pa = new PasswordAuthentication(id, pw);
	}
	
	// 시스템에서 사용하는 인증정보
	public PasswordAuthentication getPasswordAuthentication() {
		return pa;
		
	}

}
