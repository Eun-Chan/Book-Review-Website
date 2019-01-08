package com.brw.command.user;

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

/**
 * 작성자 : 김은찬
 * 내용 : Gmail SMTP , 이메일 전송
 */
public class EmailSend {
	
	final String host = "smtp.gmail.com";
	final int port = 465;
	
	Properties props = System.getProperties();
	
	/*
	 * to : 받는 이
	 * from : 보내는 이
	 * subject : 이메일 제목
	 * body : 이메일 내용
	 */
	public void emailSend(String to , String subject , String body) {
		props.put("mail.smtp.host", host); 
	    props.put("mail.smtp.port", port); 
	    props.put("mail.smtp.auth", "true"); 
	    props.put("mail.smtp.ssl.enable", "true"); 
	    props.put("mail.smtp.ssl.trust", host);
	    
	    System.out.println("a");
	    Authenticator auth = new MyAuthentication();
	    System.out.println("b");
	    Session session = Session.getDefaultInstance(props, auth);
	    session.setDebug(true);
	    System.out.println("c");
	    Message mimeMessage = new MimeMessage(session);
	    
	    try {
			mimeMessage.setFrom(new InternetAddress("eunchan2000@gmail.com"));
			mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(to)); //수신자셋팅 //.TO 외에 .CC(참조) .BCC(숨은참조) 도 있음
	        mimeMessage.setSubject(subject); //제목셋팅
	        mimeMessage.setText(body); //내용셋팅
	        Transport.send(mimeMessage);
		    System.out.println("d");
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