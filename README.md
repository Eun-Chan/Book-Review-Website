

# 도서 리뷰 & 도서 정보 웹사이트 (JSP)

### 프로젝트 정보 링크

1. [AWS 설정 (EC2 , RDS)](#1.-aws)
2. [DBCP (커넥션 풀) - ojdbc6(ec2 tomcat에 추가)](#2.-dbcp)

3. [싱글톤 패턴](#3.-싱글톤-패턴)
4. [Front Controller Pattern (url Pattern - 확장자 패턴)](#4.-front-contrller-pattern)
5. [Gmail(smtp , 회원가입 인증) & 카카오 로그인 인증 api](#5.-gmail-smtp-,-카카오-로그인-인증-api)
6. [중복 로그인 회피 - 세션바인딩 리스너](#6.-중복-로그인-(세션-바인딩-리스너))
7. [리뷰 상세보기 페이지(좋아요, 댓글, 대댓글)](#7.-리뷰-상세보기-페이지(좋아요,댓글,대댓글))
8. [리뷰 게시판 , 도서 검색 , 출석체크](#8.-리뷰-게시판,-도서-검색,-출석체크)
9. [서머노트 에디터 사용법](#9.-서머노트-에디터-사용법)
10. [검색 및 상세보기](#10.검색-및-상세보기)



##1. AWS

> EC2는 Elastic Compute Cloud의 약자.
>
> 아마존 웹 서비스(AWS)에서 가장 중요한 서비스이다.
>
> 한 대의 컴퓨터를 임대한다는 개념이며 특별한 컴퓨터도 아니다. 
>
> 우리가 흔히 사용하는 컴퓨터와 같다고 할 수 있으며, 
>
> 실제 컴퓨터로 할 수 있는 광범위한 작업들을 EC2를 통해 작업을 할 수 있다.
>
> 다만, EC2는 물리적이 아니라 아마존에서 세계 각 지역에 만들어놓은 인프라(데이터 센터)에 
>
> 만들어지는 것이기때문에 네트워크를 통해 제어를 해야한다.
>
> AWS의 경우 클릭 몇 번만에 컴퓨터 1대를 설치할 수 있으므로 편리하다.
>
> 또한, 컴퓨터가 필요없게 됐을때 클릭 몇 번만에 컴퓨터를 제거할수 있으므로 편리하다.
>
> 즉, 유연하며, 탄력이 있는 컴퓨팅이 가능하다.
>
> 즉, 컴퓨터 생성 및 삭제가 매우 쉽다.
>
> 자신이 선호하는 OS를 설치하고, 웹 서비스를 위해 필요한 프로그램(웹 서버, DB)을 설치하면 된다.
>
> EC2를 통한 가장 기본적인 업무는 
>
> 웹서버를 설치하고 이 웹서버를 통해서 
>
> 사용자가 웹브라우저를 통해 요청하는 웹페이지나 이미지, 동영상 등을 제공하는 것이다.
>
> 인스턴스란 1대의 컴퓨터를 의미하는 단위이다.



### EC2 instance 생성

1. AWS 홈페이지에 접속해서, 프리티어 무료 계정 생성을  합니다.

   이 때, 주의 할게 잘 보고 무료로 사용할 수 있게끔 확인하면서  넘어갑니다. 옵션에 따라 비용이 생길수  있습니다.

![aws](https://user-images.githubusercontent.com/19322354/42276898-7aabbb0c-7fd0-11e8-941d-a2afd490f48b.PNG)





2. 서비스 지역은  위와 같이 아시아 태평양(서울)로  지정합니다.

![default](https://user-images.githubusercontent.com/19322354/42277692-32549cd6-7fd3-11e8-97a3-350384a179e1.PNG)







3. 맨 위 상단 왼쪽에  서비스를 누르고, EC2를 누릅니다.

    

4. 그 다음 인스턴스 시작을 통해 가상의 서버를 제공받기 위해 시작합니다.

![default](https://user-images.githubusercontent.com/19322354/42277735-4e6d797e-7fd3-11e8-8acf-609ec66255cd.PNG)







5. 우분투 서버를 선택합니다.

![default](https://user-images.githubusercontent.com/19322354/42277708-3b61dda2-7fd3-11e8-906b-7732d23f2274.PNG)







6. 인스턴스 유형은 무료로 사용하기 때문에 프리티어 사용가능인 t2.micro를 선택합니다.

![default](https://user-images.githubusercontent.com/19322354/42277770-6865b72e-7fd3-11e8-8bc9-1d994bfdf2f0.PNG)







7. 인스턴스 설정, 저장공간 추가, 태그 추가는 그냥 넘기고, 보안그룹 설정으로 갑니다. 

![oracle](https://user-images.githubusercontent.com/19322354/42278057-77230798-7fd4-11e8-92e6-74752541ecf3.PNG)

DB는 oracle을 사용하기 위해  추가했지만, 사용자에 따라서 각자  추가하면 됩니다.



8. 마지막 으로 키 페어(퍼블릭 키, 프라이빗 키)를 생성해야하는데, 이것은  나중에 가상의 서버에 접속하기 위해  필요하므로 적절한  이름과 함께 만들어  다운로드하고 시작을 누르면, 인스턴스가 만들어집니다.

![default](https://user-images.githubusercontent.com/19322354/42278217-fd244c08-7fd4-11e8-8fef-234bf5387331.PNG)



9. 그 다음 연결을 하기 위해 인스턴스 시작(파랑색) 옆에 연결을 누르면, 접속방법이 나오는데, 필자는 mac이므로 terminal을 통해 접속하면 되고, window는 putty를 통해 접속하면 됩니다.

> 시큐어 셀(Secure Shell, SSH)를 통해 접속 하게 되는데, 이 것은 네트워크 상의 다른 컴퓨터에 로그인하거나 원격 시스템에서 명령을 실행하고 다른 시스템으로 파일을 복사할 수 있도록 해주는 프로토콜 또는 응용 프로그램이라고 합니다.





10. MAC은 이때 프라이빗 키인 .pem으로 끝나는 파일의 권한 설정을 변경해주어야 합니다.

    ```
    chmod 400 ~~~~.pem    // 파일의 소유자에게 rwx 중 쓰기,실행하기의  권한을 주기
    ```



11. 그 다음 ssh -i ~~~.pem ubuntu@ec2 ~~.compute.amazonaws.com 으로 접속을 하면 됩니다.

    ```
    ssh -i ./eunchanDev.pem ubuntu@ec2-00-00-000-000.ap-northeast-2.compute.amazonaws.com
    ```



#### 다음으로는 JAVA로 프로그래밍을 해야하기 때문에 JDK와 apache를 설치 해야합니다.  이거슨 다음으로



JDK와 JRE의 차이

> JRE (Java Runtime Enviroment) : 컴파일된 자바 프로그램을 실행시킬 수 있는 자바환경
>
> 자바 프로그램을 실행시 JRE를 반드시 설치해야함 JRE안에는 자바 프로그래밍 도구가 없다.
>
> 자바 프로그래밍을 할 시에는 JDK가 필요하다.
>
> 
>
> JDK (Java Development Kit) : 자바 개발도구. 자바프로그래밍을 할 때 필요한 컴파일러 등이 포함
>
> JDK를 설치했다면 JRE도 같이 설치된다.

---



## 2. DBCP

> 커넥션 풀은 DB에 접근 할 커넥션들을 미리 만들어서 사용하는 것으로 , 서버에 대한 부담을 줄일 수 있는것은 물론  커넥션을 생성하는데 발생하는 오버헤드를 줄일 수 있다능
>
> 링크를 걸테니 여기 보고 참고하세요 !
>
> Link : [DBCP (커넥션풀에 대해 ....)](https://www.holaxprogramming.com/2013/01/10/devops-how-to-manage-dbcp/)

---



## 3. 싱글톤 패턴

> DAO , 세션바인딩 리스너를 처음 생성할 때 한번만 만들고 , 만든 것을 계속 사용 하는 친구
>
> Link : [싱글톤 패턴에 대해.....](https://zion437.tistory.com/157)

---



##4. Front Contrller Pattern

> 클라이언트의 요청을 한 곳으로 집중 , 개발 및 유지보수의 효율성 극대화
>
> 하나의 서블릿(Controller)에 요청을 주고, 서블릿에서 각 요청에 대해 분기
>
> Link : [프론트 컨트롤러에 대해...](http://rongscodinghistory.tistory.com/80)
>
> ```java
> // command 분기에 사용할 소스	
> // 컨텍스트 패스 + 요청한 command 이름
> String uri = request.getRequestURI();
> // 컨텍스트 패스
> String conPath = request.getContextPath();
> // 컨텍스트를 이용해 command
> String command = uri.substring(conPath.length());
> ```

---



## 5. Gmail smtp , 카카오 로그인 인증 api

>Gmail 인증을 위해 lib에 mail-1.4.7.jar를 추가하고, 이메일을 보내는 부분은 메소드로 만들어,
>
>바로 사용할 수 있게 해놨습니다.
>
>```java
>package com.brw.command.user;
>
>import java.util.Properties;
>
>import javax.mail.Authenticator;
>import javax.mail.Message;
>import javax.mail.MessagingException;
>import javax.mail.PasswordAuthentication;
>import javax.mail.Session;
>import javax.mail.Transport;
>import javax.mail.internet.AddressException;
>import javax.mail.internet.InternetAddress;
>import javax.mail.internet.MimeMessage;
>
>/**
> * 작성자 : 김은찬
> * 내용 : Gmail SMTP , 이메일 전송
> */
>public class EmailSend {
>	
>	final String host = "smtp.gmail.com";
>	final int port = 465;
>	
>	Properties props = System.getProperties();
>	
>	/*
>	 * to : 받는 이
>	 * from : 보내는 이
>	 * subject : 이메일 제목
>	 * body : 이메일 내용
>	 */
>	public void emailSend(String to , String subject , String body) {
>		props.put("mail.smtp.host", host); 
>	    props.put("mail.smtp.port", port); 
>	    props.put("mail.smtp.auth", "true"); 
>	    props.put("mail.smtp.ssl.enable", "true"); 
>	    props.put("mail.smtp.ssl.trust", host);
>	    
>	    System.out.println("a");
>	    Authenticator auth = new MyAuthentication();
>	    System.out.println("b");
>	    Session session = Session.getDefaultInstance(props, auth);
>	    session.setDebug(true);
>	    System.out.println("c");
>	    Message mimeMessage = new MimeMessage(session);
>	    
>	    try {
>			mimeMessage.setFrom(new InternetAddress("eunchan2000@gmail.com"));
>			mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(to)); //수신자셋팅 //.TO 외에 .CC(참조) .BCC(숨은참조) 도 있음
>	        mimeMessage.setSubject(subject); //제목셋팅
>	        mimeMessage.setText(body); //내용셋팅
>	        Transport.send(mimeMessage);
>		    System.out.println("d");
>		} catch (AddressException e) {
>			// TODO Auto-generated catch block
>			e.printStackTrace();
>		} catch (MessagingException e) {
>			// TODO Auto-generated catch block
>			e.printStackTrace();
>		}   
>	}	
>}
>
>class MyAuthentication extends Authenticator{
>	   PasswordAuthentication pa;
>	   
>	   public MyAuthentication() {
>	      String id = "(gmail아이디 , @gmail.com 은 제외하고 입력)";
>	      // gmail 계정을 2단계 인증으로 등록하고, 위 소스의 pwd란에 gmail용 비밀번호가 아닌 ACCESS 용 비밀번호를 등록해야 한다.
>	      String pw = "(비밀번호)";
>	      pa = new PasswordAuthentication(id, pw);
>	   }
>	   
>	   // 시스템에서 사용하는 인증정보
>	   public PasswordAuthentication getPasswordAuthentication() {
>	      return pa;
>	   }
>}
>```
>
>
>
>카카오톡 로그인 api인 경우 카카오 developer를 참고하여 만들었습니다.
>
>## 카카오톡 API
>
>> 카카오톡 API에 대한 설명입니다.
>>
>> 사용법에 대한 설명은 링크를 참조하시면 되겠습니다.
>>
>> [카카오톡 로그인 API 사용법](https://developers.kakao.com/docs/js/getting-started)
>
>#### 사용 순서
>
>1. 일단 카카오톡 API를 통해 , 카카오톡 이용자에 대한 정보를 가져오려면 카카오톡 developer에서 API키를 발급 받아야 합니다. (발급 받는 건 알아서 하3)
>
>   ```javascript
>   Kakao.init('발급 받은 키');
>   ```
>
>   이 부분은 카카오톡 쪽과 연결 하기 위한 소스라 생각 하시면 됩니다.
>
>2. 책 읽는 사람들 홈페이지에서 오른쪽 상단 위 로그인 버튼을 클릭 할 경우 , 로그인 폼이 show() 되며 , 밑에 쪽에 카카오톡 로그인 버튼이 있는데 , 클릭 할 경우 kakaologin 함수가 실행됩니다.
>
>​      ![image](https://user-images.githubusercontent.com/42317561/51749776-a6daa700-20f3-11e9-9f0a-c914994cc3d8.png)
>
>3. kakaologin 함수 안에 내용을 살펴 보면
>
>   Kakao.Auth.loginForm 이 있는데,  요것은 카카오톡 개발자 형님들 께서 만드신 함수로  바로 카카오톡 로그인 창을 팝업으로 띄어 줍니다.
>
>   로그인이 알맞게 실행되면 Ajax의 success가 실행되며, 갑자기 막 알지 못할 오류가 발생하여 실패 시 fail이 실행 됩니다.
>
>   Ajax는 다 알거임 ㅇㅈ? ㅇ ㅇㅈ
>
>   나머지 옵션 같은 경우는 알아서 찾아보시길 바랍니다.
>
>4. 이제 로그인이 막 아주 알맞게 성공을 할 경우 , success의 userGetProfile() 함수가 실행될 겁니다.
>
>   ![image](https://user-images.githubusercontent.com/42317561/51750533-aba05a80-20f5-11e9-8edd-51b5f69b9b26.png)
>
>   위에 사진은 Kakao.API.request 함수를 실행 시 url로 호출 할 수 잇는 API url 입니다.
>
>   우리 책 읽는 사람들은 카카오톡 이용자의 정보를 훔쳐오기 위해 /v1/user/me를 호출 했고,
>
>   이로서 카카오톡 사용자의 정보를 이용하여 정보를 저장할 수 있었던 겁니다.
>
>   기본적으로 사용자 정보는 카카오톡 아이디 , 프로필명 , 프로필 사진을 가져올 수 있으며,  사용자 동의 하에 이메일 , 연령대 ,성별 , 생일 까지 정보를 가져올 수 있습니다. 이러한 설정은 카카오톡 developer에서 사용자 관리 설정을 해주면 됩니다.
>
>5. userGetProfile 함수가 알맞게 실행되면 , 사용자에 대한 정보를 인자로 kakaoUserSignUP()이 실행이 됩니다.
>
>   이 함수는 책 읽는 사람들 사이트를 카카오톡 아이디로 첫 로그인을 할 시, 해당 유저의 정보를 DB에 저장하며, 그 이후 로그인은 그냥 로그인만 합니다 ㅇㅈ?
>
>   첫 로그인때는 DB에 해당 유저의 정보를 저장하지만 따로 회원가입하지 않다는 것만 알면됩니다. ㅇㅈ? ㅇ ㅇㅈ
>
>#### header.jsp
>
>```javascript
>/* 카카오톡 api 로그인 */
>	//<![CDATA[
>    // 사용할 앱의 JavaScript 키를 설정해 주세요.
>    Kakao.init('발급 받은 키를 입력해주세용');
> 	/* 카카오 로그인 */
> 	function kakaoLogin() {
>      // 로그인 창을 띄웁니다.
> 		Kakao.Auth.loginForm({
>			// 세션이 종료된 이후에도 토큰을 유지.
>			persistAccessToken: true,
>			// 세션이 종료된 이후에도 refresh토큰을 유지.
>			persistRefreshToken: true,
>			
>			success: function(authObj) {
>				console.log("success!");
>				console.log(authObj);
>				console.log("ㅡㅡㅡㅡㅡㅡㅡㅡ");
>				userGetProfile();
>			},
>			fail: function(err) {
>				alert("로그인 에러");
>				console.log(err);
>			}
>		});
>    };	
> 	/* 카카오 api로 로그인한 유저 프로필 가져오기 */
>    function userGetProfile(){
> 		Kakao.API.request({
> 			url : '/v1/user/me',
> 			success : function(res){
> 				console.log(res);
> 				console.log("res.id = " , res.id);
> 				console.log("res.acount_email = ", res.kaccount_email);
> 				console.log("res.usernickName = ", res.properties.nickname);
> 				/* 카카오톡 유저 회원으로 추가 */
> 				kakaoUserSignUp(res.id , res.kaccount_email, res.properties.nickname);	
> 			}
> 		});
> 	};
>    
>    function kakaoUserSignUp(userId, userEmail, userName){
>    	$.ajax({
>    		url : "<%=request.getContextPath()%>/sign/kakaoCreateUserCommand.do",
>    		type : "POST",
>    		data : {userId : userId , userEmail : userEmail , userNickName : userName},
>    		success : function(data){
>   				// 카카오톡 로그인후 새로고침	
>   				if(data == 'true')
>    				location.reload();
>   				else if(data == 'false'){
>   					$("#login-help").text("이미 아이디가 접속중입니다!");
>					$("#login-help").addClass("text-danger");
>   				}
>   					
>    		}
>    	});
>    }
>```



##6. 중복 로그인 (세션 바인딩 리스너)

> > 중복 로그인을 회피하기 위해 HttpSessionBindingListener 인터페이스를 구현했습니다
> >
> > Session Listener에서 두 가지를 비교해서 설명 해 드리면
> >
> > HttpSessionListener는 세션의 생성과 세션이 해제 되는 이벤트에 맞게 리스너를 호출 할 수 있습니다.
> >
> > HttpSessionBindingListener는 세션바인딩리스너 인터페이스를 구현한 세션에 바인딩 시키거나 언바인딩 되는 이벤트에 맞게 리스너를 호출 할 수 있습니다.
> >
> > (세션의 속성을 추가 , 제거 를 뜻함)
>
> 
>
> ### 1. 흐름
>
> 1.1
>
> ​	*header.jsp* 에서 로그인 시도  - ajax를 통해 서블릿으로 아이디와 비밀번호 및 아이디 저장 체크 유무 전송
>
> 1.2
>
> ​	FrontController.java 에서 url-pattern 및 분기를 통해  해당 Command로 이동
>
> 1.3
>
> ​	LoginCommand.java 에서 아이디와 비밀번호가 알맞을 경우,  setSession을 통해 HashTable에 저장합니다.
>
> ​	세션바인딩 리스너는 setSession 메소드가 호출 했을 경우 valueBound가 실행 되며 ,
>
> ​	session.invalidate(); 와 같이 세션의 속성을 제거 했을 때 valueUnBound가 실행됩니다.
>
> 
>
> ​	그리고 세션바인딩 리스너 인터페이스를 구현한 클래스는 싱글톤 패턴을 통해 효율적으로 관리됩니다. 
>
> ​	이때 유저의 정보를 담고 있는 HashTable은 static으로 지정을 해 스태틱 메모리 영역에 저장을 합니다.
>
> ​	이는 공유하기 위해 요기다가 저장 하는 겁니당
>
> 1.4
>
> ​	이후 header.jsp에서 로그아웃을 하면   서블릿을 통해 해당 Command(Logout)로 이동하여 session.invalidate(); 를
>
> ​        실행합니다. 이 때 세션바인딩 리스너에서 valueUnBound가 실행되며 HashTable에서 해당하는 아이디가 제거됩니다.
>
> 1.5
>
> ​	중복아이디를 판단하는 메소드는 간단합니다. 세션 바인딩 리스너에서 isUsing 메소드를 통해서 현재 아이디가 HashTable
>
> ​	에 담겨 있다면 true를 반환하고, 없다면 false를 반환합니다.
>
> ​	LoginCommand에서 SessionListener.getInstance().isUsing(userId) 를 조건문으로 두어 중복로그인 인지 판별합
>
> ​	니다.
>
> 
>
> #### header.jsp
>
> ```javascript
> function loginCheck(){
> 		var userId = $("#userId").val().trim();
> 		var userPassword = $("#userPassword").val().trim();
> 		var saveId = $("#saveId").is(":checked")
> 		console.log("$saveId는 바로 ! = " , saveId)
> 		if(userId == 0 || userPassword == 0){
> 			$("#login-help").text("아이디 혹은 비밀번호를 입력해 주시길 바랍니다.");
> 			$("#login-help").addClass("text-danger");
> 			return;
> 		}
> 		
> 		$.ajax({
> 			url : "<%=request.getContextPath()%>/login.do",
> 			type : "POST",
> 			data : {userId : userId , userPassword : userPassword, saveId : saveId},
> 			success : function(data){
> 				if(data == "true"){
> 					location.reload();
> 					console.log("여긴 오지");
> 				}	
> 				else if(data == "false"){
> 					$("#login-help").text("아이디 혹은 비밀번호가 알맞지 않습니다.");
> 					$("#login-help").addClass("text-danger");
> 				}
> 				else if(data == "already"){
> 					$("#login-help").text("이미 아이디가 접속중입니다!");
> 					$("#login-help").addClass("text-danger");
> 				}
> 				else if(data == "oldPwdChangeOrLater"){
> 		               location.href ="<%=request.getContextPath()%>/sign/OldPwdChangeOrLater.do?userId="+userId;
> 		               alert("비밀번호 변경한지 90일이 지났습니다. 변경페이지로 이동합니다.");
> 		            }
> 			}
> 		});
> 	}
> ```
>
> ------
>
> 
>
> #### LoginCommand.java
>
> ```java
> package com.brw.command.user;
> 
> import java.io.IOException;
> import java.io.PrintWriter;
> 
> import javax.servlet.http.Cookie;
> import javax.servlet.http.HttpServletRequest;
> import javax.servlet.http.HttpServletResponse;
> import javax.servlet.http.HttpSession;
> 
> import com.brw.command.Command;
> import com.brw.dao.DAO;
> import com.brw.dto.UserDTO;
> import com.brw.listener.SessionListener;
> 
> /**
>  * 작성자 : 김은찬 
>  * 내용 : 로그인 시 아이디 저장 및 세션에 유저 정보 저장
>  */
> public class LoginCommand implements Command {
> 
> 	@Override
> 	public void execute(HttpServletRequest request, HttpServletResponse response) {
> 		// TODO Auto-generated method stub
> 		String userId = request.getParameter("userId");
> 		String userPassword = request.getParameter("userPassword");
> 		
> 		DAO dao = DAO.getInstance();
> 		int result = dao.loginCheck(userId , userPassword);
> 				
> 		try {
> 			PrintWriter out = response.getWriter();
> 			
> 			// 로그인 성공 !
> 			if(result == 1) {
> 				// 로그인 성공 했을 경우 쿠키 저장
> 				String saveId = request.getParameter("saveId");
> 				
> 				// (아이디 저장 체크시)쿠키 생성  , 쿠키의 생성은 server  , 보관은 클라
> 				if(saveId.equals("true")) {
> 					Cookie c = new Cookie("saveId", userId);
> 					// 쿠키 유효시간 1일 , 
> 					c.setMaxAge(24*60*60);
> 					c.setPath("/brw");
> 					response.addCookie(c);
> 				}
> 				// (아이디 저장 체크 X) , 저장된 쿠키 삭제
> 				else {
> 					Cookie c = new Cookie("saveId", userId);
> 					c.setMaxAge(0);
> 					c.setPath("/brw");
> 					response.addCookie(c);
> 				}
> 				
> 				HttpSession session = request.getSession(true);
> 				
> 				// 이미 접속한 아이디인지 체크
> 				// 현재 접속자들 보여주기
> 				SessionListener.getInstance().printloginUsers();
>                 
> 				if(SessionListener.getInstance().isUsing(userId)) {
> 					System.out.println("이미 아이디가 접속중 입니다.");
> 					out.append("already");
> 					return;
> 				}
> 				
> 				// 접속 하고자 하는 아이디의 세션을 담는다
> 				UserDTO userDTO = new UserDTO();
> 				userDTO = dao.selectOneUser(userId);
> 				
> 				session.setMaxInactiveInterval(60*10);
> 				session.setAttribute("user", userDTO);
> 								
> 				SessionListener.getInstance().setSession(session, userId);
> 				
> 				int changeDate = dao.checkDate(userId);
> 				System.out.println("$loginCommand() changeDate = "+changeDate);
> 				if(changeDate > 90)
> 					out.append("oldPwdChangeOrLater");
> 				else
> 					out.append("true");	
> 			}
> 			// 로그인 실패 !
> 			else
> 				out.append("false");
> 		} catch (IOException e) {
> 			// TODO Auto-generated catch block
> 			e.printStackTrace();
> 		}
> 	}
> }
> ```
>
> ------
>
> 
>
> #### SessionListener.java
>
> ```java
> package com.brw.listener;
> 
> import java.util.Collection;
> import java.util.Enumeration;
> import java.util.Hashtable;
> 
> import javax.servlet.http.HttpSession;
> import javax.servlet.http.HttpSessionBindingEvent;
> import javax.servlet.http.HttpSessionBindingListener;
> 
> import com.brw.dto.UserDTO;
> 
> /**
>  * 작성자 : 김은찬
>  * 내용 : 중복 로그인을 방지하기 위한 세션 리스너
>  */
> public class SessionListener implements HttpSessionBindingListener{
> 	
> 	// 싱글톤 객체를 담을 변수
> 	private static SessionListener sessionListener = null;
> 	
> 	// 로그인한 접속자를 저장한 HashTable (데이터를 해시하여 테이블 내의 주소를 계산하고 데이터를 담는 것 , 해시함수 알고리즘은 나눗셈 법. 자릿수 접기 등등)
> 	private static Hashtable loginUsers = new Hashtable();
> 	
> 	// 싱글톤 처리
> 	public static synchronized SessionListener getInstance() {
> 		if(sessionListener == null) {
> 			sessionListener = new SessionListener();
> 		}
> 		return sessionListener;
> 	}
> 	
> 
> 	// 세션이 연결시 호출 (해시테이블에 접속자 저장)
> 	@Override
> 	public void valueBound(HttpSessionBindingEvent event) {
> 		// TODO Auto-generated method stub
> 		loginUsers.put(event.getSession(), event.getName());
> 		System.out.println(event.getName() + " 로그인 완료");
> 		System.out.println("현재 접속자 수 : " +  getUserCount());
> 	}
> 
> 	// 세션이 끊겼을시 호출
> 	@Override
> 	public void valueUnbound(HttpSessionBindingEvent event) {
> 		// TODO Auto-generated method stub
> 		loginUsers.remove(event.getSession());
> 		System.out.println(event.getName() + " 로그아웃 완료");
> 		System.out.println("현재 접속자 수 : " +  getUserCount());
> 	}
> 	
> 	// 입력받은 아이디를 해시테이블에서 삭제
> 	public void removeSession(String userId) {
> 		Enumeration e = loginUsers.keys();
> 		HttpSession session = null;
> 		while(e.hasMoreElements()){
>             session = (HttpSession)e.nextElement();
>             if(loginUsers.get(session).equals(userId)){
>                 //세션이 invalidate될때 HttpSessionBindingListener를 
>                 //구현하는 클레스의 valueUnbound()함수가 호출된다.
>                 session.invalidate();
>             }
>        }
> 	}
> 
>    /*
>     * 해당 아이디의 동시 사용을 막기위해서 
>     * 이미 사용중인 아이디인지를 확인한다.
>     */
>    public boolean isUsing(String userId){
>        return loginUsers.containsValue(userId);
>    }
>     
>    
>    /*
>     * 로그인을 완료한 사용자의 아이디를 세션에 저장하는 메소드
>     */
>    public void setSession(HttpSession session, String userId){
>        //이순간에 Session Binding이벤트가 일어나는 시점
>        //name값으로 userId, value값으로 자기자신(HttpSessionBindingListener를 구현하는 Object)
>        session.setAttribute(userId, this);//login에 자기자신을 집어넣는다.
>    }
>     
>     
>    /*
>      * 입력받은 세션Object로 아이디를 리턴한다.
>      * @param session : 접속한 사용자의 session Object
>      * @return String : 접속자 아이디
>     */
>    public String getUserID(HttpSession session){
>        return (String)loginUsers.get(session);
>    }
>     
>     
>    /*
>     * 현재 접속한 총 사용자 수
>     * @return int  현재 접속자 수
>     */
>    public int getUserCount(){
>        return loginUsers.size();
>    }
>     
>     
>    /*
>     * 현재 접속중인 모든 사용자 아이디를 출력
>     * @return void
>     */
>    public void printloginUsers(){
>        Enumeration e = loginUsers.keys();
>        HttpSession session = null;
>        System.out.println("===========================================");
>        int i = 0;
>        while(e.hasMoreElements()){
>            session = (HttpSession)e.nextElement();
>            System.out.println((++i) + ". 접속자 : " +  loginUsers.get(session));
>        }
>        System.out.println("===========================================");
>     }
>     
>    /*
>     * 현재 접속중인 모든 사용자리스트를 리턴
>     * @return list
>     */
>    public Collection getUsers(){
>        Collection collection = loginUsers.values();
>        return collection;
>    }
> }
> 
> ```
>
> ---



##7. 리뷰 상세보기 페이지(좋아요,댓글,대댓글)

> <h2>ReviewDetail.jsp 코드 정리</h2>
>
> 1. 이전글 다음글 처리
> 2. 좋아요 처리 방식.
> 3. 댓글, 대댓글 입력/삭제 방식
>
> <h6>이전글 다음글 처리</h6>
>
> - 쉽게 처리 하려면 그냥 해당글에 No를 가져와서 +1  , -1 처리를 하면되지만
>
> - 우리 테이블에 삭제방식이 Del_Flag를 Y로 수정하고 해당 테이블의 내용을  트리거로 넣는 방식이기때문에 +1, -1을 해서 번호를 가져올경우 중간에 삭제된값이있으면 404에러가 뜨기때문에
>
> - 쿼리로 처리함.
>
> - 다음글 번호를 가져오는 쿼리
>
> - ```java
>   SELECT rb_no nextnumber FROM reviewboard WHERE rb_no IN ((SELECT  MIN(rb_no)FROM    reviewboard WHERE   rb_no > ? and del_flag like 'N' ))
>   ```
>
> - => 해당글의 번호를 넘겨주고 그 번호보다 크면서 del_Flag가 N인것중에 가장 작은 수를 가져옴.
>
> - 이전글 번호를 가져오는 쿼리 
>
> - ```java
>   SELECT rb_no prevnumber FROM reviewboard WHERE rb_no IN ((SELECT  max(rb_no)FROM    reviewboard WHERE   rb_no < ? and del_flag like 'N' ))
>   ```
>
> - => 해당글의 번호를 넘겨주고 그번호보다 작으면서 del_flag가 N인것 중에서 가장 큰수를 가져옴.
>
> - <h6>jsp</h6>
>
>   ```javascript
>   		//다음글처리
>   		$("#nextpage").click(function(){
>   			if(<%=nextNumber%>==0){
>   				alert("다음글이 존재하지 않습니다.");
>   				return;
>   			}
>   			location.href="<%=request.getContextPath()%>/review/reviewDetail.do?rbNo=<%=nextNumber%>";
>   		});
>   		//이전글 처리
>   		$("#prevpage").click(function(){
>   			if(<%=prevNumber%>==0){
>   				alert("이전글이 존재하지 않습니다.");
>   				return;
>   			}
>   			location.href="<%=request.getContextPath()%>/review/reviewDetail.do?rbNo=<%=prevNumber%>";
>   		});
>   ```
>
> - 넘겨준 번호를 바탕으로 이전글 다음글 해당글로 href
>
> <h6>좋아요 테이블 처리 방식</h6>
>
> ![default](https://user-images.githubusercontent.com/46082543/51796339-9893a480-2233-11e9-887a-4273126cf4fd.JPG)
>
> - 1. 사용자가 해당 게시글에 좋아요를 누르면 해당 게시물에 좋아요를 누른적이 있는지 Select 문으로 가져옴
>
>      ```java
>      //셀렉트 리스트를 가져옴
>      List<ReviewBoardLikeDTO> likeList = dao.selectAllReviewBoardLike(rbNo,userId);
>      ```
>
>   2. 해당 리스트에 값이 있다면 DB에 좋아요 카운트 테이블을 0으로 UPDATE 값이 없다면 DB테이블에 delete 해줌
>
>      ```java
>      //셀렉트한 테이블의 값이 비엇으면이면 인서트 , 그게아니라면 카운터를 0으로 업데이트
>      if(likeList.isEmpty()) {
>      	result = dao.insertReviewBoardLike(rbNo, userId);
>      }else {
>      	result = dao.deleteReviewBoardLike(rbNo, userId);
>      }
>      ```
>
>   3. 1~2 작업 완료후 해당 게시판에 총 좋아요 갯수를 구한다.
>
>      ```java
>      maxLike = dao.selectLikeCount(rbNo);
>      ```
>
>      
>
> <h6>댓글 입력방식</h6>
>
> ![default](https://user-images.githubusercontent.com/46082543/51796359-10fa6580-2234-11e9-9c79-63cb6f36cd5a.JPG)
>
> 처음 구현할때 댓글 입력 방식을 학원에서 배운대로 동기식으로 처리 하려고 했으나 여러 사이트들을 참조 해본 결과 비동기식으로 처리하는 경우가 많아 비동기 식으로 처리하였습니다.
>
> 1. 댓글 입력창을 눌럿을때 로그인이 되어있지 않으면 alert로 로그인 후 이용가능합니다 라는 메세지를 보여준후 댓글 입력창에 포커스를 뺏어옴
>
>    ```javascript
>    		$("#comment-textArea").click(function(){
>    			<%if(user==null){%>
>    				alert("로그인 후 이용 가능 합니다.");
>    				$("#comment-area").blur();
>    				return;
>    			<%}%>
>    		});
>    ```
>
> 2. 로그인이 되어 있다면 댓글을 입력하고 등록버튼을 누를시 해당글번호,댓글의 내용, 작성자 아이디, 작성자 닉네임을 파라미터로 넘겨주어 처리함.
>
>    Ajax 를 사용 하여 비동기식으로 해당 댓글 리스트를 보여주는 DIV에 입력한 댓글을 Append 해주는 식으로 처리 
>
>    ```javascript
>    	//댓글 입력하는 곳
>    		$("#comment-button").on('click',function(){
>    			if($("#comment-area").val().trim().length ==0){
>    				alert("댓글을 입력해 주세요.");
>    				return;
>    			}
>    			else{
>    				<%if(user!=null){%>
>    				var textAreaVal = $("#comment-area").val();
>    					$.ajax({
>    						url:"<%=request.getContextPath()%>/insertComment.do?rbNo=					<%=review.getRbNo()%>&rbCommentContent="+textAreaVal+"&rbCommentWriter=			<%=user.getUserId()%>&rbCommentWriterNickName=<%=user.getUserNickName()%>",
>    						async:false,
>    						timeout: 1000,
>    						success:function(data){
>    							console.log(data);
>    							$("#comment-area").val("");
>    							var div =$("<div id='comment-list' class='comment-list"+data.rbCommentNo+"'></div>");
>    							var html ="";
>    							if(data!=null){
>    								html+= "<ul><li><div id='comment-html'><div id='comment-header'><span class='comment-writer"+data.rbCommentNo+"' id='comment-writer'><img src='<%=request.getContextPath() %>/images/userGradeImage/<%=user.getUserGrade() %>.svg' width='25px' height='25px'/>"+data.rbCommentWriterNickName+"</span> <span style='font-size:0.7em;''>"+(data.rbCommentDate)+"</span></div>";
>    								html+= "<div id='comment-body'><span id='review-con"+data.rbCommentNo+"'>"+data.rbCommentContent+"</span></div>";
>    								html+= "<button class='comment-delete' value="+data.rbCommentNo+" id='comment-delete"+data.rbCommentNo+"'>[삭제]</button>";
>    								html+= "<button class='comment-recomment' value="+data.rbCommentNo+">[답글]</button></div></li></ul>";
>    								div.append(html);
>    							}
>    							$("#comment-Content").append(div);
>    							isAjaxing = false;
>    						}
>    					});
>    				<%}%>
>    			}
>    		});
>    ```
>
>    
>
> <h6>댓글 삭제 </h6>
>
> ![default](https://user-images.githubusercontent.com/46082543/51796364-35564200-2234-11e9-8e11-ccfcee9b871b.JPG)
>
> 1. 해당 댓글의 삭제를 하기 위해서 삭제 버튼안에 Value로 해당댓글 번호를 같이 넘겨줌
>
> ```html
> <button class="comment-delete" value="<%=rbc.getRbCommentNo()%>" 
>         id="comment-delete<%=rbc.getRbCommentNo()%>">
> 	[삭제]
> </button>
> ```
>
> 2. AJAX로 동적으로 생성한 태그에는 일반적인 이벤트 핸들러가 동작하지 않기 때문에 일반적인 클릭이벤트는 작동하지 않는다 그래서 해당 코드로 실행해 주었음.
>
> ```javascript
> 	//댓글 삭제 처리
> 		$(document).on('click','.comment-delete',function(){
> 			var replay = confirm("정말 삭제 하실 거에요??");
> 			var brNo = $(this).val();
> 			if(replay){
> 				$.ajax({
> 					url:"<%=request.getContextPath()%>/review/reviewCommentDelete.do?					rbCommentNo="+$(this).val()+"&rbNo=<%=review.getRbNo()%>",
> 					success:function(data){
> 						console.log(data);
> 						if(data==2){
> 							$(".comment-list"+brNo).remove();	
> 						}
> 						else if(data==1){
> 							$("#review-con"+brNo).html("[삭제된 댓글입니다.]");
> 							$("#review-con"+brNo).addClass("del");
> 							$("#comment-delete"+brNo).remove();
> 						}
> 					}		
> 				})
> 			}
> 		});
> ```
>
> 3. 댓글 삭제 버튼을 누를경우 사용자에게 댓글을 삭제하시겠습니까? 라고 물어본후 확인버튼을 누르면 삭제처리를 하게끔 구현하였습니다.
>
> 4. 해당 댓글에 대댓글이 있다면 댓글의 내용을 [삭제된 댓글입니다.] 로 DB에서 업데이트 하고 화면에도 같은 메세지로 바꿔줍니다. 해당댓글에 대댓글이 없다면 해당 댓글을 DB에서 삭제한후 해당 클레스를 화면에서를 지워줌.
>
> 5. DB댓글테이블에 UPDATE 나 DELETE가 발생할 경우 트리거를 사용하여 따로 댓글 삭제 테이블을 관리함.
>
>     
>
> <h6>대댓글 입력창 생성</h6>
>
> ![default](https://user-images.githubusercontent.com/46082543/51796324-376bd100-2233-11e9-9fab-a48147305300.JPG)
>
> 1. 댓글에서 답글 버튼을 눌럿을시 아이디가 로그인 되어있는지 확인함.
> 2. 로그인이 되어있지 않다면 로그인 후 이용가능합니다라는 팝업을 보여주고 RETURN 
> 3. 로그인이 되어있다면 대댓글 입력창을 보여줌
> 4. 삭제와 마찬가지로 AJAX로 동적으로 태그를 붙여주기 떄문에 $(document).on 으로 이벤트 핸들러를 붙여줌.
> 5. 대댓글 입력창은 하나만 나와야 하기때문에 변수를 하나주고 해당변수에 맞다면 대댓글 입력창을 보여줌
>
> ```javascript
> 	//대댓글 입력창 ajax로 생성
> 		var i = 0;
> 		$(document).on('click','.comment-recomment',function(){
> 			<%if(user==null){%>
> 				alert("로그인 후 이용 가능 합니다.");
> 				return;
> 			<%}%>
> 			if(i==0){
> 				var div =$("<div class ='recomment-Area'></div>");
> 				var html ="";
> 				<%if(user!=null){%>
> 					html +="<table><tr><td><div id='recommend-Writer'><span><img src='<%=request.getContextPath()%>/images/userGradeImage/<%=user.getUserGrade()%>.svg' width='25px' height='25px'><strong><%=user.getUserNickName()%></strong></span></div></td>";
> 					html += "<td><div class='recomment-textArea'><textarea name='recomment' id='recomment-area' rows='3' cols='62' placeholder='명예회손,욕설,허위사실 유포 등의 글은 관리자에의해 제재또는 삭제될수 있습니다.''></textarea></div></td>";
> 					html +="<td><button value='"+$(this).val()+"'class='recomment-button'>등록</button></td></tr></table>";
> 				<%}%>				
> 				div.append(html);
> 				$("#comment-Content").append(div); 
> 				div.insertAfter($(this).parent().parent()).children("div").slideDown(800);
> 				// 핸들러 한 번 실행 후 제거
> 				$(this).off("click");
> 				i = 1;
> 			}
> 			else{
> 				$(".recomment-Area").remove();
> 				i = 0;
> 				}
> 			});
> ```
>
> <h6>대댓글 입력 방식</h6>
>
> ![default](https://user-images.githubusercontent.com/46082543/51796375-836b4580-2234-11e9-9aa6-8bd671dc6f54.JPG)
> ![default](https://user-images.githubusercontent.com/46082543/51796376-836b4580-2234-11e9-82f3-93cd722ac43a.JPG)
>
> 1. 기본적인 방식은 댓글입력 방식과 동일함
>
> 2. 댓글입력과 다른점이 있다면 대댓글 입력을 AJAX로 처리하여 태그를 동적으로 생성할때 ID값에 해당대댓글의 번호를 붙여서 UNIQUE한 아이디를 부여함.(삭제를 용이하게 하기위해)
>
> 3. 처음에는 전부다 CLASS로 주어서 처리하려고 했으니 그렇게하니 모든 대댓글이 한번에 삭제되는 현상이 발견되어서 처음에 대댓글을 생성할때 해당댓글번호를 ID뒤에 붙여서 유니크한 값을 만들어줌.
>
>    ```javascript
>    //대댓글 입력 하는곳
>    		$(document).on('click',".recomment-button",function(){
>    			<%if(user==null){%>
>    			alert("로그인 후 이용 가능 합니다.");
>    			return;
>    			<%}%>
>    			console.log("앙기모띵")
>    			if($("#recomment-area").val().trim().length==0){
>    				alert("댓글을 입력해 주세요.");
>    				return;
>    			}
>    			else
>    			{
>    				var reCommendArea = $("#recomment-area").val();
>    				<%if(user!=null){%>
>    				$.ajax({
>    					url:"<%=request.getContextPath()%>/insertReComment.do?rbCommentNo="+$(this).val()+"&rbCommentContent="+reCommendArea+"&rbCommentWriter=<%=user.getUserId()%>&rbNo=<%=review.getRbNo()%>&rbCommentWriterNickName=<%=user.getUserNickName()%>",
>    					async:false,
>    					timeout: 1000,
>    					success:function(data){
>    						var divs =$("<div id='recomment-list' class='recomment-list"+data.rbCommentNo+"'></div>");
>    						var htmls ="";
>    						if(data!=null){
>    							htmls+= "<ul><li><div id='recomment-html'><div id='recomment-header'><span class='recomment-writer"+data.rbCommentNo+"'><img src='<%=request.getContextPath() %>/images/userGradeImage/<%=user.getUserGrade() %>.svg'  width='25px' height='25px'/>"+data.rbCommentWriterNickName+"</span><span style = 'font-size:0.7em;'>("+data.rbCommentDate+")</span>";
>    							htmls+= "<div id='delete-img"+data.rbCommentNo+"'class='delete-img'><img src='<%=request.getContextPath()%>/images/delete-button.png' style='width:15px; height:15px; cursor:pointer;'></img><input type='hidden' id='recomment-writerNo' value='"+data.rbcommentNo+"'></div></div>";
>    							htmls+= "<div id='recomment-body'><span>"+data.rbCommentContent+"</span></div></div></li></ul>";
>    					}
>                            divs.append(htmls);
>                            $("#recomment-area").parents("#comment-list").append(divs);
>                            $(".recomment-Area").remove();
>                            i=0;
>                            console.log(data);
>                            isAjaxing = false;
>    				}
>    			});
>    		<%}%>
>    	}
>    });
>    ```
>
>    
>
> <h6>대댓글 삭제</h6>
>
> ![default](https://user-images.githubusercontent.com/46082543/51796311-dc39de80-2232-11e9-8462-94b25baf30a3.JPG)
>
> 1. 휴지통 모양 클릭시 대댓글 삭제 버튼 이벤트를 실행함.
> 2. 삭제 버튼또한 AJAX를 통한 동적으로 태그를 생성하기 때문에 $(document).on 으로 이벤트 핸들러를 붙여서 사용함
> 3. 위에서 말햇듯이 CLASS명으로 삭제를 하려다보니 모든 대댓글이 한번에 삭제되는 현상이 나타나서                         태그를 생성할때 ID값에 해당 대댓글의 번호를 붙여 유니크한 값을 주고 그 값에 이벤트핸들러를 걸어둠
> 4. 단점이라면 대댓글 리스트를 보여주는 for문안에 스크립트를 작성 해야함.     
>
> ```javascript
> <%if(reviewReComment!=null) {%>
> 			<%for(ReviewBoardComment rbrc : reviewReComment) {%>
> 				<%if(rbrc.getRbCommentRef()==rbc.getRbCommentNo()) {%>
> 					<div id ="recomment-list" class="recomment-List<%=rbrc.getRbCommentNo()%>">
> 						<ul>
> 							<li>
> 								<div id="recomment-html">
> 									<div id="recomment-header">
> 										<span class="recomment-writer<%=rbrc.getRbCommentNo()%>"><img src="<%=request.getContextPath() %>/images/userGradeImage/<%=rbrc.getUserGrade() %>.svg" alt="" width="25px" height="25px"/><%=rbrc.getRbCommentWriterNickName() %></span>	
> 										<span style="font-size:0.7em;">(<%=rbrc.getRbCommentDate() %>)</span>
> 										<%if(user!=null && (user.getUserId().equals(rbrc.getRbCommentWriter()) || user.getUserId().equals("admin"))) {%>
> 										<div id="delete-img<%=rbrc.getRbCommentNo()%>" class="delete-img"><img src="<%=request.getContextPath() %>/images/delete-button.png" style="width: 15px; height: 15px; cursor: pointer;"/></div>
> 										<input type="hidden" id="recomment-writerNo<%=rbrc.getRbCommentNo() %>" value="<%=rbrc.getRbCommentNo() %>" />
> 										<%} %>
> 									</div>
> 									<div id="recomment-body">
> 											<span><%=rbrc.getRbCommentContent() %></span>
> 									</div>
> 								</div>
> 							</li>
> 						</ul>		
> 					</div>
> 					<script>
> 					//대댓글 삭제 처리
> 					$(document).on('click','#delete-img<%=rbrc.getRbCommentNo()%>',function(){
> 						var recommentNo = $("#recomment-writerNo<%=rbrc.getRbCommentNo()%>").val();
> 						$.ajax({
> 							url:"<%=request.getContextPath()%>/review/reviewReCommentDelete.do?rbCommentNo="+recommentNo+"&rbNo=<%=review.getRbNo()%>",
> 							success:function(data){
> 								if(data==1){
> 									$(".recomment-List"+recommentNo+"").remove();
> 								}
> 							}
> 						});
> 					});
> 					
> 					</script>
> 				<%} %>
> 			<%} %>
> ```



##8. 리뷰 게시판, 도서 검색, 출석체크



### 8.1. 리뷰게시판 페이징

![image](https://user-images.githubusercontent.com/43057794/51796907-da294d00-223d-11e9-9879-2805604f87ef.png)

- 수업 때 한 페이징 코드 따와서 부트스트랩에 맞게 바꿨음
- 딱히 내가 건드린 건 없음
- 인풋폼태그들이랑 버튼도 부트스트랩으로 만들었음



### 8.2. 리뷰게시판 검색

- 이것도 역시 수업 때 한 코드 따와서 부트스트랩에 맞게 바꿨음



### 8.3. 리뷰 작성

<img width="969" alt="image-20190120224701425" src="https://user-images.githubusercontent.com/43057794/51796790-e44a4c00-223b-11e9-81e3-78fa6f164043.png">

![image](https://user-images.githubusercontent.com/43057794/51796915-f0cfa400-223d-11e9-98a8-7fed0bd916ca.png)

- 서머노트 적용법은 따로 작성해 놓았음



#### 3-1. 도서 검색

- 버튼 클릭하면 새 창이 뜨고 거기서 검색. 
- 검색 기능은 민우형이 만든거 가져와서 쓰기만 함.  
- 물론 부트스트랩 적용했음



<img width="923" alt="image-20190120225207604" src="https://user-images.githubusercontent.com/43057794/51796799-0fcd3680-223c-11e9-9dce-aff8b62896f6.png">

- 선택버튼을 누르면 창이 닫히면서 부모창(리뷰 작성 페이지)에 [도서명, ISBN, 저자, 도서금액, 출판사] 정보를 인풋태그에 담는다.

  

### 8.4. 리뷰 수정



## 공지사항 게시판

- 관리자 이외의 사용자가 공지사항 게시판을 볼 경우

![image](https://user-images.githubusercontent.com/43057794/51796916-05ac3780-223e-11e9-9e85-95b49ecd1394.png)

- 관리자가 공지사항 게시판을 볼 경우

![image](https://user-images.githubusercontent.com/43057794/51796918-15c41700-223e-11e9-9614-4c5020e753b8.png)



- 특징?
  - jsp에서 테이블 태그를 session객체에 담겨 있는 user의 id로 분기하였음
  - 공지관리에서 공지보이기 라디오버튼을 누르면 ajax를 통해 db의 공지사항 테이블의 allowview컬럼을 수정한다. 이에 따라서 리뷰게시판의 상단에 공지사항이 노출되게 된다.

![image](https://user-images.githubusercontent.com/43057794/51796921-28d6e700-223e-11e9-9ab9-c904ca9d2351.png)



![image](https://user-images.githubusercontent.com/43057794/51796925-37bd9980-223e-11e9-9b2c-44f209cd0579.png)





### 공지 관리 기능

관리자로 로그인했을 경우 공지사항 게시판 jsp에서 `<table>` 내에 각 행의 마지막 열에 라디오버튼을 추가하고 그 라디오버튼에 클릭이벤트를 걸어 ajax로 db 수정을 하도록 하였다.

![image](https://user-images.githubusercontent.com/43057794/51796929-45731f00-223e-11e9-8144-732940d8de35.png)

- 코드
  - `<input:radio>` 의 `<%="Y".equals(n.getNtcAllowview())?"checked":""%>` 
    - 공지사항 게시판에 접속을 했을 때 보여줄 라디오버튼 checked속성 정해주기
    - db의 allowview 컬럼의 값에 따라 둘 중에 하나의 라디오버튼에 체크가 되게 된다.
  - `<input:radio>` 의 `[value="Y"||"N"]`
    - 라디오 버튼을 `<form>` 으로 전송하도록 설계하였고 선택한 라디오버튼에 따라 db에 저장할 값을 정해준 것
  - `<form>` 의 `[action]` 이 없음
    - ajax로 처리하기 때문에 사실 `<form>` 자체가 없어도 됨







### 검색

- 수업 때는 검색기능을 만들 때 게시판 처음 jsp와 검색한 뒤의 게시판 jsp를 따로 만들었었는데 사실 그렇게 할 필요가 없다. 수업 때는 설명을 하기 위해서 그렇게 한 듯.
- 그냥 게시판 처음 jsp에서 모두 다 처리 가능

<img width="655" alt="image-20190127105050902" src="https://user-images.githubusercontent.com/43057794/51796821-9f72e500-223c-11e9-8386-fac45a018351.png">

- 위 코드는 공지사항 게시판에서 가져옴. 공지사항은 검색타입이 제목밖에 없으므로 searchKeyword만 받아옴.
- request.getParameter()는 String을 반환하므로 searchKeyword에 담긴 값이 없더라도 일단은 에러가 나지 않는다. -> null이 담겨있다.

<img width="803" alt="image-20190127105249461" src="https://user-images.githubusercontent.com/43057794/51796825-b1ed1e80-223c-11e9-8021-0a068c6630b0.png">

- searchKeyword 변수를 사용하는 곳은 딱 이곳뿐.
- 따라서 null이어도 에러가 발생하지 않는다.



### 출석체크

##### 출석체크 jsp에서 받는 변수들

<img width="694" alt="image-20190127113919149" src="https://user-images.githubusercontent.com/43057794/51796831-caf5cf80-223c-11e9-8521-6a05305f4b44.png">

- today: db에서 오늘 날짜를 String으로 가져옴
- atList: 출석체크리스트. 오늘날짜를 기준으로 출석체크 목록을 가져온다. 한 번 출석체크를 했다면 다시하려고 시도할 때 못하게 막는다.
- checkValidation: 로그인한 회원이 출석체크를 했는지 안했는지에 대한 boolean값을 가져온다.
- 급하게 만들어서 오늘 날짜 기준밖에 보여주지 못함. ^^ㅋ



##### 출석체크 등록 Controller

<img width="774" alt="image-20190127115054530" src="https://user-images.githubusercontent.com/43057794/51796838-dba64580-223c-11e9-8b5e-33b31192da8a.png">

- 이번 semi-project 때는 view단 처리를 forwarding만 사용하였다. redirect를 하지 않았기 때문에 21번 코드를 넣어주어야 출석체크를 등록한 후에 두 번 출석체크가 되는 것을 막을 수 있다.



---



## 9. 서머노트 에디터 사용법

> # summernote 사용법
>
> > summernote는 한국인개발자들이 모여 만든 웹에디터입니다. 무료오픈소스기때문에 다양한 버전이 존재하며 입맛에 맞게 고쳐쓰거나 배포가 가능합니다.
>
> summernote 홈페이지 : <https://summernote.org>
>
> ![image](https://user-images.githubusercontent.com/43057794/52159465-5ad9c480-26e8-11e9-90cf-abc387b0c916.png)
>
> 
>
> 
>
> ## 설치
>
> > summernote는 `bootstrap`과 `jquery`를 필요로 하기때문에 이 것들이 먼저 선행되어야 합니다.
> >
> > 또한 `html5`에서 작동합니다.
> >
> > summernote 홈페이지에서 파일을 다운 받거나, summernote github에서 릴리즈된 버전을 받을 수 있습니다. 또는 CDN을 이용하여 링크로 걸어 사용할 수도 있습니다.
>
> 
>
> ### js/css 포함시키기
>
> ```html
> <!-- include libraries(jQuery, bootstrap) -->
> <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
> <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
> <script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 
> 
> <!-- include summernote css/js -->
> <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.css" rel="stylesheet">
> <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.js"></script>
> ```
>
> 
>
> ### summernote을 입힐 태그 준비
>
> summernote는 `form`태그 없이 사용이 가능합니다.
>
> 만약 `form`태그없이 사용하려면 `div`태그를 `body` 태그안에 위치시켜 사용합니다.
>
> ```html
> <div id="summernote">Hello Summernote</div>
> ```
>
> 
>
> `form`태그에서 사용하려면 `textarea`를 사용합니다.
>
> ```html
> <form method="post">
>   <textarea id="summernote" name="editordata"></textarea>
> </form>
> 
> ```
>
> 
>
> ### summernote 실행
>
> 스크립트를 통해 준비된 태그에 summernote를 실행시킵니다.
>
> ```html
> ...생략
> <script>
>     $(function(){
>        $("#summernote").summernote(); 
>     });
> </script>
> ... 생략
> <form method="post">
>   <textarea id="summernote" name="editordata"></textarea>
> </form>
> ... 생략
> ```
>
> 
>
> summernote를 실행할 때 다양한 옵션을 부여할 수 있다.
>
> ```html
> $('#summernote').summernote({
>   height: 300,                 // set editor height
>   minHeight: null,             // set minimum height of editor
>   maxHeight: null,             // set maximum height of editor
>   focus: true                  // set focus to editable area after initializing summernote
> });
> ```
>
> 
>
> ### summernote가 적용된 화면
>
> ![image](https://user-images.githubusercontent.com/43057794/52159483-75ac3900-26e8-11e9-8be0-fcbe3c6f2385.png)
>
> 
>
> 
>
> ## TroubleShooting
>
> 
>
> ### 1.이미지 업로드 관련 troubleshooting
>
> 기본적으로 summernote는 로컬의 이미지파일을 에디터에 넣었을 경우 base64를 이용하여 데이터화합니다. 보안상 이 것이 훨씬 좋다고 하지만 현재 이미지파일들이 고화질인 경우가 많으며 화질이 높을 수록 base64로 된 이미지파일은 용량과 텍스트의 길이가 커지고 길어지게 됩니다.
>
> 따라서 db에 저장이 불가능한 경우가 발생하게 되어 `ajax`를 통하여 이를 해결한 예제가 굉장히 많습니다.
>
> 하지만 구글링을 통한 예제를 모아보니 3, 4년된 자료가 많으며(작성일: 2019/1/10) 버전업에 따라 적용이 되지 않는 것들이 많았습니다.
>
> 현재 제가 찾아낸 방법이 정확히 몇 버전부터 되는 것인지는 정확히 알 수 없습니다. (`summernote 작업 버전 : 0.8.11`)
>
> 
>
> 해결방법은 기본적으로 다음과 같은 구조를 가지고 있습니다.
>
> > 이미지업로드시 콜백함수 처리 ☞ 미리 선언해둔 함수 실행 ☞ ajax처리 ☞ 업로드된 이미지 로컬에 저장 ☞ 로컬에 저장된 경로 json으로 보내기 ☞ summernote 에디터에 로컬경로로 이미지 넣기
>
> 
>
> 먼저 콜백함수와 그 안에서 사용될 함수를 선언합니다.
>
> ```html
> <script>
>     function sendFile(file){
> 		// 파일 전송을 위한 폼생성
> 		var form_data = new FormData();
> 		form_data.append('file', file);
> 		$.ajax({
> 		data: form_data,
> 		type: "POST",
> 		url: 'ajax처리를 할 url',
> 		cache: false,
> 		contentType: false,
> 		processData: false,
> 		success: function(url) {
> 			// 에디터 안에 이미지 삽입
> 			$("#summernote").summernote('insertImage', url);
> 		},
> 	});
>     }
>     
> $(function(){
> 	// summernote 에디터 준비
> 	$("#summernote").summernote({
> 		height: 300,
> 		placeholder: '내용을 작성해주세요',
> 		callbacks: {
> 			// 이미지 업로드시 사용될 콜백함수
> 			onImageUpload: function(files){
> 				sendFile(files[0]);
> 			}
> 		}
> 	});
> });
> </script>
> ```
>
> #### - 관련 에러
>
> 1. sendFile 매개변수
>    - 예제 중 많은 수가 매개변수를 다음과 같이 3개를 가지는 것이 있습니다.
>    - sendFile(file, editor, welEditable) 
>    - 하지만 현재는 file만 사용하면 된다고 합니다.
> 2. ajax의 success함수 내의 `$(editor).summernote('editor.insertImage', url)`
>    - 위 코드는 아무 반응이 없습니다. 에러도 나지않고 이미지삽입도 되지 않습니다.
>    - 따라서 사용 X
> 3. 파일이 저장된 절대경로로 이미지를 불러오려 할 때
>    - `$("#summernote").summernote('insertImage', url);` 는 올바른 코드이지만 `url` 이 파일이 저장된 로컬의 절대경로라면 경로의 첫 부분에 `http://` 이 자동적으로 붙게되어 경로가 에러가 나게 됩니다. 따라서 서블릿에서 저장경로와 불러오는 경로를 다르게 해주어야합니다.
>
> 
>
> ### ajax처리용 서블릿
>
> ```java
> package com.brw.controller;
> 
> import java.io.File;
> import java.io.IOException;
> import java.util.Enumeration;
> 
> import javax.servlet.http.HttpServletRequest;
> import javax.servlet.http.HttpServletResponse;
> 
> import com.brw.command.Command;
> import com.google.gson.Gson;
> import com.google.gson.JsonIOException;
> import com.oreilly.servlet.MultipartRequest;
> import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
> 
> public class ReviewWriteImage implements Command  {
> 
> 	@Override
> 	public void execute(HttpServletRequest request, HttpServletResponse response) {
> 		
> 		// 이미지 업로드할 경로
> 		String saveDir = request.getServletContext().getRealPath("") + "upload" + File.separator + "reviewImage";
> 
> 		int maxSize = 10 * 1024 * 1024;  // 업로드 사이즈 제한 10M 이하
> 		
> 		String fileName = ""; // 파일명
> 		
> 		try{
> 	        // 로컬경로에 파일 저장 및 저장 후 파일명 가져옴
> 			MultipartRequest multi = new MultipartRequest(request, saveDir, maxSize, "utf-8", new DefaultFileRenamePolicy());
> 			Enumeration files = multi.getFileNames();
> 			String file = (String)files.nextElement(); 
> 			fileName = multi.getFilesystemName(file); 
> 		}catch(Exception e){
> 			e.printStackTrace();
> 		}
> 		
> 	    // 저장된 로컬경로와 파일명을 통해 이미지태그의 경로를 생성
> 		String loadingPath = request.getContextPath() + "/upload/reviewImage/" + fileName;
> 		
> 	    // 생성된 경로를 JSON 형식으로 보내주기 위한 설정
> 		response.setContentType("application/json; charset=utf-8");
> 		
> 		try {
> 			// 파일이 저장된 로컬경로를 json으로 보냄
> 			new Gson().toJson(loadingPath, response.getWriter());
> 		} catch (JsonIOException e) {
> 			e.printStackTrace();
> 		} catch (IOException e) {
> 			e.printStackTrace();
> 		}
> 
> 
> 
> 	}
> 
> }
> ```
>
> #### - 관련 에러
>
> 1. request.getServletContext().getRealPath("")
>    - 일반적인 Servlet, 즉 HttpServlet을 상속한 클래스는 getServletContext().getRealPath("")로 바로 호출이 가능하지만 현 예제는 HttpServlet을 상속받지 않고 Command 인터페이스를 구현한 클래스이기 때문에 request를 통해 호출해야 합니다.
> 2. 파일이 저장된 절대경로를 json으로 보내게 되면 파일을 제대로 불러오지 못합니다. 따라서 `img`태그의 `src` 속성에 넣을 경로는 WebDynaicProject의 ContextPath를 이용해야 합니다.



## 10.검색 및 상세보기

> <img width="1293" alt="2019-02-02 12 51 21" src="https://user-images.githubusercontent.com/42317561/52159567-8610e380-26e9-11e9-8bff-5a8d2fccc792.png">
>
> 
>
> <img width="1281" alt="2019-02-02 12 51 31" src="https://user-images.githubusercontent.com/42317561/52159571-91fca580-26e9-11e9-8b36-83394be25261.png">
>
> 
>
> ![image](https://user-images.githubusercontent.com/42317561/52159607-fe77a480-26e9-11e9-9b8f-0b94d814aeb0.png)
>
> ![image](https://user-images.githubusercontent.com/42317561/52159611-0cc5c080-26ea-11e9-8d7c-7875e2d93ed5.png)
>
> ![image](https://user-images.githubusercontent.com/42317561/52159615-1b13dc80-26ea-11e9-9c3c-b00c2804fd67.png)
>
> 
>
> ![image](https://user-images.githubusercontent.com/42317561/52159620-29fa8f00-26ea-11e9-9c88-610ec3442d7d.png)
>
> 
>
> ![image](https://user-images.githubusercontent.com/42317561/52159622-37177e00-26ea-11e9-9417-56ff9e814765.png)
>
> ![image](https://user-images.githubusercontent.com/42317561/52159644-852c8180-26ea-11e9-869a-ad31a0307053.png)
>
> ![image](https://user-images.githubusercontent.com/42317561/52159628-4696c700-26ea-11e9-8241-65bbcbad4624.png)
>
> 
>
> ![image](https://user-images.githubusercontent.com/42317561/52159629-48f92100-26ea-11e9-9fa1-cefce769135b.png)
>
> 
>
> ![image](https://user-images.githubusercontent.com/42317561/52159631-4d253e80-26ea-11e9-861f-e7c57a0282dd.png)

