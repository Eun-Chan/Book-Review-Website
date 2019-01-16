<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.brw.dto.ReviewBoardDTO" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!-- 서머노트용 js, css 적용 -->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.css" rel="stylesheet"> 
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.js"></script>


<script type="text/javascript">

// 비로그인사용자이거나 관리자가 아닌 사용자일 경우, url을 통해 접근했을 경우 인덱스로 돌려버림
<% if(user == null || !"admin".equals(user.getUserId())) { %>
alert("잘못된 경로로 접근하였습니다.");
location.href = "<%=request.getContextPath()%>";
<% } %>


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

	
	$("#btnSave").on("click",function(){
		
		// 유효성 검사는 이곳에서
		
		// 제목입력칸에 ', " 입력 못하게 하기
		var regTitle = /[^'"]/;
		if(!regTitle.test($("input[name=rbTitle]").val())){
			alert("\', \"는 입력 불가합니다.");
			return;
		}
     	// 리뷰 제목
    	if($("input[name=ntcTitle]").val().trim().length == 0){
    		alert("리뷰 제목을 입력하세요.");
    		return;
    	}
    	// 리뷰 내용
    	if($("#summernote").summernote('code') == ""){
    		alert("리뷰 내용을 입력하세요.");
    		return;
    	}
    	
    	
    	
		// form 제출
		$("#write-form").submit();

	});
	
	
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


</style>
</head>
<body>
	<div id="form-container" class="container-fluid">
		<h2>리뷰 작성 페이지</h2>
		<form action="<%=request.getContextPath() %>/admin/noticeWriteEnd.do" name="write_form" id="write-form" method="post">
			<div class="form-group" id="write-container">
				<!-- 글제목 인풋태그 -->
				<input type="text" name="ntcTitle" class="form-control" placeholder="제목" />
				
				<!-- summernote용 텍스트에어리어 -->
				<textarea name="ntcContent" id="summernote"></textarea>
			</div>
			<div id="btn-group" class="text-center">
			<button type="button" class="btn btn-success" id="btnSave">등록</button>
			<button type="reset" class="btn btn-warning">초기화</button>
			<button type="button" class="btn btn-danger" id="cancel">취소</button>
			</div>
		</form>
		
	</div>

	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>