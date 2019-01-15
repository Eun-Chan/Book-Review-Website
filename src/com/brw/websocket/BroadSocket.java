package com.brw.websocket;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

/**
 * 작성자 : 김은찬
 * 내용 : WebSocket 채팅 구현
 */
// 클라이언트에 접속할 서버 주소
@ServerEndpoint("/broadcasting/login.do")
public class BroadSocket {
	/*
	 * 자료구조 set ==> 순서 신경 X , 중복 허용 X  , set은 HashSet(정렬X) , TreeSet(저장된 데이터값에 따라 정렬 - red-black tree타입 ) , LinkedHashSet (저장된 순서에 따라 값 정렬) 
	 */
	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());
	
	// 클라이언트로부터 메시지가 도착했을 경우 처리
	@OnMessage
	public void onMessage(String message, Session session) throws IOException {
		System.out.println(message);
		if(message.equals("chat_user_CNT")) {
			synchronized (clients) {
				for(Session client : clients) {
					client.getBasicRemote().sendText("접속자 : "+clients.size());
					System.out.println("클라 아이디"+client.getId());
					System.out.println(client.hashCode());
					
				}
			}
		}
		else { 
			synchronized (clients) {
				for (Session client : clients) {
				if(!client.equals(session)) {
					client.getBasicRemote().sendText(message);	
					}
				}
			}
		}
	}
	
	// 클라가 접속할 때 처리
	@OnOpen
	public void onOpen(Session session) throws IOException {
		System.out.println(session);
		System.out.println("클라이언트 접속 완료");
		clients.add(session);
		onMessage("chat_user_CNT" , session);
	}
	
	// 클라가 접속을 끊을 때 처리
	@OnClose
	public void onClose(Session session) throws IOException {
		System.out.println("클라이언트 접속 종료");
		clients.remove(session);
		onMessage("chat_user_CNT" , session);
	}
}
