<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- jstl코드로 결제시간 yyyy-MM-dd HH:mm:ss -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.Date"%>
<!doctype html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
	integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
	integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js"
	integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
	crossorigin="anonymous"></script>
<link
	href="${pageContext.request.contextPath }/resources/css/default.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath }/resources/css/sidebar.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath }/resources/css/button.css"
	rel="stylesheet" type="text/css">
<title>관리자 - 결제관리</title>
<style>
/* a링크 활성화 색상 변경 */
a:hover, a:active {
	color: #ff5050 !important;
}

.w-900 {
	width: 900px;
}

.h-500 {
	height: 500px;
}

div {
	background-color: transparent;
}

/* 확인용 
.container-fluid{
	border: 1px solid gray;
}

#mainNav{
	border: 1px solid blue;
} 
*/
</style>
</head>
<body>
	<%--네비게이션 바 영역 --%>
	<header id="pageHeader"><%@ include file="../inc/header.jsp"%></header>

	<article id="mainArticle">
		<%--본문내용 --%>
		<div class="container-fluid w-900">
			<div class="row">
				<div class="col-md-12 mt-3">
					<h1>결제관리</h1>
				</div>
			</div>

			<%-- 'search' 영역 --%>
			<div class="row">
				<div class="col-md-12 mt-3">
					<nav class="navbar navbar-light bg-light justify-content-end">
						<form class="form-inline" 
							  action="admin_payment_list"
							  id="paymentSearchKeyword" 
							  name="paymentSearchKeyword"
							  method="get">
							<input class="form-control mr-sm-2" 
								   type="text"
								   placeholder="Search" 
								   aria-label="Search"
								   name="paymentSearchKeyword"
								   value="${not empty param.paymentSearchKeyword ? param.paymentSearchKeyword : ''}">
							<button class="btn btn-outline-red my-2 my-sm-0" 
									type="submit">Search</button>
						</form>
					</nav>
				</div>
			</div>

			<%-- 결제관리 테이블 --%>
			<div class="row">
				<div class="col-md-12">
					<table class="table table-striped text-center">
						<thead>
							<tr>
								<th scope="col">결제번호</th>
								<th scope="col">아이디</th>
								<%-- 원래는 주문자명이었는데 동명이인이 있을수 있으니 id로 바꿔놓음 0608 - 정의효 --%>
								<th scope="col">결제일시</th>
								<th scope="col">결제상태</th>
								<th scope="col">주문내역 상세보기</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="paymentList" items="${paymentList }">
								<tr>
									<th scope="row">${paymentList.payment_num }</th>
									<td>${paymentList.member_id }</td>
									<td>${paymentList.payment_datetime }</td>
									<td>${paymentList.payment_status }</td>
									<td>
										<form action="admin_payment_list_detail" method="POST">
											<input type="hidden" 
												   name="order_num"
												   value="${paymentList.order_num }"> 
											<input type="hidden" 
												   name="payment_num"
												   value="${paymentList.payment_num }">
											<!-- list_detail 취소를위한 payment_num -->
											<input type="submit" 
												   class="btn btn-outline-red btn-sm"
												   value="상세보기">
										</form>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>

			<!-- 0622정의효 페이징처리 -->
			<nav aria-label="...">
				<ul class="pagination pagination-md justify-content-center">
					<%-- 페이지가 1이상일때 클릭시 이전 페이지로 이동 --%>
					<%-- 이전 페이지로 이동 --%>
					<c:choose>
						<c:when test="${pageNo > 1}">
							<li class="page-item">
								<a class="page-link"
								   href="admin_payment_list?pageNo=${pageNo - 1}&paymentSearchKeyword=${param.paymentSearchKeyword}"
								   tabindex="-1" 
								   aria-disabled="false">&laquo;</a>
						    </li>
						</c:when>
						<c:otherwise>
							<li class="page-item disabled">
								<a class="page-link" 
								   href="#"
								   tabindex="-1" 
								   aria-disabled="true">&laquo;</a>
						    </li>
						</c:otherwise>
					</c:choose>

					<%-- 각 페이지 번호마다 하이퍼링크 설정(현재 페이지는 하이퍼링크 제거) --%>
					<c:forEach var="i" 
						 	   begin="${pageInfo.startPage}"
							   end="${pageInfo.endPage}">
						<c:choose>
							<%-- 현재 페이지 --%>
							<c:when test="${pageNo eq i}">
								<li class="page-item active" 
									aria-current="page">
									<a class="page-link" href="#">${i} <span class="sr-only">(current)</span></a>
								</li>
							</c:when>
							<c:otherwise>
								<%-- 다른 페이지 --%>
								<li class="page-item">
									<a class="page-link"
									   href="admin_payment_list?pageNo=${i}&paymentSearchKeyword=${param.paymentSearchKeyword}">${i}</a>
								</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>

					<%-- 다음 페이지로 이동 --%>
					<c:choose>
						<c:when test="${pageNo < pageInfo.maxPage }">
							<li class="page-item">
								<a class="page-link"
								   href="admin_payment_list?pageNo=${pageNo + 1}&paymentSearchKeyword=${param.paymentSearchKeyword}">&raquo;</a>
							</li>
						</c:when>
						<c:otherwise>
							<li class="page-item disabled">
								<a class="page-link" 
								   href="#"
								   tabindex="-1" 
								   aria-disabled="true">&raquo;</a>
						    </li>
						</c:otherwise>
					</c:choose>
					<li class="page-item"></li>
				</ul>
			</nav>
		</div>
	</article>

	<nav id="mainNav" class="d-none d-md-block sidebar">
		<%--왼쪽 사이드바 --%>
		<%@ include file="/WEB-INF/views/sidebar/sideBar.jsp"%>
	</nav>

	<div id="siteAds"></div>
	<%--페이지 하단 --%>
	<footer id="pageFooter">
		<%@ include file="../inc/footer.jsp"%>
	</footer>
</body>