<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!doctype html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<title>영화 예매 사이트</title>
<style>
	.container-top{
		margin: 3rem;
	}
	aside{
		margin: 10px;
		background-color: #d5b59c;
	}
	.card{
    position: relative;
    display: block;
    height: 435px;
    text-decoration: none;
    border:3px solid #e4e4e4;
    border-radius: 10px;
  }
	
	/* 예매 선택 구간 */
	/* 크기 조절 */
	.container-fluid{
		width: 1200px;
		margin: 1rem;
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
		height: 230px;
		background-color: #aaa;
	}

	.row1>div{
		height: 450px;
		margin: 0.5rem;
		padding: 10px;
/* 		background-color: white; */
		border: 2px solid #aaa;
	}
	.card-text>input{
		width: 80px;
		height: 30px;
	}
	.right_side{
		text-align: right;
	}
	.bottom{
		text-align: center;
		bottom: 1rem;
		position: absolute;
	}
</style>
<script type="text/javascript">
$(function(){
 	//스낵 담기
	let ticketprice=Number($("#totalview").html());
	$(document).on("click", "#addsnack", function(){
		
		let totalprice=0;
		let snacknum=$(this).val();
 		let quantity=Number(($("#quantity"+snacknum).val()));
		let snackprice=Number(($("#snackprice"+snacknum).val()));
		if(Number.isInteger(quantity)==false){
			
			$(".snackquantity").val(1);
		}else if(quantity<=0){
			
			$(".snackquantity").val(1);
		}else if(quantity>100){
			alert("100개를 초과해서 구매할 수 없습니다.");
			$(".snackquantity").val(1);
		}else{
		$("#snackquantity"+snacknum).html(quantity);
		$("#quantityview"+snacknum).html(quantity);
		$("#snackpriceview"+snacknum).html(quantity*snackprice);
		
		//총가격
		for (var i = 1; i < ${fn:length(snackList)}+1; i++) { 
			totalprice+=Number($("#snackpriceview"+i).html());
			}
		
		$("#totalprice").html(totalprice);
		$("#totalview").html(ticketprice+totalprice);
		
		$("#snackCart"+snacknum).css("display", "");
		$("#snackview"+snacknum).css("display", "");
		}

		
	});
	//다시 선택하기
	$(document).on("click", "#snackreset", function(){
		$("#totalprice").html(0);
		for (var i = 1; i < ${fn:length(snackList)}+1; i++) { 
			$("#snackpriceview"+i).html(0);
			$("#snackquantity"+i).html(0);
			$("#quantityview"+i).html(0);
			$("#snackCart"+i).css("display", "none");
			$("#snackview"+i).css("display", "none");
			}
		$(".snackquantity").val(1);
		$(".quantityview").val(1);
		
		$("#totalview").html(ticketprice);
	
	});
	
	//카트 X
	$(document).on("click", "#snackcancel", function(){
		let snacknum=$(this).val();
		let totalprice=$("#totalprice").html();
 		let snackview=Number($("#snackpriceview"+snacknum).html());
 		$("#totalprice").html(totalprice-snackview);
		$("#snackpriceview"+snacknum).html(0);
		$("#snackquantity"+snacknum).html(0);
		$("#quantityview"+snacknum).html(0);
		$("#snackCart"+snacknum).css("display", "none");
		$("#snackview"+snacknum).css("display", "none");
		
		$("#totalview").html(ticketprice+Number($("#totalprice").html()));
	});
});	
function reservation_ing(){
	let arr=[];
	let arr2=[];
	for (var i = 1; i < ${fn:length(snackList)}+1; i++) { 
		if(Number.isInteger(Number($("#snackquantity"+i).html()))==false){
			alert("잘못된시도")
		
		}else if($("#snackquantity"+i).html()<0){
			alert("잘못된시도")
		}else if($("#snackquantity"+i).html()>100){
			alert("잘못된시도")
		}
		else if($("#snackquantity"+i).html()>0 && $("#snackquantity"+i).html()<=100){
			arr.push([i]);
			arr2.push([$("#snackquantity"+i).html()]);
		}
		
	}
	location.href='reservation_ing?play_num=${reservation.play_num}&seat_name=${param.seat_name}&ticket_type_num=${param.ticket_type_num}&snack_num='+arr+'&snack_quantity='+arr2
}


</script>
</head>
<body>
 <%--네비게이션 바 영역 --%>
 <header id="pageHeader"><%@ include file="../inc/header.jsp"%></header>
 
  <article id="mainArticle">
  <%--본문내용 --%>
	 <h2>영화 예매</h2>
		<div class="container-fluid reservation_con" >
	           <div class="row row1">
	           	<%-- 스낵 권유 파트 --%>
	               <div class="col-8" id="seat-part">
	               	<h5>스낵이 필요하지는 않으신가요?</h5>
	               		<div class="row row-cols-1 row-cols-md-3" style="width: 45rem;">
	               		<c:forEach var="snack" items="${snackList}">
						<div class="col mb-4">
						    <div class="card h-100">
						      <img src="${pageContext.request.contextPath }/resources/img/${snack.snack_img}" width="80" height="130" class="card-img-top" alt="...">
						      <div class="card-body">
						        <h5 class="card-title">${snack.snack_name}</h5>
						        	${snack.snack_price}원
						        <p class="card-text">
						        	<input type="number" class="snackquantity" id="quantity${snack.snack_num}"value=1>
						        	<button type="button" class="btn btn-outline-danger" value="${snack.snack_num}" id="addsnack" >담기</button><br>
						        	${snack.snack_txt}<br>
						        </p>
						      </div>
						    </div>
						  </div>
						  </c:forEach>
	               			
<!-- 	               			<div class="col mb-4"> -->
<!-- 						    <div class="card h-100"> -->
<!-- 						      <img src="/resources/img/popcorn.png" width="80" height="130" class="card-img-top" alt="..."> -->
<!-- 						      <div class="card-body"> -->
<!-- 						        <h5 class="card-title">상품명</h5> -->
<!-- 						        	10,000원 -->
<!-- 						        <p class="card-text"> -->
<!-- 						        	<input type="number"> -->
<!-- 						        	<button type="button" class="btn btn-outline-danger">담기</button><br> -->
<!-- 						        	한 줄 설명(고소팝콘 M1 + 콜라2)<br> -->
<!-- 						        </p> -->
<!-- 						      </div> -->
<!-- 						    </div> -->
<!-- 						  </div> -->
	               			
	               		</div>
	               		
	               		
					
	               </div>
	               
	               <%-- 주문 정보 확인 파트 --%>
	               <div class="col-md-3">
	                <h5>주문 정보</h5>
	                <hr>
	                <%-- (상품 담기 시 입력되는 창) --%>
	                <c:forEach var="snack" items="${snackList}" >
	                <table border="1" id="snackCart${snack.snack_num}"style="display:none; width:200px;">
	                	<tr>
	                		
	                		<td width="150px">${snack.snack_name} x <span id="snackquantity${snack.snack_num}">0</span> </td>
	                	</tr>
	                	<tr>
	                		<td colspan="2" class="right_side">
	                	
	                	<input type="hidden" id="snackprice${snack.snack_num}" value="${snack.snack_price}">
             	
	                			<span id="snackpriceview${snack.snack_num}" >0</span><span>원</span> <button class="btn btn-secondary" value="${snack.snack_num}"  id="snackcancel">x</button>
	                		</td>
	                	</tr>
	                </table>
	                
	                </c:forEach>
	                
	               
	                
	                <div class="bottom">
	                	<hr>
		                	스낵 총 금액 :(<span id="totalprice" >0</span>)원
		                <button class="btn btn-secondary" id="snackreset"><img src="${pageContext.request.contextPath }/resources/img/reset.png" width="20px"> 다시 선택하기</button>
	                </div>
	               </div>
	           </div>
	           
	           <%-- 선택사항 안내 구간, 다음으로 넘어가기 --%>
	           <div class="row row2">
	           <div class="col-1 p-2">
				<button class="btn btn-secondary" onclick="history.back()"> &lt; 이전</button>
			</div>
	           	<%-- 선택한 영화 포스터와 영화명 노출 --%>
	               <div class="col-3.5">
					<h5>선택 정보</h5>
			  		<img src="${reservation.movie_poster }" alt="선택영화포스터" height="120px" >
			  		<span>${reservation.movie_name_kr }</span><br>
				</div>
				<%-- 선택한 상영스케줄 노출 --%>
	               <div class="col-2">
	               <br>
	               	<table> <%-- 선택요소들이 ()안에 들어가게 하기 (인원은 x) --%>
			  			<tr><td>극장 ${reservation.theater_name }</td></tr>
			  			<tr><td>일시 ${reservation.play_date} ${reservation.play_start_time }</td></tr>
			  			<tr><td>상영관 ${reservation. room_name }</td></tr>
			  		</table>
	               </div>
	               <%-- 미선택 사항 노출 --%>
	               <div class="col-2.5">
	               	<h5>좌석 선택</h5>
	               	<table> <%-- 선택요소들이 ()안에 들어가게 하기 (인원은 x) --%>
<!-- 			  			<tr><td>좌석명 (일반석)</td></tr> -->
			  			<tr><td>좌석번호<br> (${param.seat_name })</td></tr>
			  		</table>
	               </div>
	               <%-- 미선택 사항(결제) 노출 --%>
	               <div class="col-3">
	               	<h5>결제</h5>
	               	<%-- 선택요소들이 ()안에 들어가게 하기 (인원은 x) --%>
	               	<c:set var = "total" value = "0" />
	               	<c:set var = "count" value = "1" />
					  <c:forEach var="ticket" items="${ticketPriceList}" varStatus="status" >
					  	<c:choose>
							<c:when test="${status.index eq 0 }" >
							  ${ticket.ticket_user_type}
							  ${ticket.ticket_type_price}
							  <c:if test="${status.last eq true }">
								X${count}
								</c:if>
					  		</c:when>
							<c:when test="${status.index ne 0 }" >
								<c:if test="${ticketPriceList[status.index-1].ticket_user_type eq ticket.ticket_user_type }">
								
							    <c:set var = "count" value = "${count + 1}"/>
								</c:if>
								<c:if test="${ticketPriceList[status.index-1].ticket_user_type ne ticket.ticket_user_type }">
								X${count}<br>
								<c:set var = "count" value = "1"/>
								 ${ticket.ticket_user_type}
							  	${ticket.ticket_type_price}
								</c:if>
								<c:if test="${status.last eq true }">
								X${count}
								</c:if>
							</c:when>
						</c:choose>
					  <c:set var= "total" value="${total + ticket.ticket_type_price}"/>
					  </c:forEach>
			  			
			  			<div style="list-style-type: none;">

		                 	<c:forEach var="snack" items="${snackList}" >
		               		<div id="snackview${snack.snack_num}" style="display:none">${snack.snack_name}  ${snack.snack_price}X<span id="quantityview${snack.snack_num}">0</span></div>
		               		
		               		</c:forEach>
	               		</div>
	               		
			  			<b>총금액(<span id=totalview>${total}</span>)</b>
			  		
	               </div>
	               <%-- 다음 페이지 이동 버튼 --%>
	               <div class="col-0.5">
		  			<button class="btn btn-danger" id="nextBtn" onclick="reservation_ing()"> next ></button>
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