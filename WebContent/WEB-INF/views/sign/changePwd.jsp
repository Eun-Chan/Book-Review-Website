<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 반응형 웹을 위한 메타태그 -->
<meta name="viewport" content="width=device-width", initial-scral="1">
<title>책 읽는 사람들</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css">
</head>
<body>
<div class="contentwrap">
	<article class="container">
		<div class="page-header">
			<h1>비밀번호 변경</h1>
		</div>
		<form action="<%=request.getContextPath()%>/sign/passwordUpdate.do" class="form-horizontal" onsubmit="return passwordUpdateSubmit();">
			<div class="form-group">
				<label for="userId" class="col-sm-2 control-label">아이디</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="userId" name="userId" value="<%=request.getAttribute("userId")%>" readonly>
				</div>
			</div>
			<div class="form-group">
				<label for="userPassword" class="col-sm-2 control-label">비밀번호 변경</label>
				<div class="col-sm-4">
					<input type="password" class="form-control" id="userPassword" name="userPassword" placeholder="변경하실 비밀번호를 입력하세요."/>
					<span><p id="password-help"></p></span>
				</div>
			</div>
			<div class="form-group">
				<label for="userPasswordOk" class="col-sm-2 control-label">비밀번호 확인</label>
				<div class="col-sm-4">
					<input type="password" class="form-control" id="userPasswordOk" name="userPasswordOk" placeholder="비밀번호를 한번 더 입력하세요."/>
					<span><p id="passwordOk-help"></p></span>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label"></label>
				<div class="col-sm-6">
					<button type="submit" class="btn btn-primary">변경하기</button>
					<button type="button" class="btn btn-primary" onclick="location.href='index.jsp'">나가기</button>
				</div>
			</div>
		</form>
	</article>
</div>

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>

<script>
	/* 비밀번호 유효성 통과 확인 변수 */
	var USERPASSWORD = 0;
	/* 비밀번호가 서로 동일한지 확인하는 변수 */
	var USERPASSWORD_OK = 0;
	/* 비밀번호 유효성 검사 시작 */
	$("#userPassword").keyup(function(e){
		console.log(e.key);
		
		var regPassword = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&*+=-]).*$/g;
		var userPassword = $(this).val().trim();
		if(!regPassword.test(userPassword)){
			$("#password-help").text("비밀번호는 숫자/문자/특수문자 포함형태로 8~15자리 입니다.");
			$("#password-help").removeClass("text-success");
			$("#password-help").addClass("text-danger");
			USERPASSWORD = 0;
		}
		else{
			$("#password-help").text("멋진 비밀번호 입니다!");
			$("#password-help").removeClass("text-danger");
			$("#password-help").addClass("text-success");
			USERPASSWORD = 1;
		}
		console.log(USERPASSWORD_OK);
	});
	/* 비밀번호 유효성 검사 완료 */
	
	/* 비밀번호 확인 검사 시작 */
	$("#userPasswordOk").keyup(function(e){
		
		/* 비밀번호 위에 꺼 */
		var pwd1 = $("#userPassword").val().trim();
		var pwd2 = $("#userPasswordOk").val().trim();
		
		if(USERPASSWORD == 0){
			$("#passwordOk-help").text("유효하지 않은 비밀번호 입니다.");
			$("#passwordOk-help").removeClass("text-success");
			$("#passwordOk-help").addClass("text-danger");
		}
		else if(USERPASSWORD == 1 && (pwd1 != pwd2)){
			$("#passwordOk-help").text("비밀번호가 일치하지 않습니다.");
			$("#passwordOk-help").removeClass("text-success");
			$("#passwordOk-help").addClass("text-danger");
		}
		else{
			$("#passwordOk-help").text("비밀번호 일치!");
			$("#passwordOk-help").removeClass("text-danger");
			$("#passwordOk-help").addClass("text-success");
			USERPASSWORD_OK = 1;
		}
	});
	/* 비밀번호 확인 검사 완료 */
	
	function passwordUpdateSubmit(){
		if(USERPASSWORD == 1 && USERPASSWORD_OK == 1){
			alert("비밀번호 변경 완료!");
			return true;
		}
		alert("변경하실 비밀번호를 정확히 입력하십시오.");
		return false;
	}
</script>
</body>
</html>