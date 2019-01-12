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

/* 테이블 최소 높이 지정 */
#table-container{
	min-height: 300px;
}

</style>
<script>
$(function(){
	// 공지 관리 라디오 버튼 리스너
	$("input:radio").on("click",function(){
		var ntcNo = $(this).parents("form").attr("id");
		var ntcAllowView = $(this).val();
		console.log(ntcAllowView);
		$.ajax({
			url: "<%=request.getContextPath()%>/admin/noticeUpdateAllowView.do",
			data: {ntcNo: ntcNo, ntcAllowView: ntcAllowView},
			success: function(data){
				console.log("hi");
			}
		});
	});
});
</script>

<div id="notice-manager-container" class="container-fluid">

	<h2>공지사항</h2>
	
	<!-- 공지사항 리스트를 보여줄 테이블 영역 -->
	<div id="table-container">
		<table class="table table-hover table-info table-responsive"
			id="notice-list-table">
			<thead>
				<tr>
					<% if(user != null && "admin".equals(user.getUserId())) { %>
					<th class="text-center w150">no</th>
					<th class="text-center w370">제목</th>
					<th class="w150">작성자</th>
					<th class="text-center w100">작성일</th>
					<th class="text-center w50">조회수</th>
					<!-- 라디오버튼으로 해서 공지사항게시판이 아닌 다른 게시판에서 보여줄 공지, 보여주지 않을 공지를 
					선택하고 저장하면 공지사항을 제외한 다른 게시판에서 보여줄 공지만 보여주게 된다. -->
					<th class="text-center w100">공지 관리</th>
					<% }
					   else if (user == null || !"admin".equals(user.getUserId())) { %>
					<th class="text-center w150">no</th>
					<th class="text-center w370">제목</th>
					<th class="w150">작성자</th>
					<th class="text-center w150">작성일</th>
					<th class="text-center w100">조회수</th>
					<% } %>
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
					<!-- 관리자일 경우 공지관리하는 라디오버튼 열 추가 -->
					<% if(user != null && "admin".equals(user.getUserId())) { %>
					<td class="text-center">
						<form id="<%=n.getNtcNo()%>">
							<div class="radio">
						      <label><input type="radio" name="optradio" <%="Y".equals(n.getNtcAllowview())?"checked":""%> value="Y">공지 보이기</label>
						    </div>
						    <div class="radio">
						      <label><input type="radio" name="optradio" <%="N".equals(n.getNtcAllowview())?"checked":""%> value="N">공지 감추기</label>
						    </div>
					    </form>
					</td>
					<% } %>
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

	<% if(user != null && "admin".equals(user.getUserId())) { %>
	<!-- 글쓰기 버튼 영역 -->
	<div id="btn-write-container">
		<button id="btn-write" class="btn btn-success">공지사항 등록</button>
	</div>
	<% } %>
	<!-- 페이지바 영역 -->
	<div id="pagebar-container" class="text-center">
		<%=pageBar %>
	</div>


</div>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>