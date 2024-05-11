<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/myPage.css" rel="stylesheet" type="text/css">
<title>영화 예매 사이트</title>
<style>

<%-- a링크 활성화 색상 변경 --%>
a:hover, a:active{
 color:  #ff5050 !important;
	
}
</style>
</head>
<body>
 <%--네비게이션 바 영역 --%>
 <header id="pageHeader"><%@ include file="../inc/header.jsp"%></header>
 
  <article id="mainArticle">
  <%--본문내용 --%> 
   <div class="container">
  	<div class="mainTop">
	 <div class="row">
	  	<div class="col-4"> <span class="admin_movie_name">영화제목</span> <%--css로 색이랑형태 --%></div>
	  	<div class="col-8"><input type="text" placeholder="영화제목을 입력해주세요"></div>
     </div>
	 <div class="row">
	  	<div class="col-4"> <span class="admin_movie_director">감독명</span> <%--css로 색이랑형태 --%></div>
	  	<div class="col-8"><input type="text" placeholder="감독명 입력해줘"></div>
     </div>
	 <div class="row">
	  	<div class="col-4"><span class="admin_movie_genre">장르</span></div>
	  	<div class="col-8">
			 <select>
			 	<option value="none">선택해주세요</option>
			 	<option value="action">액션</option>
			 	<option value="crime">범죄</option>
			 	<option value="scienceFiction">SF</option>
			 	<option value="comedy">코미디</option>
			 	<option value="romance">로맨스</option>
			 </select>
	  	</div>
     </div>
	 <div class="row">
	  	<div class="col-4"><span class="admin_movie_runningtime">러닝타임</span></div>
	  	<div class="col-8"><input type="time"> 제이쿼리로 오전오후->24시간변경예정 <%--제이쿼리로 오전오후 없애고 24시간으로 변경하기 --%></div>
     </div>
	 <div class="row">
	  	<div class="col-4"><span class="admin_movie_grade">등급</span></div>
	  	<div class="col-8">
	 	 	<select name="movie_grade">
	 	 		<option value="none">선택해주세요</option>
	 	 		<option value="all">전체관람가</option>
	 	 		<option value="12">12세이상관람가</option>
	 	 		<option value="15">15세이상관람가</option>
	 	 		<option value="notTeenager">청소년관람불가</option>
	 	 		<option value="limit">제한상영가</option>
	 	 	</select>
	  	</div>
     </div>
	 <div class="row">
	  	<div class="col-4"><span class="admin_movie_opening-date">개봉일</span></div>
	  	<div class="col-8"><input type="date"></div>
     </div>
	 <div class="row">
	  	<div class="col-4"><span class="admin_movie_end-date">종영일</span></div>
	  	<div class="col-8"><input type="date"></div>
     </div>
	 <div class="row">
	  	<div class="col-4"><span class="admin_movie_casts">출연진</span></div>
	  	<div class="col-8"><input type="text" placeholder="전우치,홍길동,빠빠빠"></div>
     </div>
	 <div class="row">
	  	<div class="col-4"><span class="admin_movie_poster">포스터</span></div>
	  	<div class="col-8"><input type="file"></div>
     </div>
	 <div class="row">
	  	<div class="col-4"><span class="admin_movie_summary">줄거리</span></div>
	  	<div class="col-8"><textarea rows="5" cols="50" placeholder="줄거리를 입력해주세요"></textarea></div>
     </div>
 	 <input class="btn btn-danger" id="bottom-right" type="submit" value="등록하기"> 
  	 </div>
  </div>
  
  </article>
  
  <nav id="mainNav" class="d-none d-md-block sidebar">
  <%--왼쪽 사이드바 --%>
<!-- 	<div class="d-flex justify-content-center"> -->
<!-- 	  <div class="col-10"> -->
<!-- 	    <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical"> -->
<!-- 	      <a class="nav-link active" id="v-pills-member-management-tab" data-toggle="pill" href="#v-pills-home" role="tab" aria-controls="v-pills-home" aria-selected="true">회원관리</a> -->
<!-- 	      <a class="nav-link" id="v-pills-movie-management-tab" data-toggle="pill" href="#v-pills-profile" role="tab" aria-controls="v-pills-profile" aria-selected="false">영화관리</a> -->
<!-- 	      <a class="nav-link" id="v-pills-schedule-tab" data-toggle="pill" href="#v-pills-messages" role="tab" aria-controls="v-pills-messages" aria-selected="false">상영스케쥴 관리</a> -->
<!-- 	      <a class="nav-link" id="v-pills-payments-tab" data-toggle="pill" href="#v-pills-settings" role="tab" aria-controls="v-pills-settings" aria-selected="false">결제관리</a> -->
<!-- 	      <a class="nav-link" id="v-pills-notice-tab" data-toggle="pill" href="#v-pills-settings" role="tab" aria-controls="v-pills-settings" aria-selected="false">공지사항 관리</a> -->
<!-- 	      <a class="nav-link" id="v-pills-csPQ-tab" data-toggle="pill" href="#v-pills-settings" role="tab" aria-controls="v-pills-settings" aria-selected="false">1:1 질문 관리</a> -->
<!-- 	      <a class="nav-link" id="v-pills-faq-tab" data-toggle="pill" href="#v-pills-settings" role="tab" aria-controls="v-pills-settings" aria-selected="false">자주 묻는 질문 관리</a> -->
<!--    		 </div> -->
<!-- 	  </div> -->
<!-- 	</div> -->
  	<%@ include file="/WEB-INF/views/sidebar/sideBar.jsp"%>
  </nav>
  
  <div id="siteAds"></div>
  <%--페이지 하단 --%>
  <footer id="pageFooter"><%@ include file="../inc/footer.jsp"%></footer>
</body>