<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.brw.dto.ReviewBoardDTO" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script type="text/javascript" src="<%=request.getContextPath() %>/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
$(function(){
	
	// 스마트에디터용 시작
	var oEditors = [];

	nhn.husky.EZCreator.createInIFrame({
	
	    oAppRef: oEditors,
	    elPlaceHolder: "rbContent",
	    sSkinURI: "<%=request.getContextPath() %>/se2/SmartEditor2Skin.html",
	    fCreator: "createSEditor2"
	
	});
	// 스마트 에디터용 끝
	
	
	$("#btnSave").on("click",function(){
		// id가 rbContent인 textarea에 에디터에서 대입
        oEditors.getById["rbContent"].exec("UPDATE_CONTENTS_FIELD", []);
		
		// 유효성 검사는 이곳에서
     	// 리뷰 제목
    	if($("input[name=rbTitle]").val().trim().length == 0){
    		alert("리뷰 제목을 입력하세요.");
    		return;
    	}
    	// 리뷰 내용
    	if($("textarea[name=rbContent]").val().trim() == "<p><br></p>"){
    		alert("리뷰 내용을 입력하세요.");
    		return;
    	}
    	// 도서 정보
    	if($("input[name=rbBookTitle]").val().trim().length == 0){
    		alert("도서를 선택하세요.");
    		return;
    	}
    	if($("input[name=rbIsbn]").val().trim().length == 0){
    		alert("도서를 선택하세요.");
    		return;
    	}
    	// 별점
    	if($("input[name=rbStarscore]").val() == 0){
    		alert("별점을 입력하세요.");
    		return;
    	}
    	
		
		// form 제출
		$("#write-form").submit();

	});
	
	// 도서 검색 버튼 리스너
	$("#btnSearch").on("click",function(){
		// 팝업창 띄우기
		var popup = open("<%=request.getContextPath()%>/review/bookSearch.do","도서 검색","left=300px, top=100px, height=500px, width=925px");
	});
	
	
	/* 별점 jquery 시작 */
	$('.starRev span').click(function(){
	  $(this).parent().children('span').removeClass('on');
	  $(this).addClass('on').prevAll('span').addClass('on');
	  // 별점 히든태그에 밸류값 넣기
	  var starScore = $("span.on").length * 0.5;
	  $("input[name=rbStarscore]").val(starScore);
	  // 별점별 텍스트 변경
	  var spanStar = $("span#starscore");
	  switch(starScore){
	  case 0.5 : spanStar.text("최악이에요"); break;
	  case 1 : spanStar.text("싫어요");; break;
	  case 1.5 : spanStar.text("재미없어요");; break;
	  case 2 : spanStar.text("별로에요");; break;
	  case 2.5 : spanStar.text("부족해요");; break;
	  case 3 : spanStar.text("보통이에요");; break;
	  case 3.5 : spanStar.text("볼만해요");; break;
	  case 4 : spanStar.text("재미있어요");; break;
	  case 4.5 : spanStar.text("훌륭해요");; break;
	  case 5 : spanStar.text("최고에요");; break;
	  }
	});	
	/* 별점 jquery 끝 */
	
	/* 초기화 버튼 */
	$("button[type=reset]").on("click",function(){
		oEditors.getById["rbContent"].exec("SET_IR",[""]);
		$('.starRev span').removeClass("on");
		$("span#starscore").text("");
	});
	
	/* 취소 버튼 */
	$("button#cancel").on("click",function(){
		location.href = "<%=request.getContextPath()%>/review/reviewList.do";
	});
	
	
	
});


</script>
<style>
div#write-container{
	width: 950px;
	margin: 0 auto;
}
div#write-container textarea{
	width: 945px;
}
input#rbBookTitle{
	display: inline-block;
	width: 400px;
}

/* 별점 css 시작 */
.starRev{
	display: inline-block;
	/* width: 300px; */
}
.starR1{
    background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat -52px 0;
    background-size: auto 100%;
    width: 15px;
    height: 30px;
    float: left;
    text-indent: -9999px;
    cursor: pointer;
}
.starR2{
    background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat right 0;
    background-size: auto 100%;
    width: 15px;
    height: 30px;
    float: left;
    text-indent: -9999px;
    cursor: pointer;
}
.starR1.on{background-position:0 0;}
.starR2.on{background-position:-15px 0;}
/* 별점 css 끝 */

/* 별점별 평가내용 */
#starscore{
	font-size: 2em;
}

</style>
</head>
<body>
	<div id="form-container" class="container-fluid">
		<h2>리뷰 작성 페이지</h2>
		<form action="<%=request.getContextPath() %>/review/reviewWriteEnd.do" name="write_form" id="write-form">
			<div class="form-group" id="write-container">
				<!-- 글제목 인풋태그 -->
				<input type="text" name="rbTitle" class="form-control" placeholder="제목" />
				<!-- 작성자 히든태그 -->
				<input type="hidden" name="rbWriter" value="<%=user.getUserId()%>"/>
				<!-- 도서명 인풋태그 -->
				리뷰할 도서 : <input type="text" name="rbBookTitle" class="form-control" id="rbBookTitle" readonly/>
				<!-- ISBN 히든태그 -->
				<input type="hidden" name="rbIsbn" />
				<!-- 도서 정보 저장용 히든태그 -->
				<input type="hidden" name="bookAuthor" />
				<input type="hidden" name="bookPriceStandard" />
				<input type="hidden" name="bookPublisher" />
				<!-- 책검색용 팝업 버튼 -->
				<button type="button" class="btn btn-primary" id="btnSearch">도서 검색</button>
				<!-- 별점 -->
				<br />
				<!-- 별점 히든태그 -->
				<input type="hidden" name="rbStarscore" />
				<div class="starRev">
					<span class="starR1">별1_왼쪽</span>
					<span class="starR2">별1_오른쪽</span>
					<span class="starR1">별2_왼쪽</span>
					<span class="starR2">별2_오른쪽</span>
					<span class="starR1">별3_왼쪽</span>
					<span class="starR2">별3_오른쪽</span>
					<span class="starR1">별4_왼쪽</span>
					<span class="starR2">별4_오른쪽</span>
					<span class="starR1">별5_왼쪽</span>
					<span class="starR2">별5_오른쪽</span>
				</div>
				<!-- 별점별 평가내용 -->
				<span id="starscore"></span>
				
				<!-- 스마트에디터용 텍스트에어리어 -->
				<textarea name="rbContent" id="rbContent" rows="17" cols="100" class="form-control"></textarea>
			</div>
			<div id="btn-group" class="text-center">
			<button type="button" class="btn btn-success" id="btnSave">등록</button>
			<button type="reset" class="btn btn-warning">초기화</button>
			<button type="button" class="btn btn-danger" id="cancel">취소</button>
			</div>
		</form>
	</div>

	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>