<%@page import="com.brw.dto.ReviewBoardReportDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<ReviewBoardReportDTO> reportList = (List<ReviewBoardReportDTO>)request.getAttribute("reportList");
	String pageBar = (String)request.getAttribute("pageBar");
%>
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
#report_rbNo{
 cursor: pointer;
}
</style>
<!-- 신고게시판 리스트를 보여줄 테이블 영역 -->
<div id="table-container">
<div id="review-list-container" class="container-fluid">
   <h2 class="text-primary">게시판 관리</h2>
  	     <table class="table table-hover table-info table-responsive"
         id="review-list-table">
         <thead>
            <tr>
               <th class="text-center" style="font-size: 0.9em;" >게시판글번호</th>
               <th class="text-center" style="font-size: 0.9em;">게시판글제목</th>
               <th class="text-center" style="font-size: 0.9em;">피신고자</th>
               <th class="text-center" style="font-size: 0.9em;">신고자</th>
               <th class="text-center" style="font-size: 0.9em;">신고내용</th>
               <th class="text-center" style="font-size: 0.9em;">신고종류</th>
               <th class="text-center" style="font-size: 0.9em;">신고일</th>
            </tr>
         </thead>
         <tbody>
         <%if(reportList != null || !reportList.isEmpty()) {%>
         	<%for(ReviewBoardReportDTO rbr : reportList){ %>
            <tr class="notice">
               <td class="text-center col-md-1" style="font-size: 0.9em;" id="report_rbNo"><%=rbr.getRbReportRbNo() %></td>
               <td class="text-center col-md-1" style="font-size: 0.9em;"><%=rbr.getRbReportTitle() %></td>
               <td class="text-center col-md-1" style="font-size: 0.9em;"><%=rbr.getRbReportSuspect() %></td>
               <td class="text-center col-md-1" style="font-size: 0.9em;"><%=rbr.getRbReportWriter() %></td>
               <td class="text-center col-md-4" style="font-size: 0.9em;"><%=rbr.getRbReportContent() %></td>
               <td class="text-center col-md-1" style="font-size: 0.9em;"><%=rbr.getRbReportClasses() %></td>
               <td class="text-center col-md-2" style="font-size: 0.9em;"><%=rbr.getRbReportDate() %></td>
                <td class="del-member col-md-1" style="border: none; text-align: center;"><button class="btn-gradient red" value="<%=rbr.getRbReportRbNo()%>">삭제</button></td>
            </tr>
             <input type="hidden" id="rbNo" value="<%=rbr.getRbReportRbNo() %>" />
            <%} %>
         <%} %>
         </tbody>
      </table>
      <div id="pagebar-container" class="text-center">
  	  	<%=pageBar %>
  	  </div>
  	  <script>
  	 	$(".btn-gradient.red").click(function(){
  	  		var rbNo = $("#rbNo").val();
  	  		if(confirm("해당글을 삭제하시겠습니까?")){
  	  			$.ajax({
  	  				url:"<%=request.getContextPath()%>/review/adminReviewDelete.do?rbNo="+rbNo,
  	  				success:function(data){
  	  					if(data>0){
  	  						alert("게시글 수정에 성공하엿습니다.");
  	  						location.href ="<%=request.getContextPath()%>/review/reviewBoardManager.do";
  	  					}
  	  				}
  	  			});
  	  			
  	  		}
  	  			
  	  	});
  	  	$("#report_rbNo").click(function(){
  	  		var rbNo = $("#rbNo").val();
  	  		parent.location.href="<%=request.getContextPath()%>/review/reviewDetail.do?rbNo="+rbNo;
  	  	});
  	  </script>
</div>
</div>
