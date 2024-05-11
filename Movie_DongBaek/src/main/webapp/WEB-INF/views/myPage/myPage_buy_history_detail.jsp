<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmf" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<%-- 아임포트 --%>
<script type="text/javascript" src ="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/myPage.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/button.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/sidebar_myPage.css" rel="stylesheet" type="text/css">
<!-- Sweet Alert 플러그인 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<link rel="stylesheet"href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
<title>영화 예매 사이트</title>
<style>

	/* a링크 활성화 색상 변경 */
	a:hover, a:active{
	 color:  #ff5050 !important;
		
	}
	/* 표 중간배치 */
	.w-900 {
		margin: 0 auto;
	}
	
	.table {
		width: 800px;
	}
	
	#nothing {
		color: gray;
		font-size: 0.8em;
	}
	
	.row>button{
		margin-left: 10px;
	}
	
</style>
<script type="text/javascript">
	
	$(function() {
		$("#cancleCk").hide();	// 나중에 풀기
		// 받아온 파라미터 play_change에 '취소가능'이 있으면 결제취소버튼 생성
		if($("#play_change").val() === '취소가능') {
			$("#cancleCk").show();
		}
	}); // function() 끝
	
	// ========== 취소 환불 요청하기 ===================
	function cancelPay() {
		let payment_num = $("#payment_num").val();
		let order_num = $("#order_num").val();
		let payment_total_price = $("#payment_total_price").val();
		console.log("payment_num : " + payment_num);
		console.log("order_num : " + order_num);
	   	
		$.ajax({
	      // 예: http://www.myservice.com/payments/cancel
	      url: "payCancel", // {환불정보를 수신할 가맹점 서비스 URL}
	      type: "POST",
	      
	      data: {
	    	'order_num': order_num, 	// 생략가능
	    	'payment_num': payment_num, // "{결제건의 주문번호}" 예: ORD20180131-0000011
	    	'payment_total_price': payment_total_price, // 2000, 환불금액
	        'reason': "테스트 결제 환불" // 환불사유
     		 },
	      success: function(data) {
// 			console.log("가져오기 성공");
	    	  
	    	  // 환불 완료 swal창으로 안내
	    	  swal({
	    		  title: "환불 성공!",
	    		  text: "예매가 성공적으로 취소되었습니다.",
	    		  icon: "success",
	    		  button: "확인"}, function() {
						// 환불 완료 후 전 화면으로 이동
						location.href = "myPage";
					});
	      },
	      error: function(xhr, status, error) {
	    	  swal("환불 실패!" + error);
	      }
	    });
	    
  }	// cancelPay() 끝
	
	
</script>
</head>
<body>
 <%--네비게이션 바 영역 --%>
 <header id="pageHeader"><%@ include file="../inc/header.jsp"%></header>
 
  <article id="mainArticle">
  <input type="hidden" id="play_change" value="${play_change}">
  <input type="hidden" id="payment_num" value="${myPaymentDetailList[0].payment_num}">
  <input type="hidden" id="order_num" value="${myPaymentDetailList[0].order_num}">
  <%--본문내용 --%>
  	<div class="container container-fluid w-900">
  		<div class="mainTop">
			<h2>나의 구매 내역</h2>
			<br>
				<%-- 상세보기 테이블 --%>
		  	<div class="row">
				<table class="table table-bordered text-center">
				    <tr>
				      <th>주문자명</th>
				      <td>${myPaymentDetailList[0].payment_name}</td> 
				    </tr>
				    <tr>
				    	<th>예매 내역</th>
				    	<td>
						    <c:forEach var="ticket" items="${myTicket }">
								&lt; ${ticket.movie_name_kr} &gt; :
								${ticket.ticket_type}
								${ticket.ticket_quantity } 개
								<br>
						    </c:forEach>
			      		</td> 
				    </tr>
							    <tr>
							    	<th>주문 내역</th>
							    		<td>
							    			<c:choose>
									    		<c:when test="${empty mySnack}">
									    			<span id="nothing">스토어 주문내역 없음</span>
									    		</c:when>
									    		<c:otherwise>
					    							<c:forEach var="snack" items="${mySnack }" varStatus="i">
					    								<c:if test="${i.index ne 0 }"> / </c:if>
														${snack.snack_name}
														${snack.snack_quantity}개 
					    							</c:forEach>
									    		</c:otherwise>
							    			</c:choose>
						      			</td> 
							    </tr>
				    <tr>
				      <th>결제일</th>
				      <td>
				      	<fmf:formatDate value="${myPaymentDetailList[0].payment_datetime}" pattern="yyyy년 MM월 dd일 HH:mm"/>
				      </td>
				    </tr>
					<tr>
				      <th>결제수단</th> <%-- 우리는 카드 --%>
				      <td>
				      ${myPaymentDetailList[0].payment_card_name } / ${myPaymentDetailList[0].payment_card_num }
				      </td> <%-- 카드회사명 --%>
					</tr>
				     <tr>
				     	<th>총결제 금액</th>
				     	<td>
				     		<fmf:formatNumber value="${myPaymentDetailList[0].payment_total_price}" pattern="#,###,###" />
				     		<input type="hidden" id="payment_total_price" value="${myPaymentDetailList[0].payment_total_price}">
				     	</td> <%-- 결제기능 구현시 최종금액 DB로 저장되니 가져오기만하면될듯? --%>
				     </tr>
				     <tr>
				     	<th>결제 상태</th>
				     	<td>${myPaymentDetailList[0].payment_status }</td>
				     </tr>
				</table>
			</div>
			
			<%-- 버튼 --%>
			<div class="row d-flex justify-content-center">
				<%-- 결제취소버튼 --%>
				<button class="btn btn-red" type="button" id="cancleCk" data-toggle="modal" data-target="#cancleCheck">결제취소</button>
<!-- 				<button class="btn btn-outline-red" type="button" id="cancleCk" >결제취소</button> -->
				<button class="btn btn-secondary" type="button" onclick="history.back()">뒤로가기</button>
			</div>
  		</div>
	</div>
  </article>
  
  <%-- 모달 영역 --%>
	<div class="modal fade" id="cancleCheck" tabindex="-1" role="dialog" aria-labelledby="checkTitle" aria-hidden="true">
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
	      정말 결제를 취소하시겠습니까? <br>
	      결제 취소 즉시 좌석 예매가 취소됩니다.
	      </div>
	      <div class="modal-footer justify-content-center">
	        <button class="btn btn-outline-red" type="button" id="cancleCk" onclick="cancelPay()">결제취소</button>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">아니오</button>
	      </div>
	    </div>
	  </div>
	</div>
	
  
  	<nav id="mainNav" class="d-none d-md-block sidebar">
		<%--왼쪽 사이드바 --%>
  		<%@ include file="/WEB-INF/views/sidebar/sideBar_myPage.jsp"%>
  	</nav>
  
  
  <div id="siteAds"></div>
  <%--페이지 하단 --%>
  <footer id="pageFooter"><%@ include file="../inc/footer.jsp"%></footer>
</body>