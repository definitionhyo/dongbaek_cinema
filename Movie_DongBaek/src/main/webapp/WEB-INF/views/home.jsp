<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!doctype html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<title>영화 예매 사이트</title>
<style>
.w-1200 {
	width: 1200px;
}
.subject_now {
	color: #ef4f4f;
	font-size: 18px;
 	text-decoration: overline;
	margin: auto;
}
a:link,a:visited { color:gray; }

.movieDiv {
	position: relative;
}
.movieDiv img {
	background-image: linear-gradient(to bottom, rgba(0, 0, 0, 0),
			 rgba(0, 0, 0, 0.09) 35%, rgba(0, 0, 0, 0.85));
}
.movieRank {
	position: absolute;
	margin-bottom: 0;
	padding-bottom: 0;
	bottom: -20px;
	left: 10px;
	font-size: 60px;
	font-style: italic;
	color: #eee;
}

.searchArea {
	margin: 25px auto 20px auto;
}

/* 찜하기 관련 */
#needLogin, #needLogin>div {
	background-color: #ffffff00;
}

</style>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.0.js"></script>
<script type="text/javascript">
	
	// 찜하기 받아오기
	$(function() {
		
		let sId = $("#sessionId").val();
// 		console.log(sId);
		$.ajax ({
			type: 'GET',
			url: 'likeMovieShow',
			data: {'member_id' : sId},
			dataType: 'JSON',
			success: function(result) {
// 			console.log(result);
				
				for(let i = 1; i <= 4; i++) {
					let movieNo = $("" + $("#likeMovie" + i).data("target")).val();	// movie_num
// 					console.log(movieNo);
					
					for(let like of result) {
						if(like.movie_num == movieNo) {	// 일치하면
// 							console.log(i);
							$("#likeMovie" + i).removeClass("btn-outline-danger");
							$("#likeMovie" + i).addClass("btn-danger");
							$("#likeMovie" + i).text("♡찜");
							$("#clickCk" + i).attr("disabled", true);
						}
					}
				}
			},
			error: function() {
				console.log("에러");
			}
		});
		
	});// function 끝
	
	
	// 찜하기 기능
	function checkMovie(element, i) {
		
		let sId = $("#sessionId").val();
// 		console.log($(element).val());
		let movie_num = $("" + $(element).data('target')).val();
		let targetId = 'clickCk' + i;
// 		console.log(targetId);	// 타겟아이디
		let isLike = $("#" + targetId).prop("disabled");	// 찜 안했을 땐 false
// 		console.log(sId);	// 세션아이디 확인
// 		console.log(movie_num);
// 		console.log(isLike);
		
		$.ajax({
			type: 'POST',
			url: 'likeMovie',
			data: {'member_id': sId, 'movie_num': movie_num, 'isLike': isLike },
			dataType: 'JSON',
			success : function(result) {
				console.log("성공!");
				console.log(isLike);
				
				if(isLike) {	// 찜 상태가 false면
					$(element).removeClass("btn-danger");
					$(element).addClass("btn-outline-danger");
					$(element).text("♡찜하기");
					
					// 찜 상태 전환(false로)
					$("#" + targetId).attr("disabled", false);
					
				} else {	// 찜 상태가 true이면
					$(element).removeClass("btn-outline-danger");
					$(element).addClass("btn-danger");
					$(element).text("♡찜");
					
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
</head>
<body>
 <%--네비게이션 바 영역 --%>
 <header id="pageHeader"><%@ include file="inc/header.jsp"%></header>
  	<article id="mainArticle">
  	<%--본문내용 --%>
	<div class="container-fluid w-1200">
	  <br>
 	<%-- 현재상영작 --%>
 	 <div class="d-flex justify-content-center" >
				<!-- 	 <ul class="nav nav-pills mb-3 text-dark" id="pills-tab" role="tablist"  > -->
				<!-- 		<li class="nav-item bg-white " > -->
				<!-- 			<a class="nav-link active" id="pills-home-tab" data-toggle="pill" href="#pills-home" role="tab" aria-controls="pills-home" aria-selected="true"> -->
		<b class="subject_now">현재상영작</b>
		<!-- 			</a> -->
		<!-- 		</li> -->
		<!-- 	</ul> -->
  	</div>
 	
 	<div class="d-flex justify-content-end" style="color: #ccc;">
 		<a href="movie_list_present" >
 			<b>더 많은 영화보기</b>
 		</a> +
 	</div>
 
 	<%-- 영화목록 4개출력(예매율순?) --%>
  <div class="tab-content" id="pills-tabContent">
	<!--   <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab"> -->


	<%-- 컨텐츠 forEach --%>
	<div class="row" style="white-space: nowrap; overflow:hidden; text-overflow: elipsis;">
		<c:forEach var="movie" items="${movieList}" varStatus="i">
			<div class="col-3">
				<div class="card border-0 shadow-sm">
					<div class="movieDiv">
						<a href="movie_detail_info?movie_num=${movie.movie_num}">
							<img src="${movie.movie_poster}" class="card-img-top" alt="...">
							<span class="movieRank">${i.count}</span>
						</a>
					</div>
					<div class="card-body">
						<h6 class="card-title"><b> ${movie.movie_name_kr}</b></h6>
						<p class="card-text">
							<%-- 찜하기 버튼 클릭 시 movie_num 파라미터로 받아 전달 --%>
							<input type="hidden" name="member_id" value="${sessionScope.member_id }" id ="sessionId">
							<input type="hidden" name="movie_num" value="${movie.movie_num}" id="movie_num${i.count }">
							<c:choose>
								<%--
								회원이나 직원이('비회원'이 아닐 때)
								세션 아이디가 있을 때(로그인o) 찜하기 기능
									- 찜하기 목록에 있으면 찜 표시
									- 찜하기 목록에 없으면 그대로 표시
								세션 아이디가 없을 때(로그인x) 모달창으로 로그인권유,
								--%>
								<c:when test="${not empty sessionScope.member_id && member_type ne '비회원'}">
									<button type="button" class="btn btn-outline-danger" id="likeMovie${i.count }" data-target="#movie_num${i.count }" value="${i.count }" onclick="checkMovie(this, ${i.count })">♡찜하기</button>
									<input type="hidden" id="clickCk${i.count }">
								</c:when>
<%-- 									<c:otherwise> --%>
<%-- 										<button type="button" class="btn btn-outline-danger" id="likeMovie${i.count }" data-target="#movie_num${i.count }" data-number="${i.count }" onclick="checkMovie(this.dataset.number)">♡찜하기</button> --%>
<%-- 										<input type="hidden" id="clickCk${i.count }"> --%>
<%-- 									</c:otherwise> --%>
<%-- 									</c:choose> --%>
<%-- 								</c:when> --%>
								<%-- 세션아이디가 없거나 비회원일 때 -> 클릭 시 모달창 팝업 --%>
								<c:otherwise>
									<%-- 찜하기 버튼과 버튼 클릭 시 상태 변경용 히든 타입 태그 --%>
									<button type="button" class="btn btn-outline-danger" id="likeMovieNo${i.index }" data-toggle="modal" data-target="#needLogin">♡찜하기</button>
								</c:otherwise>
							</c:choose>
							<button type="button" class="btn btn-danger" onclick="location.href='reservation_main?movie_num=${movie.movie_num}'">예매하기</button>
						</p>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
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
	
	
	
		
		<%--    <%-- 영화검색창(if로 현재상영작, 상영예정작 구분해서 보내기 --%> 
	    <%-- 현재상영작 내 --%> 
	   <div class="row searchArea">
	   
	      <form class="form-inline my-2 my-lg-0" action="movie_list_present" id="movieSearchKeyword" name="movieSearchKeyword" method="get" >
	          <input class="form-control mr-sm-2" type="text"
	                           placeholder="영화명을 입력해주세요" aria-label="Search" 
	                           name="movieSearchKeyword"
	                           value="${not empty param.movieSearchKeyword ? param.movieSearchKeyword : ''}">
	            <button class="btn btn-outline-success my-2 my-sm-0" type="submit" onclick="location.href='movie_list_present?movieSearchKeyword=${param.movieSearchKeyword}'">Search</button>
	       </form>
	       
		 <%-- 상영예정작 내 --%>    
	     
	    </div>
		<%--     영화검색창 끝 --%>
	    
    
    
    </div>
  	</article>
  	<%--div 컨테이너 끝 --%>
  
  <nav id="mainNav" class="d-none d-md-block sidebar">
  <%--왼쪽 사이드바 --%>
  </nav>
  <div id="siteAds"></div>
  <%--페이지 하단 --%>
  <footer id="pageFooter"><%@ include file="inc/footer.jsp"%></footer>
</body>