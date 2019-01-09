<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.brw.dto.*" %> 
<%@ page import="java.util.*" %>
<%@ page import="com.brw.command.user.*" %>
<%

	
%>
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
		<form class="form-horizontal">
			<div class="form-group">
				<label for="userId" class="col-sm-2 control-label">비밀번호 찾기</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="userId" placeholder="비밀번호를 찾을 아이디를 입력하세요"/>
					<span><p id="id-help"></p></span>
				</div>
				<div class="col-sm-1">
					<button type="button" class="btn btn-default" id="idAuth">아이디 확인</button>
				</div>
			</div>
		</form>
	</article>
</div>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
<script>
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
	
	$("#emailAuth").on("click", function(){
		var userEmail = $("#userEmail").val().trim();
		
		$.ajax({
			url : "<%=request.getContextPath()%>/emailCheck.do",
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
	
	$("#userId").keyup(function(e){
		var regID = /^[a-z][a-z0-9]{7,14}$/;
		var userId = $("#userId").val().trim();
		
		if(!regID.test(userId)){
			$("#id-help").text("아이디는 영소문자/숫자만 가능하고, 단 소문자로 시작해야합니다.(8~15자리)");
			$("#id-help").removeClass("text-success");
			$("#id-help").addClass("text-danger");
			
		}
	});
	
	$("#idAuth").on("click" , function(){
		var userId = $("#userId").val().trim();
		
		$.ajax({
			url : "<%=request.getContextPath()%>/idCheck.do",
			data : {userId : userId},
			success : function(data){
				// 해당 아이디가 존재하지 않을 경우
				if(data == "false"){
					$("#id-help").text("해당 아이디로 회원가입정보가 없습니다.");
					$("#id-help").removeClass("text-success");
					$("#id-help").addClass("text-danger");
				}
				// 해당 아이디가 존재할 경우
				else if(data == "true"){
					
				}
			}
		});
	});
	
	function findId(){
		var userEmail = $("#userEmail").val().trim();
		
		$.ajax({
			url : "<%=request.getContextPath()%>/sign/searchIdForEmail.do",
			data : {userEmail : userEmail},
			success : function(data){
				
			}
		});
	}
	
	function goIdSearchEnd(){
		$.ajax({
			url : "<%=request.getContextPath()%>/sign/idSearchEnd.do",
			success : function(){
				console.log("idSearchEnd.jsp 로 이동!");
			}
		});
	}
	
</script>
</body>
</html>