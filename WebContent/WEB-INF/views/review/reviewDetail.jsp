<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/reviewDetail.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/bootstrap.css" />
<script src="<%=request.getContextPath()%>/js/bootstrap.js"></script>
<title>Insert title here</title>
</head>
<body>
	<div id ="reviewDetail">
		<div id ="reviewDetail-Header">
			<span id="date">작성일 : yyyy-mm-dd</span>
			<span id="comment">댓글 : (댓글 갯수)</span>
		</div>
		<div id ="reviewDetail-Title">
			<span>제목 : 제목이다아아아아아아아아</span>
		</div>
		<div id="reviewDetail-Writer">
			작성자는 나다임마.
			<hr />
		</div>
		<div id ="reviewDetail-Content">
			<p>
			<span>
				리뷰게시판 매인 컨텐츠
				ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ
				ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ
				ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ
				ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ	ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ
			</span>
			</p>
			<div id="like-Wapper" >
				<div id ="like">
					<br />
					<span>0</span>
					<br />
					<img src="<%=request.getContextPath() %>/images/heart.png" alt="" style="width: 15px;height: 12px;margin-top: 10px;margin-right:2px"/>
				</div>
			</div>
		</div>
		<div id ="comment-Content">
			<span>해당 글에대한 댓글 목록 보여주는 곳</span>
		</div>
		<div id ="comment-Area">
			<table>
				<tr>
				<td>
				<textarea name="comment" id="" cols="70" rows="3">댓글은 로그인 후 이용 하실수 있습니다.</textarea>
				</td>	
				<td>
					<input type="button" value="등록" />
				</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>