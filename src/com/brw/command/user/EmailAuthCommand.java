/**
 * 
 */
package com.brw.command.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
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
		
		
		Properties props = System.getProperties();
		props.put("mail.smtp.user","eunchan2000@gmail.com");
		props.put("mail.smtp.host","smtp.gmail.com");
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
			// 편지 보낸 시간
			
			msg.setSentDate(new Date());
			System.out.println("a");
			
			InternetAddress from = new InternetAddress("test<test@gmail.com>");
			System.out.println("b");
			// 이메일 발신자
			msg.setFrom(from);
			
			// 이메일 수신자
			System.out.println("email ="+email);
			
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
			System.out.println("authNum = "+authNum);
			try {
				out = response.getWriter();
				out.append(String.valueOf(authNum));
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

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
		String pw = "dmscks89!";
		
		pa = new PasswordAuthentication(id, pw);
	}
	
	// 시스템에서 사용하는 인증정보
	public PasswordAuthentication getPasswordAuthentication() {
		return pa;
		
	}

}
