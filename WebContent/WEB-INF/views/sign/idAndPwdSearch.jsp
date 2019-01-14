<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.brw.dto.*" %> 
<%@ page import="java.util.*" %>
<%@ page import="com.brw.command.user.*" %>

<html>
<head>
<meta charset="UTF-8">
<!-- 반응형 웹을 위한 메타태그 -->
<meta name="viewport" content="width=device-width", initial-scral="1">
<title>책 읽는 사람들 - 아이디&비밀번호 찾기</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css">
</head>
<body>

<div class="contentwrap">
	<article class="container">
		<div class="page-header">
			<h1>아이디 & 비밀번호 찾기</h1>
		</div>
		<form class="form-horizontal">
			<div class="form-group">
				<label for="userEmail" class="col-sm-2 control-label">아이디 찾기</label>	
				<div class="col-sm-4">
					<input type="text" class="form-control" id="userEmail" placeholder="회원가입 시 등록한 이메일을 입력하세요."/>
					<span><p id="email-help"></p></span>
				</div>
				<div class="col-sm-1">
					<button type="button" class="btn btn-default" id="emailAuth" disabled="disalbed">이메일 확인</button>
				</div>
			</div>
		</form>
		<form action="<%=request.getContextPath()%>/sign/changePwd.do" class="form-horizontal" onsubmit="return authOk();">
			<div class="form-group">
				<label for="userId" class="col-sm-2 control-label">비밀번호 찾기</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="userId" name="userId" placeholder="비밀번호를 찾을 아이디를 입력하세요"/>
					<span><p id="id-help"></p></span>
				</div>
				<div class="col-sm-1">
					<button type="button" class="btn btn-default" id="idAuth">아이디 확인</button>
				</div>
			</div>
			<div class="form-group" id="searchIdForEmail" style="display:none">
				<label for="userId" class="col-sm-2 control-label">인증번호</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="userIdAuth" placeholder="인증번호"/>
					<span><p id="emailAuth-help"></p></span>
				</div>
				<div class="col-sm-1">
					<button type="submit" class="btn btn-default" id="userEmailAuth-btn">인증번호 확인</button>
				</div>
			</div>
			<div class="form-group">
				<label for="inputName" class="col-sm-2 control-label"></label>
				<div class="col-sm-6">
      				<button type="button" class="btn btn-primary" onclick="location.href='index.jsp'">홈으로</button>
    			</div>
			</div>
		</form>
	</article>
</div>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
<script>
	/* 인증번호 저장 변수 */
	var authNum;

	/* 아이디 찾기 부분에서 이메일 유효성 검사 */
	$("#userEmail").keyup(function(e){
		var regEmail = /^[0-9a-zA-Z]([\-.\w]*[0-9a-zA-Z\-_+])*@([0-9a-zA-Z][\-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9}$/i;
		var userEmail = $("#userEmail").val().trim();
		
		var emailAuth = $("#emailAuth");
		
		if(!regEmail.test(userEmail)){
			$("#email-help").text("올바르지 않은 이메일 형식 입니다.");
			$("#email-help").removeClass("text-success");
			$("#email-help").addClass("text-danger");
			
			/* 이메일 버튼 비활성화 */
			emailAuth.prop("disabled" , true);
		}
		else{
			$("#email-help").text("알맞은 이메일 형식 입니다.");
			$("#email-help").removeClass("text-danger");
			$("#email-help").addClass("text-success");
			
			/* 이메일 버튼 활성화 */
			emailAuth.prop("disabled" , false);
		}
	});
	
	/* 이메일 확인 클릭 시 해당 이메일로 가입한 아이디가 있는지 검사 */
	$("#emailAuth").on("click", function(){
		var userEmail = $("#userEmail").val().trim();
		
		$.ajax({
			url : "<%=request.getContextPath()%>/sign/searchIdForEmail.do",
			data : {userEmail : userEmail},
			success : function(data){
				if(data == "true"){
					findId();
				}
				else if(data == "false"){
					alert("해당 이메일로 가입된 아이디가 없습니다.");
					$("#email-help").text("해당 이메일로 가입된 아이디가 없습니다!");
					$("#email-help").removeClass("text-success");
					$("#email-help").addClass("text-danger");
				}
			}
		});
	});
	
	/* 아이디 찾기 성공 후(이메일로 아이디 전송) 해당 jsp로 이동 */
	function findId(){
		location.href = "<%=request.getContextPath()%>/sign/idSearchEnd.do"
	}
	
	/* 비밀번호 찾기 시 아이디 유효성 검사 */
	$("#userId").keyup(function(e){
		var regID = /^[a-z][a-z0-9]{7,14}$/;
		var userId = $("#userId").val().trim();
		
		if(!regID.test(userId)){
			$("#id-help").text("아이디는 영소문자/숫자만 가능하고, 단 소문자로 시작해야합니다.(8~15자리)");
			$("#id-help").removeClass("text-success");
			$("#id-help").addClass("text-danger");
			
		}
	});
	
	/* 아이디 확인 클릭 시 이메일 인증 후 비밀번호 변경하는 홈페이지로 이동 */
	$("#idAuth").on("click" , function(){
		var userId = $("#userId").val().trim();
		
		$.ajax({
			url : "<%=request.getContextPath()%>/idCheck.do",
			data : {userId : userId},
			success : function(data){
				// 해당 아이디가 존재하지 않을 경우
				if(data == "true"){
					$("#id-help").text("해당 아이디로 회원가입정보가 없습니다.");
					$("#id-help").removeClass("text-success");
					$("#id-help").addClass("text-danger");
				}
				// 해당 아이디가 존재할 경우
				else if(data == "false"){
					$("#id-help").text("이메일 확인 후 인증번호를 입력하세요.");
					$("#id-help").removeClass("text-danger");
					$("#id-help").addClass("text-success");
					/* 해당 아이디의 이메일로 인증번호 보내고, 이메일 인증 div blodk 변환 */
					$("#searchIdForEmail").css("display","block");
					sendAuth();
				}
			}
		});
	});
	
	/* 비밀번호 찾기 시 이메일로 인증번호를 전송 */
	function sendAuth(){
		var userId = $("#userId").val().trim();
		
		$.ajax({
			url : "<%=request.getContextPath()%>/sign/findPwdEmailAuth.do",
			data : {userId : userId},
			success : function(data){
				 if(data == "true"){
					 // 아이디를 통해 이메일을 검색 했을 때, 결과가 안나올 수 있지만
					 // 그럴 일이 없으니 여기 비워두기 ㅇㅈ? ㅇ ㅇㅈ
				 	 console.log("sendAuth true()");
				 }
				 else{
					 console.log("sendAuth false()");
					 authNum = data;
				 }
			}
		});
	}
	
	/* 인증번호 확인 버튼 눌렀을 때 클릭 이벤트 */
	/* 유저가 입력한 인증번호 저장 */
	  /* $("#userEmailAuth-btn").on("click", function(){
		var auth = $("#userIdAuth").val().trim();
		console.log("유저가 입력한 인증번호 =" , auth);
		console.log("실제 인증번호 = " , authNum);
		authOk(auth , authNum);
	}); */ 
	
	/* 인증번호가 맞는지 확인하는 함수 */
	function authOk(){
		var userId = $("#userId").val().trim();
		// 유저가 입력한 이메일 인증번호
		var userAuthNum = $("#userIdAuth").val().trim();
		
		if(authNum == userAuthNum){
			$.ajax({
				/* 이쪽 url은 의미가 없다고 해도 무방 */
				url : "<%=request.getContextPath()%>/sign/changePwd.do",
				data : 	{userId : userId},
				success : function(data){
					console.log("비밀번호 변경홈페이지로 이동 (userId도 가져가기)");
					return true;
				}
			});
		}
		else{
			$("#emailAuth-help").text("인증번호 인증 실패!");
			$("#emailAuth-help").removeClass("text-success");
			$("#emailAuth-help").addClass("text-danger");
			return false;
		}
	}
</script>
</body>
</html>