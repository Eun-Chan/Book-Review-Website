<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/bootstrap.css" />
<script src="<%=request.getContextPath() %>/js/jquery-3.3.1.js"></script>
<script src="<%=request.getContextPath() %>/js/bootstrap.js"></script>
<script>
function goHome(){
	location.href="<%=request.getContextPath() %>";
}
</script>
<div id="review-list-container" class="container-fluid">
	<h2 class="text-primary">리뷰게시판</h2>
	<button class="btn btn-primary" onclick="goHome();">메인으로</button>
	<br /><br />
	<div class="progress">
		<div class="progress-bar progress-bar-striped progress-bar-animated" style="width: 70%">70%</div>
	</div>
	<br />
	<table class="table table-hover table-info" id="test-table">
		<thead>
			<tr>
				<th>no</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
				<th>추천수</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>
</div>

<script>
$.ajax({
	url: "getReviewList.ajax",
	success: function(data){
		console.log(data);
		var tr = "";
		for(var i in data){
			var r = data[i];
			tr += "<tr><td>" + r.reviewNo + "</td><td>" + r.reviewTitle + "</td><td>" + r.reviewWriter
					+ "</td><td>" + r.reviewDate + "</td><td>" + r.reviewReadCnt + "</td><td>" + r.reviewRecommend + "</td></tr>";
		}
		$("#test-table").find("tbody").append(tr);
	}
});
</script>


