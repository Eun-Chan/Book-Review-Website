<%@page import="com.brw.dto.UserDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<UserDTO> userlist = (List<UserDTO>)request.getAttribute("Userlist");
	String pageBar = (String)request.getAttribute("pageBar");
	List<Integer> rePortCountList = (List<Integer>)request.getAttribute("rePortCountList");
%>
<!-- 회원 리스트를 보여줄 테이블 영역 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css">
<script src="<%=request.getContextPath()%>/js/jquery-3.3.1.js"></script>
<style>
th{
	vertical-align: center;
}
.btn-gradient {
    text-decoration: none;
    color: white;
    padding: -1px;
    display: inline-block;
    position: relative;
    border: 1px solid rgba(0,0,0,0.21);
    border-bottom: 4px solid rgba(0,0,0,0.21);
    border-radius: 4px;
    text-shadow: 0 1px 0 rgba(0,0,0,0.15);
}
.btn-gradient.red{ 
    background: rgba(250,90,90,1);
    background: -webkit-gradient(linear, 0 0, 0 100%, from(rgba(250,90,90,1)), to(rgba(232,81,81,1)));
    background: -webkit-linear-gradient(rgba(250,90,90,1) 0%, rgba(232,81,81,1) 100%);
    background: -moz-linear-gradient(rgba(250,90,90,1) 0%, rgba(232,81,81,1) 100%);
    background: -o-linear-gradient(rgba(250,90,90,1) 0%, rgba(232,81,81,1) 100%);
    background: linear-gradient(rgba(250,90,90,1) 0%, rgba(232,81,81,1) 100%);
    filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#fa5a5a', endColorstr='#e85151', GradientType=0 );
}
.del-member{
	border: none;
}
</style>
<div id="table-container">
<div id="review-list-container" class="container-fluid">
   <h2 class="text-primary">회원 정보</h2>
      <table class="table table-hover table-info table-responsive"
         id="review-list-table">
         <thead>
            <tr>
               <th class="text-center" style="font-size: 0.9em;">아이디</th>
               <th class="text-center" style="font-size: 0.9em;">이름</th>
               <th class="text-center" style="font-size: 0.9em;">별명</th>
               <th class="text-center" style="font-size: 0.9em;">이메일</th>
               <th class="text-center" style="font-size: 0.9em;">포인트</th>
               <th class="text-center" style="font-size: 0.9em;">등급</th>
               <th class="text-center" style="font-size: 0.9em;">신고당한횟수</th>
            </tr>
         </thead>
         <tbody>
         <%if(userlist!=null || !userlist.isEmpty()){ %>
         	<%for(int i =0 ; i<userlist.size(); i++){ %>
            <tr class="notice">
               <td class="text-center col-md-1" style="font-size: 0.9em;"><%=userlist.get(i).getUserId()%></td>
               <td class="text-center col-md-2" style="font-size: 0.9em;"><%=userlist.get(i).getUserName() %></td>
               <td class="text-center col-md-2" style="font-size: 0.9em;"><%=userlist.get(i).getUserNickName() %></td>
               <td class="text-center col-md-3" style="font-size: 0.9em;"><%=userlist.get(i).getUserEmail() %></td>
               <td class="text-center col-md-1" style="font-size: 0.9em;"><%=userlist.get(i).getUserPoint() %></td>
               <td class="text-center col-md-1" style="font-size: 0.9em;"><%=userlist.get(i).getUserGrade()%></td>
            <%if(rePortCountList.get(i)>9){ %>
               <td class="text-center col-md-1" style="font-size: 0.9em;"><%=rePortCountList.get(i)%></td>
               <td class="del-member col-md-1" style="border: none; text-align: center;"><button class="btn-gradient red" value="<%=userlist.get(i).getUserId()%>">탈퇴</button></td>
            <%}else{ %>    
            	 <td class="text-center col-md-1 style="font-size: 0.9em;"><%=rePortCountList.get(i)%></td>
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
			$.ajax({
				url:"<%=request.getContextPath()%>/sign/memberDelete.do?userId="+userId,
				success:function(data){
					if(data>0){
						alert("회원수정에 성공하였습니다.");
						location.href="<%=request.getContextPath()%>/sign/memberManager.do";
					}
				}
			})
			
			

		}
	})
</script>