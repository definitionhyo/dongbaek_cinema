<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<title>영화 예매 사이트</title>
</head>
<body>

<%--header include --%>
<header id=pageHeader>
<%@ include file="../inc/header.jsp"%>      
</header>

<%--컨텐츠 섹션(본문내용) 시작  --%>
<section id=mainArticle>
<div id=content-margin>
</div>
<!-- 본문 내용 입력-->

<%-- 극장선택탭 include --%>
<%@ include file="theater_tap.jsp"%>
<br>
<br>



<%-- 탭  --%>
<div class="container" align="center" >
	<%-- 탭제목 --%>
	<div class="row-col-my-5">
		<nav>
		  <div class="nav nav-tabs" id="nav-tab" role="tablist">
		   <button class="nav-link" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true" onclick="location.href='theater_main'">
		    	극장정보
		    </button>
		    <button class="nav-link " id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onclick="location.href='theater-runningtime_tap'">
		    	상영시간표
		    </button>
		    <button class="nav-link active" id="nav-contact-tab" data-bs-toggle="tab" data-bs-target="#nav-contact" type="button" role="tab" aria-controls="nav-contact" aria-selected="false" onclick="location.href='theater-price_tap'">
		    	요금안내
		    </button>
		  </div>
		</nav>
	</div>	
	<%-- 탭 내용 - collpse --%>
	<div class="row-col-my-5" >
		<div class="tab-content" id="nav-tabContent">
		  <div class="tab-pane fade show active my-3 mx-6" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab" tabindex="0">
			  	<div class="row">
					<table class="table table-striped" >
						<tr>
							<td></td>
							
							<td>일반</td>
							<td>조조</td>
							<td>심야</td>
							
							
						</tr>
						<tr>
							<td>일반</td>
							<td>${ticketList[0].ticket_type_price}</td>
							<td>${ticketList[1].ticket_type_price}</td>
							<td>${ticketList[2].ticket_type_price}</td>
						</tr>
						<tr>
							<td>청소년</td>
							<td>${ticketList[3].ticket_type_price}</td>
							<td>${ticketList[4].ticket_type_price}</td>
							<td>${ticketList[5].ticket_type_price}</td>
						</tr>
						<tr>
							<td>경로/어린이</td>
							<td>${ticketList[6].ticket_type_price}</td>
							<td>${ticketList[7].ticket_type_price}</td>
							<td>${ticketList[8].ticket_type_price}</td>
						</tr>
						<tr>
							<td>장애인</td>
							<td>${ticketList[9].ticket_type_price}</td>
							<td>${ticketList[10].ticket_type_price}</td>
							<td>${ticketList[11].ticket_type_price}</td>
						</tr>

					</table>	
				</div>
		  </div>
		  <%-- 두번째탭 내용--%>
		  <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab" tabindex="0">
		  	<h6>상영시간표</h6>
		  </div>
		  
		  <%-- 세번째탭 내용--%>
		  <div class="tab-pane fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab" tabindex="0">
		  	<h6>관람료</h6>
		  </div>
		</div>
		</div>
	</div>
	<div>
	</div>
<%--컨텐츠 섹션 끝 ------------------------------------------------------------------------------------- --%>
</section>
 <nav id="mainNav" class="d-none d-md-block sidebar">
  <%--왼쪽 사이드바 --%>
  <div id=left-margin></div>
  </nav>
 <div id="siteAds"></div>
<footer id=pageFooter>
<%@ include file="../inc/footer.jsp"%>
</footer>
</body>
</html>