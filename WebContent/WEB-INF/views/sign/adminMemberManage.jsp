<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<UserDTO> userlist = (List<UserDTO>)request.getAttribute("Userlist");
	String pageBar = (String)request.getAttribute("pageBar");
	List<Integer> rePortCountList = (List<Integer>)request.getAttribute("rePortCountList");
%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/adminMemberManager.css" />
<div id="review-list-container" class="container-fluid">
   <h2 class="text-primary">회원 정보</h2>
<!-- 회원 리스트를 보여줄 테이블 영역 -->
<div id="table-container">
      <table class="table table-hover table-info table-responsive"
         id="review-list-table">
         <thead>
            <tr>
               <th class="text-center">아이디</th>
               <th class="text-center">이름</th>
               <th class="text-center">별명</th>
               <th class="text-center">이메일</th>
               <th class="text-center">포인트</th>
               <th class="text-center">등급</th>
               <th class="text-center">신고당한횟수</th>
            </tr>
         </thead>
         <tbody>
         <%if(userlist!=null || !userlist.isEmpty()){ %>
         	<%for(int i =0 ; i<userlist.size(); i++){ %>
            <tr class="notice">
               <td class="text-center"><%=userlist.get(i).getUserId()%></td>
               <td class="text-center"><%=userlist.get(i).getUserName() %></td>
               <td class="text-center"><%=userlist.get(i).getUserNickName() %></td>
               <td class="text-center"><%=userlist.get(i).getUserEmail() %></td>
               <td class="text-center"><%=userlist.get(i).getUserPoint() %></td>
               <td class="text-center"><%=userlist.get(i).getUserGrade()%></td>
            <%if(rePortCountList.get(i)>9){ %>
               <td class="text-center"><%=rePortCountList.get(i)%></td>
               <td class="del-member" style="border: none; text-align: center;"><button class="btn-gradient red" value="<%=userlist.get(i).getUserId()%>">탈퇴</button></td>
            <%}else{ %>    
            	 <td class="text-center"><%=rePortCountList.get(i)%></td>
            <%} %>                  
            </tr>
           	<%} %>
          <%} %>
         </tbody>
      </table>
      <div id="pagebar-container" class="text-center">
      	<%=pageBar %>
  	  </div>
   </div>
</div>
<script>
	$(".btn-gradient.red").click(function(){
		var userId = $(this).val();
		if(confirm("정말 탈퇴 처리 하시겠습니까?")){
			location.href="<%=request.getContextPath()%>/sign/memberDelete.do?userId="+userId;

		}
	})
</script>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>