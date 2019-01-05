<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.brw.dto.*" %>
<%
 	ReviewBoardDTO review = (ReviewBoardDTO)request.getAttribute("review");
	List<ReviewBoardComment> reviewComment = (List<ReviewBoardComment>)request.getAttribute("reviewComment");
	List<ReviewBoardComment> reviewReComment = (List<ReviewBoardComment>)request.getAttribute("reviewReComment");
	int count = (int)request.getAttribute("count");
	ReviewBoardComment lastReviewComment = (ReviewBoardComment)request.getAttribute("lastReviewComment");
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
			<span id="comment">댓글 : <%=count %></span>
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
				<li><a href="<%=request.getContextPath()%>/review/reviewList.do" class="btn-gradient green">목록 </a></li>
				<li><a href="#" class="btn-gradient green">다음글</a></li>
			</ul>
			<ul id="right-menu">
				<li><a href="#" class="btn-gradient red">신고하기</a></li>
			</ul>
		</div>
		<div id ="comment-Content">
		<%if(reviewComment!=null) {%>
			<%for(ReviewBoardComment rbc : reviewComment){ %>
			<div id="comment-list">
				<ul>
					<li>
						<div id="comment-html">
							<div id="comment-header">
								<span><%=rbc.getRbCommentWriter() %></span>
								<span style="font-size:0.8em;"><%=rbc.getRbCommentDate() %></span>
							</div>
							<div id ="comment-body">
								<span><%=rbc.getRbCommentContent() %></span>
							</div>
							<button class="comment-recomment" value="<%=rbc.getRbCommentNo()%>"> 
								[답글]
							</button>
						</div>
					</li>
				</ul>
		<%if(reviewReComment!=null) {%>
			<%for(ReviewBoardComment rbrc : reviewReComment) {%>
				<%if(rbrc.getRbCommentRef()==rbc.getRbCommentNo()) {%>
					<div id ="recomment-list">
						<ul>
							<li>
								<div id="recomment-html">
									<div id="recomment-header">
										<span><%=rbrc.getRbCommentWriter() %></span>
										<span><%=rbrc.getRbCommentDate() %></span>
									</div>
									<div id="recomment-body">
											<span><%=rbrc.getRbCommentContent() %></span>
									</div>
								</div>
							</li>
						</ul>				
					</div>
				<%} %>
			<%} %>
		<%} %>
		</div>
		<%} %>
	<%} %>
	</div>
		<div id ="comment-Area">
			<table>
				<tr>
					<td>
						<div id="comment-textArea">
							<textarea name="comment" id="comment-area"rows="3" cols="90"></textarea>
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
		var result = 0;
		$("#comment-button").on('click',function(){
			if($("#comment-area").val().trim().length ==0){
				alert("댓글을 입력해 주세요.");
				return;
			}
			else{
				var textAreaVal = $("#comment-area").val();
				$.ajax({
					url:"<%=request.getContextPath()%>/insertComment.do?rbNo=<%=review.getRbNo()%>&rbCommentContent="+textAreaVal+"&rbCommentWriter=ikso2000",
					success:function(data){
						$("#comment-area").val("");
						var div =$("<div id='comment-list'></div>");
						var html ="";
						if(data!=null){
							html+= "<ul><li><div id='comment-html'><div id='comment-header'><span>"+data.rbCommentWriter+"</span> <span>"+data.rbCommentDate+"</span></div>";
							html+= "<div id='comment-body'><span>"+data.rbCommentContent+"</span></div><button class='comment-recomment' value="+data.rbCommentNo+">[답글]</button></div></li></ul>";
							div.append(html);
							$("#comment-Content").append(div);
						}
					}
				});
			}
		});

		$(document).on('click','.comment-recomment',function(){
			var div =$("<div class ='recomment-Area'></div>");
			var html ="";
			html +="<table><tr><td><div class='recomment-textArea'><textarea name='recomment' id='recomment-area' rows='3' cols='75'></textarea></div></td>";
			html +="<td><button value='"+$(this).val()+"'class='recomment-button'>등록</button></td></tr></table>";
			div.append(html);
/* 			$("#comment-Content").append(div); */
			div.insertAfter($(this).parent().parent()).children("div").slideDown(800);
			// 핸들러 한 번 실행 후 제거
			$(this).off("click");
		});
		
		$(document).on('click',".recomment-button",function(){
			console.log("앙기모띵")
			if($("#recomment-area").val().trim().length==0){
				alert("댓글을 입력해 주세요.");
				return;
			}
			else
			{
				var reCommendArea = $("#recomment-area").val();
				$.ajax({
					url:"<%=request.getContextPath()%>/insertReComment.do?rbCommentNo="+$(this).val()+"&rbCommentContent="+reCommendArea+"&rbCommentWriter=ikso2000&rbNo=<%=review.getRbNo()%>",
					success:function(data){
						console.log("에이잭스실행완료");
						var div =$("<div id='recomment-list'></div>");
						var html ="";
						if(data!=null){
							html+= "<ul><li><div id='recomment-html'><div id='recomment-header'><span>"+data.rbCommentWriter+"</span> <span>"+data.rbCommentDate+"</span></div>";
							html+= "<div id='recomment-body'><span>"+data.rbCommentContent+"</span></div></div></li></ul>";
							div.append(html);
						}
						$("#recomment-area").parents("#comment-list").append(div);
						$(".recomment-Area").remove();
						console.log(data);
					}
				});	
			}
		});
	</script>
</body>
</html>