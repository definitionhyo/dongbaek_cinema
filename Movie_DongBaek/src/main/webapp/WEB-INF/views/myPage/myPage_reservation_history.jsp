<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmf" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

/* a링크 활성화 색상 변경 */
a:hover, a:active{
 color:  #ff5050 !important;
}

table {
	margin-top: 20px;
}

#infoType {
	color: gray;
	font-size: 0.8em;
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
  	<div class="container container-fluid w-900">
  		<div class="mainTop">
		  <h2>나의 예매내역</h2>
		  <br>
		  <span>지난 <b>1개월</b>까지의 예매내역을 확인하실 수 있습니다</span><br>
				<table class="table">
					<c:choose>
						<c:when test="${empty myTicketList}">
							<tr>
								<td>고객님의 최근 예매내역이 존재하지 않습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<tr>
								<th>포스터</th> <%-- {param.board_ticket_num} --%>
								<th>영화명</th>
								<th>상영일</th>
								<th>결제</th>
								<th>예매 상태 변경</th>
<!-- 								<th>리뷰 쓰기</th> -->
							</tr>
							<c:forEach var="myTicket" items="${myTicketList }">
								<tr>
									<td><img src="${myTicket.movie_poster }" alt="포스터" height="150"></td><%-- {param.movie.poster} --%>
									<td>
										${myTicket.movie_name_kr } <br>
										<span id="infoType">${myTicket.ticket_type }</span>
									</td>
									<td>
										${myTicket.play_date }
										<fmf:formatDate value="${myTicket.play_start_time }" pattern="HH:mm"/>
									</td><%-- {param.datetime_start} ~ {param.datetime_end} --%>
									<td>
										${myTicket.ticket_payment_status }
									</td>
									<td>
										<form action="myPayment_detail" method="post">
										<input type="hidden" name="payment_num" value="${myTicket.payment_num }">
										<input type="hidden" name="play_change" value="${myTicket.play_change }">
										<input type="submit" value="${myTicket.play_change }"
												<c:if test="${myTicket.play_change eq '취소불가' }"> disabled</c:if> >
										</form>
									</td>
								</tr>
							
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</table>
			</div>
				
		<%-- 페이징 처리 --%>
		<nav aria-label="...">
		    <ul class="pagination pagination-md justify-content-center">
		        <%-- 이전 페이지로 이동 --%>
		        <c:choose>
		            <c:when test="${pageInfo.startPage > 1}">
		                <li class="page-item">
		                    <a class="page-link" href="myPage_reservation_history?pageNo=${pageInfo.startPage - 1}" tabindex="-1" aria-disabled="false">&laquo;</a>
		                </li>
		            </c:when>
		            <c:otherwise>
		                <li class="page-item disabled">
		                    <a class="page-link" href="#" tabindex="-1" aria-disabled="true">&laquo;</a>
		                </li>
		            </c:otherwise>
		        </c:choose>
		
		        <%-- 각 페이지 번호마다 하이퍼링크 설정(현재 페이지는 하이퍼링크 제거) --%>
		        <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
		            <c:choose>
		                <%-- 현재 페이지 --%>
		                <c:when test="${pageNo eq i}">
		                    <li class="page-item active" aria-current="page">
		                        <a class="page-link">${i} <span class="sr-only">(current)</span></a>
		                    </li>
		                </c:when>
		                <c:otherwise>
		                    <%-- 다른 페이지 --%>
		                    <li class="page-item">
		                        <a class="page-link" href="myPage_reservation_history?pageNo=${i}">${i}</a>
		                    </li>
		                </c:otherwise>
		            </c:choose>
		        </c:forEach>
		
		        <%-- 다음 페이지로 이동 --%>
		        <c:choose>
		            <c:when test="${pageInfo.endPage < pageInfo.maxPage}">
		                <li class="page-item">
		                    <a class="page-link" href="myPage_reservation_history?pageNo=${pageInfo.endPage + 1}">&raquo;</a>
		                </li>
		            </c:when>
		            <c:otherwise>
		                <li class="page-item disabled">
		                    <a class="page-link" href="#" tabindex="-1" aria-disabled="true">&raquo;</a>
		                </li>
		            </c:otherwise>
		        </c:choose>
		    </ul>
		</nav>
				
	  </div>
  </article>
  
  	<nav id="mainNav" class="d-none d-md-block sidebar">
		<%--왼쪽 사이드바 --%>
  		<%@ include file="/WEB-INF/views/sidebar/sideBar_myPage.jsp"%>
  	</nav>
  
  <div id="siteAds"></div>
  <%--페이지 하단 --%>
  <footer id="pageFooter"><%@ include file="../inc/footer.jsp"%></footer>
</body>