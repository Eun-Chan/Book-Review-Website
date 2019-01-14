<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%> <!-- isErrorPage="true"을 하면 exception내장객체를 이용할 수 있다 -->
<%
	String errMsg = "";
	
	if(response.getStatus() == 404){
		errMsg = "잘못된 경로를 입력하셨습니다.";
	}
	else if(response.getStatus() == 500){
		errMsg = "페이지가 망가졌어요...\n관리자에게 문의하세요.";
	}
	else{
		errMsg = exception.getMessage();
	}
	
%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<style>
#error-container{
	text-align: center;
	min-height: 450px;
	vertical-align: middle;
}
#errMsg{
	color: #ab433f;
	font-size: 2em;
}
div#errSign-container{
	width: 900px;
	margin: 50px auto;
}
span#errSign1{
	font-size: 250px;
}
p#home{
	font-size: 1.3em;
}
</style>
	<div id="error-container">
		<div id="errSign-container" class="panel panel-danger">
	    	<div class="panel-heading"><span id="errSign1" class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span></div>
	    	<div class="panel-body">
		      	<br /><span id="errMsg"><%=errMsg %></span><br /><br />
				<p id="home"><a href="<%=request.getContextPath()%>">Home으로 돌아가기</a></p>
			</div>
	    </div>
	</div>
	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>