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
<title>header 입니다</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/custom.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css" /> <!-- footer의 css -->
<script>
	
</script>
</head>
<body>
<nav class="navbar navbar-default">
	<!-- 너비가 768px 이하가 될 시 data-target을 통해 해당 네비바를 toggle형태로 압축 -->
	<div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#topHeader">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#"><img src="<%=request.getContextPath()%>/images/logo.png"></a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="topHeader">
      <ul class="nav navbar-nav">
        <li><a href="<%=request.getContextPath()%>">홈<span class="sr-only">(current)</span></a></li>
        <li><a href="<%=request.getContextPath()%>/review/reviewList.do">도서 리뷰</a></li>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">메뉴<span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu">
            <li><a href="#">Action</a></li>
            <li><a href="#">Another action</a></li>
            <li><a href="#">Something else here</a></li>
            <li class="divider"></li>
            <li><a href="#">Separated link</a></li>
            <li class="divider"></li>
            <li><a href="#">One more separated link</a></li>
          </ul>
        </li>
      </ul>
      <form class="navbar-form navbar-left" role="search">
        <div class="form-group">
          <input type="text" class="form-control" placeholder="도서 & 리뷰 검색">
        </div>
        <!-- span은 bootstrap 전용 이미지 사용 하기 위해 -->
        <button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-search"></span></button>
      </form>
      <!-- header 오른쪽 구석탱이 -->
      <ul class="nav navbar-nav navbar-right">
     	<% if(user == null) { %>
       	<li><button type="button" class="btn btn-default navbar-btn" data-toggle="modal" data-target="#loginModal">로그인</button></li>	
      	<% } 
      	else {%>
      	<li><a href="#">채팅</a></li>
      	<li class="dropdown">
      		<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><%=user.getUserName()%> 님<span class="caret"/></a>
      		<ul class="dropdown-menu" role="menu">
      			<li><a href="#">내 정보보기</a></li>
      			<li class="divider"></li>
            	<li><a href="<%=request.getContextPath()%>/logout.do">로그아웃</a></li>
      		</ul>
      	</li>
      	<%}%>
      </ul>
    </div><!-- /.navbar-collapse -->
    </div>
</nav>
	
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