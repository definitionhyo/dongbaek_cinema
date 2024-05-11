<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<head>
<%-- 결제취소 구현위해 mypage_buy-history_detail가져옴 --%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
	integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
	crossorigin="anonymous"></script>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<%-- 아임포트 --%>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
	integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
<%-- 결제취소 구현위해 mypage_buy-history_detail가져옴 - 여기까지 --%>
<!-- <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script> -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js"
	integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
	crossorigin="anonymous"></script>
<link
	href="${pageContext.request.contextPath }/resources/css/default.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath }/resources/css/sidebar.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath }/resources/css/button.css"
	rel="stylesheet" type="text/css">
<title>결제내역 상세페이지</title>
<style>

/* a링크 활성화 색상 변경 */
a:hover, a:active {
	color: #ff5050 !important;
}

.w-900 {
	width: 900px;
	margin: 0 auto;
}

.h-500 {
	height: 500px;
}

div {
	background-color: transparent;
}

article {
	justify-content: center;
	align-items: center;
	margin: 2em auto;
}
</style>

<script type="text/javascript">
	$(function() {
		$("#cancleCk").hide(); // 나중에 풀기
		// 받아온 파라미터 play_change에 '취소가능'이 있으면 결제취소버튼 생성
		if ($("#play_change").val() === '취소가능') {
			$("#cancelCk").show();
		}
	}); // function() 끝

	// ========== 취소 환불 요청하기 ===================
	function cancelPay() {
		let payment_num = $("#payment_num").val();
		let order_num = $("#order_num").val();
		let payment_total_price = $("#payment_total_price").val();
		console.log("payment_num : " + payment_num);

		$.ajax({
			// 예: http://www.myservice.com/payments/cancel
			url : "payCancel", // {환불정보를 수신할 가맹점 서비스 URL}
			type : "POST",

			data : {
				'order_num' : order_num, // 생략가능
				'payment_num' : payment_num, // "{결제건의 주문번호}" 예: ORD20180131-0000011
				'payment_total_price' : payment_total_price, // 2000, 환불금액
				'reason' : "테스트 결제 환불" // 환불사유
			},
			success : function(data) {
				// 			console.log("가져오기 성공");

				// 환불 완료 swal창으로 안내
				swal({
					title : "환불 성공!",
					text : "예매가 성공적으로 취소되었습니다.",
					icon : "success",
					button : "확인"
				}, function() {
					// 환불 완료 후 전 화면으로 이동
					location.href = "admin_payment_list";
				});
			},
			error : function(xhr, status, error) {
				swal("환불 실패!" + error);
			}
		});

	} // cancelPay() 끝
</script>

</head>
<body>
	<%--네비게이션 바 영역 --%>
	<header id="pageHeader"><%@ include file="../inc/header.jsp"%></header>
	
	<!-- 결제번호 값을 input 태그에 추가 -->
	<input type="hidden" id="payment_num" value="${param.payment_num}">

	<%--본문내용 --%>
	<article id="mainArticle">
		<div class="container-fluid w-900 justify-content-center">
			<div class="row">
				<div class="col-md-12 mt-3">
					<h3>결제내역 상세보기</h3>
				</div>
			</div>


			<%-- 상세보기 테이블 --%>
			<div class="row">
				<div class="col-md-12">
					<table class="table table-bordered text-center">

						<c:set var="headcount" value="0" />
						<c:set var="seat_names" value="" />
						<c:set var="snack_names" value="" />
						<c:set var="dong_baek_combo_count" value="0" />
						<c:set var="chul_juk_combo_count" value="0" />
						
						<c:forEach var="paymentDetail" items="${paymentDetail}">
						    <c:set var="headcount"
						           value="${headcount + paymentDetail.headcount}" />
						    <c:set var="seat_names" value="${paymentDetail.seat_names}" />
							<c:set var="snack_names" value="" />
						    <c:set var="dong_baek_combo_count"
						           value="${dong_baek_combo_count + paymentDetail.dong_baek_combo_count}" />
						    <c:set var="chul_juk_combo_count"
						           value="${chul_juk_combo_count + paymentDetail.chul_juk_combo_count}" />
						</c:forEach>

						<c:set var="last_paymentDetail"
							   value="${paymentDetail[fn:length(paymentDetail) - 1]}" />

						<tr>
							<th>결제번호</th>
							<td>${last_paymentDetail.payment_num}</td>
						</tr>
						<tr>
							<th>주문자명</th>
							<td>${last_paymentDetail.member_name}</td>
						</tr>
						<tr>
							<th>결제일</th>
							<td>${last_paymentDetail.payment_datetime}</td>
						</tr>
						<tr>
							<th>영화명</th>
							<td>${last_paymentDetail.movie_name_kr}</td>
						</tr>
						<tr>
							<th>극장명</th>
							<td>${last_paymentDetail.theater_name}</td>
						</tr>
						<tr>
							<th>인원수</th>
							<td>${headcount}</td>
						<tr>
						<tr>
						<th>좌석번호</th>
						<td>${seat_names}</td>
						</tr>
						<tr>
						<th>주문한 스낵</th>
						<td>
							<c:choose>
								<c:when test="${last_paymentDetail.dong_baek_combo_count == 0 && last_paymentDetail.chul_juk_combo_count == 0}">없음</c:when>
								<c:otherwise>
									<c:if test="${last_paymentDetail.dong_baek_combo_count > 0}">동백콤보 ${last_paymentDetail.dong_baek_combo_count}개</c:if>
									<c:if test="${last_paymentDetail.dong_baek_combo_count > 0 && last_paymentDetail.chul_juk_combo_count > 0}">, </c:if>
									<c:if test="${last_paymentDetail.chul_juk_combo_count > 0}">철쭉콤보 ${last_paymentDetail.chul_juk_combo_count}개</c:if>
								</c:otherwise>
							</c:choose>
						</td>
						</tr>
						<tr>
							<th>결제방법</th>
							<td>${last_paymentDetail.payment_card_name}</td>
						</tr>
						<tr>
							<th>총결제 금액</th>
							<td>${last_paymentDetail.payment_total_price}</td>
						</tr>
					</table>
				</div>
			</div>

			<%-- 버튼 --%>
			<div class="row d-flex justify-content-center mt-3">
				<div class="col-3">
					<c:choose>
						<c:when test="${last_paymentDetail.payment_status eq '결제취소'}">
							<button class="w-100 btn btn-outline-red mb-3" 
									type="button"
									id="cancelCk" 
									data-toggle="modal" 
									disabled>결제취소</button>
						</c:when>
						<c:otherwise>
							<button class="w-100 btn btn-outline-red mb-3" 
									type="button"
									id="cancelCk" 
									data-toggle="modal" 
									data-target="#cancelCheck">결제취소</button>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="col-3">
					<button class="w-100 btn btn-outline-red mb-3" 
							type="button"
							onclick="window.history.back();">뒤로가기</button>
				</div>
			</div>
		</div>

		<%-- '결제취소' 모달 --%>
		<div class="modal fade" id="cancelCheck" tabindex="-1" role="dialog" aria-labelledby="checkTitle" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="checkTitle">결제취소</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body text-center" id="modalMsg">
						<%-- 메세지가 표시되는 부분 --%>
						정말 결제를 취소하시겠습니까? <br> 결제 취소 즉시 좌석 예매가 취소됩니다.
					</div>
					<div class="modal-footer justify-content-center">
						<button class="btn btn-outline-red" 
								type="button" 
								id="cancelCk"
								onclick="cancelPay()">예</button>
						<button type="button" 
								class="btn btn-secondary"
								data-dismiss="modal">아니오</button>
					</div>
				</div>
			</div>
		</div>
		<%-- 본문 테이블 끝 --%>

	</article>

	<%--왼쪽 사이드바 --%>
	<nav id="mainNav" class="d-none d-md-block sidebar">
		<%@ include file="../sidebar/sideBar.jsp"%>
	</nav>


	<%--페이지 하단 --%>
	<div id="siteAds"></div>
	<footer id="pageFooter">
		<%@ include file="../inc/footer.jsp"%>
	</footer>
</body>