<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.brw.dto.*" %>
<%
	ReviewBoardViewDTO review = (ReviewBoardViewDTO)request.getAttribute("review");
	List<ReviewBoardComment> reviewComment = (List<ReviewBoardComment>)request.getAttribute("reviewComment");
	List<ReviewBoardComment> reviewReComment = (List<ReviewBoardComment>)request.getAttribute("reviewReComment");
	int count = (int)request.getAttribute("count");
	ReviewBoardComment lastReviewComment = (ReviewBoardComment)request.getAttribute("lastReviewComment");
	int nextNumber = (int)request.getAttribute("nextNumber");
	int prevNumber = (int)request.getAttribute("prevNumber");
	Integer maxLike = (Integer)request.getAttribute("maxLike");
%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/reviewDetail.css" />
<style>
img{
	max-width: 780px;
}
</style>
	<div id ="reviewDetail">
		<div id ="reviewDetail-Header">
			<span id="date">작성일 : <%=review.getRbDate() %></span>
			<span id="comment">댓글 : <%=count %></span>
		</div>
		<div id ="reviewDetail-Title">
			<h3>[리뷰]<%=review.getRbTitle() %></h3>
		</div>
		<div id="reviewDetail-Writer">
			<span id="reviewDetail-booktitle">도서명 : <%=review.getRbBookTitle() %> </span>
	      	<div id="start-Container">
		       <div class="starRev0">
				  <span class="starR1 on" id="star0"></span>
				  <span class="starR2 on" id="star1"></span>
				  <span class="starR1 on" id="star2"></span>
				  <span class="starR2 on" id="star3"></span>
				  <span class="starR1 on" id="star4"></span>
				  <span class="starR2" id="star5"></span>
				  <span class="starR1" id="star6"></span>
				  <span class="starR2" id="star7"></span>
				  <span class="starR1" id="star8"></span>
				  <span class="starR2" id="star9"></span>
				  &nbsp;&nbsp;
				   <span>(<%=review.getRbStarscore()%>점)</span>
				</div>
			</div>
			<span id="reviewBoard-Writer" class="reviewBoard-Writer"><img src="<%=request.getContextPath() %>/images/userGradeImage/<%=review.getUserGrade() %>.svg" alt="" width="25px" height="25px"/><%=review.getUserNickName() %></span>
		</div>
		<div id ="reviewDetail-Content">
			<p>
			<span>
				<%=review.getRbContent() %>
			</span>
			</p>
		</div>
			<div id="like-Wapper" >
				<div id ="like">
					<br />
					<span id = "likeCounter">
						<%if(maxLike==null){ %>
							0
						<%}else{ %>
							<%=maxLike %>
						<%} %>
					</span>
					<br />
					<img src="<%=request.getContextPath() %>/images/heart.png" alt="" style="width: 15px;height: 12px;margin-top: 10px;margin-right:2px"/>
				</div>
			</div>
		<div id="side-menu">
			<ul id="left-menu">
				<li><a href="#" class="btn-gradient green" id="prevpage">이전글</a></li>
				<li><a href="<%=request.getContextPath() %>/review/reviewList.do" class="btn-gradient green" id="report-button">목록 </a></li>
				<li><a href="#" class="btn-gradient green" id="nextpage">다음글</a></li>
			</ul>
			<ul id="right-menu">
				<li><button class="btn-gradient red" style ="float: right;">신고하기</button></li>
			<%if(user!=null && (user.getUserId().equals(review.getRbWriter()) || user.getUserId().equals("admin"))){ %>
				<li><button class="btn-gradient green" style="margin-right: 5px;">삭제</button></li>
				<li><button id="btn-revise-review" class="btn-gradient green" style="margin-right: 5px;">수정</button></li>
			<%} %>
			</ul>
		</div>
		<div id ="comment-Content">
		<%if(reviewComment!=null) {%>
			<%for(ReviewBoardComment rbc : reviewComment){ %>
			<div id="comment-list" class ="comment-list<%=rbc.getRbCommentNo() %>">
			<%System.out.println(rbc.getRbCommentWriter()); %>
				<ul>
					<li>
						<div id="comment-html">
							<div id="comment-header">
								<span class="comment-writer<%=rbc.getRbCommentNo()%>" id="comment-writer"><img src="<%=request.getContextPath() %>/images/userGradeImage/<%=rbc.getUserGrade() %>.svg" alt="" width="25px" height="25px"/><%=rbc.getRbCommentWriterNickName() %></span>
								<input type="hidden" class="comment-writerval" value=<%=rbc.getRbCommentNo()%>>
								<span style="font-size:0.8em;">(<%=rbc.getRbCommentDate() %>)</span>
							</div>
							<div id ="comment-body">
								<span id="review-con<%=rbc.getRbCommentNo()%>"><%=rbc.getRbCommentContent() %></span>
							</div>
							<%if(user!=null && rbc.getRbCommentDelflag().equals("N") && (user.getUserId().equals(rbc.getRbCommentWriter()) || user.getUserId().equals("admin"))){ %>
								<button class="comment-delete" value="<%=rbc.getRbCommentNo()%>" id="comment-delete<%=rbc.getRbCommentNo()%>">
									[삭제]
								</button>
							<%} %>
							<button class="comment-recomment" value="<%=rbc.getRbCommentNo()%>"> 
								[답글]
							</button>
						</div>
					</li>
				</ul>
				<script>
					//작성자 영역을 제외한곳 클릭시 해당 div 숨기기
					$(function(){
						$(document).on('click',".comment-writer<%=rbc.getRbCommentNo()%>",function(){
							var x = $(this).position().top+20;
							var y = $(this).position().left+25;
							console.log(x,y);
							$("#hide-div").css("visibility","visible");
							$("#hide-div").css("top",x).css("left",y);
							$("#Writer").val("<%=rbc.getRbCommentWriterNickName()%>");
						});
						
						$('html').on('click', function(e){
						    var $tgPoint = $(e.target);
						    var $popCallBtn = $tgPoint.hasClass('comment-writer<%=rbc.getRbCommentNo()%>');
						    var $popCallBtn2 = $tgPoint.hasClass('reviewBoard-Writer');
						    var $popArea = $tgPoint.hasClass('hide-div');
						 
						    if (!$popCallBtn && !$popArea && !$popCallBtn2) {
						    	$("#hide-div").css("visibility","hidden");
						    }
						});
						
						// 명훈 : 리뷰 수정 버튼 리스너
						$("#btn-revise-review").on("click",function(){
							location.href = "<%=request.getContextPath()%>/review/reviewRevise.do";
						});
					});
				</script>
		<%if(reviewReComment!=null) {%>
			<%for(ReviewBoardComment rbrc : reviewReComment) {%>
				<%if(rbrc.getRbCommentRef()==rbc.getRbCommentNo()) {%>
					<div id ="recomment-list" class="recomment-List<%=rbrc.getRbCommentNo()%>">
						<ul>
							<li>
								<div id="recomment-html">
									<div id="recomment-header">
										<span class="recomment-writer<%=rbrc.getRbCommentNo()%>"><img src="<%=request.getContextPath() %>/images/userGradeImage/<%=rbrc.getUserGrade() %>.svg" alt="" width="25px" height="25px"/><%=rbrc.getRbCommentWriterNickName() %></span>	
										<span style="font-size:0.7em;">(<%=rbrc.getRbCommentDate() %>)</span>
										<div id="delete-img"><img src="<%=request.getContextPath() %>/images/delete-button.png" style="width: 15px; height: 15px; cursor: pointer;"/></div>
										<input type="hidden" id="recomment-writerNo" value="<%=rbrc.getRbCommentNo() %>" />
									</div>
									<div id="recomment-body">
											<span><%=rbrc.getRbCommentContent() %></span>
									</div>
								</div>
							</li>
						</ul>		
					</div>
				<%} %>
			<%} %>
		<%} %>
		</div>
		<%} %>
	<%} %>
	</div>
		<div id ="comment-Area">
			<table>
				<tr>
				<%if(user!=null) {%>
					<td>
						<div id="comment-Writer">
							<span><img src="<%=request.getContextPath() %>/images/userGradeImage/<%=user.getUserGrade() %>.svg" alt="" width="25px" height="25px"/><strong><%=user.getUserNickName() %></strong></span>
						</div>
					</td>
					<td>
						<div id="comment-textArea">
							<textarea name="comment" id="comment-area"rows="3" cols="75" placeholder="명예회손,욕설,허위사실 유포 등의 글은 관리자에의해 제재또는 삭제될수 있습니다."></textarea>
						</div>
					</td>	
				<td>
					<input type="button" value="등록" id="comment-button"/>
				</td>
				<%}else{ %>
					<td>
						<div id="comment-textArea2">
							<textarea name="comment" id="comment-area"rows="3" cols="90" placeholder="명예회손,욕설,허위사실 유포 등의 글은 관리자에의해 제재또는 삭제될수 있습니다."></textarea>
						</div>
					</td>	
				<td>
					<input type="button" value="등록" id="comment-button"/>
				</td>
				
				<%} %>
				</tr>
			</table>
		</div>
		<script>
				$(document).on('click',"#reviewBoard-Writer",function(){
				var x = $(this).position().top+20;
				var y = $(this).position().left+25;
				console.log(x,y);
				$("#hide-div").css("visibility","visible");
				$("#hide-div").css("top",x).css("left",y);
				$("#Writer").val("<%=review.getUserNickName()%>");
			});
		</script>
		<div id="hide-div" class="hide-div">
			<ul>
				<li>
					<a href="#" id="nameSearch">이름으로 검색하기</a>
				</li>
				<li id="hide-divClose">
					<span>닫기</span>
				</li>
			</ul>
		<input type="hidden" id="Writer"/>
		</div>
	</div>
	<script>
		$("#hide-divClose").click(function(){
			$("#hide-div").css("visibility","hidden");
		});	
		//신고 하기 버튼 클릭시 user값이 없으면 리턴 있으면 신고 페이지 띄워주기
		$(".btn-gradient.red").click(function(){
			<%if(user==null){%>
				alert("로그인 후 이용해 주세요.");
				return;
			<%}else{%>
				console.log("아아");
				var url = "<%=request.getContextPath()%>/review/reviewReport.do?rbReportNo=<%=review.getRbNo()%>&rbReportTitle=<%=review.getRbTitle()%>&rbReportSuspect=<%=review.getUserNickName()%>&rbReportWriter=<%=user.getUserNickName()%>&rbWriter=<%=review.getRbWriter()%>&userId=<%=user.getUserId()%>";
				window.open(url,"_blank" ,"width=500px,height=400px",resizable="no");			
			<%}%>
		});
		
		//이름으로 검색하기 클릭시 처리
		$("#nameSearch").click(function(){
			var rbCommentWriterNickName = $("#Writer").val();
			location.href="<%=request.getContextPath()%>/review/reviewSearch.do?searchType=userNickName&searchKeyword="+rbCommentWriterNickName;
		});					
	
		
		//도서명 클릭시 도서 상세정보로 가기
		$("#reviewDetail-booktitle").click(function(){
			var search = confirm("해당 도서 상세보기로 이동하시겠습니까?");
			if(search){
				location.href="<%=request.getContextPath()%>/book/bookInfo.do?isbn13=<%=review.getRbIsbn()%>";
			}
		});

		//별점 처리
		var result = 0;
		var starscore = <%=review.getRbStarscore()%>
		$(function(){
			starscore = starscore * 2;
		   	for(var i=0; i<starscore; i++)
       		{
           		$("span#star"+i).addClass('on');
           		$(".starR1.on").css("display","block");
           		$(".starR2.on").css("display","block");
       		}
		});
		
		//댓글 입력하는 곳
		$("#comment-button").on('click',function(){
			if($("#comment-area").val().trim().length ==0){
				alert("댓글을 입력해 주세요.");
				return;
			}
			else{
				<%if(user!=null){%>
				var textAreaVal = $("#comment-area").val();
					$.ajax({
						url:"<%=request.getContextPath()%>/insertComment.do?rbNo=<%=review.getRbNo()%>&rbCommentContent="+textAreaVal+"&rbCommentWriter=<%=user.getUserId()%>&rbCommentWriterNickName=<%=user.getUserNickName()%>",
						async:false,
						timeout: 1000,
						success:function(data){
							console.log(data);
							$("#comment-area").val("");
							var div =$("<div id='comment-list' class='comment-list"+data.rbCommentNo+"'></div>");
							var html ="";
							if(data!=null){
								html+= "<ul><li><div id='comment-html'><div id='comment-header'><span class='comment-writer"+data.rbCommentNo+"' id='comment-writer'><img src='<%=request.getContextPath() %>/images/userGradeImage/<%=user.getUserGrade() %>.svg' width='25px' height='25px'/>"+data.rbCommentWriterNickName+"</span> <span style='font-size:0.7em;''>"+(data.rbCommentDate)+"</span></div>";
								html+= "<div id='comment-body'><span id='review-con"+data.rbCommentNo+"'>"+data.rbCommentContent+"</span></div>";
								html+= "<button class='comment-delete' value="+data.rbCommentNo+" id='comment-delete"+data.rbCommentNo+"'>[삭제]</button>";
								html+= "<button class='comment-recomment' value="+data.rbCommentNo+">[답글]</button></div></li></ul>";
								div.append(html);
							}
							$("#comment-Content").append(div);
							isAjaxing = false;
						}
					});
				<%}%>
			}
		});
		//대댓글 입력창 ajax로 생성
		var i = 0;
			$(document).on('click','.comment-recomment',function(){
				<%if(user==null){%>
					alert("로그인 후 이용 가능 합니다.");
					return;
				<%}%>
				if(i==0){
					var div =$("<div class ='recomment-Area'></div>");
					var html ="";
					html +="<table><tr><td><div class='recomment-textArea'><textarea name='recomment' id='recomment-area' rows='3' cols='75'></textarea></div></td>";
					html +="<td><button value='"+$(this).val()+"'class='recomment-button'>등록</button></td></tr></table>";
					div.append(html);
					$("#comment-Content").append(div); 
					div.insertAfter($(this).parent().parent()).children("div").slideDown(800);
					// 핸들러 한 번 실행 후 제거
					$(this).off("click");
					i = 1;
				}
				else{
					$(".recomment-Area").remove();
					i = 0;
				}
			});

		
		//대댓글 입력 하는곳
		$(document).on('click',".recomment-button",function(){
			<%if(user==null){%>
				alert("로그인 후 이용 가능 합니다.");
				return;
			<%}%>
			console.log("앙기모띵")
			if($("#recomment-area").val().trim().length==0){
				alert("댓글을 입력해 주세요.");
				return;
			}
			else
			{
				console.log("들어왓나?");
				var reCommendArea = $("#recomment-area").val();
				<%if(user!=null){%>
				$.ajax({
					url:"<%=request.getContextPath()%>/insertReComment.do?rbCommentNo="+$(this).val()+"&rbCommentContent="+reCommendArea+"&rbCommentWriter=<%=user.getUserId()%>&rbNo=<%=review.getRbNo()%>&rbCommentWriterNickName=<%=user.getUserNickName()%>",
					async:false,
					timeout: 1000,
					success:function(data){
						console.log("에이잭스실행완료");
						var divs =$("<div id='recomment-list' class='recomment-list"+data.rbCommentNo+"'></div>");
						var htmls ="";
						if(data!=null){
							htmls+= "<ul><li><div id='recomment-html'><div id='recomment-header'><span class='recomment-writer"+data.rbCommentNo+"'><img src='<%=request.getContextPath() %>/images/userGradeImage/<%=user.getUserGrade() %>.svg'  width='25px' height='25px'/>"+data.rbCommentWriterNickName+"</span><span style = 'font-size:0.7em;'>"+(data.rbCommentDate)+"</span>";
							htmls+= "<div id='delete-img'><img='<%=request.getContextPath()%>/images/delete-button.png' style='width:15px; height:15px; cursor:pointer;'></img><input type='hidden' id='recomment-writerNo' value='"+data.rbcommentNo+"'></div></div>";
							htmls+= "<div id='recomment-body'><span>"+data.rbCommentContent+"</span></div></div></li></ul>";
						}
						divs.append(htmls);
						$("#recomment-area").parents("#comment-list").append(divs);
						$(".recomment-Area").remove();
						i=0;
						console.log(data);
						isAjaxing = false;
					}
				});
				<%}%>
			}
		});
		//다음글처리
		$("#nextpage").click(function(){
			if(<%=nextNumber%>==0){
				alert("다음글이 존재하지 않습니다.");
				return;
			}
			location.href="<%=request.getContextPath()%>/review/reviewDetail.do?rbNo=<%=nextNumber%>";
		});
		//이전글 처리
		$("#prevpage").click(function(){
			if(<%=prevNumber%>==0){
				alert("이전글이 존재하지 않습니다.");
				return;
			}
			location.href="<%=request.getContextPath()%>/review/reviewDetail.do?rbNo=<%=prevNumber%>";
		});
		
		//좋아요 버튼
		$("#like").click(function(){
			<%if(user==null){%>
				alert("로그인후 이용할 수 있습니다.");
				return;
			<%}%>
			
			<%if(user!=null){%>
			$.ajax({
				url:"<%=request.getContextPath()%>/review/reviewLike.do?rbNo=<%=review.getRbNo()%>&userId=<%=user.getUserId()%>",
				success:function(data){
					$("#likeCounter").html(data);
				}
			});
			<%}%>
		});
		
		$("#comment").click(function(){
			var offset = $("#comment-list").offset();
			$('html, body').animate({scrollTop : offset.top}, 400);
		});
		
		$("#comment-textArea").click(function(){
			<%if(user==null){%>
				alert("로그인 후 이용 가능 합니다.");
				$("#comment-area").blur();
				return;
			<%}%>
		});
		//댓글 삭제 처리
		$(document).on('click','.comment-delete',function(){
			var replay = confirm("정말 삭제 하실 거에요??");
			var brNo = $(this).val();
			if(replay){
				$.ajax({
					url:"<%=request.getContextPath()%>/review/reviewCommentDelete.do?rbCommentNo="+$(this).val()+"&rbNo=<%=review.getRbNo()%>",
					success:function(data){
						console.log(data);
						if(data==2){
							$(".comment-list"+brNo).remove();	
						}
						else if(data==1){
							$("#review-con"+brNo).html("[삭제된 댓글입니다.]");
							$("#review-con"+brNo).addClass("del");
							$("#comment-delete"+brNo).remove();
						}
					}		
				})
			}
		});
		
		//대댓글 삭제 처리
		$(document).on('click','#delete-img',function(){
			var recommentNo = $("#recomment-wrtierNo").val();
			$.ajax({
				url:"<%=request.getContextPath()%>/review/reviewReCommentDelete.do?rbCommentNo="+recommentNo+"&rbNo=<%=review.getRbNo()%>",
				success:function(data){
					console.log(data);
				}
			});
		})
	</script>
