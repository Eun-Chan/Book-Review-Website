<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 반응형 웹을 위한 메타태그 -->
<meta name="viewport" content="width=device-width", initial-scral="1">
<title>회원 가입</title>
<link rel="stylesheet" href="css/bootstrap.css">
</head>
<body>
<div class="contentwrap">
	<article class="container">
		<div class="page-header">
			<h1>회원가입</h1>
		</div>
		<form action="" class="form-horizontal">
			<div class="form-group">
				<label for="userId" class="col-sm-2 control-label">아이디</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="userId" name="userId" placeholder="아이디를 입력하세요"/>
					<span><p class="" id="id-help"></p></span>
				</div>
				<div class="col-sm-1">
					<button type="button" class="btn btn-default" id="idCheck">중복 확인</button>
				</div>
			</div>
			<div class="form-group">
				<label for="userPassword" class="col-sm-2 control-label">비밀번호</label>
				<div class="col-sm-4">
					<input type="password" class="form-control" id="userPassword" name="userPassword" placeholder="비밀번호를 입력하세요"/>
					<p class="help-block">특수문자 포함 8자 이상</p>
				</div>
			</div>
			<div class="form-group">
				<label for="userPasswordOk" class="col-sm-2 control-label">비밀번호 확인</label>
				<div class="col-sm-4">
					<input type="password" class="form-control" id="userPasswordOk" name="userPasswordOk" placeholder="비밀번호를 다시입력하세요"/>
				</div>
			</div>
			<br />
			<div class="form-group">
				<label for="userName" class="col-sm-2 control-label">이름</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="userName" name="userName" placeholder="이름을 입력하세요"/>
				</div>
			</div>
			<div class="form-group">
				<label for="userEmail" class="col-sm-2 control-label">이메일</label>
				<div class="col-sm-4">
					<input type="email" class="form-control" id="userEmail" name="userEmail" placeholder="이메일"/>
				</div>
				<div class="col-sm-1">
					<button type="button" class="btn btn-default">이메일 인증</button>
				</div>
			</div>
			<div class="form-group">
				<label for="inputName" class="col-sm-2 control-label"></label>
				<div class="col-sm-6">
      				<button type="submit" class="btn btn-primary">회원가입</button>
      				<button type="button" class="btn btn-primary" onclick="location.href='index.jsp'">취소하기</button>
    			</div>
			</div>
		</form>
	</article>
</div>

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>

<script>
	/* 회원가입 - 중복확인 버튼 */
	$("#idCheck").on("click", function(){
		var userId = $("#userId").val().trim();
		/* 사용자가 7자리 이하를 입력할 경우 , ajax 요청 x */
		if(userId.length < 8){
			$("#id-help").text("8~15자의 영문 소문자, 숫자와 특수기호(_),(-)만 가능합니다.");
			$("#id-help").removeClass("text-success");
			$('#id-help').addClass('text-danger');
			return;	
		}	
		$.ajax({
			url: "<%=request.getContextPath()%>/idCheck.do",
			data: {userId:userId},
			success: function(data){
				console.log(data);
				
				/* 아이디 생성 가능 상태 */
				if(data == "true"){
					$("#id-help").text("멋진 아이디네요!");
					$("#id-help").removeClass("text-danger");
					$("#id-help").addClass("text-success");
				}
				else if(data == "false"){
					$("#id-help").text("이미 사용중인 아이디거나 탈퇴된 아이디입니다.");
					$("#id-help").removeClass("text-success");
					$("#id-help").addClass("text-danger");
				}
			}
		});
	});
	
	/* 회원가입 - 중복확인 버튼 완료 */
	$("#userPassword").keyup(function(e){
		console.log(e.key);
		
		var pwdLength = $(this).val().trim();
	});
	
	
</script>

</body>
</html>