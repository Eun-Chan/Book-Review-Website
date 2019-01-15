<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.brw.dto.ReviewBoardDTO" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	ReviewBoardViewDTO rbv = null;
	if(request.getAttribute("rbv") != null){
		rbv = (ReviewBoardViewDTO)request.getAttribute("rbv");
	}
%>
<!-- 서머노트용 js, css 적용 -->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.css" rel="stylesheet"> 
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.js"></script>


<script type="text/javascript">
		console.log(<%=rbv.getRbNo()%>);

// 로그인하지 않고 url을 통해 접근했을 경우 인덱스로 돌려버림
<% if(user == null) { %>
alert("잘못된 경로로 접근하였습니다.");
location.href = "<%=request.getContextPath()%>";
<% } %>

<%
// 로그인이 되어있고 리뷰 수정인 경우이고 접속한 회원과 리뷰작성한 회원이 같지 않을 경우 홈으로 보내기
if(user != null && rbv != null && !user.getUserId().equals(rbv.getRbWriter())){
%>
alert("잘못된 경로로 접근하였습니다.");
location.href = "<%=request.getContextPath()%>";
<%
}
%>



//summernote 이미지업로드시 사용할 함수
function sendFile(file) {
    // 파일 전송을 위한 폼생성
	var form_data = new FormData();
	form_data.append('file', file);
	$.ajax({
		data: form_data,
		type: "POST",
		url: '<%=request.getContextPath()%>/review/reviewWriteImage.do',
		cache: false,
		contentType: false,
		processData: false,
		success: function(url) {
            // editor안에 이미지 삽입
			$("#summernote").summernote('insertImage', url);
		},
	});
}
	
$(function(){
	
	// summernote 에디터 준비
	$("#summernote").summernote({
		height: 300,
		placeholder: '내용을 작성해주세요',
		callbacks: {
			// 이미지 업로드시 사용될 콜백함수
			onImageUpload: function(files){
				sendFile(files[0]);
			}
		}
	});
	
	<%
	//로그인이 되어있고 리뷰 수정인 경우이고 접속한 회원과 리뷰작성한 회원이 같아야 리뷰 내용 적용 (수정하기 위해서)
	if(user != null && rbv != null && user.getUserId().equals(rbv.getRbWriter())){
	%>
		var title = $("input[name=rbTitle]");
		var content = $("#summernote");
		var bookTitle = $("input[name=rbBookTitle]");
		var isbn = $("input[name=rbIsbn]");
		var starScore = $("input[name=rbStarscore]");
		
		title.val("<%=rbv.getRbTitle()%>");
		content.summernote('code',"<%=rbv.getRbContent()%>");
		bookTitle.val("<%=rbv.getRbBookTitle()%>");
		isbn.val("<%=rbv.getRbIsbn()%>");
		starScore.val(<%=rbv.getRbStarscore()%>);
		
		var spanStar = $("span#starscore");
		switch(<%=rbv.getRbStarscore()%>){
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
		
		//별점 처리
		var result = 0;
		var starscore = <%=rbv.getRbStarscore()%> * 2;
		console.log(starscore);
	   	for(var i=0; i<starscore; i++) {
        	$("span#star"+i).addClass('on');
    	}
		
	   	
	<%
	}
	%>	

	
	$("#btnSave").on("click",function(){
		
		// 유효성 검사는 이곳에서
     	// 리뷰 제목
    	if($("input[name=rbTitle]").val().trim().length == 0){
    		alert("리뷰 제목을 입력하세요.");
    		return;
    	}
    	// 리뷰 내용
    	if($("#summernote").summernote('code') == ""){
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
	
	/* summernote 내용 초기화 버튼 */
	$("button:reset").on("click",function(){
		$("#summernote").summernote("code","");
	});
	
	/* 취소 버튼 */
	$("button#cancel").on("click",function(){
		var bool = confirm("정말 취소하시겠습니까?");
		if(!bool) return;
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
	font-size: 1.5em;
}

</style>
</head>
<body>
	<div id="form-container" class="container-fluid">
		<h2>리뷰 작성 페이지</h2>
		<form action="<%=request.getContextPath() %>/review/reviewReviseEnd.do" name="write_form" id="write-form">
			<div class="form-group" id="write-container">
				<!-- 글번호 히든태그 -->
				<input type="hidden" name="rbNo" value="<%=rbv.getRbNo() %>"/>
				<!-- 글제목 인풋태그 -->
				<input type="text" name="rbTitle" class="form-control" placeholder="제목" />
				<!-- 작성자 히든태그 -->
				<input type="hidden" name="rbWriter" value="<%=user!=null?user.getUserId():""%>"/>
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
					<span id="star1" class="starR1">별1_왼쪽</span>
					<span id="star2" class="starR2">별1_오른쪽</span>
					<span id="star3" class="starR1">별2_왼쪽</span>
					<span id="star4" class="starR2">별2_오른쪽</span>
					<span id="star5" class="starR1">별3_왼쪽</span>
					<span id="star6" class="starR2">별3_오른쪽</span>
					<span id="star7" class="starR1">별4_왼쪽</span>
					<span id="star8" class="starR2">별4_오른쪽</span>
					<span id="star9" class="starR1">별5_왼쪽</span>
					<span id="star10" class="starR2">별5_오른쪽</span>
				</div>
				<!-- 별점별 평가내용 -->
				<span id="starscore">별점을 입력해주세요.</span>
				
				<!-- summernote용 텍스트에어리어 -->
				<textarea name="rbContent" id="summernote"></textarea>
			</div>
			<div id="btn-group" class="text-center">
			<button type="button" class="btn btn-success" id="btnSave">등록</button>
			<button type="reset" class="btn btn-warning">초기화</button>
			<button type="button" class="btn btn-danger" id="cancel">취소</button>
			</div>
		</form>
		
	</div>

	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>