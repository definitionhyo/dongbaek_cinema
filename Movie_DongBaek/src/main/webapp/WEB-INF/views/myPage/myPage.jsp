<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmf" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/myPage.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/sidebar_myPage.css" rel="stylesheet" type="text/css">
<title>동백시네마 마이페이지</title>
<style>	
/* a링크 활성화 색상 변경 */

#myPage_GOLD {
	margin: 1em auto auto 3em;
}
.col-8 {
	margin-bottom: 2em;
}
.col-8>h1 {
	margin-top: 1em;
}
/* 등급 아이콘 크기 조절 */
.gradeImg {
	width: 40px;
	vertical-align: -8px;
	padding: 0;
}

</style>
</head>
<body>
	<%--네비게이션 바 영역 --%>
	<header id="pageHeader"><%@ include
			file="../inc/header.jsp"%></header>

	<article id="mainArticle">
		<%--본문내용 --%>
		<div class="container container-fluid w-900">
			<div class="mainTop row">
				<%-- 마이페이지 환영멘트 --%>
				<div class="col-4">
					<img src="${pageContext.request.contextPath }/resources/img/membership_main_photo.png" id="myPage_GOLD">
				</div>
				<div class="col-8">
					<h1>
						<span>
							<b>${member.member_name}님 환영합니다!</b>
						</span>
					</h1>
					<h3>
					현재 등급
					<%-- 등급에 따른 아이콘 표시 --%>
					<c:choose>
						<c:when test="${myGrade.grade_name eq 'NONE'}">
						</c:when>
						<c:when test="${myGrade.grade_name eq 'BRONZE'}">
							<img class="gradeImg" src="${pageContext.request.contextPath }/resources/img/grade_bronze.png">
						</c:when>
						<c:when test="${myGrade.grade_name eq 'SILVER'}">
							<img class="gradeImg" src="${pageContext.request.contextPath }/resources/img/grade_silver.png">
						</c:when>
						<c:when test="${myGrade.grade_name eq 'GOLD'}">
							<img class="gradeImg" src="${pageContext.request.contextPath }/resources/img/grade_gold.png">
						</c:when>
						<c:otherwise>
							<img class="gradeImg" src="${pageContext.request.contextPath }/resources/img/grade_platinum.png">
						</c:otherwise>
					</c:choose>
					${myGrade.grade_name}
					</h3>
					<%-- 왼쪽 사이드바에 있으니 굳이 필요하지 않은듯 --%>	
	<!-- 			<a href="myPage_modify_check">회원정보수정</a> <br> -->
					<div class="grade">
		<!-- 				<h2>등급별 혜택</h2> -->
		<!-- 				<br> -->
		<!-- 				<hr class="my-4"> -->
						
						<b>혜택</b> : 영화 금액 <b>${myGrade.grade_discount * 100} % 할인</b>
						<br> 
						<c:choose>
								<c:when test="${myGrade.next_grade_discount * 100 eq 0}" >
									현재 최고등급입니다.
								</c:when>
								<c:otherwise>
									<tr>
										<td>다음 등급 : ${myGrade.next_grade_name}</td>
		<!-- 								<td> -->
		<!-- 									할인율 : 영화 결제금액 <br> -->
		<%-- 									<span class="sale">${myGrade.next_grade_discount * 100} %</span> 할인<br> --%>
		<%-- 									선정 기준 및 유지 기준 : 1년간 <fmf:formatNumber value="${myGrade.grade_max}" pattern="#,###,###" /> 원 달성 시 다음해 승급 --%>
		<!-- 								</td> -->
									</tr>
								</c:otherwise>
							</c:choose>
					</div>
					<br> 
					<a href="grade">전체 등급 혜택 확인하러 가기 click</a>
				</div>
<%-- 				<b>다음 등급 : </b>${myGrade.next_grade_name}<br> --%>
<%-- 				<b>혜택</b> :영화 금액의 <b>${myGrade.next_grade_discount * 100}% 할인</b> --%>
			</div>
			
			<div class="myTicketing">
				<h2>예매내역</h2>
<!-- 				<hr class="my-4"> -->
				<table class="table table-striped">
					<c:choose>
						<c:when test="${empty myTicketList}">
							<tr>
								<td>고객님의 최근 예매내역이 존재하지 않습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<tr>
								<th>번호</th>
								<th>포스터</th> <%-- {param.board_ticket_num} --%>
								<th>영화제목</th>
								<th>상영일</th>
								<th>예매 상태 변경</th>
							</tr>
							<c:forEach var="myTicket" items="${myTicketList }" begin="0" end="3" step="1" varStatus="status">
								<tr>
									<%-- 게시물 번호 처리, 1번부터 시작 --%>
									<td>${status.index+1} </td>
									<td><img src="${myTicket.movie_poster }" alt="포스터" height="150"></td><%-- {param.movie.poster} --%>
									<td>${myTicket.movie_name_kr }</td>
									<td>
										${myTicket.play_date }
										<fmf:formatDate value="${myTicket.play_start_time }" pattern="HH:mm"/>
									</td><%-- {param.datetime_start} ~ {param.datetime_end} --%>
									
									<td>
									<form action="myPayment_detail" method="post">
										<input type="hidden" name="payment_num" value="${myTicket.payment_num }">
										<input type="hidden" name="play_change" value="${myTicket.play_change }">
										<input type="submit" value="${myTicket.play_change }"
												<c:if test="${myTicket.play_change eq '취소불가' }"> disabled</c:if> >
										</form>
										<%-- 상영일 상영시간이 30분 이전이라면 취소 가능 --%>
										<%-- 오늘 날짜 --%>
<%-- 										<jsp:useBean id="now" class="java.util.Date" /> --%>
<%-- 										<fmt:formatDate var="nowDate" value="${javaDate}" pattern="yyyy-MM-dd"/> --%>
<%-- 										상영 날짜 --%>
<%-- 										<fmt:parseDate value="${myTicketList.play_date }" var="play_date" pattern="yyyy-MM-dd" /> --%>
<%-- 										<input type="button" value="${myTicketList.play_change }"> --%>
										
<%-- 												<c:if test="${myTicket.play_change eq '취소불가' }"> disabled</c:if> > --%>
									</td><%-- {param.iscdange??} --%>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
					
				</table>
			</div>
	
			<hr>
			
			
<!-- 			<div class="myQuest"> -->
<!-- 				<h2>나의 문의 내역</h2> -->
<!-- 				<br> -->
<!-- <!-- 				<hr class="my-4"> -->
<!-- 				<table  class="table table-striped"> -->
<%-- 					<c:choose> --%>
<%-- 						<c:when test="${empty myInq}"> --%>
<!-- 							<tr> -->
<!-- 								<td>고객님의 최근 문의 내역이 존재하지 않습니다.</td> -->
<!-- 							</tr> -->
<%-- 						</c:when> --%>
<%-- 						<c:otherwise> --%>
<%-- 							<c:forEach var="myPayment" items="${myPaymentList }"> --%>
<!-- 								<tr> -->
<!-- 							 		<th>문의 번호 </th> -->
<!-- 							 		<th>문의 유형</th> -->
<!-- 							 		<th>문의 제목</th> -->
<!-- 							 		<th>문의 내용</th> -->
<!-- 							 		<th>답변 여부</th> -->
<!-- 							 		<th>문의내역 변경</th> -->
<!-- 							 	</tr> -->
<!-- 							 	<tr> -->
<%-- 							 		<td>{myInq.cs_num }</td>{param.inquiry_board_num} --%>
<%-- 							 		<td>{myInq.cs_type}</td>{param.inquiry-category} --%>
<%-- 							 		<td>{myInq.cs_subject }</td>{param.inquiry_board_subject} --%>
<%-- 							 		<td>{myInq.cs_content }<a href="inqury_content_detail">더보기</a> </td> {param.inquiry_board_content} 팝업으로 --%>
<%-- 							 		<td><img alt="답변안달렸을때X사진" src="X.jpg"> </td>{param.inquiry_board_isanswer} --%>
<!-- 							 		<td><button value="수정">수정</button> <button value="삭제">삭제</button> </td> -->
<!-- 							 	</tr> -->
<%-- 							</c:forEach> --%>
<%-- 						</c:otherwise> --%>
<%-- 					</c:choose> --%>
<!-- 				</table> -->
<!-- 			</div> -->
		</div>

	</article>

	<nav id="mainNav" class="d-none d-md-block sidebar"> 
		<%--왼쪽 사이드바 --%>
  		<%@ include file="/WEB-INF/views/sidebar/sideBar_myPage.jsp"%>
  	</nav>
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
<!-- 	</nav> -->

	<div id="siteAds"></div>
	<%--페이지 하단 --%>
	<footer id="pageFooter"><%@ include
			file="../inc/footer.jsp"%></footer>
</body>