<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<title>영화 예매 사이트</title>
<style>

article {
	justify-content: center;
		align-items: center;
		margin: 2em auto;
}
	.container-top{
		margin: 3rem;
	}
	aside{
		margin: 10px;
		background-color: #d5b59c;
	}
	
	/* 예매 선택 구간 */
	/* 크기 조절 */
	.container-fluid{
		width: 1200px;
		padding-left: 2rem;
		border: 2px solid #aaa;
	/* 	background-color: #d5b59c; */
	}
	div{
		background-color: transparent;
	}
	.container-fluid h5{
		text-align: center;
		font-weight: bold;
	}
	/* 각 파트 구별을 위한 색상 조절, 여백 */
	.row1>div{
		height: 300px;
		margin: 0.5rem;
		padding: 10px;
		background-color: white;
	}
	/* 페이지 이름 잘보이게 설정 */
	#mainArticle>h2{
		font-weight: bold;
		padding-left: 1rem;
	}
	
	/* 선택사항 안내 구간 */
	/* 위 파트와 구별을 위한 색상 부여 */
	.row2{
		padding-top: 0.5rem;
		height: 150px;
		background-color: #aaa;
	}
	
	.row1>div{
		border: 1px solid #aaa;
	}
	/* 영화 목록에 앞의 모양 제거 */
	#selectMovie ul {
		list-style: none;
		padding-left: 0;
	}
	/* 극장 파트 좌우 배치 */
	#region{
	/* 	border: 1px solid #000; */
		width: 130px;
		display: inline-block;
		vertical-align: top;
		padding-top: 1.5rem;
	}
	#room{
		vertical-align: top;
	/* 	border: 1px solid #000; */
		width: 300px;
		display: inline-block;
		padding-top: 1.5rem;
		
	}
	#playType{
		text-align: right;
	}
	.col-3 {
		padding-top: 1.5rem;
	}
	.col-4 {
		padding-top: 1rem;
		padding-left: 3rem;
		align-content: center;
	}
	.col-4 > button {
		margin-top: 2rem;
		padding: 1rem;
		padding-left: 1.5rem;
		padding-right: 1.5rem;
	}
</style>
<script type="text/javascript">
	
// 	$(function() {
// 		$(".nav-link").on("click", function() {
// 			$(".nav-link").removeClass("active");
// 			$(this).addClass("active");
// 		})
// 	})
	
</script>
</head>
<body>
 <%--네비게이션 바 영역 --%>
 <header id="pageHeader"><%@ include file="../inc/header.jsp"%></header>
 
  <article id="mainArticle">
  <%--본문내용 --%>
		<div class="container-fluid reservation_con" >
			<h2 align="center">${member.member_name} 회원님! 예매가 완료되었습니다.</h2>
			<div class="col col1">
	            <div class="row row1">
	            	<%-- 예매 진행 중인 영화 포스터 파트  --%>
	                <div class="col-3" align="center">
	                	<img src="${reservation.movie_poster }" width="200" height="285">
	                </div>
	                
	                <%-- 예매 진행 중인 예매 정보 출력 파트 --%>
	                <div class="col-4.5">
		                <%-- 테두리가 없는 테이블 --%>
		                <%-- 예매 진행 중인 구체적인 내용 출력 --%>
					 	<table id="region" class="table table-borderless">
					 		<thead>
					 		<tr>
					 			<th scope="col" colspan="2">예매 정보</th>
					 		</tr>
					 		</thead>
					 		<tbody>
					 		<tr><td>영화 제목</td></tr>
					 		<tr><td>극장과 상영관</td></tr>
					 		<tr><td>날짜와 시간</td></tr>
					 		<tr><td>좌석 정보</td></tr>
					 		</tbody>
					 	</table>
					 	<%-- 아래의 테이블은 데이터를 전달받아 출력 --%>
					 	<table id="room" class="table table-borderless">
					 		<thead>
					 		<tr>
					 			<th scope="col" width="300px">&nbsp;</th>
					 		</tr>
					 		</thead>
					 		<tbody>
					 		<tr><td>${reservation.movie_name_kr }</td></tr>
					 		<tr><td>${reservation.theater_name } ${reservation. room_name }</td></tr>
					 		<tr><td>${reservation.play_date} ${reservation.play_start_time }</td></tr>
					 		<tr><td>${param.seat_name }</td></tr>
					 		</tbody>
					 	</table>
	                </div>
	                
					<%-- 결제할 금액을 명시하는 파트 --%>
	                 <c:if test="${snackNumlist ne null}">
	                <div class="col-3" align="center">
				  		<img src="${pageContext.request.contextPath }/resources/img/${snackNumlist[0].snack_img }" height="100px" width="100px">
					
					<%-- 선택한 스낵의 정보 --%>
		                
		                	<table id="snackregion" class="table table-borderless">
						 		<tr>
						 			<th scope="col" colspan="2"><b>스낵 정보</b></th>
						 		</tr>
						 		<tr>
						 		<td>
						 		<c:forEach var="snack" items="${snackNumlist}" varStatus="status" >
						 		 	${snack.snack_name}
									 ${snack.snack_price}x${snackquantitylist[status.index]}<br>
									
						 		 </c:forEach>
						 		 
						 		</td>
						 		</tr>
						 		
						 	</table>
		                </div>
	                </c:if>
	            
	            </div>
	            
	             <div class="row row2">
	             	
	             	<div class="col-3">
	             		<h4>총 결제 금액</h4>
	             		<table id="paymentcheck" class="table table-borderless">
	             			<tr>
	             				<th>&nbsp;</th>
	             				<th><button type="button" class="btn btn-danger btn-lg">${param.payment_total_price }원</button></th>
	             			</tr>
	             		</table>
	             	</div>
	                <%-- 돌아가기, 결제하기 버틈 --%>
	                <div class="col-4">
			  			<button class="btn btn-danger" id="nextBtn" onclick="location.replace('myPage')"> 확인 </button>
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