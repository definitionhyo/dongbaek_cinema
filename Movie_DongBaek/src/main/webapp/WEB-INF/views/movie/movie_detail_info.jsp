<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<!-- <script> -->
<!--  	function reservation_main(this.value){ -->
<!--  		location.href="reservation_main"; -->
		
<!--  	} -->
<!-- </script> -->

<title>영화 예매 사이트</title>

</head>
<body>
<%--네비게이션 바 영역 --%>
<header id="pageHeader"><%@ include file="../inc/header.jsp"%></header>
<article id="mainArticle">
<%--본문내용 --%>
	<%--top 섹션 include --%>
<div class="container">
	<%@include file="movieDetail_top.jsp" %>
	
	<%-- 2. 두번째 섹션 - 탭 --%>
	<section id="tap">
		 <div class="row">
			 <div class="col">
		  		<ul class="nav nav-tabs">
					<li class="nav-item">
				    	<a class="nav-link active" href="movie_detail_info?movie_num=${movie.movie_num }"> 주요정보 </a>
				  	</li>
				  	<li class="nav-item">
				    	<a class="nav-link" href="movie_detail_review?movie_num=${movie.movie_num }"> 리뷰</a>
				  	</li>
				  	<li class="nav-item">
				    	<a class="nav-link" href="movie_detail_photo?movie_num=${movie.movie_num }"  style="width:150px"> 예고편 / 스틸컷</a>
				  	</li>
				</ul>
			</div>
		</div>
	</section>
		  	
	<%-- 2-1. 탭 컨텐츠 --%>	  	
	<section id="movie-end">
		<div class="p-3">
				<div><b>감독  </b> ${movie.movie_director} </div>
			  	<div><b>장르 </b>${movie.movie_genre }</div>
			  	<div><b>러닝타임 </b>${movie.movie_running_time }</div>
			  	<div><b>관람등급 </b>${movie.movie_grade }</div>
			  	<div><b>개봉일 </b>${movie.movie_release_date }</div>
		  	<hr>
		 		<div class="row" id="cast">
		  			<b>출연진 &nbsp; </b> ${movie.movie_cast }
		  	</div>
		  	<hr>
		  	<div class="row" id="content">
		  		<b> 시놉시스 &nbsp;</b> ${movie.movie_content }
		  	</div>
		 </div>
	</section>		
	
</div> <%-- 컨테이너 끝 --%>  
</article>
  
  
  <nav id="mainNav" class="d-none d-md-block sidebar">
  <%--왼쪽 사이드바 --%>
  </nav>
  <div id="siteAds"></div>
  <%--페이지 하단 --%>
  <footer id="pageFooter"><%@ include file="../inc/footer.jsp"%></footer>
</body>
