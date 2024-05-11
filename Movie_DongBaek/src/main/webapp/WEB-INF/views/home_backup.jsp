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
.w-1200 {
	width: 1200px;
}
.subject_now {
	color: #ef4f4f;
	font-size: 18px;
 	text-decoration: overline;
	margin: auto;
}
a:link,a:visited { color:gray; }
</style>
</head>
<body>
 <%--네비게이션 바 영역 --%>
 <header id="pageHeader"><%@ include file="inc/header.jsp"%></header>
  	<article id="mainArticle">
  	<%--본문내용 --%>
	<div class="container-fluid w-1200">
	  <br>
 	
 	<%-- 현재상영작 --%>
 	 <div class="d-flex justify-content-center" >
				<!-- 	 <ul class="nav nav-pills mb-3 text-dark" id="pills-tab" role="tablist"  > -->
				<!-- 		<li class="nav-item bg-white " > -->
				<!-- 			<a class="nav-link active" id="pills-home-tab" data-toggle="pill" href="#pills-home" role="tab" aria-controls="pills-home" aria-selected="true"> -->
		<b class="subject_now">현재상영작</b>
		<!-- 			</a> -->
		<!-- 		</li> -->
		<!-- 	</ul> -->
  	</div>
 	
 	<div class="d-flex justify-content-end" style="color: #ccc;">
 		<a href="movie_list_present" >
 			<b>더 많은 영화보기</b>
 		</a> +
 	</div>
 
 	<%-- 영화목록 4개출력(예매율순?) --%>
  <div class="tab-content" id="pills-tabContent">
	<!--   <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab"> -->


	<%-- 컨텐츠 forEach --%>
	<div class="row" style="white-space: nowrap; overflow:hidden; text-overflow: elipsis;">
		<c:forEach var="movie" items="${movieList}">
			<div class="col-3">
				<div class="card border-0 shadow-sm">
					<a href="movie_detail_info?movie_num=${movie.movie_num}">
						<img src="${movie.movie_poster}" class="card-img-top" alt="...">
					</a>
					<div class="card-body">
						<h6 class="card-title"><b> ${movie.movie_name_kr}</b></h6>
						<p class="card-text"><button type="button" class="btn btn-outline-danger">♡찜하기</button>
						<button type="button" class="btn btn-danger" onclick="location.href='reservation_main?movie_num=${movie.movie_num}'">예매하기</button></p>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
  </div>
	<%-- 컨텐츠 -- 주석처리 --%>
<!-- 	<div class="row"> -->
<!-- 			<div class="col-3"> -->
<!-- 		 	 <div class="card h-100"> -->
<%-- 		     <a href="movie_detail_info"><img src="${pageContext.request.contextPath}/resources/img/poster02@2.jpg" class="card-img-top" alt="..." ></a>  --%>
<!-- 		      <div class="card-body"> -->
<!-- 		        <h5 class="card-title">Card title</h5> -->
<!-- 		        <p class="card-text"><button type="button" class="btn btn-outline-danger">♡찜하기</button> -->
<!-- 		        <button type="button" class="btn btn-danger" onclick="location.href='reservation_main'">예매하기</button></p> -->
<!-- 		      </div> -->
<!-- 		    </div> -->
<!-- 		 	</div> -->
		 	
		 	
<!-- 		 	<div class="col-3"> -->
<!-- 		 	 <div class="card h-100"> -->
<%-- 		      <img src="${pageContext.request.contextPath}/resources/img/poster04@2.jpg"  class="card-img-top" alt="..."> --%>
<!-- 		      <div class="card-body"> -->
<!-- 		        <h5 class="card-title">Card title</h5> -->
<!-- 		        <p class="card-text"><button type="button" class="btn btn-outline-danger">♡찜하기</button> -->
<!-- 		        <button type="button" class="btn btn-danger">예매하기</button></p> -->
<!-- 		      </div> -->
<!-- 		    </div> -->
<!-- 		 	</div> -->
		 	
		 	
		 	
<!-- 		 	<div class="col-3"> -->
<!-- 		 	<div class="card h-100"> -->
<%-- 		      <img src="${pageContext.request.contextPath}/resources/img/poster09.jpg"   class="card-img-top" alt="..."> --%>
<!-- 		      <div class="card-body"> -->
<!-- 		        <h5 class="card-title">Card title</h5> -->
<!-- 		        <p class="card-text"><button type="button" class="btn btn-outline-danger">♡찜하기</button> -->
<!-- 		        <button type="button" class="btn btn-danger">예매하기</button></p> -->
<!-- 		      </div> -->
<!-- 		    </div> -->
<!-- 		 	</div> -->
		 	
		 	
		 	
<!-- 		 	<div class="col-3"> -->
<!-- 		 	<div class="card h-100"> -->
<%-- 		      <img src="${pageContext.request.contextPath}/resources/img/poster09.jpg"   class="card-img-top" alt="..."> --%>
<!-- 		      <div class="card-body"> -->
<!-- 		        <h5 class="card-title">Card title</h5> -->
<!-- 		        <p class="card-text"><button type="button" class="btn btn-outline-danger">♡찜하기</button> -->
<!-- 		        <button type="button" class="btn btn-danger">예매하기</button></p> -->
<!-- 		      </div> -->
<!-- 		    </div> -->
<!-- 		 	</div> -->
<!-- 	</div> -->
<!-- 	</div> -->
<!-- 	<div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">예매율 순위</div> -->

	
	
	
	
	
	
	
	
<br>
	<%-- 영화검색창 --%>
   <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="search" placeholder="Search"  style="border: 1px solid #bd2130;">
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
    </form>
    
    </div>
  	</article>
  	<%--div 컨테이너 끝 --%>
  
  <nav id="mainNav" class="d-none d-md-block sidebar">
  <%--왼쪽 사이드바 --%>
  </nav>
  <div id="siteAds"></div>
  <%--페이지 하단 --%>
  <footer id="pageFooter"><%@ include file="inc/footer.jsp"%></footer>
</body>