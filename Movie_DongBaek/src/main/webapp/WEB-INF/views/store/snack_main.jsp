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

	 .card{
    position: relative;
    display: block;
    height: 435px;
    text-decoration: none;
    border:3px solid #e4e4e4;
    border-radius: 10px;
  }
	
</style>
<script type="text/javascript">

</script>
</head>
<body>
 <%--네비게이션 바 영역 --%>
 <header id="pageHeader"><%@ include file="../inc/header.jsp"%></header>
 
  <article id="mainArticle">
  <%--본문내용 --%>
		<div class="container">
 		<h2>스토어</h2>
 		<hr>
		<div class="container-fluid reservation_con" style="border:none;">
	           <div class="row row1">
	           	<%-- 스낵 권유 파트 --%>
	               <div class="col-md-8 col-lg-8" id="seat-part">
	               		<div class="row row-cols-1 row-cols-md-3" style="width: 50rem;">
	               		<c:forEach var="snack" items="${snackList }">
						<div class="col mb-3" >
						    <div class="card h-100" >
						      <img src="${pageContext.request.contextPath }/resources/img/${snack.snack_img}"  height="280" class="card-img-top" alt="...">
						      <div class="card-body">
						        <h5 class="card-title" style="text-align:left">${snack.snack_name}</h5><br>
						        	<b>${snack.snack_txt}</b><br>
						        	<hr>
						        	<b>${snack.snack_price}원</b>
						      </div>
						    </div>
						  </div>
	               		</c:forEach>
<!-- 	               			<div class="col mb-4"> -->
<!-- 						    <div class="card h-100"> -->
<!-- 						      <img src="/resources/img/popcorn.png" width="80" height="130" class="card-img-top" alt="..."> -->
<!-- 						      <div class="card-body"> -->
<!-- 						        <h5 class="card-title">상품명</h5> -->
<!-- 						        	10,000원 -->
<!-- 						        	<br> -->
<!-- 						        	한 줄 설명(고소팝콘 M1 + 콜라2)<br> -->
<!-- 						      </div> -->
<!-- 						    </div> -->
<!-- 						  </div> -->
	               			
	               		</div>
	               		
	               </div>
	               
	               
	           </div>
	           
	           
	           </div>
  </div>
  </article>
  
  <nav id="mainNav" class="d-none d-md-block sidebar">
  <%--왼쪽 사이드바 --%>
  </nav>
  
  <div id="siteAds"></div>
  <%--페이지 하단 --%>
  <footer id="pageFooter"><%@ include file="../inc/footer.jsp"%></footer>
</body>