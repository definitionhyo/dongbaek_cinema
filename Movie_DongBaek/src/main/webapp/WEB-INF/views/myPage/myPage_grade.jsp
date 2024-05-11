<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmf" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<title>영화 예매 사이트</title>
<style>
	
	<%-- a링크 활성화 색상 변경 --%>
	a:hover, a:active{
	 color:  #ff5050 !important;
		
	}
	
	/* 본문내용과 사이드바 위, 아래 여백주기 */
	#mainArticle{
		margin: 50px auto 30px;
	}
	.mainTop {
		margin-top: 0.8em;
	}
	.part {
		padding: 20px;
/* 		border: 1px dotted #ccc; */
	}
	/* 등급 아이콘 크기 조절 */
	.gradeImg {
		width: 60px;
		vertical-align: -25px;
	}
	/* 좌우 중간 정렬 */
	.middle {
		margin: 0 auto;
	}
	/* 강조할 텍스트 빨간색 */
	.sale {
		color: red;
		font-weight: bold;
	}
	/* 버튼 크기 조절 */
	.btn-outline-dark {
		font-size: 0.8em;
		style: #eee;
		text-align: center;
		vertical-align: middle;
		padding: 3px 5px 2px 6px;
		margin-top: 5px;
	}
	/* 글자 연하게 */
	i {
 		font-style: none; 
 		style: #eee; 
	}
</style>
<script type="text/javascript">
	
	function getCode(url, param) {
		switch (url) {
		// 나의 구매내역으로 이동
		case 'myPage_buy_history' :
			location.href = 'myPage_buy_history';
			break;
		
		}
		
	}
</script>
</head>
<body>
	<%--네비게이션 바 영역 --%>
	<header id="pageHeader"><%@ include
			file="../inc/header.jsp"%></header>

	<article id="mainArticle">
		<%--본문내용 --%>
		<h2> 나의 멤버십 등급</h2>
		<div class="container part container-fluid w-900">
			<div class="mainTop">
				<h3>
					<c:choose>
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
					${member_id} 님은 <strong>${myGrade.grade_name}</strong> 등급입니다
				</h3>
			</div>
			<br>
			<div>
				<table class="table">
					<tr>
						<td>
							현재 등급 :<b> ${myGrade.grade_name}</b><br>
							혜택 : 영화 결제금액 <span class="sale">${myGrade.grade_discount * 100} %</span> 할인
						</td>
						<td>
							<span>
								현재 누적 금액 <br>
								<span><fmf:formatNumber value="${payment_total_price}" pattern="#,###,###" /></span>
								 / <span><fmf:formatNumber value="${myGrade.grade_max}" pattern="#,###,###" /> 원</span><br>
								&nbsp; <input type="button" value="상세보기 >" class="btn btn-outline-dark" onclick="getCode('myPage_buy_history')">
							</span>
						</td>
					</tr>
					<c:choose>
						<c:when test="${myGrade.next_grade_discount * 100 eq 0}" >
							현재 최고등급입니다.
						</c:when>
						<c:otherwise>
							<tr>
								<td>다음 등급 : ${myGrade.next_grade_name}<br>
									할인율 : 영화 결제금액 
									<span class="sale">${myGrade.next_grade_discount * 100} %</span> 할인<br>
								</td>
								<td>
									선정 기준 및 유지 기준 : 1년간 <fmf:formatNumber value="${myGrade.grade_max}" pattern="#,###,###" /> 원 달성 시 다음해 승급 <br>
									<a href="grade">전체 등급 혜택 확인하러 가기 click</a>
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</table>
			</div>
		</div>
		<div class="part">
			<h4>꼭 확인하세요!</h4>
			<%-- cgv 참조 --%>
			<h5>멤버십 등급 반영 기준</h5>
			<ul>
				<li>동백씨네마 매표에서 구매하신 금액 기준 및 이벤트 보상이 합산되어 반영됩니다.</li>
				<li>구매 시, 고객정보가 반영된 내역으로 집계됩니다.</li>
				<li>최근 1년 실적을 매년 누적 집계합니다.</li>
				<li>멤버십 점수 반영률과 멤버십 승급 기준 및 혜택은 당사 사정에 따라 변경될 수 있습니다.</li>
			</ul>
		</div>
			

	</article>

	<%--왼쪽 사이드바 --%>
		<nav id="mainNav" class="d-none d-md-block sidebar">
		<%--왼쪽 사이드바 --%>
  		<%@ include file="/WEB-INF/views/sidebar/sideBar_myPage.jsp"%>
  	</nav>

	<div id="siteAds"></div>
	<%--페이지 하단 --%>
	<footer id="pageFooter"><%@ include
			file="../inc/footer.jsp"%></footer>
</body>