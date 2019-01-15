package com.brw.listener;

import java.util.Collection;
import java.util.Enumeration;
import java.util.Hashtable;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

import com.brw.dto.UserDTO;

/**
 * 작성자 : 김은찬
 * 내용 : 중복 로그인을 방지하기 위한 세션 리스너
 */
public class SessionListener implements HttpSessionBindingListener{
	
	// 싱글톤 객체를 담을 변수
	private static SessionListener sessionListener = null;
	
	// 로그인한 접속자를 저장한 HashTable (데이터를 해시하여 테이블 내의 주소를 계산하고 데이터를 담는 것 , 해시함수 알고리즘은 나눗셈 법. 자릿수 접기 등등)
	private static Hashtable loginUsers = new Hashtable();
	
	// 싱글톤 처리
	public static synchronized SessionListener getInstance() {
		if(sessionListener == null) {
			sessionListener = new SessionListener();
		}
		return sessionListener;
	}
	

	// 세션이 연결시 호출 (해시테이블에 접속자 저장)
	@Override
	public void valueBound(HttpSessionBindingEvent event) {
		// TODO Auto-generated method stub
		loginUsers.put(event.getSession(), event.getName());
		System.out.println(event.getName() + " 로그인 완료");
		System.out.println("현재 접속자 수 : " +  getUserCount());
	}

	// 세션이 끊겼을시 호출
	@Override
	public void valueUnbound(HttpSessionBindingEvent event) {
		// TODO Auto-generated method stub
		loginUsers.remove(event.getSession());
		System.out.println(event.getName() + " 로그아웃 완료");
		System.out.println("현재 접속자 수 : " +  getUserCount());
	}
	
	// 입력받은 아이디를 해시테이블에서 삭제
	public void removeSession(String userId) {
		Enumeration e = loginUsers.keys();
		HttpSession session = null;
		while(e.hasMoreElements()){
            session = (HttpSession)e.nextElement();
            if(loginUsers.get(session).equals(userId)){
                //세션이 invalidate될때 HttpSessionBindingListener를 
                //구현하는 클레스의 valueUnbound()함수가 호출된다.
                session.invalidate();
            }
       }
	}

   /*
    * 해당 아이디의 동시 사용을 막기위해서 
    * 이미 사용중인 아이디인지를 확인한다.
    */
   public boolean isUsing(String userId){
       return loginUsers.containsValue(userId);
   }
    
   
   /*
    * 로그인을 완료한 사용자의 아이디를 세션에 저장하는 메소드
    */
   public void setSession(HttpSession session, String userId){
       //이순간에 Session Binding이벤트가 일어나는 시점
       //name값으로 userId, value값으로 자기자신(HttpSessionBindingListener를 구현하는 Object)
       session.setAttribute(userId, this);//login에 자기자신을 집어넣는다.
   }
    
    
   /*
     * 입력받은 세션Object로 아이디를 리턴한다.
     * @param session : 접속한 사용자의 session Object
     * @return String : 접속자 아이디
    */
   public String getUserID(HttpSession session){
       return (String)loginUsers.get(session);
   }
    
    
   /*
    * 현재 접속한 총 사용자 수
    * @return int  현재 접속자 수
    */
   public int getUserCount(){
       return loginUsers.size();
   }
    
    
   /*
    * 현재 접속중인 모든 사용자 아이디를 출력
    * @return void
    */
   public void printloginUsers(){
       Enumeration e = loginUsers.keys();
       HttpSession session = null;
       System.out.println("===========================================");
       int i = 0;
       while(e.hasMoreElements()){
           session = (HttpSession)e.nextElement();
           System.out.println((++i) + ". 접속자 : " +  loginUsers.get(session));
       }
       System.out.println("===========================================");
    }
    
   /*
    * 현재 접속중인 모든 사용자리스트를 리턴
    * @return list
    */
   public Collection getUsers(){
       Collection collection = loginUsers.values();
       return collection;
   }
}
