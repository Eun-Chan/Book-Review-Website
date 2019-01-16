<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.brw.dto.*" %>
<%
	
	// 해당 글번호에 맞는 공지사항 글
	NoticeDTO n = (NoticeDTO)request.getAttribute("notice");

%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/reviewDetail.css" />
<style>
footer{
	position: relative;
	top: 80px;
}
footer p{
	position: relative;
	bottom: 70px;
}
</style>
<script>
$(function(){
	// 공지사항 수정 버튼 리스너
	$("#btn-revise-notice").on("click",function(){
		location.href = "<%=request.getContextPath()%>/admin/noticeRevise.do?ntcNo=" + <%=n.getNtcNo()%>;
	});
	// 공지사항 삭제 버튼 리스너
	$("#btn-delete-notice").on("click",function(){
		location.href = "<%=request.getContextPath()%>/admin/noticeDelete.do?ntcNo=" + <%=n.getNtcNo()%>;
	});
});
</script>

	<div id ="reviewDetail">
		<div id ="reviewDetail-Header">
			<span id="date"><%=n.getNtcDate() %></span>
		</div>
		<div id ="reviewDetail-Title">
			<h2>
				<span>[공지]</span>
				<span><%=n.getNtcTitle() %></span>
			</h2>
		</div>
		<div id="reviewDetail-Writer">
			<div id="reviewDetail-booktitle">
				
			</div>
	       <div id="start-Container">
	       <div class="starRev0">
			  
			</div>
			 
		</div>
			<span>작성자 : <img src="<%=request.getContextPath() %>/images/userGradeImage/10.svg" alt="" width="25px" height="25px"/>관리자</span>
		</div>
		<hr id="bs_hr">
		<div id ="reviewDetail-Content">
			<p>
			<span>
				<%=n.getNtcContent() %>
			</span>
			</p>
		</div>
		<div id="side-menu">
			<ul id="left-menu">
				<li><a href="<%=request.getContextPath() %>/admin/noticeList.do" class="btn-gradient green">목록 </a></li>
			</ul>
			<ul id="right-menu">
				<li><button class="btn-gradient red" style ="float: right;">신고하기</button></li>
			<%if(user!=null && (user.getUserId().equals("admin"))){ %>
				<li><button id="btn-delete-notice" class="btn-gradient green" style="margin-right: 5px;">삭제</button></li>
				<li><button id="btn-revise-notice" class="btn-gradient green" style="margin-right: 5px;">수정</button></li>
			<%} %>
			</ul>
		</div>
		
	</div>	

	<script>
		//이름으로 검색하기 클릭시 처리
		$("#nameSearch").click(function(){
			var rbCommentWriter = $("#Writer").val();
			location.href="<%=request.getContextPath()%>/review/reviewSearch.do?searchType=rb_writer&searchKeyword="+rbCommentWriter;
		});
		
		

		//답글 textarea가 한번만 생성되고 생성 안되게 막는 코드
		$(document).one('click','.comment-recomment',function(){
			<%if(user==null){%>
				alert("로그인 후 이용 가능 합니다.");
				return;
			<%}%>
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
		
	</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
