<%@page import="com.brw.dto.ReviewBoardDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css" />
<link rel="shortcut icon" type="image/x-icon" href="https://img.icons8.com/windows/32/000000/literature.png" />
<title>책 읽는 사람들</title>
</head>
<body>
	<!-- Header -->
	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	
	<!-- Body -->
	<a href="<%=request.getContextPath()%>/reviewList.do">헤헤</a>
	<a href="<%=request.getContextPath()%>/review/reviewList.do">리뷰게시판</a>
	<a href="<%=request.getContextPath()%>/book/bookInfo.do">해리포터상세보기테스트</a>
	<a href="<%=request.getContextPath()%>/book/bookList.do">도서검색테스트</a>
	<a href="<%=request.getContextPath()%>/book/showbasket.do">도서즐겨찾기테스트</a>
	
	<!-- 인기도서 출력 Start -->
	<form action="<%=request.getContextPath()%>/index.do"	id="indexForm" method="post"></form>
	<div class="masthead">
       <h3 class="text-muted">책 읽는 사람들</h3>
       <nav>
         <ul class="nav nav-justified">
           <li class="active"><a href="#" id="select-AllBook">통합</a></li>
           <li><a href="#" id="select-NewBook">신간</a></li>
           <li><a href="#" id="select-CategoryBook">외국</a></li>
           <li><a href="#" id="select-CategoryBook">e북</a></li>
         </ul>
       </nav>
     </div>
      
     <div class="container">
      
	<!-- 첫번째 -->
    <div class="row">
	  <div class="col-sm-6 col-md-3">
	   <div class="thumbnail">
	   	 <img class="img-thumbnail" id="bookImage0">
	     <div class="caption">
	       <div class="span-center"><span id="book0" class="bestseller-title"></span></div>
	       <p id="book-Author0" class="book-Author"> </p>
	       <!-- 별점 -->
	       <div id="start-Container">
	       <div class="starRev0">
			  <span class="starR1" id="star0-0">별1_왼쪽</span>
			  <span class="starR2" id="star0-1">별1_오른쪽</span>
			  <span class="starR1" id="star0-2">별2_왼쪽</span>
			  <span class="starR2" id="star0-3">별2_오른쪽</span>
			  <span class="starR1" id="star0-4">별3_왼쪽</span>
			  <span class="starR2" id="star0-5">별3_오른쪽</span>
			  <span class="starR1" id="star0-6">별4_왼쪽</span>
			  <span class="starR2" id="star0-7">별4_오른쪽</span>
			  <span class="starR1" id="star0-8">별5_왼쪽</span>
			  <span class="starR2" id="star0-9">별5_오른쪽</span>
			</div>
			</div>
			<br /><br />
			<div id="button-Container">
	       		<p><a href="#" class="btn btn-primary" role="button">구매하기</a> <a href="#" class="btn btn-default" role="button" id="detail-Book0">더 보기</a></p>
	        </div>
	     </div>
	   </div>
	 </div>
	 
	<!-- 두번째 -->
	<div class="col-sm-6 col-md-3">
	   <div class="thumbnail">
	   	 <img class="img-thumbnail" id="bookImage1"> 
	     <div class="caption">
	       <div class="span-center"><span id="book1" class="bestseller-title"></span></div>
	       <p id="book-Author1" class="book-Author"> </p>
	       <!-- 별점 -->
	       <div id="start-Container">
	       <div class="starRev0">
			  <span class="starR1" id="star1-0">별1_왼쪽</span>
			  <span class="starR2" id="star1-1">별1_오른쪽</span>
			  <span class="starR1" id="star1-2">별2_왼쪽</span>
			  <span class="starR2" id="star1-3">별2_오른쪽</span>
			  <span class="starR1" id="star1-4">별3_왼쪽</span>
			  <span class="starR2" id="star1-5">별3_오른쪽</span>
			  <span class="starR1" id="star1-6">별4_왼쪽</span>
			  <span class="starR2" id="star1-7">별4_오른쪽</span>
			  <span class="starR1" id="star1-8">별5_왼쪽</span>
			  <span class="starR2" id="star1-9">별5_오른쪽</span>
			</div>
			</div>
			<br /><br />
	       <p><a href="#" class="btn btn-primary" role="button">구매하기</a> <a href="#" class="btn btn-default" role="button" id="detail-Book1">더 보기</a></p>
	     </div>
	   </div>
	</div>
	
	<!-- 세번째 -->
	<div class="col-sm-6 col-md-3">
	   <div class="thumbnail">
	     <img class="img-thumbnail" id="bookImage2"> 
	     <div class="caption">
	       <div class="span-center"><span id="book2" class="bestseller-title"></span></div>
	       <p id="book-Author2" class="book-Author"> </p>
	       <!-- 별점 -->
	       <div id="start-Container">
	       <div class="starRev0">
			  <span class="starR1" id="star2-0">별1_왼쪽</span>
			  <span class="starR2" id="star2-1">별1_오른쪽</span>
			  <span class="starR1" id="star2-2">별2_왼쪽</span>
			  <span class="starR2" id="star2-3">별2_오른쪽</span>
			  <span class="starR1" id="star2-4">별3_왼쪽</span>
			  <span class="starR2" id="star2-5">별3_오른쪽</span>
			  <span class="starR1" id="star2-6">별4_왼쪽</span>
			  <span class="starR2" id="star2-7">별4_오른쪽</span>
			  <span class="starR1" id="star2-8">별5_왼쪽</span>
			  <span class="starR2" id="star2-9">별5_오른쪽</span>
			</div>
			</div>
			<br /><br />
	       <p><a href="#" class="btn btn-primary" role="button">구매하기</a> <a href="#" class="btn btn-default" role="button" id="detail-Book2">더 보기</a></p>
	     </div>
	   </div>
	 </div>
	<!-- 네번째 -->
	<div class="col-sm-6 col-md-3">
	  <div class="thumbnail">
	    <img class="img-thumbnail" id="bookImage3"> 
	    <div id="bookImage3"></div>
	    <div class="caption">
	      <div class="span-center"><span id="book3" class="bestseller-title"></span></div>
	      <p id="book-Author3" class="book-Author"> </p>
	      <!-- 별점 -->
	       <div id="start-Container">
	       <div class="starRev0">
			  <span class="starR1" id="star3-0">별1_왼쪽</span>
			  <span class="starR2" id="star3-1">별1_오른쪽</span>
			  <span class="starR1" id="star3-2">별2_왼쪽</span>
			  <span class="starR2" id="star3-3">별2_오른쪽</span>
			  <span class="starR1" id="star3-4">별3_왼쪽</span>
			  <span class="starR2" id="star3-5">별3_오른쪽</span>
			  <span class="starR1" id="star3-6">별4_왼쪽</span>
			  <span class="starR2" id="star3-7">별4_오른쪽</span>
			  <span class="starR1" id="star3-8">별5_왼쪽</span>
			  <span class="starR2" id="star3-9">별5_오른쪽</span>
			</div>
			</div>
			<br /><br />
	      <p><a href="#" class="btn btn-primary" role="button">구매하기</a> <a href="#" class="btn btn-default" role="button" id="detail-Book3">더 보기</a></p>
	    </div>
	  </div>
	</div>
	 </div> <!-- rowEnd -->
    </div> <!-- /container -->
    <!-- 인기도서 출력 End -->
    
    <!-- 최근 리뷰 Start -->
    <h3 class="subTitle"><strong>최근 리뷰</strong></h3>
    <hr class="title-line" />
    <br />
    
    <!-- 리뷰 -->
    <div class="recent_comment">
    	<span id="bookName0" class="bookName"></span> &nbsp;
    	<span id="nickName0" class="nickName"></span>
    	<span id="writer-Time0" class="writer-Time"></span>
    	<br /><br />
    	<span id="rbTitle0" class="rbTitle"></span>
    	<br /><br />
    	<hr />	
    </div>
    <div class="recent_comment">
    	<span id="bookName1" class="bookName"></span> &nbsp;
    	<span id="nickName1" class="nickName"></span>
    	<span id="writer-Time1" class="writer-Time"></span>
    	<br /><br />
    	<span id="rbTitle1" class="rbTitle"></span>
    	<br /><br />
    	<hr />	
    </div>
    <div class="recent_comment">
    	<span id="bookName2" class="bookName"></span> &nbsp;
    	<span id="nickName2" class="nickName"></span>
    	<span id="writer-Time2" class="writer-Time"></span>
    	<br /><br />
    	<span id="rbTitle2" class="rbTitle"></span>
    	<br /><br />
    	<hr />	
    </div>
    <div class="recent_comment">
    	<span id="bookName3" class="bookName"></span> &nbsp;
    	<span id="nickName3" class="nickName"></span>
    	<span id="writer-Time3" class="writer-Time"></span>
    	<br /><br />
    	<span id="rbTitle3" class="rbTitle"></span>
    	<br /><br />
    	<hr />	
    </div>
    <div class="recent_comment">
    	<span id="bookName4" class="bookName"></span> &nbsp;
    	<span id="nickName4" class="nickName"></span>
    	<span id="writer-Time4" class="writer-Time"></span>
    	<br /><br />
    	<span id="rbTitle4" class="rbTitle"></span>
    	<br /><br />
    	<hr />	
    </div>
<script>
/**
 * @광준 : 더 보기 버튼을 눌렀을 때 상세보기 페이지로 이동
 */
/* $("a#detail-Book").click(function(){
	$(this).
}); */

function startPage(bookIsbn){
/* 최근리뷰 view */
$('#indexForm').ready(function(){
   $.ajax({
        type: 'post',
        url: "<%=request.getContextPath()%>/index.do?bookIsbn="+bookIsbn,
        contentType: "application/json; charset=utf-8;",
        success: function(data){
        	console.log(data);
            for(var i in data[0])
           	{
            	if(data[0][i] != null && !(isEmpty(data[0][i]))) //isEmpty함수가 없기 때문에, 직접 정의한다.(하단에 변수참고)
           		{
	            	$("span#bookName"+i).text(data[0][i].rbBookTitle);
		            $("span#nickName"+i).text(data[0][i].rbWriter + " | ");
		            $("span#rbTitle"+i).text(data[0][i].rbTitle);
		           	$("span#writer-Time"+i).text(data[0][i].rbDate);
           		}
           	}    
            /* 베스트셀러 별점처리 */
            
            for(var j=0; i<data[1].length; j++)
            {
	            var totalStarScore = scoreRound(data[1][j].starScoreBook);
	           	var selectStarScore = totalStarScore / 0.5;
	           	for(var i=0; i<selectStarScore; i++)
	       		{
	           		$("span#star"+j+"-"+i).addClass('on');
	       		}
            }

        },
        error: function(){
        	console.log("index.jsp_최근리뷰 View, 별점정보를 읽기_광준@ajax처리에 실패했습니다.");
        }
   });
   


    return false; //<- 이 문장으로 새로고침(reload)이 방지됨
});
}; //startPage End
	
$('.starRev span').click(function(){
  $(this).parent().children('span').removeClass('on');
  $(this).addClass('on').prevAll('span').addClass('on');
  return false;
});	

//요소가 비어있는지 검사하는 함수
var isEmpty = function(value){
	if( value == "" || value == null || value == undefined || ( value != null && typeof value == "object" && !Object.keys(value).length ) ){
		return true;
	}else{ 
		return false;
	}
}


/* 베스트셀러 10건을 가져온다. */
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
   			var isbn13 = book.isbn13; //도서분류 고유값
   			var title = book.title; //도서제목
   			var author = book.author; //도서저자
   			var cover = book.cover; //도서이미지
   			
   			bookList.push({"isbn13":isbn13, "title":title, "author":author, "cover":cover});
   		}
    	
    	//난수생성
		var ranNum = new Array();
    	
    	console.log("bookList.length: " + bookList.length);
    	for(var i=0; i<bookList.length; i++)
   		{
   			ranNum[i] = Math.floor(Math.random()*(bookList.length));

   			for(var j=0; j<i; j++)
			{
				if(ranNum[j] == ranNum[i])
				{
					i--;
					continue;
				}
			}
   		}

    	/* 데이터 view 처리*/
		$("span#book0").html((bookList[ranNum[0]].title).length>12?(bookList[ranNum[0]].title).substr(0,12)+"…":(bookList[ranNum[0]].title));
		$("p#book-Author0").html(bookList[ranNum[0]].author);
		$("#bookImage0").attr("src", bookList[ranNum[0]].cover);
		
		$("span#book1").html((bookList[ranNum[1]].title).length>12?(bookList[ranNum[1]].title).substr(0,12)+"…":(bookList[ranNum[1]].title));
		$("p#book-Author1").html(bookList[ranNum[1]].author);
		$("#bookImage1").attr("src", bookList[ranNum[1]].cover);
		
		$("span#book2").html((bookList[ranNum[2]].title).length>12?(bookList[ranNum[2]].title).substr(0,12)+"…":(bookList[ranNum[2]].title));
		$("p#book-Author2").html(bookList[ranNum[2]].author);
		$("#bookImage2").attr("src", bookList[ranNum[2]].cover);
		
		$("span#book3").html((bookList[ranNum[3]].title).length>12?(bookList[ranNum[3]].title).substr(0,12)+"…":(bookList[ranNum[3]].title));
		$("p#book-Author3").html(bookList[ranNum[3]].author);
		$("#bookImage3").attr("src", bookList[ranNum[3]].cover);	
		
		/**
		 * @광준
		 * API로 가져온 도서정보에서 우리 DB의 별점 데이터를 가져오기 위해 변수로 IBSN 정보를 저장한다. 
		 */
		var bookIsbn = [];
		bookIsbn.push(bookList[ranNum[0]].isbn13);
		$("a#detail-Book0").prop('href', "http://localhost:9090/brw/book/bookInfo.do?isbn13=" + bookList[ranNum[0]].isbn13);
		bookIsbn.push(bookList[ranNum[1]].isbn13);
		$("a#detail-Book1").prop('href', "http://localhost:9090/brw/book/bookInfo.do?isbn13=" + bookList[ranNum[1]].isbn13);
		bookIsbn.push(bookList[ranNum[2]].isbn13);
		$("a#detail-Book2").prop('href', "http://localhost:9090/brw/book/bookInfo.do?isbn13=" + bookList[ranNum[2]].isbn13);
		bookIsbn.push(bookList[ranNum[3]].isbn13);
		$("a#detail-Book3").prop('href', "http://localhost:9090/brw/book/bookInfo.do?isbn13=" + bookList[ranNum[3]].isbn13);
		startPage(bookIsbn);
    },
    error:function()
    {
    	console.log("index.jsp_베스트셀러 View_광준@ajax처리에 실패했습니다.");
    }
 });
 
 //0.5반올림
function scoreRound(score)
{
	return Math.ceil(score *2 ) / 2;
}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>