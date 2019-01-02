<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bookList</title>
<script src = "<%=request.getContextPath()%>/js/jquery-3.3.1.js"></script>
<script>
$(function(){
	var title = $("#title");
	var sname = $("#author");
	
	$("select#searchType").change(function(){
		sid.hide();
		sname.hide();
		sgender.hide();
		
		$("#search-"+$(this).val()).css("display","inline-block");
	});
});
</script>
</head>
<body>
	<!-- 검색시작 -->
	<div id="finder">
		<!-- 검색 select태그 -->
		<div id="search-container">
			검색타입 :
			<select id="searchType">
				<option value="title">제목</option>
				<option value="author">저자</option>
			</select>		
		</div>
		<!-- 검색 input태그 -->
		<input type="text" name="search" id="search" placeholder = " 내용을 입력하세요."/>
		<input type="button" value="검색" id="btn-search"/>
	</div>
	<div id="bookListContainer"></div>
<script>
$("#btn-search").click(function() {
	var searchVal = $("#search").val();
	var searchType = $("#searchType").val();
	$.ajax({
		url : "http://www.aladin.co.kr/ttb/api/ItemSearch.aspx?ttbkey=ttbkmw71511428001&Query="+searchVal+"&QueryType="+searchType+"&MaxResults=10&start=1&SearchTarget=Book&output=js&callback=bookListDisplay",
		jsonp: "bookListDisplay",
		dataType: "jsonp"
	});
});
function bookListDisplay(success,data) {
	var table = $("<table></table>");
	for(var i in data.item) {
		var book  = data.item[i];
		var html = "<tr><td>"+"<img src ='"+book[i].cover+"'></td>";
		html += "<td>"+book[i].title+"</td>";
		html += "<td>"+book[i].description+"</td>";
		html += "<td>"+book[i].author+"</td>";
		html += "<td>"+book[i].pubDate+"</td>";
		html += "<td>"+book[i].priceStandard+"</td></tr>";	
		table.append(html);
	}
	$("#bookListContainer").html(table);
}
</script>
</body>
</html>