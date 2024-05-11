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
<link href="${pageContext.request.contextPath }/resources/css/button.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/sidebar_myPage.css" rel="stylesheet" type="text/css">
<!-- <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<link rel="stylesheet"href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
<title>영화 예매 사이트</title>
<style>

	 /* a링크 활성화 색상 변경 */ 
	a:hover, a:active{
	 color:  #ff5050 !important;
		
	}
	
	.mainTop {
		margin-bottom: 30px;
	}
	
	.subtit {
		margin-bottom: 20px;
		
	}
	/* 찜하기 내역 없을 때 안내 */
	#noList {
		height: 10rem;
	}
	
	#noList>span {
		vertical-align: middle;
		line-height: 10rem;
		align-content: center;
		margin-left: 300px;
		color: gray;
	}
	
	/* 총 갯수 회색, 작게 보여주기 */
	.gray {
		color: gray;
		font-size: 0.9em;
	}
	
	.likeContent {
		width: 80% !important;
		margin: 5px auto 10px;
		position: relative; /* watched, cancleLike 띄우기 위해서 설정*/
	}
	
	.img {
		width: 190px;
		border: 5px solid #000;
	}
	
	.movieName {
		font-size: 1.2em;
		font-weight: bold;
	}
	
	.textCut {
		/* 영역보다 긴 글의 경우 ... 으로 처리 */
		white-space: nowrap; /* 영역보다 커도 줄 바꿈하지마라 */
		overflow: hidden; /* 잘리는 부분 안보이게 함 */
		text-overflow: ellipsis; /* 잘리는 부분 ...으로 처리 */
	}
	
	.movieBtn {
		margin: 0 auto 30px;
		width: 5.5rem;
		height: 2rem;
		padding: 3px;
	}
	.cancleLike {
		font-size: 0.9rem;
		padding: 2px 10px;
		position: absolute;
		top: 8px;
		right: 35px;
		border: 3px double gray; 
		border-radius: 50%
	}
	
	.watched {
		width: 65px;
		position: absolute;
		bottom: 22px;
		right: 25px;
	}
	
</style>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.0.js"></script>
<script type="text/javascript">
	
	// 공통 이동 처리 함수
	function getCode(url, param) {

// 		switch(url) {
// 			case 'myPayment_detail' : 
// // 				session.setAttribute("order_num", param);
// 				location.href = 'myPayment_detail?payment_num=' + param;
// 				break;
// 		}
	}
	
	function cancleLike(i){
		let movie_num = i;
		let sId = $("#sessionId").val();
		let isLike = true;
		
		$.ajax({
			type: 'POST',
			url: 'likeMovie',
			data: {'member_id': sId, 'movie_num': movie_num, 'isLike': isLike },
			dataType: 'JSON',
			success : function(result) {
				
				if(isLike) {	// 찜 상태가 false면
					alert("선택하신 영화 찜하기를 해제했습니다!");
					location.reload();				
					// 찜 상태 전환(false로)
					
				} else {	// 찜 상태가 true이면
					console.log("찜해제 실패!");
				}
			},
			error : function(xhr, status, error) {
			    console.error(error);
			}
			
		});	// ajax끝
		
		
	} // function 끝
	

</script>
</head>
<body>
 <%--네비게이션 바 영역 --%>
 <header id="pageHeader"><%@ include file="../inc/header.jsp"%></header>
 
 <%-- 세션아이디 들고오기 --%>
 <input type="hidden" name="member_id" value="${sessionScope.member_id }" id ="sessionId">
 
  <article id="mainArticle">
  <%--본문내용 --%>
  	<div class="container w-900">
  		<div class="mainTop">
			<h2>찜한 영화</h2>
			<br>
			<div class="subtit">기대되는 영화 <span class="gray">${likeListCount}건</span> </div>
			<hr>
					<c:choose>
						<c:when test="${empty likeList}">
							<div id="noList">
								<span>고객님의 영화 찜하기 내역이 존재하지 않습니다.</span>
							</div>
						</c:when>
						<c:otherwise>
				<div class="row">
							<c:forEach var="like" items="${likeList }">
								<%-- 찜하기 영화 갯수만큼 생성 --%>
								<div class="col-4">
									<div class="likeContent">
<%-- 										<button class="cancleLike btn btn-dark" data-toggle="modal" data-target="#isCancle" value="${like.movie_num }">X</button> --%>
										<button class="cancleLike btn btn-dark" value="${like.movie_num }" onclick="cancleLike(this.value)">X</button>
										<input type="hidden" id="cancleVal${like.movie_num }">
										
										<div class="poster"><a href="movie_detail_info?movie_num=${like.movie_num}"><img class="img" src="${like.movie_poster}"></a></div>
										<div class="movieName textCut">${like.movie_name_kr} </div>
										<div class="movieRelease gray">${like.movie_release_date} 개봉</div>
										<c:choose>
										<%-- 영화가 상영중이면 예매하러 가는 버튼 생성 --%>
											<c:when test="${like.movie_status eq '상영중'}">
												<button type="button" class="movieBtn btn btn-danger" onclick="location.href='reservation_main?movie_num=${like.movie_num}'">예매하기</button>
											</c:when>
											<c:otherwise>
												<button type="button" class="movieBtn btn btn-secondary">상영종료</button>
											</c:otherwise>
										</c:choose>
										<c:if test="${like.like_view eq '관람' }">
											<img class="watched" src="${pageContext.request.contextPath }/resources/img/watched.png">
										</c:if>
									</div>
								</div>
							</c:forEach>
				</div>	<%-- row클래스 끝 --%>
						</c:otherwise>
					</c:choose>
			</div>
			<hr>
			<%-- 페이징 처리 --%>
			<nav aria-label="...">
			    <ul class="pagination pagination-md justify-content-center">
			        <%-- 이전 페이지로 이동 --%>
			        <c:choose>
			            <c:when test="${pageInfo.startPage > 1}">
			                <li class="page-item">
			                    <a class="page-link" href="myPage_like?pageNo=${pageInfo.startPage - 1}" tabindex="-1" aria-disabled="false">&laquo;</a>
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
			                <c:otherwise>
			                    <%-- 다른 페이지 --%>
			                    <li class="page-item">
			                        <a class="page-link" href="myPage_like?pageNo=${i}">${i}</a>
			                    </li>
			                </c:otherwise>
			            </c:choose>
			        </c:forEach>
			
			        <%-- 다음 페이지로 이동 --%>
			        <c:choose>
			            <c:when test="${pageInfo.endPage < pageInfo.maxPage}">
			                <li class="page-item">
			                    <a class="page-link" href="myPage_like?pageNo=${pageInfo.endPage + 1}">&raquo;</a>
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
  
  	<%-- 찜하기 취소 안내 모달 영역 --%>
	<div class="modal fade" id="isCancle" tabindex="-1" role="dialog" aria-labelledby="needSessionId" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="needSessionId">찜하기 취소</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body text-center" id="modalMsg">
	      <%-- 메세지가 표시되는 부분 --%>
	      확인을 누르면 영화 찜하기가 취소되고 목록에서 사라집니다.<br>
	      영화 찜하기를 취소하겠습니까?
	      </div>
	      <div class="modal-footer justify-content-center">
	        <button type="button" class="btn btn-danger" onclick="checkMovie()">찜 취소</button>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal" aria-label="Close">아니오</button>
	      </div>
	    </div>
	  </div>
	</div>
  
  
  
  
  
  
  
  	<nav id="mainNav" class="d-none d-md-block sidebar">
		<%--왼쪽 사이드바 --%>
  		<%@ include file="/WEB-INF/views/sidebar/sideBar_myPage.jsp"%>
  	</nav>
  
<!--   <nav id="mainNav" class="d-none d-md-block sidebar"> -->
<%--   <%--왼쪽 사이드바 --%>
<!--   <!-- 	왼쪽 탭 링크들 -->
<!--   	<h3>마이페이지</h3> -->
<!-- 		<ul class="left-tap"> -->
<!-- 			<li class="myPage-ticketing-buy"><a class="nav-link" href="myPage_reservation_buy_history">예매 -->
<!-- 					/ 구매내역</a></li> -->
<!-- 			<li class="myPage-review"><a class="nav-link" href="myPage_myReview">나의 리뷰</a></li> -->
<!-- 			<li class="myPage-moviefourcut"><a class="nav-link" href="myPage_moviefourcut">영화네컷</a></li> -->
<!-- 			<li class="myPage-quest"><a class="nav-link" href="myPage_inquiry">문의 내역</a></li> -->
<!-- 			<li class="myPage-grade"><a class="nav-link" href="myPage_grade">등급별 혜택</a></li> -->
<!-- 			<li class="myPage-privacy"><a class="nav-link" href="myPage_modify_check">개인정보수정</a></li> -->
<!-- 		</ul> -->
<!--   </nav> -->
  
  <div id="siteAds"></div>
  <%--페이지 하단 --%>
  <footer id="pageFooter"><%@ include file="../inc/footer.jsp"%></footer>
</body>