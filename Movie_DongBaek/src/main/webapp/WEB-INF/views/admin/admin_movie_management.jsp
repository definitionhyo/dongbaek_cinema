<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<title>관리자 - 영화관리</title>
<style>
.w-900 {
	width: 900px;
}

.h-500 {
	height: 500px;
}

div {
	background-color: transparent;
}

/* 확인용 */
/* .container-fluid { */
/* 	border: 1px solid gray; */
/* } */

/* #mainNav { */
/* 	border: 1px solid blue; */
/* } */

/* a링크 활성화 색상 변경 */
a:hover, a:active {
	color: #ff5050 !important;
}
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
					<h1>영화관리</h1>
				</div>
			</div>

			<%-- 'search' 영역 --%>
			<div class="row">
				<div class="col-md-12 mt-3">
					<nav class="navbar navbar-light bg-light justify-content-end">
						<form class="form-inline" 
							  action="admin_movie_management" 
							  id="movieSearchKeyword" 
							  name="movieSearchKeyword" 
							  method="get">
							<input class="form-control mr-sm-2" 
								   type="text"	
								   placeholder="Search" 
								   aria-label="Search"
								   name="movieSearchKeyword"
								   value="${not empty param.movieSearchKeyword ? param.movieSearchKeyword : ''}">
							<button class="btn btn-outline-red my-2 my-sm-0" 
									type="submit">Search</button>
						</form>
					</nav>
				</div>
			</div>

			<%-- 영화관리 테이블 시작 --%>
			<div class="row">
				<div class="col-md-12">
					<table class="table table-striped text-center">
						<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">영화제목</th>
								<th scope="col">개봉일시</th>
								<th scope="col">종영일시</th>
								<th scope="col">수정 및 삭제</th>
							</tr>
						</thead>
						<%-- 테이블에 채워지는 영화제목, 개봉일시, 종영일시, 수정 및 삭제 (제목,개봉/종영 일시 = DB에서가져오기) --%>
						<%-- 뿌리기 코드 <c:forEach var="movie" items="${movie }"> --%>
						<tbody>
							<c:forEach var="movieList" items="${movieList }">
								<tr>
									<th scope="row">${movieList.movie_num }</th>
									<td>${movieList.movie_name_kr}</td>
									<td>${movieList.movie_release_date}</td>
									<td>${movieList.movie_close_date}</td>
									<td>
										<button class="btn btn-danger" 
												value="수정 및 삭제"
												onclick="location.href='admin_movie_detail?movie_num=${movieList.movie_num }'">수정 및 삭제</button>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>

			<!-- 0622정의효 페이징처리 -->
			<div class="row">
				<div class="col-12 d-flex justify-content-between">
					<div></div>
					<nav aria-label="...">
						<ul class="pagination pagination-md justify-content-center mb-0">
							<%-- 이전 페이지로 이동 --%>
							<c:choose>
								<c:when test="${pageNo > 1}">
									<li class="page-item">
										<a class="page-link"
										   href="admin_movie_management?pageNo=${pageNo - 1}&movieSearchKeyword=${param.movieSearchKeyword}"
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
										<li class="page-item active" aria-current="page">
											<a class="page-link" 
											   href="#">${i} <span class="sr-only">(current)</span>
										    </a>
										</li>
									</c:when>
									<c:otherwise>
										<%-- 다른 페이지 --%>
										<li class="page-item">
											<a class="page-link"
											   href="admin_movie_management?pageNo=${i}&movieSearchKeyword=${param.movieSearchKeyword}">${i}</a>
										</li>
									</c:otherwise>
								</c:choose>
							</c:forEach>

							<%-- 다음 페이지로 이동 --%>
							<c:choose>
								<c:when test="${pageNo < pageInfo.maxPage }">
									<li class="page-item">
										<a class="page-link"
										   href="admin_movie_management?pageNo=${pageNo + 1}&movieSearchKeyword=${param.movieSearchKeyword}">&raquo;</a>
									</li>
								</c:when>
								<c:otherwise>
									<li class="page-item disabled">
										<a class="page-link"
										   href="#" 
										   tabindex="-1" 
										   aria-disabled="true">&raquo;</a></li>
								</c:otherwise>
							</c:choose>
						</ul>
					</nav>
					<div>
						<button type="button" 
								class="btn btn-primary btn-lg btn-danger"
								onclick="location.href='admin_movie_regist'" 
								id="registBtn">등록</button>
					</div>
				</div>
			</div>
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