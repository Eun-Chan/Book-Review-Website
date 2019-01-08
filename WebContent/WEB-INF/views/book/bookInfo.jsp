<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	String isbn13 = (String)request.getAttribute("isbn13");
	boolean	basketCheck = (Boolean)request.getAttribute("basketCheck");					
%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BookInformationTest</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/bootstrap.css" />
<script src="<%=request.getContextPath()%>/js/jquery-3.3.1.js"></script>
<script src="<%=request.getContextPath() %>/js/bootstrap.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bookInfo.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/custom.css">
<style>
p#reviewTab{
	font-size: 24px;
	font-weight: bold;
	text-align: center;
}
</style>
</head>
<body>
	<!-- <br />
	<label for="bookInfo-titleSrc">책제목입력 : </label>
	<input type="text" id="bookInfo-titleSrc" />
	<button id="btn">확인</button> -->
	<br />
	<br />
	<div id="bookInfo-container">
	<table>
		<tr>
			<td><div id="bookInfo-img"></div></td>
			<td width="15"></td>
			<td style="max-width: 700px">
				<table>
					<tr>
						<td width="66"><span>제목: </span></td>
						<td><div id="bookInfo-title"></div></td>
					</tr>
					<tr>
						<td width="66"><span>저자: </span></td>
						<td><div id="bookInfo-author"></div></td>
					</tr>
					<tr>
						<td width="66"><span>출판사: </span></td>
						<td><div id="bookInfo-publisher"></div></td>
					</tr>
					<tr>
						<td width="66"><span>카테고리 : </span></td>
						<td><div id="bookInfo-category"></div></td>
					</tr>
					<tr>
						<td width="66"><span>책 소개: </span></td>
						<td><div id="bookInfo-desc"></div></td>
					</tr>
					<tr>
						<td width="66"><span>리뷰 별점: </span></td>
						<td><div id="start-Container" style="left:0">
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
						</td>
					</tr>				
				</table>
				<br />
				<button onclick="basket();" class="btn btn-info" id="basket">즐겨찾기</button>
			</td>
		</tr>
	</table>
	<div id="hiddenInfo" style="display:none"></div>	
	<br />		
	</div>
	<br />
	<hr style="background-color:blue">
	<p id="reviewTab">위의 도서로 작성 된 리뷰!</p>
	<div id="command-info"></div>
	
<script>
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
console.log("ajax1번째 종료");

function bookDisplay(success, data){
	console.log(data);
	
	$("#bookInfo-img").append("<img src='"+data.item[0].cover+"'>");
	$("#bookInfo-title").append("<span>"+data.item[0].title+"</span>");
	$("#bookInfo-author").append("<span>"+data.item[0].author+"</span>");
	$("#bookInfo-publisher").append("<span>"+data.item[0].publisher+"</span>");
	$("#bookInfo-category").append("<span>"+data.item[0].categoryName+"</span>");
	$("#bookInfo-desc").append("<span id='bookInfodsp'>"+data.item[0].description+"</span>");
	
	
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
	           		$("span#star"+j).addClass('on');
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

	var title = $("#bookInfo-title span").text();
	var author = $("#bookInfo-author span").text();
	var isbn13 = $("#hiddenInfo span:nth(0)").text();
	var priceStandard = $("#hiddenInfo span:nth(1)").text();
	var publisher = $("#bookInfo-publisher span").text();
	
	location.href="<%=request.getContextPath()%>/book/basket.do?title="+title+"&author="+author+"&isbn13="+isbn13+"&priceStandard="+priceStandard+"&publisher="+publisher;
	
};
</script>
</body>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>