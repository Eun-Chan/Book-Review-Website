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
@ServerEndpoint("/broadcasting")
public class BroadSocket {
	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());
	
	// 클라이언트로부터 메시지가 도착했을 경우 처리
	@OnMessage
	public void onMessage(String message, Session session) throws IOException {
		System.out.println(message);
		synchronized (clients) {
			for (Session client : clients) {
				if(!client.equals(session)) {
					client.getBasicRemote().sendText(message);
				}
			}
		}
	}
	
	// 클라가 접속할 때 처리
	@OnOpen
	public void onOpen(Session session) {
		System.out.println(session);
		clients.add(session);
	}
	
	// 클라가 접속을 끊을 때 처리
	@OnClose
	public void onClose(Session session) {
		clients.remove(session);
	}
}
