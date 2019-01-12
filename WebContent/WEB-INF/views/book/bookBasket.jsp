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
	<br />
	<div id="basketTotal">
		<div id="button">
			<input type="button" value="전체선택" class="btn btn-primary" id="allButton"/>
			<input type="button" value="삭제" class="btn btn-info" id="deleteButton"/>
			<br /><br />	
		</div>
		<div id="basketList"></div>
	</div>
	<br />
	<div id="pagebar-container" class="text-center"></div>
	<div id="totalBasket"></div>
	<br />
<script>
var userId = "<%=user.getUserId()%>";
var cPage = <%=request.getParameter("cPage")%>;
console.log(userId)
/*즐겨찾기 보여주는 결과*/
$.ajax({
	url : "<%=request.getContextPath()%>/book/showBookBasket.do",
	dataType:"json",
	data: "userId="+userId+"&cPage="+cPage,
	success:function(data){
		console.log(data);
		console.log("list",data.list);
		var table = $("<table class='table'><th>"+"책제목"+"</th><th>"+"가격"+"</th><th>"+"날짜"+"</th><th>"+"선택"+"</th></table>");
		for(var i in data.list) {
			var basket = data.list[i];
			var html = "<tr><td><a href='<%=request.getContextPath()%>/book/bookInfo.do?isbn13="+basket.ISBN+"'>"+basket.bookTitle+"</a></td>";   
			html += "<td>"+basket.price+"원"+"</td>";
			html += "<td>"+basket.pickDate+"</td>";
			html += "<td><input type='checkbox' id='basketcheck' name = 'chk' value='"+basket.ISBN+"'/></td></tr>";
			
			table.append(html);
		}
		var cnt = parseInt(i)+1;
		if(isNaN(cnt) == true) {
			var cntHtml = "<p><h4>"+"총 0권의 책을 즐겨찾기에 추가하셨습니다."+"</h4></p>";
			location.href = "<%=request.getContextPath()%>/book/goBasket.do?cPage=1";
		}
		else {		
			var cntHtml = "<p><h4>"+"총 "+data.totalContents+"권의 책을 즐겨찾기에 추가하셨습니다."+"</h4></p>";		
		}
		var paging = data.pageBar;
		console.log("cnt",cnt);
		$("#pagebar-container").html(paging);
		$("#basketList").html(table);
		$("#totalBasket").html(cntHtml);
		
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
				var table = $("<table><th>"+"책제목"+"</th><th>"+"가격"+"</th><th>"+"날짜"+"</th><th>"+"선택"+"</th></table>");
				for(var i in data) {
					var basket = data[i];
					var html = "<tr><td>"+basket.bookTitle+"</td>";
					html += "<td>"+basket.price+"</td>";
					html += "<td>"+basket.pickDate+"</td>";
					html += "<td><input type='checkbox' id='basketcheck' name = 'chk' value='"+basket.ISBN+"'/></td></tr>"
					
					table.append(html);
				}
				location.reload();				
				$("#basketList").html(table);
			},
			error : function() {
				console.log("응안돼");
			}
		});
	});
});
//전체선택 옵션 구상중..
var clickCount = 0;
$("#allButton").click(function() {
	clickCount++;
	console.log(clickCount);
	if(clickCount%2 == 0) {
		$("input[name=chk]:checkbox").prop("checked",false);	
	}
	else {
		$("input[name=chk]:checkbox").prop("checked",true);	
	}
});
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
