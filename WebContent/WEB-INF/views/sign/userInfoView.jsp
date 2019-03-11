<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
   String nowUser = user.getUserId();
   int cPage = (((Integer)request.getAttribute("cPage"))==null?1:((Integer)request.getAttribute("cPage")));
%>
<body>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/userInfoView.css" />


<table class="table" id="myInfoPage-Container">
   <!-- 구분 -->
   <!-- <nav>
      도서정보 장르 메뉴
      <ul class="nav nav-justified" id="MyContent">
         <li><a id="select-Review">내가 쓴 리뷰</a></li>
         <li><a id="select-ReviewComment">내가 쓴 댓글</a></li>
      </ul>
   </nav> -->
   
   <!-- 내용 : ajax 처리 -->
   <div id="post-Container">
      <h3>내가 쓴 리뷰 글</h3>
      <table class="table" id="myReviewTable">
         <th>번호</th>
         <th>도서명</th>
         <th>제목</th>
         <th>작성일</th>
         <th>조회수</th>
         <th>추천수</th>
      </table>
   </div>
   <!--  
   <div id="reple-Container">
      <h3>내가 쓴 댓글</h3>
      <br />
      <table class="table" id="myreple-Table">
         <th>번호</th>
         <th>제목</th>
         <th>내용</th>
         <th>작성일</th>
         <th>조회수</th>
         <th>추천수</th>
      </table>
   </div> -->
</table>

<!-- 페이징 처리 -->
<div id="pageing-Container">
   <ul class="pagination" id="pageing-list">
      
   </ul>
</div>
<!-- <div id="pageing-Container-comment">
   <ul class="pagination" id="pageing-list-comment">
      
   </ul>
</div> -->

<script>
/* 메뉴선택에 따른 내용 show/hide처리 */
$("#select-Review").click(function(){
   $("#post-Container").show();
   $("#myReviewTable").show();
   $("#pageing-Container").show();
   $("#pageing-Container-comment").hide();
   $("#reple-Container").hide();
   $("#myreple-Table").hide();
});
$("#select-ReviewComment").click(function(){
   $("#post-Container").hide();
   $("#myReviewTable").hide();
   $("#pageing-Container").hide();
   $("#pageing-Container-comment").show();
   $("#reple-Container").show();
   $("#myreple-Table").show();
});

/*데이터 수집*/
$(document).ready(function(){
   $.ajax({
      type: 'post',
      url: '<%=request.getContextPath()%>/sign/userInfoViewJoin.do?nowUser=<%=nowUser%>&cPage=<%=cPage%>',
      contentType: 'application/json; charset=utf-8;',
      success: function(data)
      {
         console.log(data);
         var firstLoadSize = 10;
         if(data[0].length < 10) firstLoadSize = data[0].length;
         /*작성한 글 조회*/
         for(var i=0; i<firstLoadSize; i++)
         {
            var bookTitle = (data[0][i].rb_booktitle);
            if(bookTitle.length>12) bookTitle = bookTitle.substr(0,13)+"...";
            var rbTitle = data[0][i].rb_title;
            if(rbTitle.length>12) rbTitle = rbTitle.substr(0,13)+"...";
            $("#myReviewTable").append("<tr class='myReviewContent' id='myReviewContent"+i+"'><td>"+data[0][i].rb_no+"</td><td>"+(bookTitle)+"</td><td>"+rbTitle+"</td><td>"+data[0][i].rb_date+"</td><td>"+data[0][i].rb_readcnt+"</td><td>"+data[0][i].rb_recommend+"</td></tr>");
            linkAdd(data[0][i].rb_no, i, true);
         }
         /*작성한 댓글 조회*/
         firstLoadSize = 10;
         if(data[1].length < 10) firstLoadSize = data[1].length;
         for(var i=0; i<firstLoadSize; i++)
         {
            var rbTitle_comment = data[1][i].rb_title;
            if(rbTitle_comment.length>12) rbTitle_comment = rbTitle_comment.substr(0,13)+"...";
            var rbCommentContent = data[1][i].rb_comment_content;
            if(rbCommentContent.length>12) rbCommentContent = rbCommentContent.substr(0,13)+"..."; 
            $("#myreple-Table").append("<tr class='myReivewComment' id='myReivewComment"+i+"'><td>"+data[1][i].rb_no+"</td><td>"+rbTitle_comment+"</td><td>"+rbCommentContent+"</td><td>"+data[1][i].rb_comment_date+"</td><td>"+data[1][i].rb_readcnt+"</td><td>"+data[1][i].rb_recommend+"</td></tr>");
            linkAdd(data[1][i].rb_no, i, false);
         }
         /*페이징 처리*/
         $("#pageing-list").append(data[2][0].postHtml);
         $("#pageing-list-comment").append(data[2][1].commentHtml);
         $("#select-Review").trigger("click");
         
         var totalPage = Math.ceil(data[0].length/10);
         console.log("totalPage : " + totalPage);
         for(var i=1; i<=totalPage; i++)
         {
            $("a#cPage"+i).click(function(){
               cpageReload($(this).text());
            });         
         }
         totalPage = Math.ceil(data[1].length/10);
         for(var i=1; i<=totalPage; i++)
         {
            $("a#cPage-comment"+i).click(function(){
               cpageReload($(this).text());
            });   
         }
      },
      error: function()
      {
         console.log("내 정보보기 페이지 로딩에 실패했습니다.@userInfoView.jsp");
      }
   });
});

function cpageReload(cPage)
{
   $("#pageing-list").empty();
   $("#myReviewTable").empty();
   $("#myReviewTable").append("<tbody><tr><th>번호</th>   <th>도서명</th><th>제목</th><th>작성일</th><th>조회수</th><th>추천수</th></tr></tbody>");
   
   $.ajax({
      type: 'post',
      url: '<%=request.getContextPath()%>/sign/userInfoViewJoin.do?nowUser=<%=nowUser%>&cPage='+cPage,
      contentType: 'application/json; charset=utf-8;',
      success: function(data)
      {
         console.log(data);
         /*작성한 글 조회*/
         var mokSize = data[0].length%10;
         var viewCnt = 10;
         if(cPage == (Math.floor(data[0].length/10))+1) viewCnt = mokSize;
         else viewCnt = 10;
         
         for(var i=0; i<viewCnt; i++)
         {
            var bookTitle = (data[0][i].rb_booktitle);
            if(bookTitle.length>12) bookTitle = bookTitle.substr(0,13)+"...";
            var rbTitle = data[0][i].rb_title;
            if(rbTitle.length>12) rbTitle = rbTitle.substr(0,13)+"...";
            $("#myReviewTable").append("<tr class='myReviewContent' id='myReviewContent"+i+"'><td>"+data[0][i].rb_no+"</td><td>"+(bookTitle)+"</td><td>"+rbTitle+"</td><td>"+data[0][i].rb_date+"</td><td>"+data[0][i].rb_readcnt+"</td><td>"+data[0][i].rb_recommend+"</td></tr>");
            linkAdd(data[0][i].rb_no, i*(cPage-1), true);
         }
         /*작성한 댓글 조회*/
         mokSize = data[1].length%10;
         viewCnt = 10;
         if(cPage == (Math.floor(data[1].length/10))+1) viewCnt = mokSize;
         for(var i=0; i<viewCnt; i++)
         {
            var rbTitle_comment = data[1][i].rb_title;
            if(rbTitle_comment.length>12) rbTitle_comment = rbTitle_comment.substr(0,13)+"...";
            var rbCommentContent = data[1][i].rb_comment_content;
            if(rbCommentContent.length>12) rbCommentContent = rbCommentContent.substr(0,13)+"..."; 
            $("#myreple-Table").append("<tr class='myReivewComment' id='myReivewComment"+i+"'><td>"+data[1][i].rb_no+"</td><td>"+rbTitle_comment+"</td><td>"+rbCommentContent+"</td><td>"+data[1][i].rb_comment_date+"</td><td>"+data[1][i].rb_readcnt+"</td><td>"+data[1][i].rb_recommend+"</td></tr>");
            linkAdd(data[1][i].rb_no, i*(cPage-1), false);
         }
         /*페이징 처리*/
         $("#pageing-list").append(data[2][0].postHtml);   
         $("#select-Review").trigger("click");
         
         var totalPage = Math.ceil(data[0].length/10);
         console.log("totalPage : " + totalPage);
         for(var i=1; i<=totalPage; i++)
         {
            $("a#cPage"+i).click(function(){
               cpageReload($(this).text());
            });
         }
      
      },
      error: function()
      {
         console.log("내 정보보기 페이지 로딩에 실패했습니다.@userInfoView.jsp");
      }
   });
}

/*게시글의 링크를 연결하는 함수*/
function linkAdd(rbNo_parameter, i, typeReview)
{
   if(typeReview == true)
   {
      $("#myReviewContent"+i).click(function(){
         location.href = "<%=request.getContextPath()%>/review/reviewDetail.do?rbNo="+rbNo_parameter;
      });   
   }
   else if(typeReview == false)
   {
      $("#myReivewComment"+i).click(function(){
         location.href = "<%=request.getContextPath()%>/review/reviewDetail.do?rbNo="+rbNo_parameter;
      });
   }
   
}

</script>
</body>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>