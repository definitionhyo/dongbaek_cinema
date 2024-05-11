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
		  <div class="mainTop">
			 <h2>문의 내역</h2>
			 <br>
			 <br>
<!-- 			 <form action=""> -->
			 	<table class="table">
						<c:choose>
							<c:when test="${empty myInqList}">
								<tr>
									<td>고객님의 최근 문의 내역이 존재하지 않습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
									<tr>
								 		<th scope="col" width="200px">문의 유형</th>
								 		<th scope="col" width="200px">문의 제목</th>
								 		<th scope="col" width="400px">문의 내용</th>
								 		<th scope="col" width="150px">답변 여부</th>
								 		<th scope="col" width="200px">문의내역 변경</th>
								 	</tr>
								<c:forEach var="myInqList" items="${myInqList }">
								 	<tr>
								 		<td>${myInqList.cs_type}</td>
								 		<td>${myInqList.cs_subject }</td>
								 		<td>${myInqList.cs_content }</td>
								 		<c:choose>
								 			<c:when test="${empty myInqList.cs_reply }">
								 				<td> 답변 예정 </td>
								 			</c:when>
									 		<c:otherwise>
									 			<td> 답변 완료 </td>
									 		</c:otherwise>
								 		</c:choose>
								 		<%-- 버튼 영역 --%>
									 	<td>
											<form action="inquiry_detail" method="post" >
												<input type="hidden" value="${myInqList.cs_num }" name="cs_num">
<%-- 												<input type="hidden" value="${myInqList.cs_reply }" name="cs_reply"> --%>
												<button class="btn btn-danger" type="submit">수정 및 삭제</button>
<!-- 												<input type="submit" value="수정 및 삭제"> -->
											</form>	 	
									 	</td>
								 	</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</table>
<!-- 			 </form> -->
		 </div>
	  </div>
  </article>
  
  	<nav id="mainNav" class="d-none d-md-block sidebar">
<%-- 		<%--왼쪽 사이드바 --%>
<!--   	<nav id="mainNav"> -->
  		<%@ include file="/WEB-INF/views/sidebar/sideBar_myPage.jsp"%>
  	</nav>
  <div id="siteAds"></div>
  <%--페이지 하단 --%>
  <footer id="pageFooter"><%@ include file="../inc/footer.jsp"%></footer>
</body>