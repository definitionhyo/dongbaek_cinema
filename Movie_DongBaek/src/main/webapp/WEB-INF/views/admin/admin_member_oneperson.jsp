<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmf" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
<title>회원관리 - ${member.member_id}</title>
<style>
.w-900 {
	width: 900px;
	margin: 0 auto;
}

.h-500 {
	height: 500px;
}

div {
	background-color: transparent;
}

article {
	justify-content: center;
	align-items: center;
	margin: 2em auto;
}

/* a링크 활성화 색상 변경 */
a:hover, a:active {
	color: #ff5050 !important;
}
</style>
</head>
<body>

	<%--네비게이션 바 영역 - 공통 --%>
	<header id="pageHeader"><%@ include file="../inc/header.jsp"%></header>

	<%--본문내용 - 공통 --%>
	<article id="mainArticle">
		<div class="container-fluid w-900 justify-content-center">
			<div class="row">
				<div class="col-md-12 mt-3">
					<h3>${member.member_id}님의회원정보</h3>
				</div>
			</div>


			<%-- 회원 정보 확인 테이블 시작 --%>
			<div class="row">
				<div class="col-md-12">
					<table class="table table-bordered text-center">
						<tr>
							<%-- 가로 길이 고정(일시) --%>
							<th width="250px">이름</th>
							<td width="550px" colspan="2">${member.member_name }</td>
						</tr>
						<tr>
							<th width="250px">계정</th>
							<td width="550px" colspan="2">${member.member_type }</td>
						</tr>
						<tr>
							<%-- 회원상태 : selectBox , 상태변경 확인버튼 --%>
							<th>회원상태</th>
							<%-- 회원상태가 탈퇴인 경우 탈퇴일도 출력 --%>
							<c:choose>
								<c:when test="${member.member_status eq '탈퇴' }">
									<td width="350px">${member.member_status} <br>(탈퇴한 날짜 : ${member.member_withdrawl })</td>
								</c:when>
								<c:otherwise>
									<td width="350px">${member.member_status}</td>
								</c:otherwise>
							</c:choose>
							<td><select id="statusSelect">
									<option selected disabled>현재 상태 : ${member.member_status }</option>
									<option value="활동">활동</option>
									<option value="탈퇴">탈퇴</option>
							</select>
								<%-- 상태변경 모달 이동 200 row --%>
								<button type="button" class="btn btn-danger"
									id="statusChangeBtn" data-toggle="modal"
									data-target="#memberStatusChange">상태 변경하기</button></td>
						</tr>
						<tr>
							<th>멤버십</th>
							<td width="350px">${member.grade_name}<br> 
								<span>
									<c:choose>
										<%-- 결제금액이 0원이 아닌 경우 --%>
										<c:when test="${not empty member.total_payment}">
											<%-- jstl fmt를 통해 3자리마다 ',' 추가  --%>
											<fmf:formatNumber value="${member.total_payment}" pattern="#,###,###" />
										</c:when>
										<c:otherwise>0</c:otherwise>
									</c:choose>
								</span> /
								<span> 
									<fmf:formatNumber value="${member.grade_max}" pattern="#,###,###" /> 원
								</span>
							</td>
							<td>
								<select id="gradeSelect">
									<option selected disabled>현재멤버십 : ${member.grade_name}</option>
									<option value="BRONZE">BRONZE</option>
									<option value="SILVER">SILVER</option>
									<option value="GOLD">GOLD</option>
									<option value="PLATINUM">PLATINUM</option>
								</select>
									<%-- 등급변경 모달 이동 241 row --%>
									<button type="button" 
											class="btn btn-danger" 
											id="gradeChangeBtn"
											data-toggle="modal" 
											data-target="#memberGradeChange">등급	변경하기</button></td>
						</tr>
						<tr>
							<th>아이디</th>
							<td colspan="2">${member.member_id}</td>
						</tr>
						<tr>
							<th>생년월일</th>
							<td colspan="2">${member.member_birth}</td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td colspan="2">${member.member_phone}</td>
						</tr>
						<tr>
							<th>이메일(선택)</th>
							<td colspan="2">${member.member_email}</td>
						</tr>
					</table>
				</div>
			</div>

			<%-- 버튼 --%>
			<div class="row d-flex justify-content-center mt-3">
				<div class="col-3">
					<%-- 삭제 모달 178 row --%>
					<button class="w-100 btn btn-outline-red mb-3" 
							type="submit"
							data-toggle="modal" 
							data-target="#memberTypeChange">삭제</button>
				</div>
				<%-- AdminController의 admin_member_list 매핑 파라미터(이전 페이지 유지,검색어 유지) : pageNo, memberSearchType, memberSearchKeyword  --%>
				<div class="col-3">
					<button class="w-100 btn btn-outline-red mb-3" 
							type="button"
							onclick="location.href='admin_member_list?pageNo=${pageNo}&memberSearchType=${memberSearchType}&memberSearchKeyword=${memberSearchKeyword}'">돌아가기</button>
				</div>
			</div>
		</div>

		<%-- '회원삭제' 모달 --%>
		<div class="modal fade" id="memberTypeChange" tabindex="-1"	role="dialog" aria-labelledby="memberDeleteTitle" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="memberDeleteTitle">회원 삭제확인</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">회원 정보를 삭제 하시겠습니까?</div>
					<div class="modal-footer justify-content-center">
						<button type="button" 
								class="btn btn-secondary"
								data-dismiss="modal">아니오</button>
						<!-- 0619 정의효 회원삭제 -->
						<form action="admin_memberDelete" method="post">
							<%--  --%>
							<input type="hidden" name="member_id" value="${member.member_id}">
							<button type="submit" class="btn btn-red">&nbsp;&nbsp;&nbsp;&nbsp;예&nbsp;&nbsp;&nbsp;&nbsp;</button>
						</form>
					</div>
				</div>
			</div>
		</div>

		<%-- '회원상태변경' 모달 --%>
		<div class="modal fade" id="memberStatusChange" tabindex="-1" role="dialog" aria-labelledby="memberStatusChangeTitle" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="memberStatusChangeTitle">회원 상태변경 확인</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">회원 상태를 변경하시겠습니까??</div>
					<div class="modal-footer justify-content-center">
						<button type="button" 
								class="btn btn-secondary"	
								data-dismiss="modal">아니오</button>
						<form action="admin_changeMemberStatus" method="post">
							<input type="hidden" name="member_id" value="${member.member_id}">
							<input type="hidden" name="member_status" value="${member.member_status}">
							<button type="submit" class="btn btn-red">&nbsp;&nbsp;&nbsp;&nbsp;예&nbsp;&nbsp;&nbsp;&nbsp;</button>
						</form>
					</div>
				</div>
			</div>
		</div>

		<script>
			$('#statusChangeBtn').on('click', function() {
				const selectedStatus = $('#statusSelect').val();
				if (selectedStatus === null	|| selectedStatus === "회원 상태 선택") {
					alert("회원 상태를 선택해주세요.");
					return false; // 차단 시도 추가
				} else {
					$('#memberStatusChange .modal-footer form input[name="member_status"]').val(selectedStatus);
					$('#memberStatusChange').modal('show'); // 모달 창을 여기에서만 표시하도록 함
				}
			});
		</script>
		<%-- '회원상태변경' 모달  끝--%>

		<%-- '회원등급변경' 모달 --%>
		<div class="modal fade" id="memberGradeChange" tabindex="-1" role="dialog" aria-labelledby="memberGradeChangeTitle"	aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="memberGradeChangeTitle">회원 등급변경 확인</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">회원 상태를 변경하시겠습니까??</div>
					<div class="modal-footer justify-content-center">
						<button type="button" class="btn btn-secondary"	data-dismiss="modal">아니오</button>
						<form action="admin_changeMemberGrade" method="post">
							<input type="hidden" name="member_id" value="${member.member_id}">
							<input type="hidden" name="grade_name" value="${member.grade_name}">
							<button type="submit" 
									class="btn btn-red">&nbsp;&nbsp;&nbsp;&nbsp;예&nbsp;&nbsp;&nbsp;&nbsp;</button>
						</form>
					</div>
				</div>
			</div>
		</div>

		<script>
			$('#gradeChangeBtn').on('click', function() {
				const selectedGrade = $('#gradeSelect').val();
				if (selectedGrade === null || selectedGrade === "현재멤버십 : ${member.grade_name}") {
					alert("변경할 등급을 선택해주세요.");
					return false; // 차단 시도 추가
				} else {
					$('#memberGradeChange .modal-footer form input[name="grade_name"]').val(selectedGrade);
					$('#memberGradeChange').modal('show'); // 추가된 line: 모달 창을 여기에서만 표시하도록 함
				}
			});
		</script>
		<%-- '회원등급변경' 모달  끝--%>
		<%-- 본문 테이블 끝 --%>
	</article>

	<%--왼쪽 사이드바 - 공통 --%>
	<nav id="mainNav" class="d-none d-md-block sidebar">
		<%@ include file="../sidebar/sideBar.jsp"%>
	</nav>

	<%--페이지 하단 - 공통 --%>
	<div id="siteAds"></div>
	<footer id="pageFooter">
		<%@ include file="../inc/footer.jsp"%>
	</footer>
</body>