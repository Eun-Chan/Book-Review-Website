<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/header.jsp" %> 
<%@ include file="/categoryMenu.jsp" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bookList</title>
<script src = "<%=request.getContextPath()%>/js/jquery-3.3.1.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bookList.css" />
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
	<div id="totalContent"></div>
	<div id="bookListContainer"></div>
	
	<div id="pageBar"></div>
	
<script>


var cPage;//현제 페이지
var searchVal = "";
var searchType = "";
var pageBar = "";

$("#btn-search").click(function(){
	searchVal = $("input#search").val();
	searchType = $("#searchType").val();
	cPage = 1;
	
	test111(cPage);	
});

function test111(pageNo){
	cPage = pageNo;
	$.ajax({
		url : "http://www.aladin.co.kr/ttb/api/ItemSearch.aspx?ttbkey=ttbkmw71511428001&SearchTarget=Book&Query="+searchVal
				+"&QueryType="+searchType+"&start="+cPage+"&MaxResults=10&SearchTarget=Book&output=js&callback=bookListDisplay",
		jsonp: "bookListDisplay",
		dataType: "jsonp"
	});
}

function bookListDisplay(success,data) {
	$("div#pageBar span, div#pageBar a").remove();
	
	var table = $("<table></table>");
	var numPerPage = 10;
	var totalResults = data.totalResults;//검색 결과 총 수
	var totalPage = parseInt(Math.ceil(totalResults/numPerPage));//전체 페이지 수	
	var pageBarSize = 5;
	var startPage = Math.floor(((cPage - 1)/pageBarSize)) * pageBarSize +1;
	var endPage = startPage + pageBarSize -1;
	var pageNo = startPage;//출력될 페이지 번호
	
	//도서정보 리스트 출력부
	console.log(data);
	console.log("isbn13!!!",data.item[0].isbn13);
	for(var i in data.item) {
		var book  = data.item[i];
		var html = "<tr><td>"+"<img src ='"+book.cover+"'></td>";
		html += "<td><a href='<%=request.getContextPath()%>/book/bookInfo.do?isbn13="+book.isbn13+"'>"+book.title+"</td>";
		html += "<td>"+book.description+"</td>";
		html += "<td>"+book.author+"</td>";
		html += "<td>"+book.pubDate+"</td>";
		html += "<td>"+book.priceStandard+"</td></tr>";	
		table.append(html);
	}
	$("#totalContent").html("<span>"+totalResults+"건의 검색결과 중 "+cPage+" 페이지</span>");
	$("#bookListContainer").html(table);
	
	//pageBar
	var pageBar = "";
	
	//이전 section
    if(pageNo == 1 ){

    }
    else {
        pageBar += "<a onclick='test111("+(pageNo-1)+")'>[이전]</a>";
    }
        
	//[페이지] section
    while(pageNo <= endPage && pageNo <= totalPage){
        
        if(cPage == pageNo ){
            pageBar += "<span class='cPage'>"+pageNo+"</span> ";
        }
        else {
            pageBar += "<a onclick='test111("+pageNo+")'>"+pageNo+"</a> ";
        }
        pageNo++;
    }
    
    //다음 section
    if(pageNo > totalPage){
        
    } else {
        pageBar += "<a onclick='test111("+pageNo+")'>[다음]</a>";
    }
    
    $("div#pageBar").append(pageBar);
}
</script>
</body>
</html>