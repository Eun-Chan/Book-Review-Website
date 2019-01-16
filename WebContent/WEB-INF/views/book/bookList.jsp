<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %> 
<%@ include file="/WEB-INF/views/common/categoryMenu.jsp" %>
<%
	String searchval = request.getParameter("searchVal");
	String searchType = request.getParameter("searchType");
%>
<title>bookList</title>
<script src = "<%=request.getContextPath()%>/js/jquery-3.3.1.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/custom.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bookList.css" />

	<!-- 검색시작 -->
	
	<div id="bookList_finder">
		<!-- 검색 select태그 -->
		<div id="bookList_search-container">
		<br />
			<form id="bookList_frm">
				<!-- 검색타입 : -->
				<select id="bookList_searchType">
					<option value="title">제목</option>
					<option value="author">저자</option>
				</select>		
				<!-- 검색 input태그 -->
				<input type="text" name="search" id="bookList_search" placeholder = " 내용을 입력하세요."/>
				<input type="button" value="검색" id="bookList_btn-search"/>
			</form>		
		</div>
	<div id="search_keyword"></div>	
	<div id="totalContent"></div>
	<div id="bookListContainer"></div>
	
	<div id="pageBar"></div>
	</div>
<style>

div#bookList_finder {
	margin-left: 200px;
	margin-right: 100px;
    min-height: 800px;
}
div#bookList_finder div#bookList_search-container{
	text-align: center;
}
table th{
	font-size: 18px;
}
p.goods_author{
	background-color: #1b4282;
}
td.goods_pubDate{
	width: 90px;
}
</style>	
<script>

	var cPage = 1;//현제 페이지
	var searchVal = "<%=searchval%>";
	var searchType = "<%=searchType%>";
	var pageBar = "";
	var CID = "";//카테고리 넘버를 가져오기 위한 변수

	$(document).ready(function(){
		bookSearch(cPage);
	});
	
	$("#bookList_btn-search").click(function(){	
		cPage = 1;
		searchVal = $("input#bookList_search").val();
		searchType = $("#bookList_searchType").val();
		bookSearch(cPage);	
	});

	$("form").on("submit", function(event){
		event.preventDefault();
		cPage = 1;
		searchVal = $("input#bookList_search").val();
		searchType = $("#bookList_searchType").val();
		bookSearch(cPage);	
	});
	//알라딘 open api를 사용하여 검색하는 함수
	function bookSearch(pageNo){
		cPage = pageNo;
		$.ajax({
			url : "http://www.aladin.co.kr/ttb/api/ItemSearch.aspx?ttbkey=ttbkmw71511428001&SearchTarget=Book&Query="+searchVal
					+"&QueryType="+searchType+"&start="+cPage+"&MaxResults=10&SearchTarget=Book&Sort=PublishTime&output=js&callback=bookListDisplay",
			jsonp: "bookListDisplay",
			dataType: "jsonp"
		});
	}
	//ajax로 불러온 리스트 값을 출력하는 함수
	function bookListDisplay(success, data) {
		$("div#pageBar span, div#pageBar a").remove();
		
		console.log(data);
		
		
		
		//var table = $("<table class='table table-hover''><tr class='bg-primary'><th scope='col'>표지</th><th scope='col'>책제목</th><th scope='col'>내용</th><th scope='col' style='width:80px'>작가</th><th scope='col' style='width:95px'>출판일</th><th scope='col'>정가</th></tr></table>");
		var table = $("<table class='table table''><tr class='bg-primary'><th scope='col'></th><th scope='col'>내용</th><th scope='col'>발간일</th><th scope='col'>정가</th></tr></table>");
		var numPerPage = 10;
		var totalResults = data.totalResults;//검색 결과 총 수
		//전체 페이지 수	
		var totalPage = parseInt(Math.ceil(totalResults/numPerPage));
		var pageBarSize = 5;
		var startPage = Math.floor(((cPage - 1)/pageBarSize)) * pageBarSize +1;
		var endPage = startPage + pageBarSize -1;
		var pageNo = startPage;//출력될 페이지 번호
		
		//도서정보 리스트 출력부
		for(var i in data.item) {
			var book  = data.item[i];
				
			var html = "<tr><td><a href='<%=request.getContextPath()%>/book/bookInfo.do?isbn13="+book.isbn13+"'>"+"<img src ='"+book.cover+"'></a></td>";
			html += "<td><a href='<%=request.getContextPath()%>/book/bookInfo.do?isbn13="+book.isbn13+"'><h3 class='goods_title'>"+book.title+"</h3></a>";
			html += "<p class='badge goods_author'>"+book.author+"</p>";
  			html += "<p class='goods_description'><책소개>"+book.description+"</p>";
			html += "<td class='goods_pubDate' style='vertical-align: middle;'>"+book.pubDate+"</td>";
			html += "<td style='width:110px; vertical-align: middle;'><span style='font-weight: bold; color:#e45374; font-size:16px;'>"+book.priceStandard+"원</span></td></tr>";	
			
			table.append(html);
		}
		$("#search_keyword").html("<h4>'<span style='color:#f33494;'>"+searchVal+"</span>'의 검색결과</h4>");
		$("#totalContent").html("<p>총 "+totalResults+"건의 검색결과 중 "+cPage+" 페이지</p><br>");
		$("#bookListContainer").html(table);
		
		//pageBar
		var pageBar = "<ul class='pagination'>";
		
		//이전 section
	    if(pageNo == 1 ){
	    	pageBar += "<li class='page-item disabled'><a class='page-link' href='#'>이전</a></li>";
	    }
	    else {
	        pageBar += "<li class='page-item disabled'><a class='page-link' onclick='bookSearch("+(pageNo-1)+")'>이전</a></li>";
	    }
	        
		//[페이지] section
	    while(pageNo <= endPage && pageNo <= totalPage){
	        
	        if(cPage == pageNo ){
	            pageBar += "<li class='page-item active'><a class='page-link' href='#'><span class='cPage'>"+pageNo+"</span></a></li> ";
	        }
	        else {
	            pageBar += "<li class='page-item'><a class='page-link' onclick='bookSearch("+pageNo+")'>"+pageNo+"</a></li> ";
	        }
	        pageNo++;
	    }
	    
	    //다음 section
	    if(pageNo > totalPage){
	    	pageBar += "<li class='page-item disabled'><a class='page-link' href='#'>다음</a></li>";
	    } else {
	        pageBar += "<li class='page-item'><a class='page-link' onclick='bookSearch("+pageNo+")'>다음</a></li>";
	    }
	    
	    $("div#pageBar").append(pageBar);
	}
	
	//카테고리 클릭시 관련 카테고리의 신작을 보여주는 첫 함수
	function moveCategoryView(CID){
		cPage = 1;
		CID = CID;
		console.log("CID1", CID);
		$.ajax({
			url: "http://www.aladin.co.kr/ttb/api/ItemList.aspx?ttbkey=ttbkmw71511428001&Sort=PublishTime&QueryType=ItemNewAll&MaxResults=10&start=1&CategoryId="+CID+"&SearchTarget=Book&output=js&callback=bookCListDisplay&Version=20131101",
			jsonp: "bookCListDisplay",
			dataType: "jsonp"

		});
	};
	//카테고리로 검색된 리스트에서 페이징 된 넘버를 누룰때 실행되는 함수
	function moveCategoryView2(CID, pageNo){
		CID=CID;
		cPage = pageNo;
		console.log("CID2", CID);
		$.ajax({
			url: "http://www.aladin.co.kr/ttb/api/ItemList.aspx?ttbkey=ttbkmw71511428001&Sort=PublishTime&QueryType=ItemNewAll&MaxResults=10&start="+cPage+"&CategoryId="+CID+"&SearchTarget=Book&output=js&callback=bookCListDisplay&Version=20131101",
			jsonp: "bookCListDisplay",
			dataType: "jsonp"

		});
	};
	//카테고리 클릭 후 받아온 리스트를 화면에 출력하기 위한 함수 : api url을 통해 return되는 값이 다르기 때문에 bookListDisplay()와 중복 사용이 불가하다
	function bookCListDisplay(data){
		$("div#pageBar span, div#pageBar a").remove();
		
		console.log(data);
		
		//var table = $("<table class='table table-hover'><tr class='bg-primary'><th scope='col'>표지</th><th scope='col'>책제목</th><th scope='col'>내용</th><th scope='col'style='width:80px'>작가</th><th scope='col' style='width:95px'>출판일</th><th scope='col'>정가</th></tr></table>");
		var table = $("<table class='table table''><tr class='bg-primary'><th scope='col'></th><th scope='col'>내용</th><th scope='col'>발간일</th><th scope='col'>정가</th></tr></table>");
		var numPerPage = 10;
		var totalResults = data.totalResults;//검색 결과 총 수
		//전체 페이지 수	
		var totalPage = parseInt(Math.ceil(totalResults/numPerPage));
		var pageBarSize = 5;
		var startPage = Math.floor(((cPage - 1)/pageBarSize)) * pageBarSize +1;
		var endPage = startPage + pageBarSize -1;
		var pageNo = startPage;//출력될 페이지 번호
		
		//도서정보 리스트 출력부
		
		for(var i in data.item) {
			var book  = data.item[i];
		
			var html = "<tr><td><a href='<%=request.getContextPath()%>/book/bookInfo.do?isbn13="+book.isbn13+"'>"+"<img src ='"+book.cover+"'></a></td>";
			html += "<td><a href='<%=request.getContextPath()%>/book/bookInfo.do?isbn13="+book.isbn13+"'><h3 class='goods_title'>"+book.title+"</h3></a>";
			html += "<p class='badge goods_author'>"+book.author+"</p>";
  			html += "<p class='goods_description'><책소개>"+book.description+"</p>";
			html += "<td class='goods_pubDate' style='vertical-align: middle;'>"+book.pubDate+"</td>";
			html += "<td style='width:110px; vertical-align: middle;'><span style='font-weight: bold; color:#e45374; font-size:16px;'>"+book.priceStandard+"원</span></td></tr>";
			table.append(html);
		}
		$("#search_keyword").html("<h4>'<span style='color:#f33494;'>"+searchVal+"</span>'의 검색결과</h4>");
		$("#totalContent").html("<p>총 "+totalResults+"건의 검색결과 중 "+cPage+" 페이지</p><br>");
		$("#bookListContainer").html(table);
		
		//pageBar
		var pageBar = "<ul class='pagination'>";

		//이전 section
	    if(pageNo == 1 ){
	    	pageBar += "<li class='page-item disabled'><a class='page-link' href='#'>이전</a></li>";
	    }
	    else {
	        pageBar += "<li class='page-item'><a class='page-link' onclick='moveCategoryView2("+data.searchCategoryId+","+(pageNo-1)+")'>이전</a></li>";
	    }
	        
		//[페이지] section
	    while(pageNo <= endPage && pageNo <= totalPage){
	        
	        if(cPage == pageNo ){
	            pageBar += "<li class='page-item'><a class='page-link' href='#'><span class='cPage'>"+pageNo+"</span></li>";
	        }
	        else {
	            pageBar += "<li class='page-item'><a class='page-link' onclick='moveCategoryView2("+data.searchCategoryId+","+pageNo+")'>"+pageNo+"</a></li>";
	        }
	        pageNo++;
	    }
	    
	    //다음 section
	    if(pageNo > totalPage){
	    	pageBar += "<li class='page-item disabled'><a class='page-link' href='#'>다음</a></li>";
	    } else {
	        pageBar += "<li class='page-item'><a class='page-link' onclick='moveCategoryView("+data.searchCategoryId+","+pageNo+")'>다음</a></li>";
	    }
	    
	    $("div#pageBar").append(pageBar);
	};



</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>