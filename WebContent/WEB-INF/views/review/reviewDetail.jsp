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
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/bootstrap.css" />
<script src="<%=request.getContextPath()%>/js/bootstrap.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/reviewDetail.css" />
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
			<div id="comment-list">
				<ul>
					<li>
						<div id="comment-html">
							<div id="comment-header">
								<span>댓글 작성자</span>
								<span>댓글 작성날짜</span>
							</div>
							<div id ="comment-body">
								<span>댓글 내용!!</span>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
		<div id ="comment-Area">
			<table>
				<tr>
					<td>
						<div id="comment-textArea">
							<textarea name="comment" id="comment-area"rows="3" cols="95"></textarea>
						</div>
					</td>	
				<td>
					<input type="button" value="등록" id="comment-button"/>
				</td>
				</tr>
			</table>
		</div>
	</div>
	<script>
		
		$("#comment-button").on('click',function(){
			if($("#comment-area").val().trim().length ==0){
				alert("댓글을 입력해 주세요.");
				return;
			}
			else{
				var textAreaVal = $("#comment-area").val();
				$.ajax({
					url:"<%=request.getContextPath()%>/insertComment.do?rbNo=<%=review.getRbNo()%>&rbCommentContent="+textAreaVal+"&rbCommentWriter=kmw0422",
					success:function(data){
						console.log(data);
					}
				});
			}
			
		});
	</script>
</body>
</html>