<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String isbn13 = (String)request.getAttribute("isbn13");
%>     
<%@ include file="/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BookInformationTest</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/custom.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/bootstrap.css" />
<script src="<%=request.getContextPath()%>/js/jquery-3.3.1.js"></script>
<script src="<%=request.getContextPath() %>/js/bootstrap.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bookInfo.css" />
</head>
<body>
	<!-- <br />
	<label for="bookInfo-titleSrc">책제목입력 : </label>
	<input type="text" id="bookInfo-titleSrc" />
	<button id="btn">확인</button> -->
	<br />
	<br />
	<div id="bookInfo-container">
		<div id="bookInfo-img"></div>
		<br />
		<div id="bookInfo-title"><span>제목: </span></div>
		<div id="bookInfo-author"><span>저자: </span></div>
		<div id="bookInfo-publisher"><span>출판사: </span></div>
		<div id="bookInfo-category"><span>카테고리 : </span></div>
		<div id="bookInfo-desc">책 소개:</div>
	</div>
	<br />
	<div id="command-info"></div>
<script>
var ISBN13 = <%=isbn13%>;
console.log(ISBN13);

$.ajax({
	url: "http://www.aladin.co.kr/ttb/api/ItemLookUp.aspx?ttbkey=ttbkmw71511428001&itemIdType=ISBN13&ItemId="+ISBN13+"&cover=big&output=js&callback=bookDisplay",
	jsonp: "bookDisplay",
	dataType: "jsonp"
});
console.log("ajax1번째 종료");

function bookDisplay(success, data){
	//console.log(data);
	
	$("#bookInfo-img").append("<img src='"+data.item[0].cover+"'>");
	$("#bookInfo-title").append("<span>"+data.item[0].title+"</span>");
	$("#bookInfo-author").append("<span>"+data.item[0].author+"</span>");
	$("#bookInfo-publisher").append("<span>"+data.item[0].publisher+"</span>");
	$("#bookInfo-category").append("<span>"+data.item[0].categoryName+"</span>");
	$("#bookInfo-desc").append("<span id='bookInfodsp'>"+data.item[0].description+"</span>");
};
$.ajax({
	url: "<%=request.getContextPath()%>/book/bookreviewInfo.do",
	dataType:"json",
	data:"ISBN13="+ISBN13,
	success:function(data) {
		console.log(data);
		console.log("ajax실행");
		var table = $("<table class='table'><th>"+"제목"+"</th><th>"+"내용"+"</th><th>"+"작성자"+"</th><th>"+"작성일자"+"</th></table>")
		for(var i in data) {
			console.log(data[i]);
			var command = data[i];
			var html = "<tr><td><a href='<%=request.getContextPath()%>/review/reviewDetail.do?rbNo="+command.rbNo+"'>"+command.rbTitle+"</a></td>";
			html += "<td id='rbcontent'>"+command.rbContent+"</td>";
			html += "<td>"+command.rbWriter+"</td>";
			html += "<td>"+command.rbDate+"</td></tr>";
    		table.append(html);
		}
		$("#command-info").html(table);
	},
	error:function(){
		console.log("실패");
	}
});
//요소가 비어있는지 검사
var isEmpty = function(value){
	if( value == "" || value == null || value == undefined || ( value != null && typeof value == "object" && !Object.keys(value).length ) ){
		return true;
	}else{ 
		return false;
	}
}
</script>
</body>
</html>
<%@ include file="/footer.jsp" %>