<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.brw.dto.*" %>
<%
 	ReviewBoardDTO review = (ReviewBoardDTO)request.getAttribute("review");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/reviewDetail.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/bootstrap.css" />
<script src="<%=request.getContextPath()%>/js/bootstrap.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery-3.3.1.js"></script>
<title>Insert title here</title>
</head>
<body>
	<div id ="reviewDetail">
		<div id ="reviewDetail-Header">
			<span id="date">작성일 : <%=review.getRbDate() %></span>
			<span id="comment">댓글 : <%=review.getRbReadCnt() %></span>
		</div>
		<div id ="reviewDetail-Title">
			<span>[리뷰]<%=review.getRbTitle() %></span>
		</div>
		<div id="reviewDetail-Writer">
			<span>작성자 : <%=review.getRbWriter() %></span>
			<hr />
		</div>
		<div id ="reviewDetail-Content">
			<p>
			<span>
				<%=review.getRbContent() %>
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
		<div id="side-menu">
			<ul id="left-menu">
				<li><a href="#" class="btn-gradient green">이전글</a></li>
				<li><a href="#" class="btn-gradient green">목록 </a></li>
				<li><a href="#" class="btn-gradient green">다음글</a></li>
			</ul>
			<ul id="right-menu">
				<li><a href="#" class="btn-gradient red">신고하기</a></li>
			</ul>
		</div>
		<div id ="comment-Content">
			<span>해당 글에대한 댓글 목록 보여주는 곳</span>
		</div>
		<div id ="comment-Area">
			<table>
				<tr>
					<td>
						<div id="comment-textArea">
							<textarea name="comment" id=""rows="3" cols="95">댓글은 로그인 후 이용 하실수 있습니다.</textarea>
						</div>
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