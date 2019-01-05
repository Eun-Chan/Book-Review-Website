<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/header.jsp" %> 
<%@ include file="/categoryMenu.jsp" %>

<title>bookList</title>
<script src = "<%=request.getContextPath()%>/js/jquery-3.3.1.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/custom.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bookList.css" />


	<!-- 검색시작 -->
	
	<div id="finder">
		<!-- 검색 select태그 -->
		<div id="search-container">
			검색타입 :
			<select id="searchType">
				<option value="title">제목</option>
				<option value="author">저자</option>
			</select>		
			<!-- 검색 input태그 -->
			<input type="text" name="search" id="search" placeholder = " 내용을 입력하세요."/>
			<input type="button" value="검색" id="btn-search"/>
		</div>
	<div id="totalContent"></div>
	<div id="bookListContainer"></div>
	
	<div id="pageBar"></div>
	</div>
<style>

div#finder{
	margin-left: 200px;
	margin-right: 100px;
    min-height: 800px;
}

</style>	
<script>

	var cPage;//현제 페이지
	var searchVal = "";
	var searchType = "";
	var pageBar = "";
	var CID = "";//카테고리 넘버를 가져오기 위한 변수

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

	function bookListDisplay(success, data) {
		$("div#pageBar span, div#pageBar a").remove();
		
		console.log(data);
		
		var table = $("<table><tr><th>표지</th><th>책제목</th><th>내용</th><th>작가</th><th>출판일</th><th>정가</th></tr></table>");
		var numPerPage = 10;
		var totalResults = data.totalResults;//검색 결과 총 수
		//전체 페이지 수	
		var totalPage = parseInt(Math.ceil(totalResults/numPerPage));
		var pageBarSize = 5;
		var startPage = Math.floor(((cPage - 1)/pageBarSize)) * pageBarSize +1;
		var endPage = startPage + pageBarSize -1;
		var pageNo = startPage;//출력될 페이지 번호
		
		//도서정보 리스트 출력부
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
	
	
	function moveCategoryView(CID){
		cPage = 1;
		console.log("1???");
		CID = CID;
		$.ajax({
			url: "http://www.aladin.co.kr/ttb/api/ItemList.aspx?ttbkey=ttbkmw71511428001&QueryType=ItemNewAll&MaxResults=10&start=1&CategoryId="+CID+"&SearchTarget=Book&output=js&callback=bookCListDisplay&Version=20131101",
			jsonp: "bookCListDisplay",
			dataType: "jsonp"

		});
	};

	function moveCategoryView2(CID, pageNo){
		CID=CID;
		cPage = pageNo;
		console.log("2????")
		$.ajax({
			url: "http://www.aladin.co.kr/ttb/api/ItemList.aspx?ttbkey=ttbkmw71511428001&QueryType=ItemNewAll&MaxResults=10&start="+cPage+"&CategoryId="+CID+"&SearchTarget=Book&output=js&callback=bookCListDisplay&Version=20131101",
			jsonp: "bookCListDisplay",
			dataType: "jsonp"

		});
	};

	function bookCListDisplay(data){
		$("div#pageBar span, div#pageBar a").remove();
		
		console.log(data);
		
		var table = $("<table><tr><th>표지</th><th>책제목</th><th>내용</th><th>작가</th><th>출판일</th><th>정가</th></tr></table>");
		var numPerPage = 10;
		var totalResults = data.totalResults;//검색 결과 총 수
		//전체 페이지 수	
		var totalPage = parseInt(Math.ceil(totalResults/numPerPage));
		var pageBarSize = 5;
		var startPage = Math.floor(((cPage - 1)/pageBarSize)) * pageBarSize +1;
		var endPage = startPage + pageBarSize -1;
		var pageNo = startPage;//출력될 페이지 번호
		
		//도서정보 리스트 출력부
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
	        pageBar += "<a onclick='moveCategoryView2(\""+CID+"\","+(pageNo-1)+")'>[이전]</a>";
	    }
	        
		//[페이지] section
	    while(pageNo <= endPage && pageNo <= totalPage){
	        
	        if(cPage == pageNo ){
	            pageBar += "<span class='cPage'>"+pageNo+"</span> ";
	        }
	        else {
	            pageBar += "<a onclick='moveCategoryView2(\""+CID+"\","+pageNo+")'>"+pageNo+"</a> ";
	        }
	        pageNo++;
	    }
	    
	    //다음 section
	    if(pageNo > totalPage){
	        
	    } else {
	        pageBar += "<a onclick='moveCategoryView(\""+CID+"\","+pageNo+")'>[다음]</a>";
	    }
	    
	    $("div#pageBar").append(pageBar);
	};



</script>

<%@ include file="/footer.jsp" %>