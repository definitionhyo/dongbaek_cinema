
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* 폰트설정 */
@font-face {
    font-family: 'TheJamsil5Bold';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2302_01@1.0/TheJamsil5Bold.woff2') format('woff2');
    font-weight: 700;
    font-style: normal;
}
@font-face {
    font-family: 'SUITE-Regular';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-2@1.0/SUITE-Regular.woff2') format('woff2');
    font-weight: 400;
    font-style: normal;
}
div>h5, div>h4, div .row .col{
	font-family: TheJamsil5Bold;
}
#content, #review_content, #movie-end, #review_contents{
	font-family:SUITE-Regular;
	margin-left: 5px;
	margin-bottom: 20px;
}
#review_content_TOP{
	width:250px;
	font-family:SUITE-Regular;
	margin-left: 5px;
	margin-bottom: 20px;
}
#movie-end{
	padding: 50px; 
	padding-right: 80px;
	
}
#movie_name{
	font-size: xx-large;
}
#emptyReview{
	width:250px;
	font-size:medium;
	color: gray;
}
#review_card{
	margin-top: 10px;
}

#section3{
	margin-top:20px;
}
/* #cast, #content{ */
/* 	padding-left:20px; */
/* } */
#cast{
	padding-left:10px;
}
</style>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.0.js"></script>
<script>

  	//찜하기 받아오기
	$(function() {
		let sId = $("#sessionId").val();
		console.log(sId);
		$.ajax ({
			type: 'GET',
			url: 'likeMovieShow',
			data: {'member_id' : sId},
			dataType: 'JSON',
			success: function(result) {
			console.log(result);
				
					let movieNo = $("#likeMovie").data('target');	// movie_num
					console.log(movieNo);
					
					for(let like of result) {
						if(like.movie_num == movieNo) {	// 일치하면
							$("#likeMovie").removeClass("btn-outline-danger");
							$("#likeMovie").addClass("btn-danger");
							$("#likeMovie").text("♡찜");
							$("#clickCk").attr("disabled", true);
						}
					}
			},
			error: function() {
				console.log("에러");
			}
		});
		
	});// function 끝
	
	
	// 찜하기 기능
	function checkMovie() {
		
		let sId = $("#sessionId").val();
		let movie_num = $("#likeMovie").data('target');
		let targetId = 'clickCk';
		console.log(targetId);	// 타겟아이디
		let isLike = $("#" + targetId).prop("disabled");	// 찜 안했을 땐 false
		console.log(sId);	// 세션아이디 확인
		console.log(movie_num);
		console.log(isLike);
		
		$.ajax({
			type: 'POST',
			url: 'likeMovie',
			data: {'member_id': sId, 'movie_num': movie_num, 'isLike': isLike },
			dataType: 'JSON',
			success : function(result) {
				console.log("성공!");
				console.log(isLike);
				
				if(isLike) {	// 찜 상태가 false면
					$("#likeMovie").removeClass("btn-danger");
					$("#likeMovie").addClass("btn-outline-danger");
					$("#likeMovie").text("♡찜하기");
					
					// 찜 상태 전환(false로)
					$("#" + targetId).attr("disabled", false);
					
				} else {	// 찜 상태가 true이면
					$("#likeMovie").removeClass("btn-outline-danger");
					$("#likeMovie").addClass("btn-danger");
					$("#likeMovie").text("♡찜");
					
					// 찜 상태 전환(true로)
					$("#" + targetId).attr("disabled", true);
				}
			},
			error : function(xhr, status, error) {
			    console.error(error);
			}
			
		});	// ajax끝
		
	} // 찜하기 버튼 클릭 함수 끝
  
  
</script>
<style type="text/css">
	/* 찜하기 관련 */
	#needLogin, #needLogin>div {
		background-color: #ffffff00;
	}
</style>
</head>
<body>

 <%-- 찜하기 기능 - 세션아이디로 조회 --%>
 <input type="hidden" name="member_id" value="${sessionScope.member_id }" id ="sessionId">
	
	<div class="row">
		<%-- 1. 왼쪽 섹션 --%>
		<div class="col-md-8">
			<div class="col" >
				
				<div class="row" style="margin-top: 80px">
					<div class="col" id="movie_name">${movie.movie_name_kr }</div>
				</div>
				
				<div class="row">
					<div class="col">${movie.movie_name_en }</div>
				</div><hr>
				 
				 <div class="row" id="content">
				 	<div class="col-ml-5">${movie.movie_content }</div>
				  </div>
				  
				  
		<%--찜버튼, 리뷰출력카드 --%>
		<div class="row">
		
			<div class="col my-2" style="width:80px">
	  		<%--찜버튼 --%>
	    	<c:choose>
					<c:when test="${not empty sessionScope.member_id && member_type ne '비회원'}">
				    	<button type="button" class="btn btn-outline-danger mr-2" id="likeMovie" data-target="${movie.movie_num }"onclick="checkMovie()">♡찜하기</button>
				    	<input type="hidden" id="clickCk">
				    </c:when>
				<c:otherwise>
					<%-- 찜하기 버튼과 버튼 클릭 시 상태 변경용 히든 타입 태그 --%>
					<button type="button" class="btn btn-outline-danger" id="likeMovieNo" data-toggle="modal" data-target="#needLogin">♡찜하기</button>
				</c:otherwise>
			</c:choose>
			</div>
			<%--찜버튼 끝 --%>
		</div>
		
		
		
		<div class="row" id="section3" >
			<%-- 리뷰컨텐츠 --%>	
			
			<div class="card border-0 shadow-sm" style="width: 20rem" id="review_card">
			    <div class="col-lg-5">
						<c:choose>
							<c:when test="${not empty review.review_content }">
								<h5 class="card-title">아이디 : ${review.member_id }</h5>
								<p class="card-text" id="review_content_TOP">${review.review_content }</p>
							</c:when>
							<c:otherwise>
								<h5 class="card-title" id="emptyReview"> 작성된 리뷰가 존재하지 않습니다 </h5>
<!-- 								<p class="card-text" id="review_content_TOP">작성된 리뷰가 존재하지 않습니다</p> -->
							</c:otherwise>
						</c:choose>
				</div>
			</div>
			<div class="col-lg-3">
				<h5>평점</h5> <fmt:formatNumber value="${movie.movie_review_rating}" maxFractionDigits="1" /> 점
			</div>	
			<div class="col-lg-3">
				<h5>실제 관람객 수</h5> <fmt:formatNumber value="${movie.movie_audience_num }" type="number" pattern="###,###" /> 명
			</div>
			<%-- 리뷰컨텐츠 끝--%>
		</div>
		
		
			  	<%-- 평점 --%>
<!-- 			 	<div class="row"> -->
<!-- 			  		<div class="col"> -->
<%-- 						<h3>평점</h3> : <fmt:formatNumber value="${movie.movie_review_rating}" maxFractionDigits="1" />  --%>
<!-- 			  		</div> -->
<!-- 			  		<div class="col"> -->
<%-- 			  			<h3>실제 관람객 수</h3>   <fmt:formatNumber value="${movie.movie_audience_num }" type="number" pattern="###,###" /> 명 --%>
<!-- 			 		</div> -->
<!-- 				</div> -->
			</div>
		</div>
		<%--왼쪽섹션 끝 --%> 
		
		
		
		
		
		<%-- 1-1. 오른쪽 포스터 카드 섹션 --%>
		<div class ="col float-right col-md-3" style="margin-top: 80px">
			<div class="row">
				<div class="card border-0 shadow-sm" style="width: 18rem">
					<img src="${movie.movie_poster }" class="card-img-top" alt="..." onclick="reservation_main()">
					<div class="card-body" style="padding-left: 90px;">
						<button class="btn btn-danger" onclick="location.href='reservation_main?movie_num=${movie.movie_num }'"> 예매하기 </button>
					</div>
				</div>
			</div>
		 </div>	
		 <%--포스터카드섹션 끝 --%>
	</div>
	
	<%-- 찜하기 안내 모달 영역 --%>
	<div class="modal fade" id="needLogin" tabindex="-1" role="dialog" aria-labelledby="needSessionId" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="needSessionId">찜하기 - 로그인 필요</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body text-center" id="modalMsg">
	      <%-- 메세지가 표시되는 부분 --%>
	      <c:choose>
		      <c:when test="${member_type eq '비회원'}">
		      	회원 로그인이 필요한 작업입니다.
		      </c:when>
		      <c:otherwise>
		      	회원 로그인이 필요한 작업입니다. 로그인 하시겠습니까?
		      </c:otherwise>
	      </c:choose>
	      </div>
	      <div class="modal-footer justify-content-center">
	      	<c:choose>
	      		<c:when test="${empty sessionScope.member_id}">
		        	<button type="button" class="btn btn-danger" onclick="location.href='member_login_form'">로그인</button>
			        <button type="button" class="btn btn-secondary" data-dismiss="modal" aria-label="Close">아니오</button>
		        </c:when>
		        <c:otherwise>
			        <button type="button" class="btn btn-secondary" data-dismiss="modal" aria-label="Close">확인</button>
		        </c:otherwise>
	      	</c:choose>
	      </div>
	    </div>
	  </div>
	</div>
	
</body>
</html>