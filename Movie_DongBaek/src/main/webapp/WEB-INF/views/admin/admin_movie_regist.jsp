<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"
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
<title>영화 등록페이지</title>
<style>
/* a링크 활성화 색상 변경 */
a:hover, a:active {
	color: #ff5050 !important;
}

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
					<h3>영화 등록하기 <span style="color: red; font-size: 0.5em;">*</span><span	style="font-size: 0.5em;">는 필수 입력 항목입니다!</span></h3>
				</div>
			</div>

			<%-- 상세보기 테이블 --%>
			<div class="row">
				<div class="col-md-12">
					<form action="admin_movie_regist_Pro" method="post">
						<table class="table table-bordered text-center">
							<tr>
								<th>
									<span style="color: red; font-size: 0.7em;">*</span> 영화제목(kr)</th>
								<td>
									<input type="text" 
										   placeholder="영화제목(kr)을 입력해주세요"
										   id="movie_name_kr" 
										   name="movie_name_kr" 
										   required="required"></td>
								<!-- 제목등 비롯하여 빈칸이 나오는 경우는 api에 값이 없는 경우이므로 직접 작성해야함 -->
							</tr>
							<tr>
								<th>
									<span style="color: red; font-size: 0.7em;">*</span> 영화제목(en)</th>
								<td>
									<input type="text" 
										   placeholder="영화제목(en)을 입력해주세요"
										   id="movie_name_en"
										   name="movie_name_en" 
										   required="required"></td>
								<!-- 제목등 비롯하여 빈칸이 나오는 경우는 api에 값이 없는 경우이므로 직접 작성해야함 -->
							</tr>
							<tr>
								<th>
									<span style="color: red; font-size: 0.7em;">*</span> 감독명</th>
								<td>
									<input type="text" 
										   placeholder="감독명 입력해줘"
										   id="movie_director" 
										   name="movie_director" 
										   required="required"></td>
							</tr>
							<tr>
								<th>
									<span style="color: red; font-size: 0.7em;">*</span> 대표장르</th>
								<td>
									<input type="text" 
										   placeholder="대표 장르" 
										   id="movie_genre"
										   name="movie_genre" 
										   required="required"></td>
							</tr>
							<tr>
								<th>
									<span style="color: red; font-size: 0.7em;">*</span> 러닝타임</th>
								<td>
									<input type="text" 
										   placeholder="러닝 타임"
										   id="movie_running_time" 
										   name="movie_running_time"
										   required="required"></td>
							</tr>
							<tr>
								<th>
									<span style="color: red; font-size: 0.7em;">*</span> 심의등급</th>
								<td>
									<input type="text" 
										   placeholder="심의등급" 
										   id="movie_grade"
										   name="movie_grade" 
										   required="required"></td>
							</tr>
							<tr>
								<th>
									<span style="color: red; font-size: 0.7em;">*</span> 출연진</th>
								<td>
									<input type="text" 
										   placeholder="출연진" 
										   id="movie_cast"
										   name="movie_cast" 
										   required="required"></td>
							</tr>
							<tr>
								<th>
									<span style="color: red; font-size: 0.7em;">*</span> 개봉일</th>
								<td>
									<input type="text" 
										   placeholder="개봉일(YYYY-MM-DD)"
										   id="movie_release_date" 
										   name="movie_release_date"
										   required="required"></td>
							</tr>
							<tr>
								<th>
									<span style="color: red; font-size: 0.7em;">*</span> 종영일</th>
								<td>
									<input type="text" 
										   placeholder="종영일(YYYY-MM-DD)"
										   id="movie_close_date" 
										   name="movie_close_date"
										   required="required"></td>
								<!-- 개봉일과 같이 YYYYMMDD -> DATE? 로 변환후 DB에저장되게 / 관리자가 직접 입력해야됨 api 없음 -->
							</tr>
							<tr>
								<th>
									<span style="color: red; font-size: 0.7em;">*</span> 관람객수</th>
								<td>
									<input type="text" 
										   value="0" 
										   id="movie_audience_num"
										   name="movie_audience_num" 
										   required="required"></td>
								<!-- 영화 등록이니 처음 관람객수 : 0  -->
							</tr>
							<tr>
								<th>
									<span style="color: red; font-size: 0.7em;">*</span> 포스터</th>
								<td>
									<input type="text"
										   placeholder="주소를 입력해주세요(http://xxxx.xxx)" 
										   id="movie_poster"
										   name="movie_poster" 
										   required="required"></td>
								<!-- 이미지 주소 링크 가져오므로=text인듯 / 관리자가 직접 입력해야됨 api 없음 -->
							</tr>
							<tr>
								<th>
									<span style="color: red; font-size: 0.7em;">*</span> 예고영상</th>
								<td>
									<input type="text"
										   placeholder="주소를 입력해주세요(http://xxxx.xxx)" 
										   id="movie_preview"
										   name="movie_preview" 
										   required="required"></td>
								<!-- 예고편 영화 주소 링크 가져오므로=text인듯 / 관리자가 직접 입력해야됨 api 없음 -->
							</tr>
							<tr>
								<th>
									<span style="color: red; font-size: 0.7em;">*</span> 스틸컷1</th>
								<td>
									<input type="text"
										   placeholder="주소를 입력해주세요(http://xxxx.xxx)" 
										   id="movie_photo1"
										   name="movie_photo1" 
										   required="required"></td>
								<!-- 이미지 주소 링크 가져오므로=text인듯 / 관리자가 직접 입력해야됨 api 없음 -->
							</tr>
							<tr>
								<th>
									<span style="color: red; font-size: 0.7em;">*</span> 스틸컷2</th>
								<td>
									<input type="text"
										   placeholder="주소를 입력해주세요(http://xxxx.xxx)" 
										   id="movie_photo2"
										   name="movie_photo2" 
										   required="required"></td>
								<!-- 이미지 주소 링크 가져오므로=text인듯 / 관리자가 직접 입력해야됨 api 없음 -->
							</tr>
							<tr>
								<th>
									<span style="color: red; font-size: 0.7em;">*</span> 스틸컷3</th>
								<td>
									<input type="text"
										   placeholder="주소를 입력해주세요(http://xxxx.xxx)" 
										   id="movie_photo3"
										   name="movie_photo3" 
										   required="required"></td>
								<!-- 이미지 주소 링크 가져오므로=text인듯 / 관리자가 직접 입력해야됨 api 없음 -->
							</tr>
							<tr>
								<th>
									<span style="color: red; font-size: 0.7em;">*</span> 줄거리</th>
								<td>
									<textarea rows="5" cols="50" 
											  placeholder="줄거리를 입력해주세요"
										 	  id="movie_content" 
										 	  name="movie_content" 
										 	  required="required"></textarea></td>
								<!-- 관리자가 직접 입력해야됨 api 없음 -->
							</tr>
							<tr>
								<th>검색할 영화 제목</th>
								<td>
									<input type="text" 
										   id="searchMovieNm"
										   placeholder="ex:범죄"></td>
							</tr>
							<tr>
								<th>조회 연도</th>
								<td>
									<input type="text" 
										   id="prdtStartYear"
										   placeholder="ex:2022 조회시작 제작연도"> 
									<input type="text"
										   id="prdtEndYear" 
										   placeholder="ex:2023 조회종료 제작연도">
							    </td>
							</tr>
							<tr>
								<td colspan="2">
									<button type="button" 
											class="btn btn-danger" 
											id="submit-button">등록하기</button>
									<!-- 모달창으로 확인 -->
									<button type="button" 
											class="btn btn-primary"
											data-toggle="modal" 
											data-target="#takeMovieAPI"
											id="getMovieApi">가져오기</button>
									<button type="button"
											class="btn btn-danger"
											onclick="window.history.back();">돌아가기</button>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>

		<!-- 등록확인 모달 창 추가 -->
		<div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">영화 등록 확인</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">등록하시겠습니까?</div>
					<div class="modal-footer">
						<button type="button" 
								class="btn btn-secondary"
								data-dismiss="modal">아니오</button>
						<button type="button" 
								class="btn btn-primary" 
								id="confirm-submit">예</button>
					</div>
				</div>
			</div>
		</div>

		<script>
			// 등록하기 버튼 클릭 시 모달창 표시
			$("#submit-button").click(function() {
				let isValid = checkRequiredFields();

				if (isValid && checkGenre()
						&& checkEndDateLaterThanStartDate()) {
					$("#confirmModal").modal("show");
				} else {
					if (!checkGenre()) {
						alert("'스릴러', '로맨스코미디', '공포', 'SF', '범죄', '액션', '판타지', '음악', '멜로', '뮤지컬', '스포츠', '애니메이션', '다큐멘터리', '기타' 중 하나를 입력해 주세요");
					} else if (!checkEndDateLaterThanStartDate()) {
						alert('종영일은 개봉일보다 이후의 날짜여야 합니다.');
					} else {
						alert('필수 입력 항목을 작성해 주세요.');
					}
				}
			});

			// 예 버튼 클릭 시 폼 제출
			$("#confirm-submit").click(function () {
		    	if (checkRequiredFields() && checkGenre()) {
			        var movieNameKr = $("#movie_name_kr").val();
			        $.ajax({
			            url: "checkMovie",
			            data: {
			                movie_name_kr: movieNameKr,
			            },
			            success: function (response) {
			                if (response.trim() === "true") {
			                    alert("이미 등록된 영화입니다.");
			                    $("#confirmModal").modal("hide"); // 모달 창 닫기 추가
			                } else {
			                    $("form").submit();
			                }
			            },
			            error: function (xhr, status, error) {
			                console.log("AJAX 요청 실패:", error);
			            },
			        });
			     }
			 });
			// 장르 유효성 검사
			function checkGenre() {
				const validGenres = [ '공포', 'SF', '범죄', '액션', '판타지', '음악',
						'멜로', '뮤지컬', '스포츠', '애니메이션', '다큐멘터리', '기타' ];
				let genre = $("#movie_genre").val();
				return validGenres.includes(genre);
			}

			//필수 입력 필드 유효성 검사 함수
			function checkRequiredFields() {
				let isValid = true;

				$('form input[required], form textarea[required]').each(function() {
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

		<!-- ------------------------- api가져오기 2개 -------------------------- -->
		<script>
			$(document).ready(function() {
				$("#getMovieApi").click(
					function() {
						var prdtStartYear = $("#prdtStartYear").val();
						var prdtEndYear = $("#prdtEndYear").val();
						var searchMovieNm = $("#searchMovieNm").val();

						$.ajax({
								method : "GET",
								url : "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json",
								data : {
									key : "2821636f951fa3b797d2cf5b22946850",
									prdtStartYear : prdtStartYear,
									prdtEndYear : prdtEndYear,
									movieNm : searchMovieNm,
									itemPerPage : "20"
								},
								success : function(response) {
									console.log(response)
									var movieList = response.movieListResult.movieList;
									var selectOptions = "";

									for (var i = 0; i < movieList.length; i++) {
										var movieNm = movieList[i].movieNm;
										var movieNmEn = movieList[i].movieNmEn;
										var directors = movieList[i].directors;
										var repGenreNm = movieList[i].repGenreNm;
										var movieCd = movieList[i].movieCd;

										selectOptions += "<option value='"
												+ movieCd
												+ "' data-directors='"
												+ JSON.stringify(directors)
												+ "' data-genre='"
												+ repGenreNm
												+ "' data-movieNmEn='"
												+ movieNmEn
												+ "'>"
												+ movieNm
												+ "</option>";
									}

									$("#takeMovieAPI .modal-body select").html(selectOptions);
									$("#takeMovieAPI").modal("show");
								},
								error : function(xhr, status, error) {
									console.log("AJAX 요청 실패:",	error);
								}
						 });
					});

				$("#takeMovieAPI .modal-footer .btn-primary").click(function() {
					var selectedMovieCd = $("#takeMovieAPI .modal-body select").val();
					var directors = JSON.parse($("#takeMovieAPI .modal-body select option:selected").attr('data-directors'));
					var repGenreNm = $("#takeMovieAPI .modal-body select option:selected").attr('data-genre');
					var movieNmEn = $("#takeMovieAPI .modal-body select option:selected").attr('data-movieNmEn'); // 추가: 영화 제목(en) 가져오기

					if (selectedMovieCd) {
						var directorNames = directors.map(function(director) {
											return director.peopleNm;
										}).join(", ");

						// 영화 정보를 가져오기 위해 새로운 API 요청
						$.ajax({
								method : "GET",
								url : "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json",
								data : {
									key : "2821636f951fa3b797d2cf5b22946850",
									movieCd : selectedMovieCd
								},
								success : function(response) {
									var movieInfo = response.movieInfoResult.movieInfo;

									var showTm = movieInfo.showTm;
									var watchGradeNm = "";
									var peopleNm = "";
									var openDt = "";

									if (movieInfo.audits && movieInfo.audits.length > 0) {
										watchGradeNm = movieInfo.audits[0].watchGradeNm;
									}
									if (movieInfo.actors && movieInfo.actors.length > 0) {
										peopleNm = movieInfo.actors.map(function(actor) {
															return actor.peopleNm;
														}).join(", ");
									}

									var openDt = movieInfo.openDt;
									if (openDt) {
										// YYYYMMDD 형식을 YYYY-MM-DD 형식으로 변환
										var formattedOpenDt = openDt.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
										openDt = formattedOpenDt; // 수정된 부분
									}

									$("#movie_running_time").val(showTm);
									$("#movie_grade").val(watchGradeNm);
									$("#movie_cast").val(peopleNm);
									$("#movie_release_date").val(openDt);

									// 수정: 영화 제목(en) 입력 필드에 값 설정
									$("#movie_name_en").val(movieNmEn);

									$("#movie_name_kr").val($("#takeMovieAPI .modal-body select option:selected").text().trim());
									$("#movie_director").val(directorNames);
									$("#movie_genre").val(repGenreNm);
								},
								error : function(xhr, status, error) {
									console.log("AJAX 요청 실패:",	error);
								}
							});
					}

					$("#takeMovieAPI").modal("hide");
				});
			});
		</script>

		<!-- 영화 정보를 표시할 모달 -->
		<div class="modal fade" id="takeMovieAPI" tabindex="-1" role="dialog" aria-labelledby="takeMovieTitle" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="takeMovieTitle">영화정보 가져오기(API)</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<!-- 영화 정보가 동적으로 추가될 영역 -->
						<select class="form-select">
						</select>
					</div>
					<div class="modal-footer">
						<button type="button" 
								class="btn btn-secondary"
								data-dismiss="modal">아니오</button>
						<button type="button" 
								class="btn btn-primary">&nbsp;&nbsp;&nbsp;&nbsp;예&nbsp;&nbsp;&nbsp;&nbsp;</button>
					</div>
				</div>
			</div>
		</div>
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