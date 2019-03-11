<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ page import="java.util.List" %>
<% 
	List<String> today = (List<String>)request.getAttribute("today");
	List<AttendanceDTO> atList = (List<AttendanceDTO>)request.getAttribute("atList");
	boolean checkValidation = false;
	if(request.getAttribute("checkValidation") != null){
		checkValidation = (boolean)request.getAttribute("checkValidation");
	}
	System.out.println("checkAttendance.jsp today="+today);
	System.out.println("checkAttendance.jsp atList="+atList);
	System.out.println("checkAttendance.jsp checkValidation="+checkValidation);
%>
<style>
div#attendance-container{
	width: 900px;
	min-height: 600px;
	text-align: center;
	margin: 30px auto;
}
/* 출석체크 인풋:텍스트, 버튼 가운데 정렬 */
#attd-content-container{
	margin: 0 auto;
}
/* 출석체크 리스트 헤드처럼 보이기 */
#tr-head{
	background: #003f85;
	color: white;
	font-weight: bold;
	text-align: center;
}
#tr-head th{
	vertical-align: middle;
}
#attendance-table tbody td {
	vertical-align: middle;
}
#day-table th{
	font-size: 2em;
	background: tomato;
}
</style>
<script>
function validate(){
	<% if(user == null){ %>
	alert("로그인을 해주세요.");
	return false;
	<% } %>
	
	<% if(checkValidation) { %>
	alert("출첵은 하루에 한 번만! 욕심쟁이~");
	return false;
	<% } %>
	
	return true;
}

</script>

<div id="attendance-container">
	<h2>출석체크</h2>
	
	<div id="day-table-container">
	<table id="day-table" class="table table-hover table-info table-responsive">
		<thead>
			<tr>
				<th class="text-center"><%=today.get(0) %></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>
					<form action="<%=request.getContextPath()%>/doAttendance.do" onsubmit="return validate();" method="post">
					<div id="attd-content-container" class="input-group">
						<input type="hidden" name="atUserId" value="<%=user == null?"":user.getUserId() %>" />
						<input id="attd-text" type="text" name="atContent" class="form-control" placeholder="출석쳌~! (100자 이내)" aria-describedby="basic-addon1">
						<span class="input-group-btn">
					    	<button id="do-attendance" class="btn btn-primary" type="submit">Double D와 함께하는 특별한 밤!</button>
					    </span>
					</div>
					</form>
				</td>
			</tr>
		</tbody>
	</table>
	
	<table id="attendance-table" class="table table-hover table-info table-responsive">
		<thead>
			<tr id="tr-head">
				<!-- <td colspan="7">출석체크한 기록 보여주기. 컬럼은 번호, 메세지, 닉네임, 출석일수, 개근일수</td> -->
				<th class="col-md-1 text-center">no</th>
				<th class="col-md-6 text-center">메시지</th>
				<th class="col-md-2 text-center">닉네임</th>
				<th class="col-md-1 text-center">총<br>출석일수</th>
				<th class="col-md-2 text-center">출석시간</th>
			</tr>
		</thead>
		<tbody>
			<% for(AttendanceDTO at : atList) { %>
			<tr>
				<td><%=at.getAtNo() %></td>
				<td><%=at.getAtContent() %></td>
				<td>
					<img src="<%=request.getContextPath() %>/images/userGradeImage/<%=at.getUserGrade() %>.svg" alt="userGrade" width=30 height=30/>
					<%=at.getUserNickName() %>
				</td>
				<td><%=at.getAtTotal() %></td>
				<td><%=at.getAtDate() %></td>
			</tr>
			<% } %>
		</tbody>
	</table>	
	</div>
	


</div>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>