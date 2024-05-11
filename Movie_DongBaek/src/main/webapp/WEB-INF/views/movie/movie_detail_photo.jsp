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
<title>영화 예매 사이트</title>
<style>
	div{background-color: transparent;}
</style>
</head>
<body>
 <%--네비게이션 바 영역 --%>
<header id="pageHeader"><%@ include file="../inc/header.jsp"%></header>
<article id="mainArticle">
<%--본문내용 --%>
<%-- 첫번째 섹션 --%>
<div class="container">
	<%--top 섹션 include --%>
	<%@include file="movieDetail_top.jsp" %>
	
	<%-- 2. 두번째 섹션 - 탭 --%>
	<section id="tap">
		 <div class="row">
			 <div class="col">
		  		<ul class="nav nav-tabs">
					<li class="nav-item">
				    	<a class="nav-link" href="movie_detail_info?movie_num=${movie.movie_num }"> 주요정보 </a>
				  	</li>
				  	<li class="nav-item">
				    	<a class="nav-link" href="movie_detail_review?movie_num=${movie.movie_num }">리뷰 </a>
				  	</li>
				  	<li class="nav-item">
				    	<a class="nav-link active" href="movie_detail_photo?movie_num=${movie.movie_num }"  style="width:150px"> 예고편 / 스틸컷</a>
				  	</li>
				</ul>
			</div>
		</div>
	</section>
	
	<%-- 세번째 섹션 --%>
	<section id="movie-end">
		<div class="container p-3" style="padding:50px; margin: 50px;">
	  	  
			
			<%-- 프리뷰 영상 --%>
			<div class="row" >
	  	  		<div class="col">
	  	  			<iframe src="${movie.movie_preview }"  width="900" height="600" ></iframe>
	  	  		</div>
	  	  	</div>
	  	  	
	  	  	<%-- 스틸컷 --%>
	  	  	<div class="row row-md-12" style= margin-top:30px;>
	  	  		<div class="col col-md-3">
			  	  	<img src="${movie.movie_photo1 }" alt="..." class="img-thumbnail" onclick="window.open('${movie.movie_photo1 }' ,'pop01','width=900 height=600');">
	  	  		</div>
	  	  		<div class="col col-md-3">
			  	  	<img src="${movie.movie_photo2 }" alt="..." class="img-thumbnail" onclick="window.open('${movie.movie_photo2 }' ,'pop01','width=900 height=600');">
	  	  		</div>
	  	  		<div class="col col-md-3">
			  	  	<img src="${movie.movie_photo3 }" alt="..." class="img-thumbnail" onclick="window.open('${movie.movie_photo3 }' ,'pop01','width=900 height=600');">
	  	  		</div>
	  	  	</div>	  	  	
		</div>
	</section>
	<%-- 세번째 섹션 끝--%>
		
			
  </div> <%-- 컨테이너 끝 --%>
  </article>
  
  <nav id="mainNav" class="d-none d-md-block sidebar">
  <%--왼쪽 사이드바 --%>
  </nav>
  <div id="siteAds"></div>
  <%--페이지 하단 --%>
  <footer id="pageFooter"><%@ include file="../inc/footer.jsp"%></footer>
</body>
