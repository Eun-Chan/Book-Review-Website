<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	String isbn13 = (String)request.getAttribute("isbn13");
	boolean	basketCheck = (Boolean)request.getAttribute("basketCheck");					
%>     


<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bookInfo.css" />
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">

	<br />
	<br />
	<div id="bookInfo-container">
		<div id="bookInfo-img"></div>
		<div id="bookInfo-info">
			<div id="bookInfo-title"></div>
			<span id="bookInfo-author" class="badge badge-author"></span>
			<span id="bookInfo-publisher" class="badge"></span>
			<div id="bookInfo-category"></div>
			<div id="bookInfo-desc"></div>
			<div id="review-rate">
				<div id="start-Container" style="left:0">
			       <div class="starRev0">
					  <span class="starR1" id="star0">별1_왼쪽</span>
					  <span class="starR2" id="star1">별1_오른쪽</span>
					  <span class="starR1" id="star2">별2_왼쪽</span>
					  <span class="starR2" id="star3">별2_오른쪽</span>
					  <span class="starR1" id="star4">별3_왼쪽</span>
					  <span class="starR2" id="star5">별3_오른쪽</span>
					  <span class="starR1" id="star6">별4_왼쪽</span>
					  <span class="starR2" id="star7">별4_오른쪽</span>
					  <span class="starR1" id="star8">별5_왼쪽</span>
					  <span class="starR2" id="star9">별5_오른쪽</span>
					  <span id="starScoreAvg" style="color:red; font-size:20px;"></span>
					</div>
				</div>
			</div>
			<button onclick="basket();" class="btn btn-info" id="basket">즐겨찾기</button>
		</div>

	<div id="hiddenInfo" style="display:none"></div>	
	<div class="clear"></div>
	<br />		
	</div>
	
	<br />
	<hr style="border-color: #b7ecf9; width:1100px;">
	<div id="start-Container2" style="left:0">
	
	<h3 id="oneLineReviewTab">한 줄 리뷰☆</h3>
	<div id="oneLineWrite">
       <div class="starRev0">
		  <span class="starR1 on id="star0">별1_왼쪽</span>
		  <span class="starR2" id="star1">별1_오른쪽</span>
		  <span class="starR1" id="star2">별2_왼쪽</span>
		  <span class="starR2" id="star3">별2_오른쪽</span>
		  <span class="starR1" id="star4">별3_왼쪽</span>
		  <span class="starR2" id="star5">별3_오른쪽</span>
		  <span class="starR1" id="star6">별4_왼쪽</span>
		  <span class="starR2" id="star7">별4_오른쪽</span>
		  <span class="starR1" id="star8">별5_왼쪽</span>
		  <span class="starR2" id="star9">별5_오른쪽</span>
		  <span id="starScoreAvg" style="color:red; font-size:20px;"></span>
		</div>
	</div><br />
	<input type="text" id="oneLineRV" /><button id="btn-oneLineRV" onclick="insert_oneLineRV()">등록</button>
	</div>
	<div id="oneLineView">
		<ul id="ul_oneLineView">
			<li>어디 나오니?</li>
			<li><div id="showStat">별:<i class="fas fa-star"></i></div> 컨탠츠: <span id="oneLineContent"></span> 작성자: <span></span> 작성일: <span></span> <a href="#">삭제</a></li>
		</ul>
	</div>
	<div id="oneLineReview-container"></div>
	
	<br />
	<hr style="border-color: #b7ecf9; width:1100px;">
	<p id="reviewTab">위의 도서로 작성 된 리뷰!</p>
	<div id="command-info"></div>
	
<script>
//한줄 리뷰 별점 클릭시 켜지는 함수
$('div#start-Container2 span').click(function(){
	  $(this).parent().children('span').removeClass('on');
	  $(this).addClass('on').prevAll('span').addClass('on');
	  return false;
	});	

//한 줄 리뷰 등록 함수
function insert_oneLineRV(){
	<%if(user == null){%>
		alert("로그인이 필요합니다!:D");
		return;
	<%}%>
	var starScore = $("div#start-Container2 div.starRev0 span.on").length/2;
	console.log(starScore);
	var oneLineRV = $("#oneLineRV").val();
	console.log(oneLineRV);
	var isbn13 = <%=isbn13%>
	console.log(isbn13);
	$.ajax({
		url: "<%=request.getContextPath()%>/book/oneLineRV.do",
		data: {starScore:starScore, oneLineRV:oneLineRV, isbn13:isbn13},
		success: function(data){
			console.log(data);
			//등록 후 현재 ul>li에 전체 리뷰를 들고와 덮어씌우기
			/* var li = $("<li></li>") */
			
			for(var i in data){
				var html = "<li>";
				var oneLine = data[i];
				
				var starScore = parseFloat(oneLine.starScore);
				
				if(starScore%1 > 0 && starScore >1){//소수점이 있고 1보다 큰 점수
					starScore = Math.ceil(starScore);
					for(var j = 0; j < starScore-1; j++){
						html +="<i class='fas fa-star'></i>";
					}
					html += "<i class='fas fa-star-half-alt'></i>";
				}else if(starScore%1 == 0){//소수점이 없는 점수
					
					for(var i = 0; i < starScore; i++){
						html += "<i class='fas fa-star'></i>";
					}
				}else{//0.5점만 준 경우
					html += "<i class='fas fa-star-half-alt'></i>";
				}
				
				html += "<span class='oneLineContent "+i+"'>"+oneLine.content+"</span>";
				html += "<span class='oneLineUserId "+i+"'>"+oneLine.userId+"</span>";
				html += "<span class='oneLineNow "+i+"'>"+oneLine.now+"</span>";
				html += "<a href='#'>삭제</a><br>";
				html += "</li>";
				/* li.append(html); */
				$("#ul_oneLineView").append(html);
			}
			
		}
	})
};


<%if(user != null && basketCheck == true){%>
	$("button#basket").text("즐겨찾기 취소");
<%}else{%>
	$("button#basket").text("즐겨찾기");
<%}%>


var ISBN13 = <%=isbn13%>;
//bookList에서 특정 책 클릭 시 그 책의 isbn값을 받아와 api를 통해 책을 검색해 온다

$.ajax({
	url: "http://www.aladin.co.kr/ttb/api/ItemLookUp.aspx?ttbkey=ttbkmw71511428001&itemIdType=ISBN13&ItemId="+ISBN13+"&cover=big&output=js&callback=bookDisplay",
	jsonp: "bookDisplay",
	dataType: "jsonp"
});

function bookDisplay(success, data){
	console.log(data);
	
	$("#bookInfo-img").append("<img src='"+data.item[0].cover+"'>");
	$("#bookInfo-title").append("<h3>"+data.item[0].title+"</h3>");
	$("#bookInfo-author").text(data.item[0].author);
	$("#bookInfo-publisher").text(data.item[0].publisher);
	$("#bookInfo-category").text(data.item[0].categoryName);
	$("#bookInfo-desc").text(data.item[0].description);
	
	
	$("#hiddenInfo").append("<span>"+data.item[0].isbn13+"</span>");
	$("#hiddenInfo").append("<span>"+data.item[0].priceStandard+"</span>");
};

$.ajax({
	url: "<%=request.getContextPath()%>/book/bookreviewInfo.do",
	dataType:"json",
	data:"ISBN13="+ISBN13,
	success:function(data) {

		var table = $("<table class='table'><th>"+"제목"+"</th><th>"+"내용"+"</th><th>"+"작성자"+"</th><th>"+"작성일자"+"</th></table>")
		
		if(!data.length > 0 ){
			var html = "<tr><td colspan='4'>해당 데이터가 없습니다.</td></tr>";
			table.append(html);
			$("#starScoreAvg").text("첫 평가자가 되어주세요:D");
		}else{
			
			var sumStarScore = 0;
			var cnt = 0;
			
			for(var i in data) {
				
				var command = data[i];
				var html = "<tr><td><a href='<%=request.getContextPath()%>/review/reviewDetail.do?rbNo="+command.rbNo+"'>"+command.rbTitle+"</a></td>";
				html += "<td id='rbcontent'>"+command.rbContent+"</td>";
				html += "<td>"+command.rbWriter+"</td>";
				html += "<td>"+command.rbDate+"</td></tr>";
	    		table.append(html);
	    		
	    		sumStarScore += command.rbStarscore;
	    		cnt = parseInt(i)+1;
			}
				
				//리뷰 평점이 있는 경우 별 표시!
		
				var totalStarScore = scoreRound(sumStarScore/cnt);
				console.log("totalStarScore", totalStarScore);
	           	var selectStarScore = totalStarScore / 0.5;
	           	console.log("selectStarScore", selectStarScore);
	           	
	           	for(var j=0; j<selectStarScore; j++){
	           		$("div#start-Container span#star"+j).addClass('on');
	       		}
	           	$("#starScoreAvg").text("("+totalStarScore+ "/5.0)");
			
		}
		
		$("#command-info").html(table);
	},
	error:function(){
		console.log("실패");
	}
});

function scoreRound(score){
	return Math.ceil(score *2 ) / 2;
}

function basket(){

	<%if(user == null){%>
		alert("로그인 후 사용이 가능합니다!:D")
		return;
	<%}%>

	var title = $("#bookInfo-title h3").text();
	var author = $("#bookInfo-author").text();
	var isbn13 = $("#hiddenInfo span:nth(0)").text();
	var priceStandard = $("#hiddenInfo span:nth(1)").text();
	var publisher = $("#bookInfo-publisher").text();
	
	location.href="<%=request.getContextPath()%>/book/basket.do?title="+title+"&author="+author+"&isbn13="+isbn13+"&priceStandard="+priceStandard+"&publisher="+publisher;
	
};
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>