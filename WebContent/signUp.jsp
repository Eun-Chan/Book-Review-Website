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
				<div class="col-sm-6">
					<input type="text" class="form-control" id="userId" name="userId" placeholder="아이디를 입력하세요"/>
					<p class="help-block">아이디 10 ~ 15자</p>
				</div>
			</div>
			<div class="form-group">
				<label for="userPassword" class="col-sm-2 control-label">비밀번호</label>
				<div class="col-sm-6">
					<input type="password" class="form-control" id="userPassword" name="userPassword" placeholder="비밀번호를 입력하세요"/>
					<p class="help-block">특수문자 포함 8자 이상</p>
				</div>
			</div>
			<div class="form-group">
				<label for="userName" class="col-sm-2 control-label">이름</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="userName" name="userName" placeholder="이름을 입력하세요"/>
				</div>
			</div>
			<div class="form-group">
				<label for="userEmail" class="col-sm-2 control-label">이메일</label>
				<div class="col-sm-6">
					<input type="email" class="form-control" id="userEmail" name="userEmail" placeholder="이메일"/>
				</div>
			</div>
			<div class="form-group">
				<label for="inputName" class="col-sm-2 control-label"></label>
				<div class="col-sm-6">
      				<button type="submit" class="btn btn-primary">회원가입</button>
      				<button type="button" class="btn btn-primary">취소하기</button>
    			</div>
			</div>
		</form>
	</article>
</div>
</body>
</html>