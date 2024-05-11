<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<script>
 $(function() {
	 // 찜하기에 사용
	 let sId = $("#sessionId").val();
	 let member_type = $("#member_type").val();
	 
	$(".custom-select").on("change", function(){
	
		//셀렉트박스 옵션 선택텍스트(예매순/가나다순) 저장
		let value = $(".custom-select option:selected").val();
		let url = '';
	
		
		if(value == 2){ //가나다순 선택시
			url = "movie_list_present2?pageNum=${param.pageNum }";
		} else { //예매순으로 다시 선택시
			url = "movie_list_return?pageNum=${param.pageNum }";
		}
				
		
			$.ajax({
				type : "get",
				url : url,
				dataType : "json", 
			})
			.done(function(movie) {
// 				alert("요청성공");
					let res = "";
					
					for(let i = 0; i < movie.length; i++) {
						let movieGrade = "";
						if(movie[i].movie_grade == '전체관람가'){
							movieGrade = "all";
						}
						if(movie[i].movie_grade == '12세이상관람가'){
							movieGrade = "12";
						}
						if(movie[i].movie_grade == '15세이상관람가'){
							movieGrade = "15";
						}
						if(movie[i].movie_grade == '청소년관람불가'){
							movieGrade = "18";
						}
						
				   
						let releaseDate = new Date(movie[i].movie_release_date);
				        let formattedDate = releaseDate.getFullYear() + "-" + ("0" + (releaseDate.getMonth() + 1)).slice(-2) + "-" + ("0" + releaseDate.getDate()).slice(-2);
						
				        let button = "";
						// 찜하기 --------------------
						if(sId != "" && member_type != '비회원') {
						    	button = "<button type='button' class='btn btn-outline-danger mr-2' id='likeMovie" + i + "' data-target='" + movie[i].movie_num + "' value='" + i + "' onclick='checkMovie(this, " + i + ")'>♡찜하기</button>"
						    	+ "<input type='hidden' id='clickCk" + i + "'>"
						} else {
								button = "<button type='button' class='btn btn-outline-danger' id='likeMovieNo" + i + "' data-toggle='modal' data-target='#needLogin'>♡찜하기</button>"
						}
						console.log(button);
						// -------------------------------
				
						res += "<div class='col-lg-3 col-mid-4'>" +
						"<div class='card border-0 shadow-sm' style='width: 18rem;'>" +
						  "<a href='movie_detail_info?movie_num=" + movie[i].movie_num + "'>" +
						  	"<img src='" + movie[i].movie_poster + "' class='card-img-top' alt='...'>" +
						  "</a>" +
							"<div class='card-body'>" +
								"<h6 class='card-title' style='white-space: nowrap; overflow:hidden; text-overflow: elipsis;'>" +
									"<img src='${pageContext.request.contextPath }/resources/img/grade_" + movieGrade +".png' alt='" + movieGrade +"' class='img-rounded'>" +
									"<b>" + movie[i].movie_name_kr + "</b>" + "</h6>" +
								"<p class='card-text'>예매율: " + movie[i].movie_booking_rate + "% 개봉일: " + formattedDate  + "</p>" +
								"<p class='d-flex justify-content-center'>" + 
									// 찜하기 버튼 변수
									button
							    	+ "<a href='reservation_main?movie_num=" +  movie[i].movie_num + "' class='btn btn-danger'>&nbsp;&nbsp;예매&nbsp;&nbsp;</a>" +
						    	"</p>" +
							"</div>" +
						"</div>" +
					"</div>"
					}
					
					$("#moviearea").html(res);
					
					// (정렬변경 후) 찜한 데이터 들고와서 표시하기
					$.ajax ({
						type: 'GET',
						url: 'likeMovieShow',
						data: {'member_id' : sId},
						dataType: 'JSON',
						success: function(result) {
//						console.log(result);
							
							for(let i = 1; i <= 8; i++) {
								let movieNo = $("#likeMovie" + i).data("target");	// movie_num
//			 					console.log(movieNo);
								
								for(let like of result) {
									if(like.movie_num == movieNo) {	// 일치하면
//										console.log(i);
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
					
			})
			.fail(function() { // 요청 실패 시
				alert("요청 실패!");
			});
 	});

 });
 
	//찜하기 받아오기
	$(function() {
		let sId = $("#sessionId").val();
//		console.log(sId);
		$.ajax ({
			type: 'GET',
			url: 'likeMovieShow',
			data: {'member_id' : sId},
			dataType: 'JSON',
			success: function(result) {
//			console.log(result);
				
				for(let i = 1; i <= 8; i++) {
					let movieNo = $("#likeMovie" + i).data("target");	// movie_num
// 					console.log(movieNo);
					
					for(let like of result) {
						if(like.movie_num == movieNo) {	// 일치하면
//							console.log(i);
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
//		console.log($(element).val());
		let movie_num = $(element).data('target');
		let targetId = 'clickCk' + i;
//		console.log(targetId);	// 타겟아이디
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
<title>영화 예매 사이트</title>
<%--페이징css --%>
<style>
	#pageList{
	  align-content: center;
	  font-size: large; 
	  margin: auto;
	  margin-bottom:50px;
/* 	  width: 1024px; */
	  text-align: center;
	}
	#nowPage{
		color:#dc3545;
		size: 20px;
		margin: auto;
/* 		width: 1024px; */
		text-align: right;
	}
	#anotherPage{
		color:graytext;
		margin: auto;
/* 		width: 1024px; */
		text-align: right;
	}
	
	/* 찜하기 관련 */
	#needLogin, #needLogin>div {
		background-color: #ffffff00;
	}
	
</style>
</head>
<body>
 <%--네비게이션 바 영역 --%>
 <header id="pageHeader"><%@ include file="../inc/header.jsp"%></header>
 
<%-- pageNum 파라미터 가져와서 저장(없을 경우 기본값 1로 설정) --%>
<c:set var="pageNum" value="1" />
<c:if test="${not empty param.pageNum }">
	<c:set var="pageNum" value="${param.pageNum }" />
</c:if>
 
 <%-- 찜하기 기능 - 세션아이디로 조회 --%>
 <input type="hidden" name="member_id" value="${sessionScope.member_id }" id ="sessionId">
 <input type="hidden" name="member_type" value="${sessionScope.member_type }" id ="member_type">
 
  <article id="mainArticle">
  <%--본문내용 --%>
	<%-- 상영작 구분 --%>
	<div class="container">
		<ul class="nav nav-tabs" style="margin-top: 20px; margin-bottom: 20px">
		  <li class="nav-item">
		    <a class="nav-link active" aria-current="page" href="movie_list_present">현재상영작</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="movie_list_prepare">상영예정작</a>
		  </li>
		</ul>
			
	<%-- 정렬 기준 --%>
	<div class="row"  align="left" style="margin-bottom: 20px">
		<div class="col col-md-10"></div>
		<div class="col col-md-2 d-flex justify-content-end">
		  <select class="custom-select"  name="movie_array">
		    <option value="1" selected>예매순</option>
		    <option value="2">평점순</option>
		  </select>
		</div>
	</div>

	
	<%-- 영화정보 --%>
	<%-- 한 열당 영화4개출력 => 한 페이지 당 2열 => 총 8개영화출력--%>
	<!-- 	<div class="m-3"> -->
		 <%-- 1열 --%>
		 
		<div class="row"  id="moviearea" align="left">
		
		<c:forEach var="movie" items="${movieList}" varStatus="i">
				<div class="col-lg-3 col-mid-4">
					<div class="card border-0 shadow-sm" style="width: 18rem;">
					  <a href="movie_detail_info?movie_num=${movie.movie_num}">
					  	<img src="${movie.movie_poster}" class="card-img-top" alt="...">
					  </a><%-- 해당영화의 포스터출력 --%>
						<div class="card-body">
							<h6 class="card-title" style="white-space: nowrap; overflow:hidden; text-overflow: elipsis;">
							<%-- 해당영화의 등급에 해당하는 이미지 출력 --%>
							<c:if test="${movie.movie_grade eq '전체관람가'}">
								<img src="${pageContext.request.contextPath }/resources/img/grade_all.png" alt="전체" class="img-rounded" >
							</c:if>
							<c:if test="${movie.movie_grade eq '12세이상관람가'}">
								<img src="${pageContext.request.contextPath }/resources/img/grade_12.png" alt="12" class="img-rounded" >
							</c:if>
							<c:if test="${movie.movie_grade eq '15세이상관람가'}">
								<img src="${pageContext.request.contextPath }/resources/img/grade_15.png" alt="15" class="img-rounded" >
							</c:if>
							<c:if test="${movie.movie_grade eq '청소년관람불가'}">
								<img src="${pageContext.request.contextPath }/resources/img/grade_18.png" alt="18" class="img-rounded" >
							</c:if>
							
							<b>${movie.movie_name_kr}</b></h6>
							<p class="card-text">예매율:${movie.movie_booking_rate}% 개봉일: ${movie.movie_release_date}</p>
							<p class="d-flex justify-content-center">
								<c:choose>
									<c:when test="${not empty sessionScope.member_id && member_type ne '비회원'}">
								    	<button type="button" class="btn btn-outline-danger mr-2" id="likeMovie${i.count }" data-target="${movie.movie_num }" value="${i.count }" onclick="checkMovie(this, ${i.count })">♡찜하기</button>
								    	<input type="hidden" id="clickCk${i.count }">
								    </c:when>
									<c:otherwise>
										<%-- 찜하기 버튼과 버튼 클릭 시 상태 변경용 히든 타입 태그 --%>
										<button type="button" class="btn btn-outline-danger" id="likeMovieNo${i.index }" data-toggle="modal" data-target="#needLogin">♡찜하기</button>
									</c:otherwise>
								</c:choose>
						    	<a href="reservation_main?movie_num=${movie.movie_num}" class="btn btn-danger">&nbsp;&nbsp;예매&nbsp;&nbsp;</a>
					    	</p>
						</div>
					</div>
				</div>
		</c:forEach>
		</div>
		<br>
	</div> <%--class="container" 끝 --%>
	<%--저장저장 --%>
	
	<%-- 페이징처리 ========================================== --%>
	<section id="pageList">
		<%-- 1. 현재페이지>1 =>[이전]버튼 동작 => 버튼클릭시 : BoardList서블릿요청(파라미터:현재pg-1) --%>
		<c:choose>
			<c:when test="${pageNum > 1 }">
				<input type="button" class="btn-sm btn-outline-danger mr-2" value="이전" onclick="location.href='movie_list_present?pageNum=${pageNum - 1}'">
			</c:when>
			<c:otherwise>
				<input type="button" class="btn-sm btn-outline-danger mr-2" value="이전" disabled="disabled">
			</c:otherwise>
		</c:choose>
		<%--간소화 할시 --%>
		<%-- 	<input type="button" value="이전" <c:if test="${pageNum > 1 }"> onclick="location.href='BoardList.bo?pageNum=${pageNum - 1}'"</c:if>> --%>
	
	
		<%-- 2. 페이지번호 목록은 시작페이지(startPage) 부터 끝페이지(endPage) 까지 표시 --%>
		<c:forEach var="i" begin="${pageInfo.startPage }" end="${pageInfo.endPage }">
			<%-- 각 페이지마다 하이퍼링크 설정(단, 현재 페이지는 하이퍼링크 제거) --%>
			<c:choose>
				<c:when test="${pageNum eq i }">
					<b id="nowPage">${i }</b> <%--페이지번호=현재페이지번호 -> 글자만표시  --%>
				</c:when>
				<c:otherwise>
					<a href="movie_list_present?pageNum=${i }" id="anotherPage">${i }</a><%--하이퍼링크활성화 --%>
				</c:otherwise>
			</c:choose>
		</c:forEach>	
	
		<%-- 3. 현재페이지<maxPage =>[다음]버튼 동작 => 버튼클릭시 : BoardList서블릿요청(파라미터:현재pg+1) --%>
		<c:choose>
			<c:when test="${pageNum < pageInfo.maxPage }">
				<input type="button" value="다음" class="btn-sm btn-outline-danger mr-2" onclick="location.href='movie_list_present?pageNum=${pageNum + 1}'">
			</c:when>
			<c:otherwise>
				<input type="button" value="다음" class="btn-sm btn-outline-danger mr-2" disabled="disabled">
			</c:otherwise>
		</c:choose>
	</section>
	<%--페이징처리 끝 ==========================================--%>
	
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
	
	
		
	<!-- JavaScript Bundle with Popper -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
  </article>
  
  <nav id="mainNav" class="d-none d-md-block sidebar">
  <%--왼쪽 사이드바 --%>
  </nav>
  
  <div id="siteAds"></div>
  <%--페이지 하단 --%>
  <footer id="pageFooter"><%@ include file="../inc/footer.jsp"%></footer>
</body>