<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmf" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/myPage.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/sidebar_myPage.css" rel="stylesheet" type="text/css">
<title>영화 예매 사이트</title>
<style>

</style>
<script type="text/javascript">
$(document).ready(function() {
	
	// 각각의 리뷰
	let myReview = $("tr.myReview");
	
	
	myReview.each(function() { // 각 리뷰에 대해 수행
		
		// 상영상태가 "상영종료" 인 영화에 대해
		// 리뷰가 있으면 해당 리뷰 가져오기
		if($("input[type=hidden]", this).val() == "상영완료") {
			let movieNum = $(".movieName", this).attr("data-movie-num");
			let memberId = $(".movieName", this).attr("data-member-id");
			let playNum = $(".movieName", this).attr("data-play-num");
			let playStatus = $(".movieName", this).attr("data-play-status");
			
			getReview(movieNum, memberId, playNum);
		}
	
		if($("input[type=hidden]", this).val() == "상영 전"){
			let movieNum = $(".movieName", this).attr("data-movie-num");
			$(".myReview[id='" + movieNum + "'] .reviewWriteModify").html("<button class='btn btn-outline-danger' disabled>작성불가</button>");								
			
		}
	});
	
});


function getReview(movieNum, memberId, playNum) {	
	
	$.ajax({
		type : "post", 
		url : "GetReivew", 
		data : {"member_id" : memberId, "movie_num" : movieNum}, 
		dataType : "json",
	})
	.done(function(myReview) {
		
		if(myReview.length > 0){
			let reviewNum = myReview[0].review_num;
			let reviewContent = myReview[0].review_content;
			let reviewRating = myReview[0].review_rating;
			let review_date = myReview[0].review_date;
			let reviewDate = review_date.substring(0, 10);
			
			$(".myReview[id='" + movieNum + "'] .reviewContent").html(reviewContent);
			$(".myReview[id='" + movieNum + "'] .reviewRating").html(reviewRating);
			$(".myReview[id='" + movieNum + "'] .reviewDate").html(reviewDate);
			$(".myReview[id='" + movieNum + "'] .reviewWriteModify").html("<button class='btn btn-outline-danger' disabled data-movie-num='" + movieNum + "' data-member-id='" + memberId + "' data-review-num='" + reviewNum + "'>작성완료</button>");
// 			alert($(".myReview[id='" + movieNum + "'] .reviewWriteModify").html());
		}else{
			// 클래스
// 			$(".myReview[id='" + movieNum + "'] .reviewWriteModify").html("<a data-movie-num='" + movieNum + "' data-member-id='" + memberId + "' onclick='review_write(this)'>작성하기</a>");
			$(".myReview[id='" + movieNum + "'] .reviewWriteModify").html("<button class='btn btn-outline-danger' data-movie-num='" + movieNum + "' data-member-id='" + memberId + "' onclick='review_write(this)'>작성하기</button>");
		}
	})
	.fail(function() { // 요청 실패 시
		alert("요청 실패!");
	});
}

// [작성하기/수정하기] 클릭 시 파라미터로 넘기기 위한 함수
function review_write(obj){
// 	alert($(obj).html());
	let movieNum = $(obj).attr("data-movie-num");      // 선택한 영화 번호   
	let memberId = $(obj).attr("data-member-id");      // 멤버 정보
	let reviewNum = $(obj).attr("data-review-num");      // 리뷰 번호
	$("input[name=movie_num]").val(movieNum);   // 선택한 상영정보 hidden 타입의 input 태그에 value 값으로 넣기
	$("input[name=member_id]").val(memberId);   // 선택한 상영정보 hidden 타입의 input 태그에 value 값으로 넣기
	$("input[name=review_num]").val(reviewNum);   // 선택한 상영정보 hidden 타입의 input 태그에 value 값으로 넣기
// 	alert(movieNum);
// 	location.href = "review_write";
	$("form").submit();
}
</script>

</head>
<body>
<%--네비게이션 바 영역 --%>
<header id="pageHeader"><%@ include file="../inc/header.jsp"%></header>
 
<article id="mainArticle">
	<%--본문내용 --%>
	<div class="container container-fluid w-900">
	<form action="review_write" method="POST">
		<input type="hidden" name="movie_num" value="">
		<input type="hidden" name="member_id" value="">
		<input type="hidden" name="review_num" value="">
	</form>
	<div class="mainTop">
 		<h2>나의 리뷰</h2>
 		<br>
 		<br>
 		<span> 회원님이 작성하신 리뷰를 확인하실 수 있습니다! </span>
 		
 		<table class="table">
 			<c:choose>
 				
<%--  				<c:when test="${myReviewList.play_change }"> --%>
 				<c:when test="${empty myReviewList }">
 					<tr>
						<td>고객님께서 작성하신 리뷰는 존재하지 않습니다.</td>
					</tr>
 				</c:when>
	 			<c:otherwise>
		 			<tr>
		 				<th>번호</th>
			 			<th>영화 제목</th>
			 			<th>리뷰 내용</th>
			 			<th>평점</th>
			 			<th>등록일</th>
				 		<th>작성 및 수정</th>
	 				</tr>
	 				<c:forEach var="myReviewList" items="${myReviewList }" begin="0" end="3" step="1" varStatus="status">
		 				<tr class="myReview" id="${myReviewList.movie_num }">
					 		<td>
					 			${status.index+1}
					 		</td> 
					 		
					 		<td class="movieName" data-movie-num="${myReviewList.movie_num }" data-member-id="${myReviewList.member_id }" data-play-status="${myReviewList.play_status }">
					 			${myReviewList.movie_name_kr }
					 			<input type="hidden" value="${myReviewList.play_status }">
					 		</td> 
					 		
					 		<td class="reviewContent">
					 			<!-- 리뷰 내용 출력 -->
					 		</td>

					 		<td class="reviewRating">
					 			<!-- 리뷰 평점 출력 -->
					 		</td> <%-- {param.avg_review_point} --%>
					 		
					 		<td class="reviewDate">
					 			<!-- 리뷰 쓴 날짜 출력 -->
					 		</td> <%-- {param.review_datetime} --%>
					 		
					 		<td class="reviewWriteModify">
<!-- 					 			<a href="#">작성불가</a> -->
					 		</td>
					 		
<%-- 					 		<c:choose> --%>
<%-- 					 			<c:when test="${empty myReviewList.review_content}"> --%>
<!-- 							 		<td class="reviewModify"> -->
<!-- 							 			<a href="myPage_reviewWrite">작성하기</a> -->
<!-- 							 		</td> -->
<%-- 						 		</c:when> --%>
<%-- 						 		<c:otherwise> --%>
<!-- 							 		<td> -->
<!-- 							 			<a href="modify_review">수정 및 삭제</a> -->
<!-- 							 			<a href="modify_delete">삭제</a> -->
<!-- 							 		</td> -->
							 		
<!-- 							 		<td> -->
<!-- 							 			작성완료 -->
<!-- 							 		</td> -->
<%-- 						 		</c:otherwise> --%>
<%-- 					 		</c:choose> --%>
				 		</tr>
	 				</c:forEach>
	 			</c:otherwise>	
 			</c:choose>
 		</table>
 	 </div>
  
  	<%-- 페이징 처리 시작 --%>
  	<nav aria-label="...">
		<ul class="pagination pagination-md justify-content-center">
			<%-- 이전 페이지로 이동 --%>
			<c:choose>
			    <c:when test="${pageInfo.startPage > 1}">
			    	<li class="page-item">
			    		<a class="page-link" href="myPage_myReview?pageNo=${pageInfo.startPage - 1}" tabindex="-1" aria-disabled="false">&laquo;</a>
			    	</li>
			    </c:when>
			    <c:otherwise>
			    	<li class="page-item disabled">
			    		<a class="page-link" href="#" tabindex="-1" aria-disabled="true">&laquo;</a>
			   		</li>
			    </c:otherwise>
			</c:choose>
			
			<%-- 각 페이지 번호마다 하이퍼링크 설정(현재 페이지는 하이퍼링크 제거) --%>
			<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
				<c:choose>
					<%-- 현재 페이지 --%>
					<c:when test="${pageNo eq i}">
						<li class="page-item active" aria-current="page">
							<a class="page-link">${i} <span class="sr-only">(current)</span></a>
						</li>
					</c:when>
					
			    	<%-- 다른 페이지 --%>
		        	<c:otherwise>
						<li class="page-item">
							<a class="page-link" href="myPage_myReview?pageNo=${i}">${i}</a>
						</li>
					</c:otherwise>
	       		</c:choose>
			</c:forEach>
			
			<%-- 다음 페이지로 이동 --%>
			<c:choose>
				<c:when test="${pageInfo.endPage < pageInfo.maxPage}">
			    	<li class="page-item">
			        	<a class="page-link" href="myPage_myReview?pageNo=${pageInfo.endPage + 1}">&raquo;</a>
			        </li>
			    </c:when>
			    <c:otherwise>
			    	<li class="page-item disabled">
			        	<a class="page-link" href="#" tabindex="-1" aria-disabled="true">&raquo;</a>
			        </li>
			    </c:otherwise>
			</c:choose>
		</ul>
	</nav>
			
  </div>
  
  </article>
  
  	<nav id="mainNav" class="d-none d-md-block sidebar">
		<%--왼쪽 사이드바 --%>
  		<%@ include file="/WEB-INF/views/sidebar/sideBar_myPage.jsp"%>
  	</nav>
  
  
  <div id="siteAds"></div>
  <%--페이지 하단 --%>
  <footer id="pageFooter"><%@ include file="../inc/footer.jsp"%></footer>
</body>