<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>즐겨찾기 페이지</title>
<script src = "<%=request.getContextPath()%>/js/jquery-3.3.1.js"></script>
<style>
table th, tr, td {
	border : 1px solid black;
}
</style>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/custom.css">
</head>
<body>
	<div id="basketInfo">
		<h2><%=user.getUserName()%>님의 즐겨찾기입니다.</h2>
	</div>
	<div id="basketList"></div>
	<input type="button" value="삭제" id="delbutton"/>
<script>

var userId = "<%=user.getUserId()%>";
console.log(userId)
$.ajax({
	url : "<%=request.getContextPath()%>/book/bookbasket.do",
	dataType:"json",
	data: "userId="+userId,
	success:function(data){
		var table = $("<table><th>"+"책제목"+"</th><th>"+"ISBN"+"</th><th>"+"가격"+"</th><th>"+"날짜"+"</th><th>"+"선택"+"</th></table>");
		for(var i in data) {
			var basket = data[i];
			var html = "<tr><td>"+basket.bookTitle+"</td>";
			html += "<td>"+basket.ISBN+"</td>";
			html += "<td>"+basket.price+"</td>";
			html += "<td>"+basket.pickDate+"</td>";
			html += "<td><input type='checkbox'id='basketcheck' /></td></tr>"
			
			table.append(html);
		}
		$("#basketList").html(table);
		
	},
	error : function() {
		console.log("실패");
	}
});

</script>
</body>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>