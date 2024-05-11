<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<%-- <link href="${pageContext.request.contextPath }/resources/css/myPage.css" rel="stylesheet" type="text/css"> --%>
<title>영화 예매 사이트</title>
<style>
	/* 위 간격 조절 */
	#mainArticle {
		margin-top: 50px;
	}
	/* 너비 조정 클래스 */
	.w-900 {
		width: 900px;
	}
	/* 주의사항 여백, 글자크기 조절 */
	.part {
		margin: 30px 0;
		color: #555;	
		font-size: 0.9em;
	}
	.part>h5 {
		padding-left: 10px;
		font-size: 1.3em;
	}
	
	/* 등급 아이콘 크기 조절 */
	.gradeImg {
		width: 80px;
		margin-right: 20px;
	}
	/* th 크기 조절 */
	th {
		width: 300px;
	}
	
	/* 강조 글자 설정 */
	.sale {
		font-size: 1.1em;
		font-weight: bold;
	}
	
	/* 표 안 수직정렬 */
	td {
		vertical-align: middle !important;
	}
	
</style>
</head>
<body>
	<%--네비게이션 바 영역 --%>
	<header id="pageHeader"><%@ include
			file="../inc/header.jsp"%></header>

	<article id="mainArticle">
		<%--본문내용 --%>
		<div class="container w-900">
			<div>
				<h2>등급별 혜택</h2>
				<table class="table">
					<tr>
						<th><img class="gradeImg" src="${pageContext.request.contextPath }/resources/img/grade_bronze.png" id="myPage_nowGrade">브론즈</th>
						<td>
							혜택 : 영화 결제금액 <span class="sale">1%</span> 할인 <br>
						</td>
					</tr>
					<tr>
						<th><img class="gradeImg" src="${pageContext.request.contextPath }/resources/img/grade_silver.png" id="myPage_nowGrade">실버</th>
						<td>
							혜택 : 영화 결제금액 <span class="sale">3%</span> 할인 <br>
							선정 기준 및 유지 기준 : 1년간 누적 금액 100,000 원 달성 시 다음해 승급
							
						</td>
					</tr>
					<tr>
						<th><img class="gradeImg" src="${pageContext.request.contextPath }/resources/img/grade_gold.png" id="myPage_nowGrade">골드</th>
						<td>
							혜택 : 영화 결제금액 <span class="sale">5%</span> 할인 <br>
							선정 기준 및 유지 기준 : 1년간 누적 금액 500,000 원 달성 시 다음해 승급
						</td>
					</tr>
					<tr>
						<th><img class="gradeImg" src="${pageContext.request.contextPath }/resources/img/grade_platinum.png" id="myPage_nowGrade">플래티넘</th>
						<td>
							혜택 : 영화 결제금액 <span class="sale">10%</span> 할인 <br>
							선정 기준 및 유지 기준 : 1년간 누적 금액 1,000,000 원 달성 시 다음해 승급
						</td>
					</tr>
					<tr>
						<td></td>
						<td></td>
					</tr>
				</table>
			</div>
			
			<div class="part">
			<%-- cgv 참조 --%>
			<h5>멤버십 등급 반영 기준</h5>
			<ul>
				<li>동백씨네마 매표에서 구매하신 금액 기준 및 이벤트 보상이 합산되어 반영됩니다.</li>
				<li>구매 시, 고객정보가 반영된 내역으로 집계됩니다.</li>
				<li>최근 1년 실적을 매년 누적 집계합니다.</li>
				<li>멤버십 점수 반영률과 멤버십 승급 기준 및 혜택은 당사 사정에 따라 변경될 수 있습니다.</li>
			</ul>
		</div>
		</div>

	</article>


<!-- bronze -->
<!-- <a href="https://www.flaticon.com/free-icons/laurel-wreath" title="laurel-wreath icons">Laurel-wreath icons created by Flat Icons - Flaticon</a> -->
<!-- silver -->
<!-- <a href="https://www.flaticon.com/free-icons/silver-medal" title="silver medal icons">Silver medal icons created by KSan Wapiti - Flaticon</a> -->
<!-- gold -->
<!-- <a href="https://www.flaticon.com/free-icons/gold-medal" title="gold medal icons">Gold medal icons created by KSan Wapiti - Flaticon</a> -->
<!-- platinum -->
<!-- <div> Icons made by <a href="https://www.flaticon.com/authors/ksan-wapiti" title="KSan Wapiti"> KSan Wapiti </a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com'</a></div> -->

	<%-- 메인화면에서 멤버십 클릭하여 진입 시 왼쪽 사이드바 불필요 -> 삭제 --%>
<%-- 
	<nav id="mainNav" class="d-none d-md-block sidebar">
		<%--왼쪽 사이드바 --%>
		<%-- 
		<!-- 	왼쪽 탭 링크들 -->
		<ul class="left-tap">
			<li class="myPage-ticketing-buy"><a class="nav-link" href="myPage_reservation_buy_history">예매
					/ 구매내역</a></li>
			<li class="myPage-review"><a class="nav-link" href="myPage_myReview">나의 리뷰</a></li>
			<li class="myPage-moviefourcut"><a class="nav-link" href="myPage_moviefourcut">영화네컷</a></li>
			<li class="myPage-quest"><a class="nav-link" href="myPage_inquiry">문의 내역</a></li>
			<li class="myPage-grade"><a class="nav-link" href="grade/grade">등급별 혜택</a></li>
			<li class="myPage-privacy"><a class="nav-link" href="myPage_modify_check">개인정보수정</a></li>
		</ul>
	</nav>
	--%>

	<div id="siteAds"></div>
	<%--페이지 하단 --%>
	<footer id="pageFooter"><%@ include
			file="../inc/footer.jsp"%></footer>
</body>