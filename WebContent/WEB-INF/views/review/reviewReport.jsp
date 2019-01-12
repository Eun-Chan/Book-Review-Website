<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String rbReportTitle = request.getParameter("rbReportTitle"); //신고당한 글제목
	String rbReportSuspect = request.getParameter("rbReportSuspect"); //글작성한 닉네임
	String rbReportWriter = request.getParameter("rbReportWriter");	// 신고작성하는 닉네임
	int rbReportNo = Integer.parseInt(request.getParameter("rbReportNo")); //신고당한 글번호
	String userId=request.getParameter("userId"); //신고하는 사람 아이디
	String rbWriter =request.getParameter("rbWriter"); //신고 당하는 사람 아이디
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reviewReport.css">
<script src="<%=request.getContextPath()%>/js/jquery-3.3.1.js"></script>
</head>
<body>
	<form id="report-form" name="report-form" method="POST">
		<input type="hidden" name="rbReportNo" value="<%=rbReportNo %>" />
		<input type="hidden" name="rbReportTitle" value="<%=rbReportTitle %>" />
		<input type="hidden" name="rbReportSuspect" value="<%=userId %>" />
		<input type="hidden" name="rbReportWriter" value="<%=rbWriter %>" />
		<div id="reviewReport-header">
			<h3>신고하기</h3>
		</div>
	 	<div id="reviewReport-body">
	 		<dl>
	 			<dt>글 제목</dt>
	 			<dd><span><%=rbReportTitle %></span></dd>
	 		</dl>
	 		<dl>
	 			<dt>작성자 닉네임</dt>
	 			<dd><span><%=rbReportSuspect %></span></dd>
	 		</dl>
	 		<dl>
	 			<dt>신고자 닉네임</dt>
	 			<dd><span><%=rbReportWriter %></span></dd>
	 		</dl>
	 		<dl>
	 			<dt>신고사유</dt>
	 			<dd>
		 			<select name="reportselect" id="reportselect" class="form-control">
		        		<option value="report1">욕설/비방</option>
		        		<option value="report2">도배</option>
		        		<option value="report3">홍보/상업성</option>
		        		<option value="report4">음란성</option>
		        		<option value="report5">기타</option>
		        	</select>
	        	</dd>
	 		</dl>
	 	</div>
	  	<textarea name="reportTextArea" id="report-textArea" cols="30" rows="10"></textarea>
	  	<input type="submit" id="report-submit" class="btn-gradient red" value="신고하기" />
	  	<button id="report-close" class="btn-gradient purple">닫기</button>
	</form>
	<script>
	$(document).ready(function(){
		$("#report-submit").click(function(){
			if($("#report-textArea").val().trim().length ==0){
				alert("신고 내용을 입력해 주세요.");
				return;
			}else{
				var formData = $("#report-form").serialize();
				console.log("잉");
				$.ajax({
					type:"POST",
					url:"<%=request.getContextPath()%>/review/insertReviewBoardReport.do",
					data:formData,
					async:false,
					success:function(data){
						if(data=="1"){
							alert("신고등록 성공.");
							self.close();
						}else{
							console.log("씨부럴");
						}
					}
				});
			}
		});
		$("#report-close").click(function(){
			console.log("클릭");
			self.close();
		});
	});

	</script>
</body>
</html>