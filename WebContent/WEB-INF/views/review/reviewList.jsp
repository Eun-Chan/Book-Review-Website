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
<script>
// 인덱스로 이동하는 함수
function goHome(){
	location.href="<%=request.getContextPath() %>";
}
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
		<select id="searchType">
			<option value="book" <%="book".equals(searchType)?"selected":"" %>>도서명</option>
			<option value="rbTitle" <%="rbTitle".equals(searchType)?"selected":"" %>>제목</option>
		</select>
		<div id="search-rb_booktitle">
			<form action="<%=request.getContextPath()%>/review/reviewSearch.do">
				<input type="hidden" name="searchType" value="rb_booktitle"/>
				<input type="text" name="searchKeyword" value="<%="book_booktitle".equals(searchType)?searchKeyword:""%>"/>
				<button type="submit">검색</button>
			</form>
		</div>
		<div id="search-rb_title">
			<form action="<%=request.getContextPath()%>/review/reviewSearch.do">
				<input type="hidden" name="searchType" value="rb_title"/>
				<input type="text" name="searchKeyword" value="<%="rb_Title".equals(searchType)?searchKeyword:""%>"/>
				<button type="submit">검색</button>
			</form>
		</div>
	</div>
	
</div> <!-- end of #review-list-container -->
<!-- 테스트 -->


