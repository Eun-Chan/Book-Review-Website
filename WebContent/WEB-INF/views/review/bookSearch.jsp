<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 검색</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/bootstrap.css" />
<script src="<%=request.getContextPath() %>/js/jquery-3.3.1.js"></script>
<script src="<%=request.getContextPath() %>/js/bootstrap.js"></script>
<style>
div.form-group{
	display: inline-block;
}
</style>
</head>
<body>
	<!-- 검색시작 -->
	<div id="finder">
		<!-- 검색 select태그 -->
		<div id="search-container" class="form-group">
			<label for="searchType">검색타입 :</label>
			<select id="searchType" class="form-control">
				<option value="title">제목</option>
				<option value="author">저자</option>
			</select>
		</div>
		<!-- 검색 input태그 -->
		<div class="form-group">
			<input type="text" name="search" id="search" placeholder = " 내용을 입력하세요." class="form-control"/>
		</div>
		<input type="button" value="검색" id="btn-search" class="btn btn-default"/>
	</div>
	<div id="totalContent"></div>
	<div id="bookListContainer">
		<table class="table"></table>
	</div>
	
	<div id="pageBar"></div>
	
<script>

// 도서 검색 ajax 시작
var cPage;//현재 페이지
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
	
	var table = $("table.table");
	var numPerPage = 10;
	//검색 결과 총 수
	var totalResults = data.totalResults;
	//전체 페이지 수
	var totalPage = parseInt(Math.ceil(totalResults/numPerPage));	
	var pageBarSize = 5;
	var startPage = Math.floor(((cPage - 1)/pageBarSize)) * pageBarSize +1;
	var endPage = startPage + pageBarSize -1;
	var pageNo = startPage;//출력될 페이지 번호
	
	//도서정보 리스트 출력부
	console.log(data);
	console.log("isbn13!!!",data.item[0].isbn13);
	var thead = "<thead><tr><th>커버</th><th>도서명</th><th>저자</th><th>출간일</th><th>도서선택</th></tr></thead>";
	table.html(thead);
	var html = "<tbody>";
	for(var i in data.item) {
		var book  = data.item[i];
		html += "<tr><td>"+"<img src ='"+book.cover+"'></td>";
		html += "<td>" + book.title + "</td>";
		/* html += "<td>"+book.description+"</td>"; */
		html += "<td>"+book.author+"</td>";
		html += "<td>"+book.pubDate+"</td>";
		/* html += "<td>"+book.priceStandard+"</td></tr>";	 */
		html += "<td><button type='button' class='btn btn-primary' id='plz' onclick='setBookInfo("
				+ book.title + "," + book.isbn13 + ");'>선택</button></tr>";
		
	}
	html += "</tbody>";
	table.append(html);
	$("#totalContent").html("<span>"+totalResults+"건의 검색결과 중 "+cPage+" 페이지</span>");
	/* $("#bookListContainer").html(table); */
	
	//pageBar
	var pageBar = "<ul class='pagination'>";
	
	//이전 section
    if(pageNo == 1 ){
    	pageBar += "<li class='page-item disabled'><a class='page-link' href='#'>이전</a></li>";
    }
    else {
        pageBar += "<li class='page-item'><a class='page-link' onclick='test111("+(pageNo-1)+")'>이전</a></li>";
    }
        
	//[페이지] section
    while(pageNo <= endPage && pageNo <= totalPage){
        
        if(cPage == pageNo ){
            pageBar += "<li class='page-item active'><a class='page-link' href='#'><span class='cPage'>"+pageNo+"</span></a></li> ";
        }
        else {
            pageBar += "<li class='page-item'><a class='page-link' onclick='test111("+pageNo+")'>"+pageNo+"</a></li> ";
        }
        pageNo++;
    }
    
    //다음 section
    if(pageNo > totalPage){
    	pageBar += "<li class='page-item disabled'><a class='page-link' href='#'>다음</a></li>";
    } else {
        pageBar += "<li class='page-item'><a class='page-link' onclick='test111("+pageNo+")'>다음</a></li>";
    }
    
    $("div#pageBar").append(pageBar);
}
// 도서 검색 ajax 끝

// 도서 선택 버튼 리스너
function setBookInfo(bookTitle, isbn){
	// 부모창의 form 선택
	console.log("??");
	var parForm = opener.document.write-form;
	parForm.rbBookTitle.value = bookTitle;
	parForm.rbIsbn.value = isbn;
	
	self.close();
}



</script>
</body>
</html>