<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %> 

<script src = "<%=request.getContextPath()%>/js/jquery-3.3.1.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bookBasket.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/custom.css">
	<br />
	<div id="basketInfo">
		<h2><%=user.getUserName()%>님의 즐겨찾기입니다.</h2>
	</div>
	<br />
	<input type="button" value="삭제" class="btn btn-info" id="deleteButton"/>
	<br />
	<br />
	<br />
	<div id="basketList"></div>
	<div id="totalbasket"></div>
	<br />
<script>

var userId = "<%=user.getUserId()%>";
console.log(userId)
$.ajax({
	url : "<%=request.getContextPath()%>/book/bookbasket.do",
	dataType:"json",
	data: "userId="+userId,
	success:function(data){
		var table = $("<table class='table'><th>"+"책제목"+"</th><th>"+"ISBN"+"</th><th>"+"가격"+"</th><th>"+"날짜"+"</th><th>"+"선택"+"</th></table>");
		for(var i in data) {
			var basket = data[i];
			var html = "<tr><td><a href='<%=request.getContextPath()%>/book/bookInfo.do?isbn13="+basket.ISBN+"'>"+basket.bookTitle+"</a></td>";   
			html += "<td>"+basket.ISBN+"</td>";
			html += "<td>"+basket.price+"</td>";
			html += "<td>"+basket.pickDate+"</td>";
			html += "<td><input type='checkbox' id='basketcheck' name = 'chk' value='"+basket.ISBN+"'/></td></tr>";
			
			table.append(html);
		}
		var cnt = parseInt(i)+1;
		console.log("cnt",cnt);
		$("#basketList").html(table);
		
	},
	error : function() {
		console.log("실패");
	}
});
$("#deleteButton").click(function() {
	$("input:checkbox[name='chk']:checked").each(function() {
		var ISBN = $(this).val();
		$.ajax({
			url : "<%=request.getContextPath()%>/book/checkedBasket.do?ISBN="+ISBN+"&userId=<%=user.getUserId()%>",
			success : function(data) {
				console.log(data);
				var table = $("<table><th>"+"책제목"+"</th><th>"+"ISBN"+"</th><th>"+"가격"+"</th><th>"+"날짜"+"</th><th>"+"선택"+"</th></table>");
				for(var i in data) {
					var basket = data[i];
					var html = "<tr><td>"+basket.bookTitle+"</td>";
					html += "<td>"+basket.ISBN+"</td>";
					html += "<td>"+basket.price+"</td>";
					html += "<td>"+basket.pickDate+"</td>";
					html += "<td><input type='checkbox' id='basketcheck' name = 'chk' value='"+basket.ISBN+"'/></td></tr>"
					
					table.append(html);
				}
				$("#basketList").html(table);
				location.reload();
				
			},
			error : function() {
				console.log("응안돼");
			}
		});
	});
});
	
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
