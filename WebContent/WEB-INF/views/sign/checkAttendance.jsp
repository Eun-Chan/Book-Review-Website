<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ page import="java.util.List" %>
<% 
	List<String> dayList = (List<String>)request.getAttribute("dayList");
	List<AttendanceDTO> atList = (List<AttendanceDTO>)request.getAttribute("atList");
%>
<style>
div#attendance-container{
	width: 900px;
	min-height: 400px;
	text-align: center;
	margin: 30px auto;
}
/* 출석체크 인풋:텍스트, 버튼 가운데 정렬 */
#attd-content-container{
	margin: 0 auto;
}
/* 출석체크 인풋:텍스트 너비 */
#attd-text{
	width: 400px;
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
</style>
<div id="attendance-container">
	<h2>출석체크</h2>
	
	<div id="day-table-container">
	<table id="day-table" class="table table-hover table-info table-responsive">
		<thead>
			<tr>
				<% for(int i=0; i<dayList.size(); i++) { %>
				<th class="text-center" <%=i == dayList.size()/2?"style='background: tomato;'":"" %>><%=dayList.get(i) %></th>
				<% } %>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td></td>
				<td colspan="5">
					<form action="">
					<div id="attd-content-container" class="input-group">
						<input type="hidden" name="atUserId" <%=user == null?"":user.getUserId() %> />
						<input id="attd-text" type="text" class="form-control" placeholder="출석쳌~! (100자 이내)" aria-describedby="basic-addon1">
						<span class="input-group-btn">
					    	<button class="btn btn-primary" type="button">Double D와 함께하는 특별한 밤!</button>
					    </span>
					</div>
					</form>
				</td>
				<td></td>
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
				<th class="col-md-1 text-center">개근일수</th>
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
				<td><%=at.getAtSerial() %></td>
				<td><%=at.getAtDate() %></td>
			</tr>
			<% } %>
		</tbody>
	</table>	
	</div>
	


</div>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>