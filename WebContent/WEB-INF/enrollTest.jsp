<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<section id="enroll-container">
	<h2>회원가입 정보 입력</h2>
	<h3>회원가입 유효성 검사 완성해야함</h3>
	<form action="<%=request.getContextPath()%>/enrollTest.do"	name="memberEnrollForm" method="post">
		<table>
			<tr>
				<td>아이디 <span class="reqired">*</span></td>
				<td>
					<input type="text" name="memberId" id="memberId" required/>
				</td>
			</tr>
			<tr>
				<td>패스워드 <span class="reqired">*</span></td>
				<td><input type="password" name="memberPw" id="memberPw" required/></td>
			</tr>
			<tr>
				<td>패스워드 확인</td>
				<td><input type="password" name="memberPw2" id="memberPw2" required/></td>
			</tr>
			<tr>
				<td>이름 <span class="reqired">*</span></td>
				<td><input type="text" name="memberName" id="memberName" required/></td>
			</tr>
			<tr>
				<td>이메일 <span class="reqired">*</span></td>
				<td><input type="email" name="email" id="email" required/></td>
			</tr>
		</table>
		<input type="submit" value="회원가입" />
		<input type="reset" value="초기화" />
	</form>
</section>



