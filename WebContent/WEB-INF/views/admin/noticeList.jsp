<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
	List<NoticeDTO> ntcList = (List<NoticeDTO>)request.getAttribute("ntcList");
	String pageBar = (String)request.getAttribute("pageBar");
	
	String searchKeyword = request.getParameter("searchKeyword");
	
%>
<style>
/* 컨테이너 너비 조정 */
div#notice-manager-container {
	width: 950px;
}

/* 테이블 영역 */
table#notice-list-table th, table#notice-list-table td {
	/* padding: 10px 5px 10px 0; */
	font-size: 13px;
	vertical-align: middle;
}

/* 게시판 새 글 new 표시 */
span.smft {
	font-size: 11px;
}

/* 게시판 너비 조정 */
th.w200 {
	width: 200px;
}
th.w370 {
	width: 370px;
}
th.w150 {
	width: 150px;
}
th.w100 {
	width: 100px;
}

/* 공지사항용 tr 색 지정 */
tr.notice{
	background: #a6ceff7d;
}

/* 게시판 테이블 th 색깔 지정 */
table#notice-list-table thead tr {
	background: #004183;
	color: white;
}

/* 글쓰기 버튼 위치 */
div#btn-write-container {
	position: relative;
	top: -50px;
	left: 815px;
}

/* 검색관련 div */
div#search-ntc_title {
	display: inline-block;
}

/* .divInline display: inline-block으로 수정 */
div.divInline {
	display: inline-block;
}

/* 검색창 너비 조절*/
div.search-bar {
	width: 400px;
}

/* 광준이가 헤더에 똑같은 아이디로 속성을 줘서 변경 */
#searchType {
	margin: 0;
}

</style>

<div id="notice-manager-container" class="container-fluid">

	<h2>공지사항 관리</h2>
	
	<!-- 공지사항 리스트를 보여줄 테이블 영역 -->
	<div id="table-container">
		<table class="table table-hover table-info table-responsive"
			id="notice-list-table">
			<thead>
				<tr>
					<th class="text-center w150">no</th>
					<th class="text-center w370">제목</th>
					<th class="w150">작성자</th>
					<th class="text-center w150">작성일</th>
					<th class="text-center w100">조회수</th>
				</tr>
			</thead>
			<tbody>
				<% for(NoticeDTO n : ntcList) { %>
				<tr class="notice">
					<td class="text-center"><%=n.getNtcNo() %></td>
					<td>
						<a href="<%=request.getContextPath()%>/admin/noticeDetail.do?ntcNo=<%=n.getNtcNo()%>"><%=n.getNtcTitle() %></a>
						<%=n.isDateNew()?"<span class='mark smft'>new</span>":"" %>
					</td>
					<td>
						<img src="<%=request.getContextPath()%>/images/userGradeImage/10.svg" width='30px' height='30px' alt='userGrade icon'>
						관리자
					</td>
					<td class="text-center"><%=n.getNtcDate() %></td>
					<td class="text-center"><%=n.getNtcReadcnt() %></td>
				</tr>
				<% } %>
			</tbody>
		</table>
	</div>
	<!-- end of #table-container -->

	<!-- 검색 영역 -->
	<div id="search-form-container" class="text-center">
		<div id="search-ntc_title">
			<form action="<%=request.getContextPath()%>/admin/noticeSearch.do">
				<div class="form-group search-bar divInline">
					<input type="text" name="searchKeyword" class="form-control"
						placeholder="제목 검색"/>
				</div>
				<button type="submit" class="btn btn-default">검색</button>
			</form>
		</div>

	</div>

	<!-- 글쓰기 버튼 영역 -->
	<div id="btn-write-container">
		<button id="btn-write" class="btn btn-success">공지사항 작성</button>
	</div>
	
	<!-- 페이지바 영역 -->
	<div id="pagebar-container" class="text-center">
		<%=pageBar %>
	</div>


</div>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>