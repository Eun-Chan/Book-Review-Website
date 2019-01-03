<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.brw.dto.ReviewBoardDTO" %>

<%
	// FrontController에서 보낸 list 받기
	List<ReviewBoardDTO> list = (List<ReviewBoardDTO>)request.getAttribute("list");
	String pageBar = (String)request.getAttribute("pageBar");
	
	String searchType = request.getParameter("searchType");
	String searchKeyword = request.getParameter("searchKeyword");
%>

<link rel="stylesheet" href="<%=request.getContextPath() %>/css/bootstrap.css" />
<script src="<%=request.getContextPath() %>/js/jquery-3.3.1.js"></script>
<script src="<%=request.getContextPath() %>/js/bootstrap.js"></script>
<style>
div#search-rbbooktitle{
	display: <%="rb_booktitle".equals(searchType)?"inline-block":"none"%>;
}
div#search-rbtitle{
	display: <%="rb_title".equals(searchType)?"inline-block":"none"%>;
}
</style>
<script>
// 인덱스로 이동하는 함수
function goHome(){
	location.href="<%=request.getContextPath() %>";
}
// 검색 후 알맞은 검색폼 보여주기
$(function(){
	var sRbbooktitle = $("#search-rb_booktitle");
	var sRbtitle = $("#search-rb_title");
	
	$("select#searchType").change(function(){
		sRbbooktitle.hide();
		sRbtitle.hide();
		
		$("#search-"+$(this).val()).css("display","inline-block");
	});
});
</script>
<style>
div#search-rb_booktitle{
	display: inline-block;
}
div#search-rb_title{
	display: none;
}
</style>

<div id="review-list-container" class="container-fluid">
	<h2 class="text-primary">리뷰게시판</h2>
	<button class="btn btn-primary" onclick="goHome();">메인으로</button>
	<br /><br />
	<!-- 진행 상황(기능만) -->
	<div class="progress">
		<div class="progress-bar progress-bar-striped progress-bar-animated" style="width: 80%">80%</div>
	</div>
	<br />
	
	<!-- 리뷰 리스트를 보여줄 테이블 영역 -->
	<div id="table-container">
		<table class="table table-hover table-info" id="test-table">
			<thead>
				<tr>
					<th>no</th>
					<th>도서명</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
					<th>추천수</th>
				</tr>
			</thead>
			<tbody>
			<% for(ReviewBoardDTO rb : list) { %>
				<tr>
					<td><%=rb.getRbNo() %></td>
					<td><%=rb.getRbBookTitle()%></td>
					<td><%=rb.getRbTitle() %></td>
					<td><%=rb.getRbWriter() %></td>
					<td><%=rb.getRbDate() %></td>
					<td><%=rb.getRbReadCnt() %></td>
					<td><%=rb.getRbRecommend() %></td>
				</tr>
			<% } %>
			</tbody>
		</table>
	</div> <!-- end of #table-container -->
	
	<!-- 페이지바 영역 --> 
	<div id="pagebar-container text-center">
		<%=pageBar %>
	</div>
	
	<!-- 검색 영역 -->
	<div id="search-form-container">
		<!-- 검색 타입 셀렉트 -->
		<select id="searchType">
			<option value="rb_booktitle" <%="rb_booktitle".equals(searchType)?"selected":"" %>>도서명</option>
			<option value="rb_title" <%="rb_title".equals(searchType)?"selected":"" %>>글 제목</option>
		</select>
		<div id="search-rb_booktitle">
			<form action="<%=request.getContextPath()%>/review/reviewSearch.do">
				<input type="hidden" name="searchType" value="rb_booktitle"/>
				<input type="text" name="searchKeyword" value="<%="rb_booktitle".equals(searchType)?searchKeyword:""%>"/>
				<button type="submit">검색</button>
			</form>
		</div>
		<div id="search-rb_title">
			<form action="<%=request.getContextPath()%>/review/reviewSearch.do">
				<input type="hidden" name="searchType" value="rb_title"/>
				<input type="text" name="searchKeyword" value="<%="rb_title".equals(searchType)?searchKeyword:""%>"/>
				<button type="submit">검색</button>
			</form>
		</div>
	</div>
	
</div> <!-- end of #review-list-container -->


