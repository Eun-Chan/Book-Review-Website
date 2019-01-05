<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.brw.dto.ReviewBoardDTO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/bootstrap.css" />
<script src="<%=request.getContextPath() %>/js/jquery-3.3.1.js"></script>
<script src="<%=request.getContextPath() %>/js/bootstrap.js"></script>
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
		
		// form 제출
		$("#write-form").submit();

	});
	
	// 도서 검색 버튼 리스너
	$("#btnSearch").on("click",function(){
		// 팝업창 띄우기
		var popup = open("<%=request.getContextPath()%>/review/bookSearch.do","도서 검색","left=300px, top=100px, height=400px, width=920px");
	});
	
});
	

</script>
<style>
div.form-group{
	width: 950px;
	margin: 0 auto;
}
div.form-group textarea{
	width: 945px;
}

</style>
</head>
<body>
	<div id="form-container" class="container-fluid">
		<h2>리뷰 작성 페이지</h2>
		<form action="<%=request.getContextPath() %>/review/reviewWriteEnd.do" id="write-form">
			<div class="form-group">
				<input type="text" name="rbTitle" class="form-control" placeholder="제목" />
				<!-- 책검색용 팝업 -->
				<button type="button" class="btn btn-primary" id="btnSearch">책 검색</button>
				<!-- 검색해서 선택한 책이름 넣기 -->
				<input type="hidden" name="rbBookTitle" />
				<!-- ISBN도 넣기 -->
				<input type="hidden" name="rbIsbn" />
				<!-- 별점 -->
				✦✦✦✧✧<span id="starscore">괜찮음!</span>
				
				<!-- 스마트에디터용 텍스트에어리어 -->
				<textarea name="rbContent" id="rbContent" rows="17" cols="100" class="form-control"></textarea>
			</div>
			<button type="button" class="btn btn-success" id="btnSave">등록</button>
			<button type="reset" class="btn btn-warning">초기화</button>
		</form>
	</div>
</body>
</html>