<%@page import="com.brw.dto.UserDTO"%>
<%@page import="org.apache.catalina.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!-- 반응형 웹을 위한 메타태그 -->

<body>
<div class="contentwrap">
	<article class="container">
		<div class="page-header">
			<h1>내 정보 수정</h1>
		</div>
		<div class="form-horizontal">
			<div class="form-group">
				<label for="userId-userInfo" class="col-sm-2 control-label">아이디</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="userId-userInfo" name="userId-userInfo" placeholder="<%=user.getUserId()%>" readonly/>
					<span><p id="id-help"></p></span>
				</div>
			</div>
			<div class="form-group">
				<label for="userPassword" class="col-sm-2 control-label">새 비밀번호</label>
				<div class="col-sm-4">
					<input type="password" class="form-control" id="userPassword-userInfo" name="userPassword-userInfo" placeholder="새로운 비밀번호를 입력하세요"/>
					<span><p id="password-help"></p></span>
				</div>
			</div>
			<div class="form-group">
				<label for="userPasswordOk" class="col-sm-2 control-label">비밀번호 확인</label>
				<div class="col-sm-4">
					<input type="password" class="form-control" id="userPasswordOk-userInfo" name="userPasswordOk-userInfo" placeholder="비밀번호를 다시입력하세요"/>
					<span><p id="passwordOk-help"></p></span>
				</div>
			</div>
			<br />
			<div class="form-group">
				<label for="userName" class="col-sm-2 control-label">이름</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="userName" name="userName" value="<%=user.getUserName()%>" readonly/>
					<span><p id="name-help"></p></span>
				</div>
			</div>
			<div class="form-group">
				<label for="userNickName" class="col-sm-2 control-label">별명</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="userNickName" name="userNickName" value="<%=user.getUserNickName()%>"/>
					<span><p id="nickName-help"></p></span>
				</div>
				<div class="col-sm-1">
					<button type="button" class="btn btn-default" id="nickNameCheck">중복 확인</button>
				</div>
			</div>
			<div class="form-group">
				<label for="userEmail" class="col-sm-2 control-label">이메일</label>
				<div class="col-sm-4">
					<input type="email" class="form-control" id="userEmail-userInfo" name="userEmail" placeholder="<%=user.getUserEmail()%>" value="<%=user.getUserEmail()%>"/>
					<span><p id="email-help"></p></span>
				</div>
				<div class="col-sm-1">
					<button type="button" class="btn btn-default" id="emailAuth" disabled="disabled">이메일 인증</button>
				</div>
			</div>
			<div class="form-group" id="userEmailAuthDiv" style="display:none">
				<label for="userEmail" class="col-sm-2 control-label">인증번호</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="userEmailAuth" name="userEmailAuth" placeholder="인증번호"/>
					<span><p id="emailAuth-help"></p></span>
				</div>
				<div class="col-sm-1">
					<button type="button" class="btn btn-default" id="userEmailAuth-btn">인증번호 확인</button>
				</div>
			</div>
			<div class="form-group">
				<label for="inputName" class="col-sm-2 control-label"></label>
				<div class="col-sm-6">
      				<button type="button" class="btn btn-primary" id="updateUser-Btn">수정하기</button>
      				<button type="button" class="btn btn-primary" onclick="location.href='<%=request.getContextPath()%>/index.jsp'">취소하기</button>
    			</div>
			</div>
	</div>
	</article>
</div>

<!-- 광준 -->
<script>
$("#updateUser-Btn").click(function(){
	if(updateUserSubmit()) updateUserInfo();
});

function updateUserInfo()
{
	var userPassword = $("#userPassword-userInfo").val().trim();
	var userNickName = $("#userNickName").val().trim();
	var userEmail = $("#userEmail-userInfo").val().trim();
	
	var url = encodeURI("<%=request.getContextPath()%>/sign/updateUser.do?userId=<%=user.getUserId()%>"+"&userPassword="+userPassword+"&userEmail="+userEmail+"&userNickName="+userNickName);
	var url_after = decodeURI(url);
	console.log(url_after);
	$.ajax({
		url: url,
		type: "get",
		success: function(data){
			console.log("넘어온데이터" + data);
			alert("정상적으로 변경되었습니다.");

			location.href = "<%=request.getContextPath()%>/index.jsp"; 
		},
		error: function(){
			alert("알 수 없는 오류입니다. 관리자에게 문의하세요.");
		}
	});
}
</script>
<script>

	/* 아이디 중복확인 통과 확인 변수 */
	var ID_OK = 1;
	/* 아이디 유효성 통과 확인 변수 */
	var USERPASSWORD_OK = 0;
	/* 이메일 유효성 통과 확인 변수 */
	var USEREMAIL_OK = 0;
	/* 이메일 인증번호 통과 확인 변수 */
	var AUTH_OK = 0;
	/* 별명 유효성 통과 확인 변수*/
	var NICKNAME_OK = 1;
	/* 인증번호 저장 변수 */
	var authNum;
	
	/* 회원가입 - 중복확인 버튼 완료 */
	var email_before_check = "<%=user.getUserEmail()%>";
	var userEmail = $("#userEmail-userInfo").val().trim();
	if(email_before_check==userEmail)
	{
		AUTH_OK = 1;
		USEREMAIL_OK = 1;
	}
	else AUTH_OK = 0;
	
	/* 비밀번호 유효성 검사 시작 */
	$("#userPassword-userInfo").keyup(function(e){
		console.log(e.key);
		
		var regPassword = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&*+=-]).*$/g;
		var userPassword = $(this).val().trim();
		if(!regPassword.test(userPassword)){
			$("#password-help").text("비밀번호는 숫자/문자/특수문자 포함형태로 8~15자리 입니다.");
			$("#password-help").removeClass("text-success");
			$("#password-help").addClass("text-danger");
			USERPASSWORD_OK = 0;
		}
		else{
			$("#password-help").text("멋진 비밀번호 입니다!");
			$("#password-help").removeClass("text-danger");
			$("#password-help").addClass("text-success");
			USERPASSWORD_OK = 1;
		}
		console.log(USERPASSWORD_OK);
	});
	
	/* 비밀번호 유효성 검사 완료 */
	
	/* 비밀번호 확인 검사 시작 */
	$("#userPasswordOk-userInfo").keyup(function(e){
		
		/* 비밀번호 위에 꺼 */
		var pwd1 = $("#userPassword-userInfo").val().trim();
		var pwd2 = $("#userPasswordOk-userInfo").val().trim();
		
		if(USERPASSWORD_OK == 0){
			$("#passwordOk-help").text("유효하지 않은 비밀번호 입니다.");
			$("#passwordOk-help").removeClass("text-success");
			$("#passwordOk-help").addClass("text-danger");
		}
		else if(USERPASSWORD_OK == 1 && (pwd1 != pwd2)){
			$("#passwordOk-help").text("비밀번호가 일치하지 않습니다.");
			$("#passwordOk-help").removeClass("text-success");
			$("#passwordOk-help").addClass("text-danger");
		}
		else{
			$("#passwordOk-help").text("비밀번호 일치!");
			$("#passwordOk-help").removeClass("text-danger");
			$("#passwordOk-help").addClass("text-success");
		}
	});
	/* 비밀번호 확인 검사 완료 */
	
	/* 이메일 인증 버튼 시작 */
	$("#userEmail-userInfo").keyup(function(e){
		var regEmail = /^[0-9a-zA-Z]([\-.\w]*[0-9a-zA-Z\-_+])*@([0-9a-zA-Z][\-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9}$/i;
		var userEmail = $("#userEmail-userInfo").val().trim();
		/* 이메일 인증 버튼을 알맞은 이메일 형식을 작성했을 경우만 클릭되게 만들기 */
		var emailAuth = $("#emailAuth");
		
		if(!regEmail.test(userEmail)){
			$("#email-help").text("올바르지 않은 이메일 형식 입니다.");
			$("#email-help").removeClass("text-success");
			$("#email-help").addClass("text-danger");
			USEREMAIL_OK = 0;
			/* 이메일 버튼 비활성화 */
			emailAuth.prop("disabled" , true);
		}
		else{
			$("#email-help").text("알맞은 이메일 형식 입니다.");
			$("#email-help").removeClass("text-danger");
			$("#email-help").addClass("text-success");
			USEREMAIL_OK = 1;
			var email_before = "<%=user.getUserEmail()%>";
			console.log("이전 이메일 : " + email_before);
			var email_now = userEmail;
			console.log("현재 이메일 : " + email_now);
			if(email_before==email_now) AUTH_OK = 1;
			else AUTH_OK = 0;
			console.log("인증통과(1): " + AUTH_OK);
			/* 이메일 버튼 활성화 */
			emailAuth.prop("disabled" , false);
		}
	});
	
	/* 이메일 인증 버튼 눌렀을 때 클릭 이벤트  */
	$("#emailAuth").on("click" , function(){
		var userEmail = $("#userEmail-userInfo").val().trim();
		
		$.ajax({
			url : "<%=request.getContextPath()%>/emailAuth.do",
			data : {userEmail : userEmail},
			
			success : function(data){
				if(data == "false"){
					alert("이미 회원가입된 이메일 입니다.");
					$("#email-help").text("이미 회원가입된 이메일입니다!");
					$("#email-help").removeClass("text-success");
					$("#email-help").addClass("text-danger");
				}
				else{
					/* 숨겨져있던 인증번호 확인 div 보이게 하기 */
					var userEmailAuthDiv = $("#userEmailAuthDiv");
					userEmailAuthDiv.css("display","block");
					
					/* 인증번호 변수에 저장하기 */
					authNum = data;
				}
			}
		});
	});
	/* 이메일 인증 버튼 완료 */
	
	/* 인증번호 확인 버튼 눌렀을 때 클릭 이벤트 */
	$("#userEmailAuth-btn").on("click", function(){
		/* 유저가 입력한 인증번호 저장 */
		var auth = $("#userEmailAuth").val().trim();
		console.log("유저가 입력한 인증번호 = " , auth);
		console.log("실제 인증번호 = " , authNum);
		authOk(auth , authNum);
	});
	/* 인증번호 확인 버튼 완료 */
	
	/* 인증번호 맞는지 확인하는 함수 */
	function authOk(auth1, auth2){
		if(auth1 == auth2){
			AUTH_OK = 1;
			$("#emailAuth-help").text("인증번호 인증 완료!");
			$("#emailAuth-help").removeClass("text-danger");
			$("#emailAuth-help").addClass("text-success");
		}
		else{
			AUTH_OK = 0;
			$("#emailAuth-help").text("인증번호 인증 실패!");
			$("#emailAuth-help").removeClass("text-success");
			$("#emailAuth-help").addClass("text-danger");
		}
	}
	/* 인증번호 맞는지 확인하는 함수 완료 */
	
	/* 회원가입 - 닉네임중복확인 버튼 시작 */
	$("#nickNameCheck").on("click", function(){
		
		var regNickName = /^[\wㄱ-ㅎㅏ-ㅣ가-힣]{2,20}$/;
		var nickName = $("#userNickName").val().trim();
		/* 아이디 유효성 검사 */
		if(!regNickName.test(nickName)){
			$("#nickName-help").text("별명은 특수문자를 제외한 2 ~ 20 글자로 입력해 주세요.");
			$("#nickName-help").removeClass("text-success");
			$('#nickName-help').addClass('text-danger');
			NICKNAME_OK = 0;
			return;
		}
		console.log("기모띵");
		console.log(nickName);
		$.ajax({
			url: "<%=request.getContextPath()%>/nickNameCheck.do",
			data: {nickName:nickName},
			success: function(data){
				console.log(data);
				
				/* 아이디 생성 가능 상태 */
				if(data == "true"){
					$("#nickName-help").text("멋진 별명이네요!");
					$("#nickName-help").removeClass("text-danger");
					$("#nickName-help").addClass("text-success");
					NICKNAME_OK = 1;
				}
				else if(data == "false"){
					$("#nickName-help").text("이미 사용중인 별명입니다.");
					$("#nickName-help").removeClass("text-success");
					$("#nickName-help").addClass("text-danger");
					NICKNAME_OK = 0;
				}
			}
		});
	});
	
	/* 회원가입 - 닉네임중복확인 버튼 완료 */
	
	
	/* form onsubmit 처리 함수 시작 */
	function updateUserSubmit(){
		console.log(ID_OK , USERPASSWORD_OK , USEREMAIL_OK , AUTH_OK);
		if(USERPASSWORD_OK == 1 && USEREMAIL_OK == 1 && AUTH_OK == 1 && NICKNAME_OK == 1){
			return true;
		}
		alert("모든 입력사항을 제대로 입력 하십시오.");
		return false;
	}
	

	/* 회원가입 - 중복확인 버튼 완료 */
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
