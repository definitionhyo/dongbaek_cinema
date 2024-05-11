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
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/sidebar.css" rel="stylesheet" type="text/css">
<title>영화 예매 사이트</title>
<style>
	.w-900 {
		width: 900px;
		margin: 0px auto;
	}
	.col-4 {
		position: relative;
	}
	.info {
		position: absolute;
		bottom: 10px;
	}
	
	.topRow {
		margin: 30px auto;
	}
	
	.col-8 {
		margin-top: 5px;
		margin-left: 3em;
	}
	
	.noticeArea {
		margin-left: 3em;
	}
	
	a>h5{
		color: #000;
		text-decoration: none;
	}
	
	a:hover{
		color: #000;
		text-decoration: none;
	}
	
	#mainNav>ul{
		list-style: none;
	}
	
	/* a링크 활성화 색상 변경 */
	a:hover, a:active{
		color:  #ff5050 !important;
		text-decoration: none;
	}
	
	b {
		font-size: 1.4em;
		font-weight: bolder;
	}
	
	#tit {
		text-decoration: none !important;
		color: #000;
		/* 영역보다 긴 글의 경우 ... 으로 처리 */
		white-space: nowrap; /* 영역보다 커도 줄 바꿈하지마라 */
		overflow: hidden; /* 잘리는 부분 안보이게 함 */
		text-overflow: ellipsis; /* 잘리는 부분 ...으로 처리 */
	}
	
	tr, td {
		padding: 2px 3px;
	}
	
	
</style>
</head>
<body>
 <header id="pageHeader">
 <%--네비게이션 바 영역 --%>
  <%@ include file="../inc/header.jsp"%>
 </header>
 
  <article id="mainArticle">
  <%--본문내용 --%>
  <div class="container-fluid w-900">
  	<br><br><br>
	<h1>고객센터</h1><br>
	<div class="row topRow">
	    <div class="col-2 d-flex justify-content-center">
	    	<a href="cs_qna_form" class="text-center">
		    	<img src="${pageContext.request.contextPath}/resources/img/online-meeting.png"  alt="..." width="100px" height="100px"style=" display:block;">
			</a>
	    </div>
	    <div class="col-4">
	    	<h5>1:1 문의</h5>
	    	<span class="info">해결되지 않은 문제가 있나요? <br>1:1 문의로 문의주세요. </span>
	    </div>
	    <div class="col-2 d-flex justify-content-center">
	    	<a href="cs_faq" class="text-center">
		    	<img src="${pageContext.request.contextPath}/resources/img/faq.png"  alt="..." width="100px" height="100px"style=" display:block;">
	    	</a>
	    </div>
	    <div class="col-4">
	    	<h5>FAQ</h5>
	    	<span class="info">자주 묻는 질문 <br>빠르고 간편하게 검색하세요. </span>
	    </div>		
	</div>
	<hr>
	<div class="row bottomRow">
		<div class="noticeArea">
		    <br>
			<b>공지사항</b>&nbsp;&nbsp;&nbsp;<a href="cs_notice">더보기></a>
			<hr>
			<table>
				<c:forEach items="${csInfoList }" var="csNotice" varStatus="i">
			    	<tr>
			    		<th>
				    		<c:choose>
				    			<c:when test="${i.index eq 1 }">
									<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-map-pin"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path><circle cx="12" cy="10" r="3"></circle></svg>
				    			</c:when>
				    			<c:otherwise>
									<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path d="m16.114 1.553 6.333 6.333a1.75 1.75 0 0 1-.603 2.869l-1.63.633a5.67 5.67 0 0 0-3.395 3.725l-1.131 3.959a1.75 1.75 0 0 1-2.92.757L9 16.061l-5.595 5.594a.749.749 0 1 1-1.06-1.06L7.939 15l-3.768-3.768a1.75 1.75 0 0 1 .757-2.92l3.959-1.131a5.666 5.666 0 0 0 3.725-3.395l.633-1.63a1.75 1.75 0 0 1 2.869-.603ZM5.232 10.171l8.597 8.597a.25.25 0 0 0 .417-.108l1.131-3.959A7.17 7.17 0 0 1 19.67 9.99l1.63-.634a.25.25 0 0 0 .086-.409l-6.333-6.333a.25.25 0 0 0-.409.086l-.634 1.63a7.17 7.17 0 0 1-4.711 4.293L5.34 9.754a.25.25 0 0 0-.108.417Z"></path></svg>
				    			</c:otherwise>
				    		</c:choose>
			   			</th>
					    <th>${csNotice.cs_type }</th>
					    <td>
					    	<a id="tit" href="cs_notice_view?cstypeNo=1&cs_type_list_num=${csNotice.cs_type_list_num }&pageNo=1">${csNotice.cs_subject }</a>
			    		</td>
					    <td>
					    	<fmf:formatDate value="${csNotice.cs_date}" pattern="yyyy.MM.dd"/>
					    </td>
			    	</tr>
				</c:forEach>
		    </table>
		</div>
 	</div>	
  </div>
  </article>
  
  <nav id="mainNav" class="d-none d-md-block sidebar">
  <%--왼쪽 사이드바 --%>
	<jsp:include page="/WEB-INF/views/sidebar/sideBar_cs.jsp"></jsp:include>
  </nav>
  
  <div id="siteAds"></div>
  <%--페이지 하단 --%>
  <footer id="pageFooter"><%@ include file="../inc/footer.jsp"%></footer>
</body>