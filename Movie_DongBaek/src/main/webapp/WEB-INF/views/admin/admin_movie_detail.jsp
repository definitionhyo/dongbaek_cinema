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
<title>영화상세정보 - ${movieList.movie_name_kr }</title>
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
	<%--네비게이션 바 영역 --%>
	<header id="pageHeader"><%@ include file="../inc/header.jsp"%></header>

	<%--본문내용 --%>
	<article id="mainArticle">
		<div class="container-fluid w-900 justify-content-center">
			<div class="row">
				<div class="col-md-12 mt-3">
					<h3>
						${movie.movie_name_kr}<span style="color: red; font-size: 0.5em;">*</span><span style="font-size: 0.5em;">는 필수 입력 항목입니다!</span>
					</h3>
				</div>
			</div>

			<%-- 영화 상세정보 확인 테이블 시작 --%>
			<div class="row">
				<div class="col-md-12">
					<form action="admin_movie_modify" method="post" id="movieForm">
						<input type="hidden" name="movie_num" value="${movie.movie_num}">
						<table class="table table-bordered text-center">
							<tr>
								<th width="250px">영화번호</th>
								<td colspan="2">${movie.movie_num }</td>
							</tr>
							<tr>
								<th>
									<span style="color: red; font-size: 0.7em;">*</span> 영화제목(kr)</th>
								<td colspan="2">
									<input type="text"
										   name="movie_name_kr" 
										   id="movie_name_kr" 
										   value="${movie.movie_name_kr }"
										   required="required"></td>
							</tr>
							<tr>
								<th>
									<span style="color: red; font-size: 0.7em;">*</span> 영화제목(en)</th>
								<td colspan="2">
									<input type="text" 
										   name="movie_name_en"
										   id="movie_name_en" 
										   value="${movie.movie_name_en }"
										   required="required"></td>
							</tr>
							<tr>
								<th>
									<span style="color: red; font-size: 0.7em;">*</span> 감독</th>
								<td colspan="2">
									<input type="text" 
										   name="movie_director"
									       id="movie_director" 
									       value="${movie.movie_director }"
										   required="required"></td>
							</tr>
							<tr>
								<th>
									<span style="color: red; font-size: 0.7em;">*</span> 출연진</th>
								<td colspan="2">
									<input type="text" 
										   name="movie_cast"
										   id="movie_cast" 
										   value="${movie.movie_cast }"
										   required="required"></td>
							</tr>
							<tr>
								<th>
									<span style="color: red; font-size: 0.7em;">*</span> 장르</th>
								<td colspan="2">
									<input type="text" 
										   name="movie_genre"
										   id="movie_genre" 
										   value="${movie.movie_genre }"
										   required="required"></td>
							</tr>
							<tr>
								<th>
									<span style="color: red; font-size: 0.7em;">*</span> 개봉일</th>
								<td colspan="2">
									<input type="text"
										   name="movie_release_date" 
										   id="movie_release_date"
										   value="${movie.movie_release_date }" 
										   required="required">
								</td>
							</tr>
							<tr>
								<th><span style="color: red; font-size: 0.7em;">*</span> 종영일</th>
								<td colspan="2">
									<input type="text" 
										   name="movie_close_date"
									       id="movie_close_date" 
									       value="${movie.movie_close_date }"
										   required="required"></td>
							</tr>
							<tr>
								<th><span style="color: red; font-size: 0.7em;">*</span> 상영시간</th>
								<td colspan="2">
									<input type="text"
										   name="movie_running_time" 
										   id="movie_running_time"
										   value="${movie.movie_running_time }" 
										   required="required">
								</td>
							</tr>
							<tr>
								<th><span style="color: red; font-size: 0.7em;">*</span> 관람객수</th>
								<td colspan="2">
									<input type="text"
										   name="movie_audience_num" 
										   id="movie_audience_num"
										   value="${movie.movie_audience_num }" 
										   required="required">
								</td>
							</tr>
							<tr>
								<th><span style="color: red; font-size: 0.7em;">*</span> 줄거리</th>
								<td colspan="2">
									<textarea rows="5" 
											  cols="50"
											  name="movie_content" 
											  id="movie_content" 
											  required="required">${movie.movie_content }</textarea>
								</td>
							</tr>
							<tr>
								<th><span style="color: red; font-size: 0.7em;">*</span> 관람등급</th>
								<td colspan="2">
									<input type="text" 
										   name="movie_grade"
										   id="movie_grade" 
										   value="${movie.movie_grade }"
										   required="required"></td>
							</tr>
							<tr>
								<th><span style="color: red; font-size: 0.7em;">*</span> 포스터이미지</th>
								<td colspan="2">
									<input type="text" 
										   name="movie_poster"
										   id="movie_poster" 
										   value="${movie.movie_poster }"
										   required="required"></td>
							</tr>
							<tr>
								<th><span style="color: red; font-size: 0.7em;">*</span> 예고영상</th>
								<td colspan="2">
									<input type="text" 
										   name="movie_preview"
										   id="movie_preview" 
										   value="${movie.movie_preview }"
										   required="required"></td>
							</tr>
							<tr>
								<th><span style="color: red; font-size: 0.7em;">*</span> 스틸컷1</th>
								<td colspan="2">
									<input type="text" 
										   name="movie_photo1"
										   id="movie_photo1" 
										   value="${movie.movie_photo1 }"
										   required="required"></td>
							</tr>
							<tr>
								<th><span style="color: red; font-size: 0.7em;">*</span> 스틸컷2</th>
								<td colspan="2">
									<input type="text" 
										   name="movie_photo2"
										   id="movie_photo2" 
										   value="${movie.movie_photo2 }"
										   required="required"></td>
							</tr>
							<tr>
								<th><span style="color: red; font-size: 0.7em;">*</span> 스틸컷3</th>
								<td colspan="2">
									<input type="text" 
										   name="movie_photo3"
										   id="movie_photo3" 
										   value="${movie.movie_photo3 }"
										   required="required"></td>
							</tr>
							<tr>
								<th>예매율</th>
								<td colspan="2">
									<input type="text"
										   name="movie_booking_rate" 
										   id="movie_booking_rate"
										   value="${movie.movie_booking_rate }"></td>
							</tr>
						</table>
					</form>
				</div>
			</div>

			<%-- 버튼 --%>
			<div class="row d-flex justify-content-center mt-3">
				<div class="col-3">
					<button class="w-100 btn btn-outline-red mb-3" 
							type="submit"
							data-toggle="modal" 
							data-target="#movieDelete">삭제</button>
				</div>
				<div class="col-3">
					<button class="w-100 btn btn-outline-red mb-3" 
							type="button"
							id="modify-button">수정</button>
				</div>
				<div class="col-3">
					<button class="w-100 btn btn-outline-red mb-3" 
							type="button"
							onclick="window.history.back();">돌아가기</button>
				</div>
			</div>
		</div>

		<%-- '영화수정' 모달 --%>
		<!-- 수정 확인 모달 창 추가 -->
		<div class="modal fade" id="modifyConfirmModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">영화 수정 확인</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">수정하시겠습니까?</div>
					<div class="modal-footer">
						<button type="button" 
								class="btn btn-secondary"	
								data-dismiss="modal">아니오</button>
						<button type="button" 
								class="btn btn-primary" 
								id="modify-confirm">예</button>
					</div>
				</div>
			</div>
		</div>

		<script>
			// 수정하기 버튼 클릭 시 모달창 표시
			$("#modify-button").click(function() {
				if (!checkRequiredFields()) {
					alert('필수 입력 항목을 작성해 주세요.');
				} else if (!checkGenre()) {
					alert("'스릴러', '로맨스코미디', '공포', 'SF', '범죄', '액션', '판타지', '음악', '멜로', '뮤지컬', '스포츠', '애니메이션', '다큐멘터리', '기타' 중 하나를 입력해 주세요");
				} else if (!checkEndDateLaterThanStartDate()) {
					alert('종영일은 개봉일보다 이후의 날짜여야 합니다.');
				} else {
					$("#modifyConfirmModal").modal("show");
				}
			});

			// 확인 모달창 '예' 버튼 클릭 시 이벤트 리스너
			$("#modify-confirm").click(function() {
				if (checkRequiredFields() && checkGenre() && checkEndDateLaterThanStartDate()) {
					$("#movieForm").submit();
				} else {
					alert('필수입력항목을 작성해 주세요.');
					// 수정 확인 모달창 꺼지지 않도록 이벤트를 막습니다.
					event.preventDefault();
					event.stopPropagation();
				}
			});

			function checkGenre() {
				const validGenres = [ '공포', 'SF', '범죄', '액션', '판타지', '음악',
						'멜로', '뮤지컬', '스포츠', '애니메이션', '다큐멘터리', '기타' ];
				let genre = $("input[name='movie_genre']").val();
				return validGenres.includes(genre);
			}

			// 필수 입력 필드 유효성 검사 함수
			function checkRequiredFields() {
				let isValid = true;
				
				$('form input[required], form textarea[required]').each(
						function() {
							if ($(this).val().trim() === '') {
								isValid = false;
							}
						});
				return isValid;
			}

			// 종영일이 개봉일보다 나중인지 확인하는 함수 추가
			function checkEndDateLaterThanStartDate() {
				let startDate = new Date($("#movie_release_date").val());
				let endDate = new Date($("#movie_close_date").val());
				return endDate > startDate;
			}
		</script>

		<%-- '영화삭제' 모달 --%>
		<div class="modal fade" id="movieDelete" tabindex="-1" role="dialog" aria-labelledby="MovieDeleteTitle" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="movieDeleteTitle">영화 삭제 확인</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">등록된 영화를 삭제 하시겠습니까?</div>
					<div class="modal-footer justify-content-center">
						<button type="button" 
								class="btn btn-secondary"
								data-dismiss="modal">아니오</button>
						<!-- 0620정의효 영화삭제-->
						<form action="admin_movieDelete" method="post">
							<input type="hidden" name="movie_num" value="${movie.movie_num}">
							<button type="submit" 
									class="btn btn-primary">&nbsp;&nbsp;&nbsp;&nbsp;예&nbsp;&nbsp;&nbsp;&nbsp;</button>
						</form>
					</div>
				</div>
			</div>
		</div>

		<%-- 본문 테이블 끝 --%>
	</article>

	<%--왼쪽 사이드바 --%>
	<nav id="mainNav" class="d-none d-md-block sidebar">
		<%@ include file="../sidebar/sideBar.jsp"%>
	</nav>


	<%--페이지 하단 --%>
	<div id="siteAds"></div>
	<footer id="pageFooter">
		<%@ include file="../inc/footer.jsp"%>
	</footer>
</body>