<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@page import="java.util.List"%>
<%
	String isbn13 = (String)request.getAttribute("isbn13");
	boolean	basketCheck = (Boolean)request.getAttribute("basketCheck");		
	List<OneLineReviewDTO> oneLineList = (List<OneLineReviewDTO>)request.getAttribute("oneLineList");
	double oneLineStar = 0.0;
%>     


<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bookInfo.css" />
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
<style>
li.oneLineReview{
	display: none;
	width: 650px;
}
li.oneLineReview span#right{
	float: right;
}
li.oneLineReview span.oneLineNow, li.oneLineReview a, li.oneLineReview span.oneLineContent{
	padding-left: 10px;
}

#btn_moreReview{
	float: right;
	margin-bottom: 15px;
}
div#seller{
	display: inline-block;
    background-color: skyblue;
    border-radius: 20px;
}
i.fas.fa-star-half-alt, i.fas.fa-star{
	color: yellow;
}
div#start-Container1 span.starR1, div#start-Container1 span.starR2,
div#start-Container3 span.starR1, div#start-Container3 span.starR2
{
	cursor: unset!important;
}
</style>
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
				<div id="start-Container1" style="left:0">
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
					  <span id="starScoreAvg1" style="color:red; font-size:20px;"></span>
					</div>
				</div>
			</div>
			<br /><br />
			<%if(user == null||!user.getUserId().equals("admin")) {%>
				<button onclick="basket();" class="btn btn-info" id="basket">즐겨찾기</button>
			<%} %>
			<div id="seller">
			<a id="moveAladin" target="_sub" style="font-size:18px; text-decoration:none; color:white;"><img src="<%=request.getContextPath()%>/images/aladin_logo.gif" width="70px;"/> 알라딘에서 구매하기<span id="aladinPrice" style="font-size:16px; padding-left: 20px; display: inline-block;color:white;"></span></a>
			
			</div>
			
		</div>

	<div id="hiddenInfo" style="display:none"></div>	
	<div class="clear"></div>
	<br />		
	</div>
	
	<br />
	<hr style="border-color: #b7ecf9; width:1100px;">
	
	<div id="oneLineReview-container">
	
		<div id="start-Container2" style="left:0">
		<span>한 줄 리뷰 평점: </span><span id="oneLineSSAVG"></span>
		<span id="oneLineSSShowScore"></span>
		<h3 id="oneLineReviewTab">한 줄 리뷰☆</h3>
		<div id="oneLineWrite">
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
			  <span id="starScoreAvg" style="color:red; font-size:20px;"></span>
			</div>
		</div><br />
		<input type="text" id="oneLineRV" /><button id="btn-oneLineRV" onclick="insert_oneLineRV()">등록</button>
		</div>
		
		<div id="oneLineView">
			<ul id="ul_oneLineView">
				
				<%if(oneLineList != null){ 
					for(int i = 0; i < oneLineList.size(); i++){
				%>
						<li class="oneLineReview">
							<%
								
								double starScore = oneLineList.get(i).getStarScore();
								
								if(starScore%1 > 0 && starScore >1){//소수점이 있고 1보다 큰 점수
									starScore = Math.ceil(starScore*2)/2;
									for(int k = 0; k < starScore-1; k++){
										%><i class='fas fa-star'></i><%
									}
									%><i class='fas fa-star-half-alt'></i><%
									for(int k = 0; k < 5-(starScore+1); k++){//4.5
										%><i class='fas fa-star' style='visibility: hidden;'></i><%
									}
									
								}else if(starScore%1 == 0){//소수점이 없는 점수
									
									for(int k = 0; k < starScore; k++){
										%><i class='fas fa-star'></i><%
									}
									for(int k = 0; k < 5-starScore; k++){//4.5
										%><i class='fas fa-star' style='visibility: hidden;'></i><%
									}
								}else{//0.5점만 준 경우
									%><i class='fas fa-star-half-alt'></i><%
									for(int k = 0; k < 5-(starScore+1); k++){//4.5
										%><i class='fas fa-star' style='visibility: hidden;'></i><%
									}
								}
								
								oneLineStar += starScore;
															
								
								%><span class='oneLineContent <%=i%>'><%=oneLineList.get(i).getContent() %></span>
								<span id="right">
									<span class='oneLineUserId <%=i%>'><%= oneLineList.get(i).getUserId()%></span>
									<span class='oneLineNow <%=i%>'><%=oneLineList.get(i).getNow() %></span>
									<a onclick='oneLineDel(<%=oneLineList.get(i).getNo()%>,"<%=oneLineList.get(i).getUserId()%>",event);'>[삭제]</a>
								</span><br>
								
						</li>
				<% 	}
					if(oneLineList.size() > 10){%><button id="load" type="button" class="btn btn-primary btn-sm">더보기</button>
					<%
					}		
					
					oneLineStar=oneLineStar/oneLineList.size();//한 줄 리뷰의 별점 평균
				}else {
					%>
						<script>$("#oneLineSSShowScore").text("0 /5");</script>
					
				<%}%>
	
			</ul>
		</div>

	</div>
	
	<br />
	<hr style="border-color: #b7ecf9; width:1100px;">
	
	<div id="command-info">
		<p id="reviewTab">위의 도서로 작성 된 리뷰!</p>
		<div id="review-rate3">
			<span>리뷰 게시판 평점 :</span><span id="starScoreAvg3" style="color:block; font-size:16px;"></span>
			<div id="start-Container3" style="left:0">
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
				  
				</div>
			</div>
		</div>
	
		<button id="btn_moreReview" class="btn btn-primary">더보기!</button>

	</div>
	
<script>
//한 줄 리뷰 10줄씩 보게끔 하는 함수
function showOneLine(){
$("li.oneLineReview").hide();
$("li.oneLineReview").slice(0,10).show();

if($("li.oneLineReview").length == 0 || $("li.oneLineReview:hidden").length == 0){
	$("button#load").hide();
}

$("button#load").click(function(){

	$("li.oneLineReview:hidden").slice(0,10).show();
	
	if($("li.oneLineReview:hidden").length == 0){
		$("button#load").hide();
	}
	
	
});
};
showOneLine();

//리뷰게시판 5개만 표시되고 더보기 버튼 누를시 리뷰 게시판으로 현재 책으로 검색된 결과 보기
function showReviewBoard(){
	$("tr.reviewBoard").hide();
	$("tr.reviewBoard").slice(0,5).show();
	
	$("#btn_moreReview").click(function(){
		var bookTitle = $("div#bookInfo-title h3").text();
		location.href="<%=request.getContextPath()%>/review/reviewSearch.do?searchType=rb_booktitle&searchKeyword="+bookTitle;
	});
};



var totalStarScore = 0.0;//리뷰 총평점 평균

//화면 로드 시한 줄 리뷰 총 평점
var oneLinetotalStar = <%=oneLineStar%>;
function showLoadOneLineSS(){
	console.log("oneLinetotalStar", oneLinetotalStar);
	
	if(oneLinetotalStar > 0){				
		$("#oneLineSSShowScore").text((Math.ceil(oneLinetotalStar*100)/100)+" /5");	
	}else{
		$("#oneLineSSShowScore").text("0 /5");	
	}	
}
showLoadOneLineSS();

oneLinetotalStar = Math.ceil(oneLinetotalStar*2)/2;
//소수점이 있고 1보다 큰 점수
if(oneLinetotalStar%1 > 0 && oneLinetotalStar >1){
	for(var j = 0; j < oneLinetotalStar-1; j++){
		$("#oneLineSSAVG").append("<i class='fas fa-star'></i>");
	}
	$("#oneLineSSAVG").append("<i class='fas fa-star-half-alt'></i>");
}else if(oneLinetotalStar%1 == 0){
	//소수점이 없는 점수
	for(var i = 0; i < oneLinetotalStar; i++){
		$("#oneLineSSAVG").append("<i class='fas fa-star'></i>");
	}
}else if(isNaN(oneLinetotalStar)){
	$("#oneLineSSAVG").append("<span>등록된 한 줄 리뷰가 없어요!</span>");
}else{//0.5점만 준 경우
	$("#oneLineSSAVG").append("<i class='fas fa-star-half-alt'></i>");
}

//한 줄 리뷰 별점 클릭시 켜지는 함수
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
	
	var oneLineRV = $("#oneLineRV").val();

	//DB에 미등록 되어있는 책일 시 등록하기 위해 필요한 변수
	if(oneLineRV.length == 0){
		alert("리뷰를 작성하세요!");
		return;
	}else if(oneLineRV.length > 50){
		alert("50자 이내로 작성 가능합니다!");
		return;
	}
	
	var title = $("#bookInfo-title h3").text();
	var author = $("#bookInfo-author").text();
	var isbn13 = $("#hiddenInfo span:nth(0)").text();
	var priceStandard = $("#hiddenInfo span:nth(1)").text();
	var publisher = $("#bookInfo-publisher").text();

	$.ajax({
		url: "<%=request.getContextPath()%>/book/oneLineRV.do",
		data: {starScore:starScore, oneLineRV:oneLineRV, title:title, author:author, isbn13:isbn13, priceStandard:priceStandard, publisher:publisher},
		success: function(data){
			console.log(data);
			
			var oneLineSS = 0.0;
			
			//등록 후 현재 ul>li에 전체 리뷰를 들고와 덮어씌우기
			var html = "";
			for(var i in data){
				html += "<li class='oneLineReview'>";
				var oneLine = data[i];
				
				var starScore = parseFloat(oneLine.starScore);
				oneLineSS += starScore;
				
				if(starScore%1 > 0 && starScore >1){//소수점이 있고 1보다 큰 점수
					//starScore = Math.ceil(starScore);
					for(var j = 0; j < starScore-1; j++){
						html +="<i class='fas fa-star'></i>";
					}
					html += "<i class='fas fa-star-half-alt'></i>";
					for(var k = 0; k < 5-(starScore+1); k++){//4.5
						html += "<i class='fas fa-star' style='visibility: hidden;'></i>";
					}
				}else if(starScore%1 == 0){//소수점이 없는 점수
					
					for(var i = 0; i < starScore; i++){
						html += "<i class='fas fa-star'></i>";
					}
					for(var k = 0; k < 5-(starScore); k++){//4
						html += "<i class='fas fa-star' style='visibility: hidden;'></i>";
					}
				}else{//0.5점만 준 경우
					html += "<i class='fas fa-star-half-alt'></i>";
					for(var k = 0; k < 5-(starScore+1); k++){//4.5
						html += "<i class='fas fa-star' style='visibility: hidden;'></i>";
					}
				}
				
				html += "<span class='oneLineContent "+i+"'>"+oneLine.content+"</span>";
				html += "<span id='right'><span class='oneLineUserId "+i+"'>"+oneLine.userId+"</span>";
				html += "<span class='oneLineNow "+i+"'>"+oneLine.now+"</span>";
				html += "<a onclick='oneLineDel("+oneLine.no+",\""+oneLine.userId+"\", event)'>[삭제]</a></span><br>";
				html += "</li>";

			}
				html += "<button id='load' type='button' class='btn btn-primary btn-sm'>더보기</button>";
				$("#ul_oneLineView").html(html);
			
			oneLineSS = oneLineSS/data.length;
			showOneLineSS(oneLineSS);
			//한 줄 리뷰 새로 입력시 새로운 별 평점 보여주기
			//별점 합계가 표시되는 별점 변경 함수 실행
			var tempReviewSS = $("#starScoreAvg3").text().split(" ");
			showBookSumStarScore(parseFloat(tempReviewSS[0]));
			showOneLine();
			
			//리뷰 작성 완료시 작성 부분 초기화
			$("#oneLineRV").val("");
			for(var j=1; j<10; j++){
		   		$("div#start-Container2 span#star"+j).removeClass('on');
				}	
			
		}
	})
};

//새로운 한 줄 리뷰 작성 시 별 평점 새로 바꾸기
function showOneLineSS(oneLineSS){
		
	$("#oneLineSSShowScore").text(Math.ceil(oneLineSS*100)/100+" /5");
	oneLineSS = Math.ceil(oneLineSS*2)/2;
	console.log("oneLineSS", oneLineSS)
	$("#oneLineSSAVG").html("");
	
	if(oneLineSS%1 > 0 && oneLineSS >1){//소수점이 있고 1보다 큰 점수
		for(var j = 0; j < oneLineSS-1; j++){
			$("#oneLineSSAVG").append("<i class='fas fa-star'></i>");
		}
		$("#oneLineSSAVG").append("<i class='fas fa-star-half-alt'></i>");
	}else if(oneLineSS%1 == 0){//소수점이 없는 점수
		
		for(var i = 0; i < oneLineSS; i++){
			$("#oneLineSSAVG").append("<i class='fas fa-star'></i>");
		}
	}else if(oneLineSS < 1 && oneLineSS%1 > 0){//0.5점만 준 경우
		$("#oneLineSSAVG").append("<i class='fas fa-star-half-alt'></i>");
	
	} else {//모든 한 줄 리뷰가 삭제됐을 경우
		$("#oneLineSSAVG").append("<span>등록된 한 줄 리뷰가 없어요!</span>");
	}
}

//로그인한 회원이 책 상세보기에 들어왔을 때 즐겨찾기 등록 여부에 따라 버튼이 변경됨.
<%if(user != null && basketCheck == true){%>
	$("button#basket").text("취소");
<%}else{%>
	$("button#basket").text("즐겨찾기");
<%}%>


var ISBN13 = <%=isbn13%>;
//bookList에서 특정 책 클릭 시 그 책의 isbn값을 받아와 api를 통해 책을 검색해 온다
//책 상세보기를 불러오기 위한 ajax로 알라딘 open api에서 받아온다
$.ajax({
	url: "http://www.aladin.co.kr/ttb/api/ItemLookUp.aspx?ttbkey=ttbkmw71511428001&itemIdType=ISBN13&ItemId="+ISBN13+"&cover=big&output=js&callback=bookDisplay",
	jsonp: "bookDisplay",
	dataType: "jsonp"
});

//알라딘 api callback함수: view단
function bookDisplay(success, data){
	console.log(data);
	
	$("#bookInfo-img").append("<img src='"+data.item[0].cover+"'>");
	$("#bookInfo-title").append("<h3>"+data.item[0].title+"</h3>");
	$("#bookInfo-author").text(data.item[0].author);
	$("#bookInfo-publisher").text(data.item[0].publisher);
	$("#bookInfo-category").text(data.item[0].categoryName);
	$("#bookInfo-desc").text(data.item[0].description);
	$("#moveAladin").attr("href",data.item[0].link);
	$("#aladinPrice").text(data.item[0].priceSales+"원");
	
	$("#hiddenInfo").append("<span>"+data.item[0].isbn13+"</span>");
	$("#hiddenInfo").append("<span>"+data.item[0].priceStandard+"</span>");
	
};




//책 상세보기에서 이 책으로 작성된 리뷰를 들고오기 위한 ajax
$.ajax({
	url: "<%=request.getContextPath()%>/book/bookreviewInfo.do",
	dataType:"json",
	data:"ISBN13="+ISBN13,
	success:function(data) {
		console.log("reviewboard",data)
		var table = $("<table class='table'><th>"+"제목"+"</th><th>"+"내용"+"</th><th>"+"작성자"+"</th><th>"+"작성일자"+"</th></table>")
		
		var sumStarScore = 0;
		var cnt = 0;
		
		if(!data.length > 0 ){
			var html = "<tr><td colspan='4'>해당 데이터가 없습니다.</td></tr>";
			table.append(html);
			$("#starScoreAvg3").text("첫 평가자가 되어주세요:D");
		}else{
			
			
			for(var i in data) {
				
				var command = data[i];
				var html = "<tr class='reviewBoard'><td><a href='<%=request.getContextPath()%>/review/reviewDetail.do?rbNo="+command.rbNo+"'>"+command.rbTitle+"</a></td>";
				html += "<td id='rbcontent'>"+command.rbContent+"</td>";
				html += "<td><img src='<%=request.getContextPath()%>/images/userGradeImage/"+command.userGrade+".svg' width='30px'>"+command.userNickName+"</td>";
				html += "<td>"+command.rbDate+"</td></tr>";
	    		table.append(html);
	    		
	    		sumStarScore += command.rbStarscore;
	    		cnt = parseInt(i)+1;
			}
		}	
				//리뷰 평점이 있는 경우 별 표시!
		
				if(cnt == 0){
					cnt = 1;
				}
				totalStarScore = scoreRound(sumStarScore/cnt);
	           	var selectStarScore = totalStarScore / 0.5;
	           	
	         	
	          //리뷰에 별점을 계산해 표시하기 위한 식
	           	for(var j=0; j<selectStarScore; j++){
	           		$("div#start-Container3 span#star"+j).addClass('on');
	       		}
	           	$("#starScoreAvg3").text(totalStarScore+ " /5.0");
	           	
	           	//리뷰와 한 줄 리뷰의 별점을 모아 표시하기 위한 함수 호출
	          	showBookSumStarScore(totalStarScore);//리뷰게시판 별점 보냄
	          	
				//리뷰 게시판 더보기는 5개를 넘어가는 경우만 표시되게
				if(data.length > 5){
					$("#btn_moreReview").show();
				}else{
					$("#btn_moreReview").hide();
				}
		
		$("#command-info").append(table);
		showReviewBoard();
	},
	error:function(){
		console.log("실패");
	}
});


function scoreRound(score){
	return Math.ceil(score *2 ) / 2;
	//리뷰게시판의 별점 평균을 받아옴
   	totalStarScore = score;
}

//한 줄 리뷰와 리뷰게시판의 평점 평균을 받아와 합쳐 책의 별점으로 표시하게 만들기
function showBookSumStarScore(score){

	var starScoreOneLineAvg = $("#oneLineSSShowScore").text().split(" ");
	if(starScoreOneLineAvg[0] == "NaN"){
		starScoreOneLineAvg = 0.0;
	}else{
		starScoreOneLineAvg = parseFloat(starScoreOneLineAvg[0]);//한 줄 리뷰 총 평점	
	}
	console.log("starScoreOneLineAvg",starScoreOneLineAvg);
	if(score == "NaN"){
		score = 0.0;
	}
	var starScoreReviewAvg = score;//리뷰 게시판 총 평점
	console.log("starScoreReviewAvg", starScoreReviewAvg);
	var total = 0.0;
	
	if(starScoreOneLineAvg != 0 && starScoreReviewAvg != 0){
		total = Math.ceil((starScoreOneLineAvg+starScoreReviewAvg)/2*100)/100;		
	}else if(starScoreOneLineAvg == 0){
		total = starScoreReviewAvg;
	}else if(starScoreReviewAvg == 0){
		total = starScoreOneLineAvg;
	}
	console.log("total", total);
	if(total > 0){
		for(var j=0; j<total*2; j++){
	   		$("div#start-Container1 span#star"+j).addClass('on');
			}		
	}else if(total == 0){
		console.log("안들어오나?")
		for(var j=0; j<10; j++){
	   		$("div#start-Container1 span#star"+j).removeClass('on');
			}	
	}
   	$("#starScoreAvg1").text(total+ " /5.0");
		
}
//한 줄 리뷰 삭제 클릭시 작동 되는 함수
function oneLineDel(oneLineNo, userId, event){
	var ect = event.currentTarget.parentElement.parentElement;//li를 가리키게 함
	console.log("ect부모", ect);
	//클릭한 곳의 event타겟을 들고 와 그것을 포함한 li태그를 선택 
	<%if(user != null){%>
	
	if(userId == "<%=user.getUserId()%>" || "admin" == "<%=user.getUserId()%>"){
		confirm("정말로 삭제 하시겠습니까?");
		$.ajax({
			url: "<%=request.getContextPath()%>/book/oneLineDel.do",
			data: {userId:userId, oneLineNo:oneLineNo, isbn13:<%=isbn13%>},
			success:function(data){
				$(ect).remove();
				console.log(data);
				var sumStarScore = 0.0;
				for(var i in data){
					var starScore = data[i].starScore;
					sumStarScore += starScore;
				}
				//한 줄 리뷰 별점 수정을 위한 함수
				showOneLineSS(sumStarScore/data.length);
				//별점 합계가 표시되는 별점 변경 함수 실행
				if(data.length == 0){
					showBookSumStarScore($("#starScoreAvg3").text().split(" ")[0]);
				}else{
					var tempReviewSS = $("#starScoreAvg3").text().split(" ");
					showBookSumStarScore(parseFloat(tempReviewSS[0]));				
				}

				if($("li.oneLineReview").length == 0){
					$("button#load").hide();
				}//아무런 한 줄 리뷰가 없으면 버튼 안보이기
				
				if($("#oneLineSSShowScore").text() == "NaN /5"){
					$("#oneLineSSShowScore").text("0 /5");
				}//아무런 한 줄 리뷰가 없을 경우 0점 표기
				
				
			}
		});
	}else{
		alert("본인의 게시글만 삭제 가능합니다!");
	}

	
	
	<%}%>
}

//즐겨찾기 버튼 누르면 사용되는 함수
function basket(){

	<%if(user == null){%>
		alert("로그인 후 사용이 가능합니다!:D")
		return;
	<%}%>
	//DB에 등록되지 않은 책인 경우 추가
	var title = $("#bookInfo-title h3").text();
	var author = $("#bookInfo-author").text();
	var isbn13 = $("#hiddenInfo span:nth(0)").text();
	var priceStandard = $("#hiddenInfo span:nth(1)").text();
	var publisher = $("#bookInfo-publisher").text();
	var basketCheck = $("button#basket").text();
	//즐겨찾기 추가
	
	$.ajax({
		url:"<%=request.getContextPath()%>/book/basket.do?title="+title+"&author="+author+"&isbn13="+isbn13+"&priceStandard="+priceStandard+"&publisher="+publisher,
		success: function(data){
			console.log("hi");
			if(basketCheck == "즐겨찾기"){
				$("button#basket").text("취소");	
			}else if(basketCheck == "취소"){
				$("button#basket").text("즐겨찾기");	
			}
		}		
	});
	
};
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>