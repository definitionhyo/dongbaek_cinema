<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">

<link rel="stylesheet" type="text/css">

<meta charset="UTF-8">
<title>영화 예매 사이트</title>
<style>
footer{
	background-color: #ef4f4f;
}
/*   cs 페이지에서 가져옴 */
#tit {
		text-decoration: none !important;
		color: #000;
		/* 영역보다 긴 글의 경우 ... 으로 처리 */
		white-space: nowrap; /* 영역보다 커도 줄 바꿈하지마라 */
		overflow: hidden; /* 잘리는 부분 안보이게 함 */
		text-overflow: ellipsis; /* 잘리는 부분 ...으로 처리 */
}
a:hover, a:active{
		color:  #ff5050 !important;
		text-decoration: none;
	}
</style>

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
		    <button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true" onclick="location.href='theater_main'">
		    	극장정보
		    </button>
		    <button class="nav-link " id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false" onclick="location.href='theater-runningtime_tap'">
		    	상영시간표
		    </button>
		    <button class="nav-link" id="nav-contact-tab" data-bs-toggle="tab" data-bs-target="#nav-contact" type="button" role="tab" aria-controls="nav-contact" aria-selected="false" onclick="location.href='theater-price_tap'">
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
				  <div class="col">
				  	<h5 id="theater_name">${theaterList[0].theater_name }</h5><br>
				  	<span id="theater_map">${theaterList[0].theater_map}</span>
				  	<br>
				  </div>
				  <div class="col" >
				  	<h5>주소</h5> 
				  	<span id ="theater_address">${theaterList[0].theater_address} </span>
				  </div>
				  <div class="col"> 
			<!-- 	cs 페이지에서 가져옴 -->
				  	<h5>공지사항 &nbsp;&nbsp;&nbsp;<a href="cs_notice">더보기></a></h5>
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
					    
					    <td>
					    	<a id="tit" href="cs_notice_view?cstypeNo=1&cs_type_list_num=${csNotice.cs_type_list_num }&pageNo=1">${csNotice.cs_subject }</a>
			    		</td>
					   
			    	</tr>
				</c:forEach>
		    </table>
		    <hr>
		    	<!--------------------------------------------------------------------------------------->
				  </div>
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