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
<title>관리자 - 회원관리</title>
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

/* a링크 활성화 색상 변경 */
a:hover, a:active {
	color: #ff5050 !important;
}

/* 확인용 
.container-fluid {
	border: 1px solid gray;
}
*/
</style>
</head>
<body>

	<%-- 네비게이션 바 영역 - 공통 --%>
	<header id="pageHeader"><%@ include file="../inc/header.jsp"%></header>
	
	<article id="mainArticle">
		<%-- 본문내용 --%>
		<div class="container-fluid w-900">
			<div class="row">
				<div class="col-md-12 mt-3">
					<h1>회원관리</h1>
				</div>
			</div>

			<%-- 'search' 영역 - 공통 --%>
			<div class="row">
				<div class="col-md-12 mt-3">
					<nav class="navbar navbar-light bg-light justify-content-end">
						<form class="form-inline" action="admin_member_list" method="GET">
							<select class="form-control mr-sm-2" name="memberSearchType"
								id="memberSearchType">
								<option value="member_name"
									<c:if test="${param.memberSearchType eq 'member_name' }">selected</c:if>>이름</option>
								<option value="member_id"
									<c:if test="${param.memberSearchType eq 'member_id' }">selected</c:if>>아이디</option>
								<option value="grade_name"
									<c:if test="${param.memberSearchType eq 'grade_name' }">selected</c:if>>멤버십</option>
							</select> <input class="form-control mr-sm-2" 
											 type="text"
											 value="${empty param.memberSearchKeyword ? '' : param.memberSearchKeyword}"
											 placeholder="Search" 
											 aria-label="Search"
											 id="memberSearchKeyword" 
											 name="memberSearchKeyword">
							<button class="btn btn-outline-secondary my-2 my-sm-0" type="submit">Search</button>
						</form>
					</nav>
				</div>
			</div>
			
			<%-- 회원관리 테이블 시작 --%>
			<div class="row">
				<div class="col-md-12">
					<table class="table table-striped text-center">
						<thead>
							<tr>
								<th scope="col">이름</th>
								<th scope="col">아이디</th>
								<th scope="col">멤버십</th>
								<th scope="col">회원상태</th>
								<th scope="col">계정 종류 및 변경</th>
							</tr>
						</thead>
						<tbody>
						<%-- AdminController의 memberList(List) 받아서 member로 뿌림 --%>
							<c:forEach var="member" items="${memberList}">
								<tr>
									<td>${member.member_name}</td>
									<td>${member.member_id}</td>
									<td>${member.grade_name}</td>
									<%-- member에서 grade_name받아서 NONE=비회원, ! = 상태 가져와서 출력 --%>
									<c:choose>
										<%-- 등급없으면 = 비회원 출력 --%>
										<c:when test="${member.grade_name  eq 'NONE'}">
											<td>비회원</td>
										</c:when>
										<%-- 등급 있으면 멤버 상태 출력 --%>
										<c:otherwise>
											<td>${member.member_status}</td>
										</c:otherwise>
									</c:choose>
									<%-- grande_name = NONE일 경우 버튼 클릭 시 deleteNonMember(178행 제이쿼리)시행 파라미터 : member_id--%>
									<c:choose>
										<c:when test="${member.grade_name eq 'NONE'}">
											<td>
												<button type="button" 
													    class="btn btn-secondary" 
													    onclick="deleteNonMember('${member.member_id}')" 
													    data-toggle="modal">${member.member_type}</button></td>
										</c:when>
										<%-- grade_name != NONE 일 경우 회원상세(admin_member_oneperson)페이지로 매핑 파라미터 : member_id, grade_name  --%>
										<c:otherwise>
											<td>
												<button type="button" 
														class="btn btn-secondary"
														onclick="location.href='admin_member_oneperson?member_id=${member.member_id}&grade_name=${member.grade_name }'">${member.member_type}</button></td>
										</c:otherwise>
									</c:choose>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>

			
			<%-- '비회원삭제' 모달 - 공통 --%>
			<div class="modal fade" id="nonMemberTypeChange" tabindex="-1"	role="dialog" aria-labelledby="nonMemberDeleteTitle" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="nonMemberDeleteTitle">회원 삭제확인</h5>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">비회원 정보를 삭제 하시겠습니까?</div>
						<div class="modal-footer justify-content-center">
							<button type="button" 
									class="btn btn-secondary"
									data-dismiss="modal">아니오</button>
							<!-- 삭제를 위한 admin_memberDelete 매핑 파라미터 : member_id-->
							<form action="admin_memberDelete" method="post">
								<input type="hidden" name="member_id" value="${member.member_id}">
								<button type="submit" class="btn btn-red">&nbsp;&nbsp;&nbsp;&nbsp;예&nbsp;&nbsp;&nbsp;&nbsp;</button>
							</form>
						</div>
					</div>
				</div>
			</div>

			<script>
			    function deleteNonMember(member_id) {
			        $("#nonMemberTypeChange").data("memberId", member_id); 
			        $("#nonMemberTypeChange").modal("show");
			    }
			    
			    $('#nonMemberTypeChange').on('show.bs.modal', function () {
			        var memberId = $(this).data('memberId');
			        $('input[name="member_id"]').val(memberId);
			    });
			</script>
			<%-- '비회원삭제' 모달 끝 --%>

			<%-- 페이징 처리 --%>
			<nav aria-label="...">
				<ul class="pagination pagination-md justify-content-center">
					<%-- 이전 페이지로 이동 --%>
					<c:choose>
						<c:when test="${pageNo > 1}">
							<li class="page-item"><a class="page-link"
								href="admin_member_list?pageNo=${pageNo - 1}&memberSearchType=${param.memberSearchType}&memberSearchKeyword=${param.memberSearchKeyword}"
								tabindex="-1" aria-disabled="false">&laquo;</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item disabled"><a class="page-link" href="#"
								tabindex="-1" aria-disabled="true">&laquo;</a></li>
						</c:otherwise>
					</c:choose>

					<%-- 각 페이지 번호마다 하이퍼링크 설정(현재 페이지는 하이퍼링크 제거) --%>
					<c:forEach var="i" begin="${pageInfo.startPage}"
						end="${pageInfo.endPage}">
						<c:choose>
							<%-- 현재 페이지 --%>
							<c:when test="${pageNo eq i}">
								<li class="page-item active" aria-current="page"><a
									class="page-link" href="#">${i} <span class="sr-only">(current)</span></a>
								</li>
							</c:when>
							<c:otherwise>
								<%-- 다른 페이지 --%>
								<li class="page-item"><a class="page-link"
									href="admin_member_list?pageNo=${i}&memberSearchType=${param.memberSearchType}&memberSearchKeyword=${param.memberSearchKeyword}">${i}</a>
								</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>

					<%-- 다음 페이지로 이동 --%>
					<c:choose>
						<c:when test="${pageNo < pageInfo.maxPage }">
							<li class="page-item"><a class="page-link"
								href="admin_member_list?pageNo=${pageNo + 1}&memberSearchType=${param.memberSearchType}&memberSearchKeyword=${param.memberSearchKeyword}">&raquo;</a>
							</li>
						</c:when>
						<c:otherwise>
							<li class="page-item disabled"><a class="page-link" href="#"
								tabindex="-1" aria-disabled="true">&raquo;</a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</nav>
		</div>
	</article>

	<%--왼쪽 사이드바 - 공통 --%>
	<nav id="mainNav" class="d-none d-md-block sidebar">
		<%@ include file="/WEB-INF/views/sidebar/sideBar.jsp"%>
	</nav>

	<div id="siteAds"></div>
	<%--페이지 하단 - 공통--%>
	<footer id="pageFooter">
		<%@ include file="../inc/footer.jsp"%>
	</footer>
</body>