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
/* 검색창 보이기&보이지 않기 */
div#search-rb_booktitle{
	display: <%="rb_booktitle".equals(searchType)?"inline-block":"none"%>;
}
div#search-rb_title{
	display: <%="rb_title".equals(searchType)?"inline-block":"none"%>;
}

/* 테이블 영역 */
table#review-list-table th, table#review-list-table td {
	padding: 10px 5px 10px 0;
	font-size: 13px;
}

/* .form-group display: inline-block으로 수정 */
div.form-group {
	display: inline-block;
}

/* 검색창 */
div.search-bar {
	width: 400px;
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
$(function(){
	$("button#btn-write").on("click",function(){
		location.href="<%=request.getContextPath()%>/review/reviewWrite.do";
	});
});
</script>

<div id="review-list-container" class="container-fluid">
	<h2 class="text-primary">리뷰게시판</h2>
	<button class="btn btn-primary" onclick="goHome();">메인으로</button>
	<br /><br />
	구현 완성도
	<div class="progress">
		<div class="progress-bar progress-bar-striped active progress-bar-success" style="width: 90%">90%</div>
	</div>
	<br />
	
	<!-- 리뷰 리스트를 보여줄 테이블 영역 -->
	<div id="table-container">
		<table class="table table-hover table-info" id="review-list-table">
			<thead>
				<tr>
					<th>no</th>
					<th class="col-sm-2">도서명</th>
					<th class="col-sm-6">제목</th>
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
					<td><a href="<%=request.getContextPath()%>/review/reviewDetail.do?rbNo=<%=rb.getRbNo() %>"><%=rb.getRbTitle() %></a></td>
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
		<div class="form-group">
			<select id="searchType" class="form-control">
				<option value="rb_booktitle" <%="rb_booktitle".equals(searchType)?"selected":"" %>>도서명</option>
				<option value="rb_title" <%="rb_title".equals(searchType)?"selected":"" %>>제목</option>
			</select>
		</div>
		<div id="search-rb_booktitle">
			<form action="<%=request.getContextPath()%>/review/reviewSearch.do">
				<input type="hidden" name="searchType" value="rb_booktitle"/>
				<div class="form-group search-bar">
					<input type="text" name="searchKeyword" class="form-control" value="<%="rb_booktitle".equals(searchType)?searchKeyword:""%>"/>
				</div>
				<button type="submit" class="btn btn-default">검색</button>
				
			</form>
			
		</div>
		<div id="search-rb_title">
			<form action="<%=request.getContextPath()%>/review/reviewSearch.do">
				<input type="hidden" name="searchType" value="rb_title"/>
				<div class="form-group search-bar">
					<input type="text" name="searchKeyword" class="form-control" value="<%="rb_title".equals(searchType)?searchKeyword:""%>"/>
				</div>
				<button type="submit" class="btn btn-default">검색</button>
			</form>
		</div>
	</div>
	
	<!-- 글쓰기 버튼 영역 -->
	<div id="btn-write-container">
		<button id="btn-write" class="btn btn-success">리뷰 작성</button>
	</div>
	
</div> <!-- end of #review-list-container -->


