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
<script>
	
</script>
</head>
<body>
<!DOCTYPE html>

<Html>

<head>

<meta charset='utf-8'>

<title>[bootstrap] 부트스트랩 – 내비게이션 메뉴바 [냅바(navbar)] - 전체 너비로 확장</title>

<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">

<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<style>body {

  min-height: 2000px;

  padding-top: 70px;

}</style>

<script></script>

</head>

<body>

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
          
          	<li><a href="#about">홈으로</a></li>
	
            <li class="active"><a href="#">공지사항</a></li>

            <li><a href="#about">자유게시판</a></li>

            <li><a href="#contact">리뷰게시판</a></li>
            
            <li><a href="#contact">즐겨찾기</a></li>
            
            
            
 
          </ul>  
          
          <ul class="nav navbar-nav" id="login-Container">
          <li class="nav-item">
		   	<% if(user == null) { %>  
		     	<li id="loginBtn-Li"><button type="button" class="btn btn-default navbar-btn" data-toggle="modal" data-target="#loginModal">로그인</button></li>	
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
		    </li>
          </ul>

        </div><!--/.nav-collapse -->
        
        

      </div>
      
      

    </nav>



<!-- 광준 -->
<!-- <nav class="navbar  navbar-expand-sm  bg-primary  navbar-dark" id="navSearch"> -->
 
 

  
    
  <!-- 검색 -->
  <!--  <form id="frm"> -->
<!--     <input type="hidden" id="hiddenInput-search"/>
			<select id="searchType">
				<option value="title">제목</option> 
				<option value="author">저자</option>
			</select> 
	</input>   
	   <input type="text" class="form-control" placeholder="검색어를 입력해주세요." name="search" id="search">
	   <input class="btn btn-default" type="button" id="btn-search" value="검색"></button> -->
   
	   <!-- <input type="button" class="search-btn" id="btn-search" value="검색"></input> -->
  <!-- </form> -->  
    
<!--   <ul  class="navbar-nav" id="navbar-menu"> -->
  <!-- 메뉴 -->
  	<%-- <li class="nav-item">
  		<a class="navbar-brand" href="#">공지사항</a>
	</li>
    <li  class="nav-item"> 
      <a  class="navbar-brand"  href="<%=request.getContextPath()%>/review/reviewList.do">자유게시판</a> 
    </li> 
    <li class="nav-item"> 
      <a class="navbar-brand" href="<%=request.getContextPath()%>/review/reviewList.do">리뷰게시판</a> 
    </li> 
    <li class="nav-item"> 
      <a class="navbar-brand" href="#">즐겨찾기</a> 
    </li>
    <li class="nav-item"> 
      <a class="navbar-brand" href="#">채팅</a> 
    </li> --%>

 	 <%-- <li class="nav-item">
  	 	<% if(user == null) { %>  
     	<li id="loginBtn-Li"><button type="button" class="btn btn-default navbar-btn" data-toggle="modal" data-target="#loginModal">로그인</button></li>	
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
    </li> --%>
<!--    </ul>
  
  
</nav>   -->
<!-- Collect the nav links, forms, and other content for toggling -->
    <%-- <div class="collapse navbar-collapse" id="topHeader">
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
      </ul> --%>


<%-- <nav class="navbar navbar-default">
	<!-- 너비가 768px 이하가 될 시 data-target을 통해 해당 네비바를 toggle형태로 압축 -->
	<div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#topHeader">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar">테</span>
        <span class="icon-bar">스</span>
        <span class="icon-bar">트</span>
      </button>
      <a class="navbar-brand" href="#"><img src="<%=request.getContextPath()%>/images/logo.png"></a>
    </div> --%>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <%-- <div class="collapse navbar-collapse" id="topHeader">
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
      </ul> --%>
      <!-- <form action="" class="navbar-form navbar-left" role="search" id="search-Book-Form">
        <div class="form-group">
          <input type="text" class="form-control" id="search-Book" placeholder="도서 & 리뷰 검색">
        </div>
        span은 bootstrap 전용 이미지 사용 하기 위해
        <button type="submit" class="btn btn-default" id="search-Book-Button"><span class="glyphicon glyphicon-search"></span></button>
      </form> -->
      <!-- <form id="frm">
			검색타입 :
			<select id="searchType">
				<option value="title">제목</option>
				<option value="author">저자</option>
			</select>		
			검색 input태그
			<input type="text" name="search" id="search" placeholder = " 내용을 입력하세요."/>
			<input type="button" value="검색" id="btn-search"/>
		</form> -->
      <!-- header 오른쪽 구석탱이 -->
     <%-- <ul class="nav navbar-nav navbar-right">
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
      </ul> --%>
<!--     </div>/.navbar-collapse
    </div>
</nav> -->
	
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
	
/**
 * @광준 - 도서검색 기능
 */
 $("#btn-search").click(function(){
	 var searchval = $("#search").val();
	 var searchType = $("#searchType").val();
	 location.href = "<%=request.getContextPath()%>/book/bookList.do?searchType=" + searchType + "&searchVal=" + searchval;
 });
 
 <%-- $("#search").keydown(function(key) {
	console.log(key);
	 if (key.keyCode == 13)//enter를 클릭했다면 
	 {
		 var searchval = $("#search").val();
		 var searchType = $("#searchType").val();
		 console.log("처리됨");
		 location.href = "<%=request.getContextPath()%>/book/bookList.do?searchType=" + searchType + "&searchVal=" + searchval;
	 }

 }); --%>
 /**
 * @광준 - form 대신 데이터 전송을 위한 구조 변경
 */
/* $(document).one('click','#btn-search',function(){
	dataSend();
}); */
$("#btn-search").click(function(){
	dataSend();
});
$("#search").keydown(function(){
	if(event.keyCode == 13) dataSend();
});

function dataSend()
{
	var searchval = $("#search").val();
	var searchType = $("#searchType").val();
	location.href = "<%=request.getContextPath()%>/book/bookList.do?searchType=" + searchType + "&searchVal=" + searchval;
}
</script>
	
<!-- header와 footer를 붙이기 위해 </body></html>를 지움 -->