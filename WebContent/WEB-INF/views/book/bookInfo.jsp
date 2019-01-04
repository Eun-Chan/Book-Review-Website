<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String isbn13 = (String)request.getAttribute("isbn13");
%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BookInformationTest</title>
<script src="<%=request.getContextPath()%>/js/jquery-3.3.1.js"></script>
<style>
#bookInfo-container{
	border: 1px solid gray;
	text-align: center;
}
</style>
</head>
<body>
	<label for="bookInfo-titleSrc">책제목입력</label>
	<input type="text" id="bookInfo-titleSrc" /><button id="btn">확인</button>
	<div id="bookInfo-container">
		<div id="bookInfo-img"></div>
		<div id="bookInfo-title"><span>제목: </span></div>
		<div id="bookInfo-author"><span>저자: </span></div>
		<div id="bookInfo-publisher"><span>출판사: </span></div>
		<div id="bookInfo-category"><span>카테고리 : </span></div>
		<div id="bookInfo-desc">소개: </div>
	</div>
<script>
var ISBN13 = <%=isbn13%>;
console.log(ISBN13);

$.ajax({
	url: "http://www.aladin.co.kr/ttb/api/ItemLookUp.aspx?ttbkey=ttbkmw71511428001&itemIdType=ISBN13&ItemId="+ISBN13+"&cover=big&output=js&callback=bookDisplay",
	jsonp: "bookDisplay",
	dataType: "jsonp"
});
	

function bookDisplay(success, data){
	console.log(data);
	
	$("#bookInfo-img").append("<img src='"+data.item[0].cover+"'>");
	$("#bookInfo-title").append("<span>"+data.item[0].title+"</span>");
	$("#bookInfo-author").append("<span>"+data.item[0].author+"</span>");
	$("#bookInfo-publisher").append("<span>"+data.item[0].publisher+"</span>");
	$("#bookInfo-category").append("<span>"+data.item[0].categoryName+"</span>");
	$("#bookInfo-desc").append("<span>"+data.item[0].description+"</span>");
};

</script>
</body>
</html>