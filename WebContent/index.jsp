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
<body onload="startPage()">
	<!-- Header -->
	<jsp:include page="header.jsp"></jsp:include>
	
	<!-- Body -->
	<a href="reviewList.do">헤헤</a>
	<a href="review/reviewList.do">리뷰게시판</a>
	<a href="book/bookInfo.do">해리포터상세보기테스트</a>
	<a href="book/bookList.do">도서검색테스트</a>
	
	<!-- 인기도서 출력 Start -->
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
			  <span class="starR1 on" id="star0">별1_왼쪽</span>
			  <span class="starR2" id="star1">별1_오른쪽</span>
			  <span class="starR1" id="star2">별2_왼쪽</span>
			  <span class="starR2" id="star3">별2_오른쪽</span>
			  <span class="starR1" id="star4">별3_왼쪽</span>
			  <span class="starR2" id="star5">별3_오른쪽</span>
			  <span class="starR1" id="star6">별4_왼쪽</span>
			  <span class="starR2" id="star7">별4_오른쪽</span>
			  <span class="starR1" id="star8">별5_왼쪽</span>
			  <span class="starR2" id="star9">별5_오른쪽</span>
			</div>
			</div>
			<br />
	       <p><a href="#" class="btn btn-primary" role="button">구매하기</a> <a href="#" class="btn btn-default" role="button">더 보기</a></p>
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
	       <p><a href="#" class="btn btn-primary" role="button">구매하기</a> <a href="#" class="btn btn-default" role="button">더 보기</a></p>
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
	       <p><a href="#" class="btn btn-primary" role="button">구매하기</a> <a href="#" class="btn btn-default" role="button">더 보기</a></p>
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
	      <p><a href="#" class="btn btn-primary" role="button">구매하기</a> <a href="#" class="btn btn-default" role="button">더 보기</a></p>
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
    
    <!-- footer -->
    <jsp:include page="footer.jsp"></jsp:include>
	
<script>
function startPage(){
/* 최근리뷰 view */
$('#indexForm').ready(function(){
	
   $.ajax({
        type: 'post',
        url: "<%=request.getContextPath()%>/index.do",
        dataType: "json",
        contentType: "application/json; charset=utf-8;",
        success: function(data){
        	console.log(data);
            for(var i in data[0])
           	{
            	if(data[i] != null && !(isEmpty(data[0][i]))) //isEmpty함수가 없기 때문에, 직접 정의한다.(하단에 변수참고)
           		{
	            	$("span#bookName"+i).text(data[0][i].rbBookTitle);
		            $("span#nickName"+i).text(data[0][i].rbWriter + " | ");
		            $("span#rbTitle"+i).text(data[0][i].rbTitle);
		           	$("span#writer-Time"+i).text(data[0][i].rbDate);
           		}
           	}    
            /* 베스트셀러 별점처리 */
            var totalStarScore = scoreRound(data[1][0].starScoreBook);
           	var selectStarScore = totalStarScore / 0.5;
           	for(var i=0; i<selectStarScore; i++)
       		{
           		$("span#star"+i).addClass('on');
           		console.log("아");
       		}
        },
        error: function(){
        	console.log("실패");
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
   			var itemId = book.itemId; //도서분류 고유값
   			var title = book.title; //도서제목
   			var author = book.author; //도서저자
   			var cover = book.cover; //도서이미지
   			
   			bookList.push({"itemId":itemId, "title":title, "author":author, "cover":cover});
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
		$("span#book0").html((bookList[ranNum[0]].title).length>12?(bookList[ranNum[0]].title).substr(0,12)+"...":(bookList[ranNum[0]].title));
		$("p#book-Author0").html(bookList[ranNum[0]].author);
		$("#bookImage0").attr("src", bookList[ranNum[0]].cover);
		
		$("span#book1").html((bookList[ranNum[1]].title).length>12?(bookList[ranNum[1]].title).substr(0,12)+"...":(bookList[ranNum[1]].title));
		$("p#book-Author1").html(bookList[ranNum[1]].author);
		$("#bookImage1").attr("src", bookList[ranNum[1]].cover);
		
		$("span#book2").html((bookList[ranNum[2]].title).length>12?(bookList[ranNum[2]].title).substr(0,12)+"...":(bookList[ranNum[2]].title));
		$("p#book-Author2").html(bookList[ranNum[2]].author);
		$("#bookImage2").attr("src", bookList[ranNum[2]].cover);
		
		$("span#book3").html((bookList[ranNum[3]].title).length>12?(bookList[ranNum[3]].title).substr(0,12)+"...":(bookList[ranNum[3]].title));
		$("p#book-Author3").html(bookList[ranNum[3]].author);
		$("#bookImage3").attr("src", bookList[ranNum[3]].cover);	
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

<%@ include file="/footer.jsp" %> 