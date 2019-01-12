<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.brw.dto.ReviewBoardDTO" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
   // FrontController에서 보낸 list 받기

   List<ReviewBoardViewDTO> list = (List<ReviewBoardViewDTO>)request.getAttribute("list");

   String pageBar = (String)request.getAttribute("pageBar");
   
   String searchType = request.getParameter("searchType");
   String searchKeyword = request.getParameter("searchKeyword");
%>

<style>
/* 컨테이너 너비 조정 */
div#review-list-container{
   width: 950px;
}

/* 검색창 보이기&보이지 않기 */
div#search-rb_booktitle{
   display: inline-block;
}
div#search-rb_title{
   display: none;
}

/* 테이블 영역 */
table#review-list-table th, table#review-list-table td {
   padding: 10px 5px 10px 0;
   font-size: 13px;
}

/* .divInline display: inline-block으로 수정 */
div.divInline {
   display: inline-block;
}

/* 검색창 */
div.search-bar {
   width: 400px;
}

/* 게시판 컬럼별 너무길면 ... 으로 표시 */
table#review-list-table tbody tr td:nth-child(2) {
   width: 160px;
   text-overflow: ellipsis;
   white-space: nowrap;
   overflow : hidden;
   display : inline-block;
}

/* 게시판 테이블 색깔 지정 */
table#review-list-table thead tr{
   background: #004183;
   color: white;
}

/* 글쓰기 버튼 위치 */
div#btn-write-container {
   position: relative;
   top: -50px;
   left: 840px;
}

/* 게시판 새 글 new 표시 */
span.smft {
   font-size: 11px;
}


/* 테이블 최소 높이 지정 */
#table-container{
   min-height: 300px;
}
</style>
<script>
$(function(){
   // 로그인을 했으면 리뷰작성 페이지로 이동
   $("button#btn-write").on("click",function(){
      <%
      if(user == null){
      %>
      alert("로그인 후 이용하세요.");
      return;
      <%
      }
      %>
      location.href="<%=request.getContextPath()%>/review/reviewWrite.do";
   });
});
</script>

<div id="review-list-container" class="container-fluid">
   <h2 class="text-primary">리뷰게시판</h2>

   <!-- 리뷰 리스트를 보여줄 테이블 영역 -->
   <div id="table-container">
      <table class="table table-hover table-info table-responsive" id="review-list-table">
         <thead>
            <tr>
               <th>no</th>
               <th class="col-sm-2">도서명</th>
               <th class="col-sm-6">제목</th>
               <th>작성자</th>
               <th>작성일</th>
               <th>조회수</th>
               <th>추천수</th>
            </tr>
         </thead>
         <tbody>

         <% for(ReviewBoardViewDTO rb : list) { %>
            <tr>
               <td><%=rb.getRbNo() %></td>
               <td><%=rb.getRbBookTitle()%></td>
               <td>
                     <a href="<%=request.getContextPath()%>/review/reviewDetail.do?rbNo=<%=rb.getRbNo() %>"><%=rb.getRbTitle() %></a> 
                   <span class="smft"><%=rb.getCommentCnt()>0?rb.getCommentCnt():"" %></span> <%=rb.isDateNew()?"<span class='mark smft'>new</span>":"" %>
               </td>
               <td><%=rb.getRbWriter() %></td>
               <td><%=rb.getRbDate() %></td>
               <td><%=rb.getRbReadCnt() %></td>
               <td><%=rb.getRbRecommend() %></td>
            </tr>
         <% } %>
         </tbody>
      </table>
   </div> <!-- end of #table-container -->
   
   
   
   <!-- 검색 영역 -->
   <div id="search-form-container" class="text-center">
      <!-- 검색 타입 셀렉트 -->
      <div class="form-group divInline">
         <select id="searchType" class="form-control">
            <option value="rb_booktitle" <%="rb_booktitle".equals(searchType)?"selected":"" %>>도서명</option>
            <option value="rb_title" <%="rb_title".equals(searchType)?"selected":"" %>>제목</option>
         </select>
      </div>
      <div id="search-rb_booktitle">
         <form action="<%=request.getContextPath()%>/review/reviewSearch.do">
            <input type="hidden" name="searchType" value="rb_booktitle"/>
            <div class="form-group search-bar divInline">
               <input type="text" name="searchKeyword" class="form-control" value="<%="rb_booktitle".equals(searchType)?searchKeyword:""%>"/>
            </div>
            <button type="submit" class="btn btn-default">검색</button>
            
         </form>
         
      </div>
      <div id="search-rb_title">
         <form action="<%=request.getContextPath()%>/review/reviewSearch.do">
            <input type="hidden" name="searchType" value="rb_title"/>
            <div class="form-group search-bar divInline">
               <input type="text" name="searchKeyword" class="form-control" value="<%="rb_title".equals(searchType)?searchKeyword:""%>"/>
            </div>
            <button type="submit" class="btn btn-default">검색</button>
         </form>
      </div>
      
   </div>
   
     <!-- 글쓰기 버튼 영역 -->
  <div id="btn-write-container">
     <button id="btn-write" class="btn btn-success">리뷰 작성</button>
  </div>
   
   
   
   <!-- 페이지바 영역 --> 
   <div id="pagebar-container" class="text-center">
      <%=pageBar %>
   </div>
   
   
</div> <!-- end of #review-list-container -->
<!-- 테스트 -->
<%@ include file="/WEB-INF/views/common/footer.jsp" %>