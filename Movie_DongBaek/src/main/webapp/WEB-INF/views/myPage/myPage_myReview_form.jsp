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
<link href="${pageContext.request.contextPath }/resources/css/sidebar_myPage.css" rel="stylesheet" type="text/css">
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
  	<div class="container container-fluid w-900">
  		<div class="row d-flex justify-content-center mt-3">
  			<div class="col-10">
				<h2>리뷰 쓰기</h2>
				
				<br>
				<br>
  				<form action="review_write_pro" method="post" name="fr" >
				 	<input type="hidden" name="movie_num" value="${movie_num}">
				 	<%-- 영화 제목 --%>
					<div class="row mb-3">
		              <label for="id" class="col-2 text-nowrap">영화 이름</label>
		              <div class="col-10">
<!-- 		              		<input type="text" disabled="disabled" readonly="readonly"> -->
		              			${myReview.movie_name_kr } 
		              </div>
			        </div>
					 	
<%-- 				 	<span>영화제목</span>  css로 색이랑 입히기 --%>
<%-- 				 	<input type="text" disabled="disabled" readonly="readonly" value="{param.movie_name}앞페이지에서가져오기?">  디스패치? 앞에서 작성하기누르면 영화제목그대로 가져오기 --%>
				  	<br>
				  	
				  	<%-- 평점 선택하기 --%>
				  	<div class="row mb-3">
		              <label for="id" class="col-2 text-nowrap">평점</label>
		              <div class="col-10">
							<div class="selectBox_movie">
							  	<select name="review_rating" class="select" id="review_rating">
							  		<option value="none">선택해주세요</option>
							  		<option value="1" <c:if test="${review_rating=='1'}">${'selected' }</c:if>>1</option>
							  		<option value="2" <c:if test="${review_rating=='2'}">${'selected' }</c:if>>2</option>
							  		<option value="3" <c:if test="${review_rating=='3'}">${'selected' }</c:if>>3</option>
							  		<option value="4" <c:if test="${review_rating=='4'}">${'selected' }</c:if>>4</option>
							  		<option value="5" <c:if test="${review_rating=='5'}">${'selected' }</c:if>>5</option>
							  	</select>
							</div>
		            	</div>
			        </div>
				  	
				  	<%-- 영화 제목 --%>
					<div class="row mb-3">
		              <label for="id" class="col-2 text-nowrap">리뷰</label>
		              <div class="col-10">
		              		<textarea rows="5" cols="50" placeholder="리뷰를 작성해 주세요" id="review_content"  name="review_content"></textarea> <%--css에서 마진넣어서  --%>
		              </div>
			        </div>
				  	
				  	<div class="row mb-3">
		            	<label for="id" class="col-2 text-nowrap">리뷰</label>
		            	<div class="col-10">
							<input type="submit" value="등록">&nbsp;&nbsp;
							<input type="reset" value="다시쓰기">&nbsp;&nbsp;
							<input type="button" value="취소" onclick="history.back()">
						</div>
					</div>
			  </form>
		  	</div>
	  	</div>
  	</div>
  </article>
  
  	<nav id="mainNav" class="d-none d-md-block sidebar">
		<%--왼쪽 사이드바 --%>
  		<%@ include file="/WEB-INF/views/sidebar/sideBar_myPage.jsp"%>
  	</nav>
  
<!--   <nav id="mainNav" class="d-none d-md-block sidebar"> -->
<%--   <%--왼쪽 사이드바 --%>
<!--   <!-- 	왼쪽 탭 링크들 -->
<!--   	<h3>마이페이지</h3> -->
<!-- 		<ul class="left-tap"> -->
<!-- 			<li class="myPage-ticketing-buy"><a class="nav-link" href="myPage_reservation_buy_history">예매 -->
<!-- 					/ 구매내역</a></li> -->
<!-- 			<li class="myPage-review"><a class="nav-link" href="myPage_myReview">나의 리뷰</a></li> -->
<!-- 			<li class="myPage-moviefourcut"><a class="nav-link" href="myPage_moviefourcut">영화네컷</a></li> -->
<!-- 			<li class="myPage-quest"><a class="nav-link" href="myPage_inquiry">문의 내역</a></li> -->
<!-- 			<li class="myPage-grade"><a class="nav-link" href="myPage_grade">등급별 혜택</a></li> -->
<!-- 			<li class="myPage-privacy"><a class="nav-link" href="myPage_modify_check">개인정보수정</a></li> -->
<!-- 		</ul> -->
<!--   </nav> -->
  
  <div id="siteAds"></div>
  <%--페이지 하단 --%>
  <footer id="pageFooter"><%@ include file="../inc/footer.jsp"%></footer>
</body>