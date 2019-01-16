<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.brw.dto.*" %>
<%@ page import="com.brw.listener.*" %>
<%
	// 웹사이트 일반 유저 일때
	UserDTO	user = (UserDTO)session.getAttribute("user");
	
	// 전송된 쿠키확인
	boolean saveId = false;
	String userId = "";
	Cookie[] cookies = request.getCookies();
	
	if(cookies != null){
		for(Cookie c : cookies){
			String key = c.getName();
			String value = c.getValue();
			System.out.printf("@header.jsp %s = %s\n", key , value);
			if("saveId".equals(key)){
				saveId = true;
				userId = value;
			}
		}
	}
	
	/* 중복 로그인을 막기위한 세션 바인딩 리스너 */
	SessionListener sessionListener = SessionListener.getInstance();
	System.out.println(sessionListener.getUserCount());
	
 	 /* if(user != null && user.getUserId() != null){ 
		// 기존의 접속을 끊음
 		SessionListener.getInstance().removeSession(userId); 
		// 새로운 세션 등록
 		SessionListener.getInstance().setSession(session, userId);
		
		
	}  */
 	if(user != null && SessionListener.getInstance().isUsing(user.getUserId())) {
		System.out.println("이미 접속중인 아이디입니다.");
		
	} 
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 반응형 웹을 위한 메타태그 -->
<meta name="viewport" content="width=device-width", initial-scral="1">
<title>책 읽는 사람들</title>
<link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/images/favicon_book.ico" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/custom.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/header.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css" /> <!-- footer의 css -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
</head>
<body onunload="<%=request.getContextPath()%>/logout.do">

<script>
	
</script>

</head>
<body>

<!-- <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
 -->
<!-- <script src="http://code.jquery.com/jquery-latest.min.js"></script> -->
  
    <!-- Fixed navbar -->

    <nav class="navbar navbar-default navbar-fixed-top" id="navbar-menuBar">
      <div class="container" id="menuBar-Container">
        <div class="navbar-header"> 
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>

            <span class="icon-bar"></span>
 
            <span class="icon-bar"></span>
 
            <span class="icon-bar"></span>

          </button>  
		<a id="home-img-Container" class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp"><img id="home_img" src="<%=request.getContextPath()%>/images/logoMenu.png" alt="" /></a>

        </div>

        <div id="navbar" class="navbar-collapse collapse">

          <ul class="nav navbar-nav">
          
          	<li><a href="<%=request.getContextPath()%>/index.jsp">홈으로</a></li>
	
            <li class="active"><a href="<%=request.getContextPath()%>/admin/noticeList.do">공지사항</a></li>

            <li><a href="<%=request.getContextPath()%>/review/reviewList.do">리뷰게시판</a></li>
            
            <li><a href="<%=request.getContextPath()%>/checkAttendance.do">출석체크</a></li>

            
          </ul>   
          
          <ul class="nav navbar-nav" id="login-Container">
          <li class="nav-item">
		   	<% if(user == null) { %>  
		     	<li id="loginBtn-Li"><button type="button" class="btn btn-default navbar-btn" data-toggle="modal" data-target="#loginModal">로그인</button></li>	
		    	<% } 
		    	else {%>  
		    	<li><a onclick="chatting();" id="chat_cnt">채팅</a></li>
		    	<li class="dropdown">
 	
		    	
		    	<li class="dropdown" id="toggleMenu-Header-li">
		    		<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><%=user.getUserName()%> 님<span class="caret"/></span></a>
		    		<ul class="dropdown-menu" role="menu" id="toggleMenu-Header">
		    			<!-- 유저 메뉴. 작성자 : 명훈 -->
		    			<!-- 즐겨찾기 메뉴. 작성자 : 세준 -->
		    			<% if(user != null && !"admin".equals(user.getUserId())) { %>
		    			<li><a href="<%=request.getContextPath()%>/book/goBasket.do">즐겨찾기</a></li>
		    			<li><a href="<%=request.getContextPath()%>/sign/userInfoView.do">내 정보보기</a></li>
		    			<li><a href="<%=request.getContextPath()%>/sign/userPasswordCheck.do">내 정보수정</a></li>
		    			<% } %>
		    			<!-- 관리자 메뉴. 작성자 : 명훈 -->
		    			<% if(user != null && "admin".equals(user.getUserId())) { %>
		    			<li><a href="<%=request.getContextPath()%>/sign/adminManager.do">회원 관리</a></li>
		    			<% } %>
		    			<li class="divider"></li>
		          		<li><a href="<%=request.getContextPath()%>/logout.do" id="logout-Btn">로그아웃</a></li>
		    		</ul>
		    	</li>
		    	<%}%>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>

<!-- 채팅 -->
<div id="chatting_div">
   <div style="height: 90%">
   	<textarea id="messageWindow" readonly="true" style="height: 100%; width: 100%"></textarea>
   </div>
   <input id="inputMessage" class="form-control" type="text" onkeyup="chat_enterkey()" placeholder="채팅을 입력해줭"/>
   <input type="submit" id="sendBtn" class="btn btn-default" value="보내기" onclick="send()" />
</div>


	
<!-- The Modal 로그인 버튼 클릭시 나오는 팝업창-->
<div class="modal fade" id="loginModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header" id="loginModal-header">
        <h4 class="modal-title" id="test">로그인</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
		<form name="loginForm">
  			<div class="form-group">
    			<label for="text">아이디</label>
    			<input type="text" class="form-control" id="userId" value="<%=userId%>">
  			</div>
  			<div class="form-group">
    			<label for="userPassword">비밀번호</label>
    			<input type="password" class="form-control" id="userPassword" onkeyup="enterkey();">
  			</div>
  			<div class="form-group form-check">
    			<label class="form-check-label">
      				<input class="form-check-input" type="checkbox" id="saveId" <%=saveId?"checked":""%>/> 아이디 저장
    			</label>
    			<span><p id="login-help"></p></span>
  			</div>
  			<button type="button" class="btn btn-primary" onclick="loginCheck();">로그인</button>
  			<button type="button" class="btn btn-primary" onclick="location.href='<%=request.getContextPath()%>/signUp.do'">회원가입</button>
  			<br /><br />
  			<a href="<%=request.getContextPath()%>/idAndPwdSearch.do">아이디 찾기</a>&nbsp;&nbsp;<a href="<%=request.getContextPath()%>/idAndPwdSearch.do">비밀번호 찾기</a>
  			<div class="form-group">
  			<br /><br />
  				<!-- <a id="kakao-login-btn"></a> -->
  				<a onclick="kakaoLogin()">카카오톡 로그인</a>
  			</div>
		</form>        
      </div> <!-- modal-body 끝 -->
      
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">나가기</button>
      </div>
    </div> <!-- modal-content 끝 -->
  </div> <!-- modal-dialog 끝 -->
</div> <!-- modal fade 끝 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="<%=request.getContextPath()%>/js/bootstrap.min.js"></script>
	
	<script>
	/* Enter 로 바로 로그인 */

	function enterkey(){
		if(window.event.keyCode == 13)
			loginCheck();
	}
	
	function chat_enterkey(){
		if(window.event.keyCode == 13)
			send();
	}	 
	
	function loginCheck(){
		var userId = $("#userId").val().trim();
		var userPassword = $("#userPassword").val().trim();
		var saveId = $("#saveId").is(":checked")
		console.log("$saveId는 바로 ! = " , saveId)
		if(userId == 0 || userPassword == 0){
			$("#login-help").text("아이디 혹은 비밀번호를 입력해 주시길 바랍니다.");
			$("#login-help").addClass("text-danger");
			return;
		}
		
		$.ajax({
			url : "<%=request.getContextPath()%>/login.do",
			type : "POST",
			data : {userId : userId , userPassword : userPassword, saveId : saveId},
			success : function(data){
				if(data == "true"){
					location.reload();
					console.log("여긴 오지");
				}	
				else if(data == "false"){
					$("#login-help").text("아이디 혹은 비밀번호가 알맞지 않습니다.");
					$("#login-help").addClass("text-danger");
				}
				else if(data == "already"){
					$("#login-help").text("이미 아이디가 접속중입니다!");
					$("#login-help").addClass("text-danger");
				}
			}
		});
	}
	
	/* 카카오톡 api 로그인 */
	//<![CDATA[
    // 사용할 앱의 JavaScript 키를 설정해 주세요.
    Kakao.init('7988131d106ae6467262223dfd9dc8d8');
 	/* 카카오 로그인 */
 	function kakaoLogin() {
      // 로그인 창을 띄웁니다.
 		Kakao.Auth.loginForm({
			
			// 세션이 종료된 이후에도 토큰을 유지.
			persistAccessToken: true,
			// 세션이 종료된 이후에도 refresh토큰을 유지.
			persistRefreshToken: true,
			
			
			success: function(authObj) {
				console.log("success!");
				console.log(authObj);
				console.log("ㅡㅡㅡㅡㅡㅡㅡㅡ");
				userGetProfile();
			},
			fail: function(err) {
				alert("로그인 에러");
				console.log(err);
			}
		});
    };	
 	/* 카카오 api로 로그인한 유저 프로필 가져오기 */
    function userGetProfile(){
 		Kakao.API.request({
 			url : '/v1/user/me',
 			success : function(res){
 				console.log(res);
 				console.log("res.id = " , res.id);
 				console.log("res.acount_email = ", res.kaccount_email);
 				console.log("res.usernickName = ", res.properties.nickname);
 				/* 카카오톡 유저 회원으로 추가 */
 				kakaoUserSignUp(res.id , res.kaccount_email, res.properties.nickname);	
 			}
 		});
 	};
    
    function kakaoUserSignUp(userId, userEmail, userName){
    	$.ajax({
    		url : "<%=request.getContextPath()%>/sign/kakaoCreateUserCommand.do",
    		type : "POST",
    		data : {userId : userId , userEmail : userEmail , userNickName : userName},
    		success : function(data){
   				// 카카오톡 로그인후 새로고침	
   				if(data == 'true')
    				location.reload();
   				else if(data == 'false'){
   					$("#login-help").text("이미 아이디가 접속중입니다!");
					$("#login-help").addClass("text-danger");
   				}
   					
    		}
    	});
    }

    function chatting(){
/* 		$("#chatting_div").css('display','block'); */
		$("#chatting_div").toggle();
    }
/*     var textarea = document.getElementById("messageWindow"); */
	var textarea = $("#messageWindow");
	<%if(user != null) {%>
    	var webSocket = new WebSocket('ws://52.78.61.219:8080/brw/broadcasting/login.do');
    <%}%>
    var inputMessage = $("#inputMessage");
    
    webSocket.onerror = function(event) {
      onError(event)
    };
    webSocket.onopen = function(event) {
      onOpen(event)
    };
    webSocket.onmessage = function(event) {
      onMessage(event)
    };
    function onMessage(event) {
		if(event.data.indexOf('접속자 : ') == 0){
			$("#chat_cnt").text("채팅 ("+event.data+")");
			return;
		}
        textarea.val(textarea.val() + event.data + "\n");
        const top = textarea.prop('scrollHeight');
        textarea.scrollTop(top);
    }
    function onOpen(event) {
        textarea.val("채팅방에 입장 하셨습니다❤\n");
        console.log(event);
    }
    function onError(event) {
      alert(event.data);
    }
    function send() {
    	if(inputMessage.val().length != 0){
    	<%if(user != null){%>
        textarea.val(textarea.val() + '<%=user.getUserName()%>띠 : ' + inputMessage.val() + "\n");
        webSocket.send('<%=user.getUserName()%>띠 : ' + inputMessage.val());
        inputMessage.val("");
        /* 채팅창 스크롤 자동 내리기 */
        const top = textarea.prop('scrollHeight');
        textarea.scrollTop(top);
    	<%}%>
    	}
    }
</script>
	
<!-- header와 footer를 붙이기 위해 </body></html>를 지움 -->