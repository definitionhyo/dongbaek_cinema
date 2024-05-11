<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/sidebar.css" rel="stylesheet" type="text/css">
<title>영화 예매 사이트</title>
<style>

a>b{
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

<%-- a링크 활성화 색상 변경 --%>
a:hover, a:active{
 color:  #ff5050 !important;
	
}
</style>

<script type="text/javascript">




</script>

</head>
<body>
 <header id="pageHeader">
 <%--네비게이션 바 영역 --%>
  <%@ include file="../inc/header.jsp"%>
 </header>
 
  <article id="mainArticle">
  <%--본문내용 --%>
  
   <div class="container-fluid w-900" >
  
<!-- 		<form action="cs_notice" method="post" enctype="multipart/form-data"> -->
			<h1>공지사항 관리자</h1>
			<input type="hidden" name="pageNo" value="${param.pageNo }"> <%-- 페이지번호 전송용 --%>
			<input type="hidden" name="cs_type" value="공지" ><%-- 공지사항 유형 정보 전송용 --%>
			<input type="hidden" name="csTypeNo" value="1" ><%-- 공지사항 유형 정보 전송용 --%>
	
			<table class="table table-striped text-center align-middle">
			<tbody>
				<tr>
			      <td scope="col" class="align-middle" width="100">번호</th>
			      <td scope="col" class="align-middle text-left" width="400">${csInfo.cs_type_list_num }</td>
			    </tr>
				<tr>
			      <td scope="col" class="align-middle" width="100">제목</th>
			      <td scope="col" class="align-middle text-left">${csInfo.cs_subject }</td>
			    </tr>
				<tr>
			      <td scope="col" class="align-middle" width="100">작성자</th>
			      <td scope="col" class="align-middle text-left">${csInfo.member_id }</td>
			    </tr>
				<tr>
			      <td scope="col" class="align-middle" width="100">내용</th>
			      <td scope="col" class="align-top text-left" height="300px;"><pre>${csInfo.cs_content }</pre></td>
			    </tr>
				<tr>
			      <td scope="col" class="align-middle" width="100">사진첨부</th>
			      <td scope="col" class="align-middle text-left">
                       <c:choose>
							<c:when test="${not empty csInfo.cs_file }">
								<a href="${pageContext.request.contextPath }/resources/upload/${csInfo.cs_file }" download="${fn:split(csInfo.cs_file, '_')[1] }">
									${fn:split(csInfo.cs_file, '_')[1] }
								</a>
							</c:when>
                          		<c:otherwise>
                           		<span id="cs_file_old_span">첨부파일이 없습니다</span>
                          		</c:otherwise>
                        </c:choose>
			      </td>
			    </tr>
				<tr>
					<td scope="col" class="align-middle"></td>
					<td scope="col" class="align-middle">
						<button class="btn btn-outline-danger" type="button" onclick="history.back()">돌아가기</button>
					</td>
			    </tr>

			</table>
			
<!-- 		</form> -->

	</div>

  </article>
  

  <%--왼쪽 사이드바 --%>
	<nav id="mainNav" class="d-none d-md-block sidebar">
		<%@ include file="/WEB-INF/views/sidebar/sideBar_cs.jsp"%>
	</nav>
  
  <div id="siteAds"></div>
  <%--페이지 하단 --%>
</body>