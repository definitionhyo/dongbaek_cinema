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
<!-- <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<link rel="stylesheet"href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
<title>영화 예매 사이트</title>
<style>

	 /* a링크 활성화 색상 변경 */ 
	a:hover, a:active{
	 color:  #ff5050 !important;
		
	}
	
	table {
		margin-top: 20px;
	}

</style>
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
	

</script>
</head>
<body>
 <%--네비게이션 바 영역 --%>
 <header id="pageHeader"><%@ include file="../inc/header.jsp"%></header>
 
  <article id="mainArticle">
  <%--본문내용 --%>
  	<div class="container container-fluid w-900">
  		<div class="mainTop">
			<h2>찜한 영화</h2>
			<br>
<!-- 			<span></span><br> -->
				<table class="table">
					<c:choose>
						<c:when test="${empty likeList}">
							<tr>
								<td>고객님의 영화 찜하기 내역이 존재하지 않습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<tr>
								<th>영화번호</th>
								<th>영화이름</th>
								<th>.</th>
								<th>.</th>
							</tr>
							<c:forEach var="like" items="${likeList }">
								<tr>
									
									<td>${like.movie_num }
									</td>
									<td>.
									</td><%-- {param.order_total} --%>
									<td>.</td>
									<td>
										.
<%-- 										<a href="myPayment_detail?order_num=${myPayment.order_num}">상세내역보기</a> --%>
									</td> <%--누르면 팝업창으로 구매종류 이름 가격 구매시간 --%>
<%-- 									<td><a href="myPayment_detail?myPayment=${myPayment}">상세내역보기</a></td> 누르면 팝업창으로 구매종류 이름 가격 구매시간 --%>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</table>
			</div>
			
			<%-- 페이징 처리 --%>
			<nav aria-label="...">
			    <ul class="pagination pagination-md justify-content-center">
			        <%-- 이전 페이지로 이동 --%>
			        <c:choose>
			            <c:when test="${pageInfo.startPage > 1}">
			                <li class="page-item">
			                    <a class="page-link" href="myPage_buy_history?pageNo=${pageInfo.startPage - 1}" tabindex="-1" aria-disabled="false">&laquo;</a>
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
			                        <a class="page-link" href="myPage_buy_history?pageNo=${i}">${i}</a>
			                    </li>
			                </c:otherwise>
			            </c:choose>
			        </c:forEach>
			
			        <%-- 다음 페이지로 이동 --%>
			        <c:choose>
			            <c:when test="${pageInfo.endPage < pageInfo.maxPage}">
			                <li class="page-item">
			                    <a class="page-link" href="myPage_buy_history?pageNo=${pageInfo.endPage + 1}">&raquo;</a>
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