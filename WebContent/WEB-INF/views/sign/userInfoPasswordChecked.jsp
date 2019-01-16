<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>


<link rel="stylesheet" href="<%=request.getContextPath()%>/css/userInfo.css" />
<div id="passwordCheckedContainer">
	<div id="passwordChecked">
		<h3>본인확인</h3>
		<p>소중한 개인정보를 위해서 본인확인을 진행합니다.</p>
			<div id="passwordCheckedInner">
				<fieldset id="passwordCheckedFieldSet">
				<label for="passwordChecked">
					비밀번호 : 
				</label>
				<input type="password" name="passwordChecked" id="passwordCheckedText"/>
				<button class="btn-gradient cyan">확인</button>
				</fieldset>
			</div>
	</div>
</div>
<script>
	//로그인하지 않고 url을 통해 접근했을 경우 인덱스로 돌려버림
	<% if(user == null) { %>
	alert("잘못된 경로로 접근하였습니다.");
	location.href = "<%=request.getContextPath()%>";
	<% } %>

	/*키보드 엔터 추가*/
	$("#passwordCheckedText").keydown(function(){
		if(event.keyCode == 13) updatePageMove();
	});
	$(".btn-gradient.cyan").click(function(){
		updatePageMove();
	});
	
function updatePageMove()
{
	console.log("처리중");
	var userPassword= $("#passwordCheckedText").val().trim();
	if($("#passwordCheckedText").val().trim().length ==0){
		alert("비밀번호를 입력해 주세요.");
		return;
	}
	else{
		$.ajax({
			url:"<%=request.getContextPath()%>/sign/checkedPassword.do?userPassword="+userPassword+"&userId=<%=user.getUserId()%>",
			success:function(data){
				if(data.userId==undefined){
					alert("비밀번호를 정확히 입력해 주세요.");
					return;
				}
				else{
					location.href="<%=request.getContextPath()%>/sign/userPrivacy.do";
				}
			}
		});
	}
}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>