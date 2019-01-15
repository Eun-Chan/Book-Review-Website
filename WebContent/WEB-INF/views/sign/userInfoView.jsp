<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	String nowUser = user.getUserId();
%>
<body>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/userInfoView.css" />


<table class="table" id="myInfoPage-Container">
	<!-- 구분 -->
	<div id="post-Container">
		<h3>내가 쓴 리뷰 글</h3>
		<table class="table" id="myReviewTable">
			<th>번호</th>
			<th>도서명</th>
			<th>제목</th>
			<th>작성일</th>
			<th>조회수</th>
			<th>추천수</th>
		</table>
	</div>
	<div id="reple-Container">
		<table class="table" id="myreple-Table">
			<h3>내가 쓴 댓글</h3>
			<th>번호</th>
			<th>제목</th>
			<th>내용</th>
			<th>작성일</th>
			<th>조회수</th>
			<th>추천수</th>
		</table>
	</div>
	
	<!-- 내용 : ajax 처리 -->
</table>

<script>
$(document).ready(function(){
	$.ajax({
		type: 'post',
		url: '<%=request.getContextPath()%>/sign/userInfoViewJoin.do?nowUser=<%=nowUser%>',
		contentType: 'application/json; charset=utf-8;',
		success: function(data)
		{
			/*작성한 글 조회*/
			for(var i in data[0])
			{
				$("#myReviewTable").append("<tr class='myReviewContent' id='myReviewContent"+i+"'><td>"+data[0][i].rb_no+"</td><td>"+data[0][i].rb_booktitle+"</td><td>"+data[0][i].rb_title+"</td><td>"+data[0][i].rb_date+"</td><td>"+data[0][i].rb_readcnt+"</td><td>"+data[0][i].rb_recommend+"</td></tr>");
				linkAdd(data[0][i].rb_no, i, true);
			}
			/*작성한 댓글 조회*/
			for(var i in data[1])
			{
				$("#myreple-Table").append("<tr class='myReivewComment' id='myReivewComment"+i+"'><td>"+data[1][i].rb_no+"</td><td>"+data[1][i].rb_title+"</td><td>"+data[1][i].rb_comment_content+"</td><td>"+data[1][i].rb_comment_date+"</td><td>"+data[1][i].rb_readcnt+"</td><td>"+data[1][i].rb_recommend+"</td></tr>");
				linkAdd(data[1][i].rb_no, i, false);
			}
		},
		error: function()
		{
			console.log("내 정보보기 페이지 로딩에 실패했습니다.@userInfoView.jsp");
		}
	});
	
	
	
});
/*게시글의 링크를 연결하는 함수*/
function linkAdd(rbNo_parameter, i, typeReview)
{
	if(typeReview == true)
	{
		$("#myReviewContent"+i).click(function(){
			location.href = "<%=request.getContextPath()%>/review/reviewDetail.do?rbNo="+rbNo_parameter;
		});	
	}
	else if(typeReview == false)
	{
		$("#myReivewComment"+i).click(function(){
			location.href = "<%=request.getContextPath()%>/review/reviewDetail.do?rbNo="+rbNo_parameter;
		});
	}
	
}

</script>
</body>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>