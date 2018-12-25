<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<section id="enroll-container">
	<h2>회원가입 정보 입력</h2>
	<h3>회원가입 유효성 검사 완성해야함</h3>
	<!-- form action="entrollTest.do" 이러한 형식으로 보내도됨(앞에 contextPath가 필요없음)-->
	<form action="<%=request.getContextPath()%>/enrollTest.do"	name="memberEnrollForm" method="post">
		<table>
			<tr>
				<td>아이디 <span class="reqired">*</span></td>
				<td>
					<input type="text" name="userId" id="userId" required/>
				</td>
			</tr>
			<tr>
				<td>패스워드 <span class="reqired">*</span></td>
				<td><input type="password" name="userPassword" id="userPassword" required/></td>
			</tr>
			<tr>
				<td>패스워드 확인</td>
				<td><input type="password" name="userPassword2" id="userPassword2" required/></td>
			</tr>
			<tr>
				<td>이름 <span class="reqired">*</span></td>
				<td><input type="text" name="userName" id="userName" required/></td>
			</tr>
			<tr>
				<td>이메일 <span class="reqired">*</span></td>
				<td><input type="email" name="userEmail" id="userEmail" required/></td>
			</tr>
		</table>
		<input type="submit" value="회원가입" />
		<input type="reset" value="초기화" />
	</form>
</section>



