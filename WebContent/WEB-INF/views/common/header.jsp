<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.brw.dto.*" %>
<%
	UserDTO user = (UserDTO)session.getAttribute("user");
	
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
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
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

            <li><a href="<%=request.getContextPath()%>/review/reviewList.do">자유게시판</a></li>

            <li><a href="<%=request.getContextPath()%>/review/reviewList.do">리뷰게시판</a></li>
            
            <li><a href="<%=request.getContextPath()%>/checkAttendance.do">출석체크</a></li>

            
            
            
 
          </ul>   
          
          <ul class="nav navbar-nav" id="login-Container">
          <li class="nav-item">
		   	<% if(user == null) { %>  
		     	<li id="loginBtn-Li"><button type="button" class="btn btn-default navbar-btn" data-toggle="modal" data-target="#loginModal">로그인</button></li>	
		    	<% } 
		    	else {%>  
		    	<li><a href="#">채팅</a></li>
 	
		    	
		    	<li class="dropdown" id="toggleMenu-Header-li">
		    		<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><%=user.getUserName()%> 님<span class="caret"/></span></a>
		    		<ul class="dropdown-menu" role="menu" id="toggleMenu-Header">
		    			<!-- 유저 메뉴. 작성자 : 명훈 -->
		    			<% if(user != null && !"admin".equals(user.getUserId())) { %>
		    			<li><a href="<%=request.getContextPath()%>/sign/userPasswordCheck.do">내 정보보기</a></li>
		    			<% } %>
		    			<!-- 관리자 메뉴. 작성자 : 명훈 -->
		    			<% if(user != null && "admin".equals(user.getUserId())) { %>
		    			<li><a href="">회원 관리</a></li>
		    			<% } %>
		    			<!-- 즐겨찾기 메뉴. 작성자 : 세준 -->
		    			<% if(user != null && !"admin".equals(user.getUserId())) { %>
		    			<li><a href="<%=request.getContextPath()%>/book/goBasket.do">즐겨찾기</a></li>
		    			<% } %>
		    			<li class="divider"></li>
		          		<li><a href="<%=request.getContextPath()%>/logout.do">로그아웃</a></li>
		    		</ul>
		    	</li>
		    	<%}%>
          </ul>

        </div><!--/.nav-collapse -->
        
        

      </div> 
      
      

    </nav>
  
<!-- 채팅 -->
<div class="container" id="chat-Container">
    <div class="row2" id="chat-row">  
        <div class="col-md-5" id="col-md-5-chat">
            <div class="panel panel-primary" id="chat-Box">
                <div class="panel-heading" id="accordion">
                    <span class="glyphicon glyphicon-comment"></span> Chat
                    <div class="btn-group pull-right">
                        <a type="button" class="btn btn-default btn-xs" data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                            <span class="glyphicon glyphicon-chevron-down"></span>
                        </a>
                    </div>
                </div>
            <div class="panel-collapse collapse" id="collapseOne">
                <div class="panel-body">
                    <ul class="chat">
                      
                      <!-- 은찬 : 채팅 내용 영역 -->  
                      
                    </ul>
                </div>
                <div class="panel-footer">
                    <div class="input-group">
                        <input id="btn-input" type="text" class="form-control input-sm" placeholder="Type your message here..." />
                        <span class="input-group-btn">
                            <button class="btn btn-warning btn-sm" id="btn-chat">
                                Send</button>
                        </span>
                    </div>
                </div>
            </div>
            </div>
        </div>
    </div>
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
	
	function enterkey(){
		if(window.event.keyCode == 13)
			loginCheck();
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
			}
		});
	}
	
</script>
	
<!-- header와 footer를 붙이기 위해 </body></html>를 지움 -->