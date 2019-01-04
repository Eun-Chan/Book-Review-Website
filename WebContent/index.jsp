<%@page import="com.brw.dto.ReviewBoardDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<%
	List<ReviewBoardDTO> reviewRecentList = (List<ReviewBoardDTO>)request.getAttribute("ReviewRecentList");
	System.out.println("최근리뷰 5건@jsp : " + reviewRecentList);
%>
<html>
<head>
<meta charset="UTF-8">
 <link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css" />
<title>책 읽는 사람들</title>
</head>
<body onload="startPage()">
	<jsp:include page="header.jsp"></jsp:include>
<<<<<<< HEAD
	여기는 index.jsp 
=======
>>>>>>> 630b857ba4aaad8adf07fc25f3f3571410256b93
	<a href="reviewList.do">헤헤</a>
	<a href="review/reviewList.do">리뷰게시판</a>
	<a href="book/bookInfo.do">해리포터상세보기테스트</a>
	<a href="book/bookList.do">도서검색테스트</a>
	
	<form action="<%=request.getContextPath()%>/index.do"	id="indexForm" method="post"></form>
	<div class="masthead">
        <h3 class="text-muted">책 읽는 사람들</h3>
        <nav>
          <ul class="nav nav-justified">
            <li class="active"><a href="#">통합</a></li>
            <li><a href="#">신간</a></li>
            <li><a href="#">장르별</a></li>
            <li><a href="#">도서리뷰</a></li>
          </ul>
        </nav>
      </div>
      <!-- 인기도서 출력 -->
      <div class="container">
	<!-- 첫번째 -->
     <div class="row">
	  <div class="col-sm-6 col-md-3">
	    <div class="thumbnail">
	    	  <img class="img-thumbnail" id="bookImage0">   	
	      <div class="caption">
	        <h3 id="book0">도서명</h3>
	        <p id="book-Content0"> </p>
	        <p><a href="#" class="btn btn-primary" role="button">구매하기</a> <a href="#" class="btn btn-default" role="button">더 보기</a></p>
	      </div>
	    </div>
	  </div>
	 
	<!-- 두번째 -->
	  <div class="col-sm-6 col-md-3">
	    <div class="thumbnail">
	    	  <img class="img-thumbnail" id="bookImage1"> 
	      <div class="caption">
	        <h3 id="book1">도서명2</h3>
	        <p id="book-Content1"> </p>
	        <p><a href="#" class="btn btn-primary" role="button">구매하기</a> <a href="#" class="btn btn-default" role="button">더 보기</a></p>
	      </div>
	    </div>
	   </div>
	  <!-- 세번째 -->
	  <div class="col-sm-6 col-md-3">
	    <div class="thumbnail">
	    	  <img class="img-thumbnail" id="bookImage2"> 
	      <div class="caption">
	        <h3 id="book2">도서명3</h3>
	        <p id="book-Content2"> </p>
	        <p><a href="#" class="btn btn-primary" role="button">구매하기</a> <a href="#" class="btn btn-default" role="button">더 보기</a></p>
	      </div>
	    </div>
	   </div>
	  <!-- 다섯번째 -->
	  <div class="col-sm-6 col-md-3">
	    <div class="thumbnail">
	    	 <img class="img-thumbnail" id="bookImage3"> 
	      <div id="bookImage3"></div>
	      <div class="caption">
	        <h3 id="book3">도서명4</h3>
	        <p id="book-Content3"> </p>
	        <p><a href="#" class="btn btn-primary" role="button">구매하기</a> <a href="#" class="btn btn-default" role="button">더 보기</a></p>
	      </div>
	    </div>
	  </div>
	 </div> <!-- rowEnd -->
    </div> <!-- /container -->
    
    <div id="result"></div>
    
    <!-- 최근 리뷰 -->
    <h3 class="subTitle"><strong>최근 리뷰</strong></h3>
    <hr class="title-line" />
    <br />
    
    <!-- 댓글 -->
    <div class="recent_comment">
    	<span id="bookName0" class="bookName"></span> &nbsp;
    	<span id="nickName0" class="nickName"></span>
    	<span id="writer-Time0" class="writer-Time"></span>
    	<br /><br />
    	<span id="content0" class="content"></span>
    	<br /><br />
    	<hr />	
    </div>
    <div class="recent_comment">
    	<span id="bookName1" class="bookName"></span> &nbsp;
    	<span id="nickName1" class="nickName"></span>
    	<span id="writer-Time1" class="writer-Time"></span>
    	<br /><br />
    	<span id="content1" class="content"></span>
    	<br /><br />
    	<hr />	
    </div>
    <div class="recent_comment">
    	<span id="bookName2" class="bookName"></span> &nbsp;
    	<span id="nickName2" class="nickName"></span>
    	<span id="writer-Time2" class="writer-Time"></span>
    	<br /><br />
    	<span id="content2" class="content"></span>
    	<br /><br />
    	<hr />	
    </div>
    <div class="recent_comment">
    	<span id="bookName3" class="bookName"></span> &nbsp;
    	<span id="nickName3" class="nickName"></span>
    	<span id="writer-Time3" class="writer-Time"></span>
    	<br /><br />
    	<span id="content3" class="content"></span>
    	<br /><br />
    	<hr />	
    </div>
    <div class="recent_comment">
    	<span id="bookName4" class="bookName"></span> &nbsp;
    	<span id="nickName4" class="nickName"></span>
    	<span id="writer-Time4" class="writer-Time"></span>
    	<br /><br />
    	<span id="content4" class="content"></span>
    	<br /><br />
    	<hr />	
    </div>
	
<script>

function startPage(){

$('#indexForm').ready(function(){
	   $.ajax({
	        type: 'post',
	        url: "<%=request.getContextPath()%>/index.do",
	        dataType: "json",
	        contentType: "application/json; charset=utf-8;",
	        success: function(data){
	            console.log("성공");
	            console.log(data);
	            for(var i in data)
            	{
	            	if(data[i] != null && !(isEmpty(data[i])))
            		{
		            	$("span#bookName"+i).text(data[i].rbBookTitle);
			            $("span#nickName"+i).text(data[i].rbWriter + " | ");
			            $("span#content"+i).text(data[i].rbContent);
			           	$("span#writer-Time"+i).text(data[i].rbDate);
            		}
            	}
	            
	            
	        },
	        error: function(){
	        	console.log("실패");
	        }
	   });
	    return false; //<- 이 문장으로 새로고침(reload)이 방지됨
	});
}; //startPage End
	
	//요소가 비어있는지 검사
	var isEmpty = function(value){
		if( value == "" || value == null || value == undefined || ( value != null && typeof value == "object" && !Object.keys(value).length ) ){
			return true;
		}else{ 
			return false;
		}
	}


$.ajax({
    url: "http://www.aladin.co.kr/ttb/api/ItemList.aspx?ttbkey=ttbkmw71511428001&QueryType=Bestseller&MaxResults=10&start=1&SearchTarget=Book&output=js&Version=20131101",
    dataType: "jsonp",
    success:function(data)
    {	
    	/* 책 정보 파싱 >> 리스트 */
    	var bookList = [];
    	for(var i in data.item)
   		{
   			var book = data.item[i]; //가져온 data에 item에 객체배열로 담겨있다. 이걸 하나씩 꺼냄. 각 정보는 api를 참고하면 됨
   			var itemId = book.itemId; //도서분류 고유값
   			var title = book.title; //도서제목
   			var description = book.description; //도서소개
   			var cover = book.cover; //도서이미지
   			
   			/* 리펙토링 - 리스트로 담지 않고 바로 데이터 넣어보리기  > 다시 리스트에 넣자. 데이터 재활용이 안된다*/
   			bookList.push({"itemId":itemId, "title":title, "description":description, "cover":cover});
   		}
    	/* 데이터 입력 */
		$("h3#book0").html(bookList[0].title);
		$("p#book-Content0").html(bookList[0].description);
		$("#bookImage0").attr("src", bookList[0].cover);
		
		$("h3#book1").html(bookList[1].title);
		$("p#book-Content1").html(bookList[1].description);
		$("#bookImage1").attr("src", bookList[1].cover);
		
		$("h3#book2").html(bookList[2].title);
		$("p#book-Content2").html(bookList[2].description);
		$("#bookImage2").attr("src", bookList[2].cover);
		
		$("h3#book3").html(bookList[3].title);
		$("p#book-Content3").html(bookList[3].description);
		$("#bookImage3").attr("src", bookList[3].cover);	
    },
    error:function()
    {
    	console.log("실패");
    }
 });
</script>
</body>
</html>