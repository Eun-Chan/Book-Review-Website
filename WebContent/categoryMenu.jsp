<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 반응형 웹을 위한 메타태그 -->
<meta name="viewport" content="width=device-width", initial-scral="1">
<title>categoryMenu 입니다</title>
<link rel="stylesheet" href="css/bootstrap.css">
<script src="<%=request.getContextPath()%>/js/jquery-3.3.1.js"></script>
<style>
div#category-container{
	border: 1px solid gray;
	border-radius: 10px;
	max-width: 180px;
	background-color: #5f9bfc;
	color: white;
	margin-top: 10px;
	margin-left:5px;
	cursor: pointer;
}
div#category-container a{
	color: white;
}
</style>
</head>
<body>
	<div id="category-container">
		<ul>
			<li><a onclick='moveCategoryView(1230)'>가정/요리/뷰티</a></li>
			<li><a onclick="moveCategoryView(55890)">건강/취미/레저</a></li>
			<li><a onclick="moveCategoryView(170)">경제경영</a></li>
			<li><a onclick="moveCategoryView(76001)">고등학교참고서</a></li>
			<li><a onclick="moveCategoryView(2105)">고전</a></li>
			<li><a onclick="moveCategoryView(987)">과학</a></li>
			<li><a onclick="moveCategoryView(8257)">대학교재/전문서적</a></li>
			<li><a onclick="moveCategoryView(2551)">만화</a></li>
			<li><a onclick="moveCategoryView(4395)">사전/기타</a></li>
			<li><a onclick="moveCategoryView(798)">사회과학</a></li>
			<li><a onclick="moveCategoryView(1)">소설/시/희곡</a></li>
			<li><a onclick="moveCategoryView(1383)">수험서/자격증</a></li>
			<li><a onclick="moveCategoryView(1108)">어린이</a></li>
			<li><a onclick="moveCategoryView(55889)">에세이</a></li>
			<li><a onclick="moveCategoryView(1196)">여행</a></li>
			<li><a onclick="moveCategoryView(74)">역사</a></li>
			<li><a onclick="moveCategoryView(517)">예술/대중문화</a></li>
			<li><a onclick="moveCategoryView(1322)">외국어</a></li>
			<li><a onclick="moveCategoryView(13789)">유아</a></li>
			<li><a onclick="moveCategoryView(656)">인문학</a></li>
			<li><a onclick="moveCategoryView(336)">자기계발</a></li>
			<li><a onclick="moveCategoryView(2913)">잡지</a></li>
			<li><a onclick="moveCategoryView(112011)">장르소설</a></li>
			<li><a onclick="moveCategoryView(17195)">전집/중고전집</a></li>
			<li><a onclick="moveCategoryView(1237)">종교/역학</a></li>
			<li><a onclick="moveCategoryView(2030)">좋은부모</a></li>
			<li><a onclick="moveCategoryView(76000)">중학교참고서</a></li>
			<li><a onclick="moveCategoryView(1137)">청소년</a></li>
			<li><a onclick="moveCategoryView(50246)">초등학교참고서</a></li>
			<li><a onclick="moveCategoryView(351)">컴퓨터/모바일</a></li>
		</ul>
	</div>
<script>
function moveCategoryView(CID){
	console.log(CID);
}
</script>	
</body>
</html>