<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
	// FrontController에서 보낸 list 받기
	List<ReviewBoardViewDTO> list = (List<ReviewBoardViewDTO>)request.getAttribute("list");
	List<NoticeDTO> ntcList = (List<NoticeDTO>)request.getAttribute("ntcList");
	String pageBar = (String)request.getAttribute("pageBar");
	
	String searchType = request.getParameter("searchType");
	String searchKeyword = request.getParameter("searchKeyword");
%>

<style>
/* 컨테이너 너비 조정 */
div#review-list-container {
	width: 950px;
}

/* 검색창 보이기&보이지 않기 */
div#search-rb_booktitle, div#search-rb_writer, div#search-userNickName {
	display: none;
}

/* 검색관련 div */
div#search-rb_title {
	display: inline-block;
}

/* 게시판 컬럼별 너무길면 ... 으로 표시 */
table#review-list-table tbody tr td.booktitle {
	text-overflow: ellipsis;
	white-space: nowrap;
	overflow: hidden;
	display: inline-block;
	position: relative;
	padding-top: 16px;
}

/* 테이블 영역 */
table#review-list-table th, table#review-list-table td {
	/* padding: 10px 5px 10px 0; */
	font-size: 13px;
	vertical-align: middle;
}

/* .divInline display: inline-block으로 수정 */
div.divInline {
	display: inline-block;
}

/* 검색창 */
div.search-bar {
	width: 400px;
}

/* 게시판 테이블 th 색깔 지정 */
table#review-list-table thead tr {
	background: #004183;
	color: white;
}

/* 글쓰기 버튼 위치 */
div#btn-write-container {
	position: relative;
	top: -50px;
	left: 840px;
}

/* 게시판 새 글 new 표시 */
span.smft {
	font-size: 11px;
}

/* 게시판 너비 조정 */
th.w50 {
	width: 50px;
}

th.w220, td.w220 {
	width: 220px;
}

th.w300 {
	width: 300px;
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

/* 광준이가 헤더에 똑같은 아이디로 속성을 줘서 변경 */
#searchType {
	margin: 0;
}

/* 테이블 최소 높이 지정 */
#table-container{
	min-height: 300px;
}
</style>
<script>
$(function(){
	// 셀렉트태그 변경 리스너
	var sRbbooktitle = $("#search-rb_booktitle");
	var sRbtitle = $("#search-rb_title");
	var sUserNickName = $("#search-userNickName");
	var sRbwriter = $("#search-rb_writer");
	
	$("select#searchType").change(function(){
		sRbbooktitle.hide();
		sRbtitle.hide();
		sUserNickName.hide();
		sRbwriter.hide();
		
		$("#search-"+$(this).val()).css("display","inline-block");
	});
	
	// 로그인을 했으면 리뷰작성 페이지로 이동
	$("button#btn-write").on("click",function(){
		<%
		if(user == null){
		%>
		alert("로그인 후 이용하세요.");
		return;
		<%
		}
		%>
		location.href="<%=request.getContextPath()%>/review/reviewWrite.do";
	});
});

</script>

<div id="review-list-container" class="container-fluid">
	<h2 class="text-primary">리뷰게시판</h2>

	<!-- 리뷰 리스트를 보여줄 테이블 영역 -->
	<div id="table-container">
		<table class="table table-hover table-info table-responsive"
			id="review-list-table">
			<thead>
				<tr>
					<th class="text-center w50">no</th>
					<th class="text-center w220">도서명</th>
					<th class="text-center w300">제목</th>
					<th class="w150">작성자</th>
					<th class="text-center w100">작성일</th>
					<th class="text-center w50">조회수</th>
					<th class="text-center w50">추천수</th>
				</tr>
			</thead>
			<tbody>
				<% for(NoticeDTO n : ntcList) { %>
				<tr class="notice">
					<td class="text-center" colspan="2"><span class="badge">공지사항</span></td>
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
					<td class="text-center">-</td>
				</tr>
				<% } %>
				<% for(ReviewBoardViewDTO rbv : list) { %>
				<tr>
					<td class="text-center"><%=rbv.getRbNo() %></td>
					<td class="w220 booktitle"><%=rbv.getRbBookTitle()%></td>
					<td>
						<a href="<%=request.getContextPath()%>/review/reviewDetail.do?rbNo=<%=rbv.getRbNo() %>"><%=rbv.getRbTitle() %></a>
						<span class="smft"><%=rbv.getCommentCnt()>0?"+" + rbv.getCommentCnt():"" %></span>
						<%=rbv.isDateNew()?"<span class='mark smft'>new</span>":"" %>
					</td>
					<td>
						<img src="<%=request.getContextPath()%>/images/userGradeImage/<%=rbv.getUserGrade()%>.svg" width='30px' height='30px' alt='userGrade icon'>
						<%=rbv.getUserNickName() %>
					</td>
					<td class="text-center"><%=rbv.getRbDate() %></td>
					<td class="text-center"><%=rbv.getRbReadCnt() %></td>
					<td class="text-center"><%=rbv.getRbRecommend() %></td>
				</tr>
				<% } %>
			</tbody>
		</table>
	</div>
	<!-- end of #table-container -->



	<!-- 검색 영역 -->
	<div id="search-form-container" class="text-center">
		<!-- 검색 타입 셀렉트 -->
		<div class="form-group divInline">
			<select id="searchType" class="form-control">
				<option value="rb_title" <%="rb_title".equals(searchType)?"selected":"" %>>제목</option>
				<option value="rb_booktitle" <%="rb_booktitle".equals(searchType)?"selected":"" %>>도서명</option>
				<option value="userNickName" <%="userNickName".equals(searchType)?"selected":"" %>>닉네임</option>
				<option value="rb_writer" <%="rb_writer".equals(searchType)?"selected":"" %>>아이디</option>
			</select>
		</div>
		<div id="search-rb_booktitle">
			<form action="<%=request.getContextPath()%>/review/reviewSearch.do">
				<input type="hidden" name="searchType" value="rb_booktitle" />
				<div class="form-group search-bar divInline">
					<input type="text" name="searchKeyword" class="form-control"
						value="<%="rb_booktitle".equals(searchType)?searchKeyword:""%>" />
				</div>
				<button type="submit" class="btn btn-default">검색</button>

			</form>

		</div>
		<div id="search-rb_title">
			<form action="<%=request.getContextPath()%>/review/reviewSearch.do">
				<input type="hidden" name="searchType" value="rb_title" />
				<div class="form-group search-bar divInline">
					<input type="text" name="searchKeyword" class="form-control"
						value="<%="rb_title".equals(searchType)?searchKeyword:""%>" />
				</div>
				<button type="submit" class="btn btn-default">검색</button>
			</form>
		</div>
		<div id="search-userNickName">
			<form action="<%=request.getContextPath()%>/review/reviewSearch.do">
				<input type="hidden" name="searchType" value="userNickName" />
				<div class="form-group search-bar divInline">
					<input type="text" name="searchKeyword" class="form-control"
						value="<%="userNickName".equals(searchType)?searchKeyword:""%>" />
				</div>
				<button type="submit" class="btn btn-default">검색</button>
			</form>
		</div>
		<div id="search-rb_writer">
			<form action="<%=request.getContextPath()%>/review/reviewSearch.do">
				<input type="hidden" name="searchType" value="rb_writer" />
				<div class="form-group search-bar divInline">
					<input type="text" name="searchKeyword" class="form-control"
						value="<%="rb_writer".equals(searchType)?searchKeyword:""%>" />
				</div>
				<button type="submit" class="btn btn-default">검색</button>
			</form>
		</div>

	</div>

	<!-- 글쓰기 버튼 영역 -->
	<div id="btn-write-container">
		<button id="btn-write" class="btn btn-success">리뷰 작성</button>
	</div>



	<!-- 페이지바 영역 -->
	<div id="pagebar-container" class="text-center">
		<%=pageBar %>
	</div>


</div>
<!-- end of #review-list-container -->
<!-- 테스트 -->
<%@ include file="/WEB-INF/views/common/footer.jsp"%>