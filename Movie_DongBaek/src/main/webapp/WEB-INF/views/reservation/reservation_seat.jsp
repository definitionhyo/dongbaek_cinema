<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<!doctype html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/reservation.css" rel="stylesheet" type="text/css">
<title>영화 예매 사이트</title>
<style> 
	.container-top{
      margin: 3rem;
   }
   aside{
      margin: 10px;
      background-color: #d5b59c;
   }
   
      /* 선택사항 안내 구간 */
   /* 위 파트와 구별을 위한 색상 부여 */

  
   .border {
      border: 3px solid #aaa;
   }
   
   #beforeBtnArea{
      position: absolute;
      bottom: 5px;
      text-align: left;
   }
   #personType>input{
      width: 50px;
      height: 25px;
   }
   
   .vertical-center {
      vertical-align: middle;
   }
   
 
    .seat {
      display: inline-block;
/*       width: 50px; */
/*       height: 50px; */
      margin: 5px;
      background-color: #e0e0e0;
      text-align: center;
/*       line-height: 50px; */
      cursor: pointer;
    }
  
/*     .selected { */
/*       background-color: #42b983; */
/*     } */
    
</style>
<script type="text/javascript">
	
	let seatList = [];
	let seatListForParam = [];
	let ticketTypeNum = [];
	
	$(function(){   // 페이지 로딩 시 좌석 출력
		let res = "";
		res += "<div id='seatMap'>";
		let row = ["A", "B", "C", "D", "E", "F"];
		for(let i = 0; i < 6; i++){
			for(let j = 1; j <= 10; j++){
				res += "<button id="+ row[i] + j +" class='seat' data-seat-num=" + (i * 10 + j) + " data-seat-name=" + row[i] + j + ">" + row[i] + j + "</button>";            
			}
			
			res += "<br>";
		}
		res += "</div>";
		$("#seat-part .seatArea").html(res);
		
		// 휠체어석 표시
		$("#seat-part .seatArea #A1").addClass("handiSeat");
		$("#seat-part .seatArea #A2").addClass("handiSeat");
		
		
		// 휠체어석을 선택할 경우 
		// "현장문의" alert 후 seat 선택하지 못하도록 disabled 클래스 추가
		$("#seat-part .seatArea #A1").on("mousedown", function() {
			$("#seat-part .seatArea #A1").addClass("disabled");
			
			alert("휠체어석입니다. \n현장에서 문의해 주세요");			
			let selectedSeatName = $("#seat-part .seatArea #A1").attr("data-seat-name");
			const index = seatList.indexOf(selectedSeatName);
			if (index > -1) {
				seatList.splice(index, 1);
			}
			
		});
		
		$("#seat-part .seatArea #A2").on("mousedown", function() {
			$("#seat-part .seatArea #A2").addClass("disabled");
			
			alert("휠체어석입니다. \n현장에서 문의해 주세요");			
			let selectedSeatName = $("#seat-part .seatArea #A2").attr("data-seat-name");
			const index = seatList.indexOf(selectedSeatName);
			if (index > -1) {
				seatList.splice(index, 1);
			}
		});
		
		
		// 인원별 티켓 가격을 계산하기 위해
		// 상영시간(play_time_type)에 해당하는 티켓의 정보(ticket_type)을 TICKET_TYPES 테이블에서 가져오기
		let playTimeType = $("#dateInfo span").eq(2).attr("data-play-time-type");
		
		$.ajax({
			type : "post", 
			url : "GetTicketPrice", 
			data : {"play_time_type" : playTimeType},
			dataType : "json", 
		})
		.done(function(ticketPrice) {
			for(let i = 0; i < ticketPrice.length; i++){
				let ticketUserType = ticketPrice[i].ticket_user_type;
				let res = "";
				
				if(ticketUserType == "일반"){
					$("#selectPeople #adult button.result").attr("data-ticket-type-num", ticketPrice[i].ticket_type_num); 
					$("#selectPeople #adult button.result").attr("data-ticket-user-type", ticketPrice[i].ticket_user_type);
					$("#selectPeople #adult button.result").attr("data-ticket-type-price", ticketPrice[i].ticket_type_price);    
				}
				
				if(ticketUserType == "청소년"){
					$("#selectPeople #teenager button.result").attr("data-ticket-type-num", ticketPrice[i].ticket_type_num); 
					$("#selectPeople #teenager button.result").attr("data-ticket-user-type", ticketPrice[i].ticket_user_type);
					$("#selectPeople #teenager button.result").attr("data-ticket-type-price", ticketPrice[i].ticket_type_price);  
					
				}
				
				if(ticketUserType == "경로/어린이"){
					$("#selectPeople #child button.result").attr("data-ticket-type-num", ticketPrice[i].ticket_type_num); 
					$("#selectPeople #child button.result").attr("data-ticket-user-type", ticketPrice[i].ticket_user_type);  
					$("#selectPeople #child button.result").attr("data-ticket-type-price", ticketPrice[i].ticket_type_price); 
				}
				
				if(ticketUserType == "장애인"){
					$("#selectPeople #handi button.result").attr("data-ticket-type-num", ticketPrice[i].ticket_type_num);
					$("#selectPeople #handi button.result").attr("data-ticket-user-type", ticketPrice[i].ticket_user_type);
					$("#selectPeople #handi button.result").attr("data-ticket-type-price", ticketPrice[i].ticket_type_price); 
				}
			}
		})
		.fail(function() { // 요청 실패 시
			alert("요청 실패!");
		});
	});
	
	$(function() {		
		// [관람인원선택] 영역이 클릭되면 =========================================================================================================================================
		$("#selectPeople button").on("click", function() {
			$("#seat-part").removeClass("disabled");   // 좌석 선택 영역 disable 클래스 제거
			$("#selectPeople button").removeClass("selected");
			$(this).addClass("selected");
			
			
			// play_num을 파라미터로 하여 OREDER_TICKETS 테이블에서 예약된 좌석 정보 가져오기
			// 예약된 좌석의 경우 disabled 클래스를 추가하여 선택할 수 없게 설정하기  
			let playNum = $(".roomInfo2").attr("data-play-num");
			$.ajax({
				type : "post", 
				url : "SelectPeople", 
				data : {"play_num" : playNum},
				dataType : "json", 
			})
			.done(function(orderTicketList) {
				for(let i = 0; i <orderTicketList.length; i++) {
					for(let j = 0; j < 60; j++){
						let seatNum = $("#seat-part button").eq(j).attr("data-seat-num");
					
						// 예약된 좌석 정보와 상영관의 좌석 번호를 비교하여
						// 예약된 좌석의 경우 disabled 클래스를 추가하여 선택할 수 없게 설정하기
						if(orderTicketList[i].seat_num == seatNum){
							$("#seat-part button").eq(j).addClass("disabled")
						}
					}
				}
			})
			.fail(function() { // 요청 실패 시
				alert("요청 실패!");
			});
		
			
			// ------------------------------------------------------------------------------------------------------------------------------------
			let adultResult = $("#selectPeople #adult button.result").text();
			let teenagerResult = $("#selectPeople #teenager button.result").text();
			let childResult = $("#selectPeople #child button.result").text();
			let handiResult = $("#selectPeople #handi button.result").text();
			let adultCount = Number(adultResult);
			let teenagerCount = Number(teenagerResult);
			let childCount = Number(childResult);
			let handiCount = Number(handiResult);
			let countPeople = adultCount + teenagerCount + childCount + handiCount;
						
			// 인원 선택 수 제한두기
			// 일반, 청소년, 우대, 장애인 수를 더해서 8 이상이면 좌석에 disabled 클래스 추가
			if(countPeople >= 8){   // 관람인원의 합이 8명 이상일 때
// 				$("#seat-part button").addClass("disabled");
				$("#selectPeople #adult button.up").addClass("disabled");
				$("#selectPeople #teenager button.up").addClass("disabled");
				$("#selectPeople #child button.up").addClass("disabled");
				$("#selectPeople #handi button.up").addClass("disabled");
				alert("인원 선택은 총 8명까지 가능합니다");
				
			}else if(countPeople == 0){   // 관람인원의 합이 0일 때
				alert("관람인원을 선택해 주세요");
				$("#seat-part button").removeClass("selected");
				$("#seat-part button").addClass("disabled");	// 좌석 선택할수 없게 disabled 클래스 추가
				
				$("#selectPeople button").on("click", function() {	// 관람인원 버튼 다시 클릭시
					$("#seat-part button").removeClass("disabled"); // 좌석 선택 영역 disabled 클래스 삭제
				});
				
			}else{
				$("#seat-part button").removeClass("disabled");
			}
			
			// 배열의 길이(선택한 좌석의 수)가 countPeople 보다 작을 때 
			if (countPeople < seatList.length) {
				alert("관람인원수를 변경하려면 기존에 선택된 좌석을 취소해야 합니다.");
				return;
			}
			
			// [결제] 영역에 티켓타입 별 가격 표시
			let adultTicketTypePrice = $("#selectPeople #adult button.result").attr("data-ticket-type-price");
			let teenagerTicketTypePrice = $("#selectPeople #teenager button.result").attr("data-ticket-type-price");
			let childTicketTypePrice = $("#selectPeople #child button.result").attr("data-ticket-type-price");
			let handiTicketTypePrice = $("#selectPeople #handi button.result").attr("data-ticket-type-price");
			let adultTotalPrice = adultTicketTypePrice * adultCount;
			let teenagerTotalPrice = teenagerTicketTypePrice * teenagerCount;
			let childTotalPrice = childTicketTypePrice * childCount;
			let handiTotalPrice = handiTicketTypePrice * handiCount;
			let totalPrice = adultTotalPrice + teenagerTotalPrice + childTotalPrice + handiTotalPrice;
			if(adultCount > 0){
				$("#paymentInfo .adult").html("(일반)");
				$("#paymentInfo .adultPrice").html(adultTicketTypePrice + " X " + adultCount);
			}else if(adultCount == 0){
				$("#paymentInfo .adult").html("");
				$("#paymentInfo .adultPrice").html("");
			}
			
			if(teenagerCount > 0){
				$("#paymentInfo .teenager").html("(청소년)");
				$("#paymentInfo .teenagerPrice").html(teenagerTicketTypePrice + " X " + teenagerCount);
			}else if(teenagerCount == 0){
				$("#paymentInfo .teenager").html("");
				$("#paymentInfo .teenagerPrice").html("");
			}
			
			if(childCount > 0){
				$("#paymentInfo .child").html("(경로/어린이)");
				$("#paymentInfo .childPrice").html(childTicketTypePrice + " X " + childCount);
			}else if(childCount == 0){
				$("#paymentInfo .child").html("");
				$("#paymentInfo .childPrice").html("");
			}
			
			if(handiCount > 0){
				$("#paymentInfo .handi").html("(장애인)");
				$("#paymentInfo .handiPrice").html(handiTicketTypePrice + " X " + handiCount);
			}else if(handiCount == 0){
				$("#paymentInfo .handi").html("");
				$("#paymentInfo .handiPrice").html("");
			}
			
			$("#paymentInfo .totalPrice").html("<b>" + totalPrice + "</b>");
			
		});
		
	});
	// [좌석] 선택 시 ======================================================================================================================================================   		
	$(function() {
		
		$("#seat-part button").on("click", function() {
			$("#selectPeople").addClass("disabled");
			
// 			$("#selectPeople button").on("click", function() {
// 				alert("관람인원을 변경하려면 좌석을 다시 선택해야 합니다.")
// 			})
			
			let resultAdult = $("#selectPeople #adult button.result").text();
			let resultTeenager = $("#selectPeople #teenager button.result").text();
			let resultChild = $("#selectPeople #child button.result").text();
			let resultHandi = $("#selectPeople #handi button.result").text();
			let adultCount = Number(resultAdult);
			let teenagerCount = Number(resultTeenager);
			let childCount = Number(resultChild);
			let handiCount = Number(resultHandi);
			let countPeople = adultCount + teenagerCount + childCount + handiCount;
			
			
			// 클릭된 좌석이 selected 클래스를 가지고 있으면
			// selecte 클래스를 제거하고, 해당 좌석명을 seatList 배열에서 찾아서 제거
			// splice()를 사용하기 위해 indexOf()를 이용해 해당하는 좌석명이 배열의 몇번째 요소인지 찾아서 제거하기
			let selectedSeatName = $(this).attr("data-seat-name");
			if ($(this).hasClass("selected")) {  
				$(this).removeClass("selected"); 
				
				const index = seatList.indexOf(selectedSeatName);
				if (index > -1) {
					seatList.splice(index, 1);
				}
				
			} else {
				// 클릭된 좌석이 selected 클래스를 가지고 있지 않으면
				if (seatList.length >= countPeople) {   // 배열의 길이(선택한 좌석의 수)가 countPeople 보다 크거나 같아지면
					alert("좌석 선택이 완료되었습니다.");
					return;
					
				} else if (countPeople < seatList.length) {   // 배열의 길이(선택한 좌석의 수)가 countPeople 보다 작을 때
					alert("인원수를 변경하려면 기존에 선택된 좌석을 취소해야 합니다.");
				
				}				
				
				$(this).addClass("selected");
				seatList.push(selectedSeatName);
			}
			
			console.log(seatList);
						
			let res="";
			for(let i = 0; i < seatList.length; i++){
				res += "<b>" + seatList[i] + " </b>";
			}
			
			$("#seatInfo").html(res);
			
			// TICKET_TYPES 테이블에서 가져온 티켓타입번호(ticket_type_num)을 
			// seatList[]와 함께 파라미터로 전달하기 위해 ticketTypeNum[] 배열에 저장
			for (let i = 0; i < adultCount; i++) {
				seatListForParam[i] = seatList[i] + "/일반";
				ticketTypeNum[i] = $("#selectPeople #adult button.result").attr("data-ticket-type-num");
			}
			
			for (let i = adultCount; i < adultCount + teenagerCount; i++) {
				seatListForParam[i] = seatList[i] + "/청소년";
				ticketTypeNum[i] = $("#selectPeople #teenager button.result").attr("data-ticket-type-num");
			}
			
			for (let i = adultCount + teenagerCount; i < adultCount + teenagerCount + childCount; i++) {
				seatListForParam[i] = seatList[i] + "/우대";
				ticketTypeNum[i] = $("#selectPeople #child button.result").attr("data-ticket-type-num");
			}
			
			for (let i = adultCount + teenagerCount + childCount; i < adultCount + teenagerCount + childCount + handiCount; i++) {
				seatListForParam[i] = seatList[i] +  "/장애인";
				ticketTypeNum[i] = $("#selectPeople #handi button.result").attr("data-ticket-type-num");
			}
			
// 			const index1 = ticketTypeNum.indexOf($("#selectPeople #adult button.result").attr("data-ticket-type-num"));
// 			if (index1 > -1) {
// 				ticketTypeNum.splice(index1, 1);
// 			}
			
// 			const index2 = ticketTypeNum.indexOf($("#selectPeople #teenager button.result").attr("data-ticket-type-num"));
// 			if (index2 > -1) {
// 				ticketTypeNum.splice(index2, 1);
// 			}
			
// 			const index3 = ticketTypeNum.indexOf($("#selectPeople #child button.result").attr("data-ticket-type-num"));
// 			if (index3 > -1) {
// 				ticketTypeNum.splice(index3, 1);
// 			}
			
// 			const index4 = ticketTypeNum.indexOf($("#selectPeople #handi button.result").attr("data-ticket-type-num"));
// 			if (index4 > -1) {
// 				ticketTypeNum.splice(index4, 1);
// 			}
			console.log(seatListForParam);
			console.log(ticketTypeNum);
		});
		
	});
	
	// [next] 버튼 클릭 시 ============================================================================================================================================================ 
	// 1) 선택한 좌석 수 == 0
	//    => alert("좌석을 선택해주세요");
	// 2) 선택한 좌석의 수 < 관람인원수 
	//    => alert("좌석 선택이 완료되지 않았습니다");
	// 3) 선택한 좌석의 수 > 관람인원수
	//    => alert("선택한 좌석 수가 관람인원수를 초과하였습니다." + "\n" + "다시 선택해주세요" + "\n" + "seatList.length : " + seatList.length + "\n" + "countPeople : " + countPeople);
	//        location.reload();
	// 4) 선택한 좌석 수 != ticketTypeNum[] 
	//    => alert("오류발생")
	function reservationSnack() {
		let resultAdult = $("#selectPeople #adult button.result").text();
		let resultTeenager = $("#selectPeople #teenager button.result").text();
		let resultChild = $("#selectPeople #child button.result").text();
		let resultHandi = $("#selectPeople #handi button.result").text();
		let adultCount = Number(resultAdult);
		let teenagerCount = Number(resultTeenager);
		let childCount = Number(resultChild);
		let handiCount = Number(resultHandi);
		let countPeople = adultCount + teenagerCount + childCount + handiCount;
		
		if(seatList.length == 0){
			alert("좌석을 선택해주세요");
			
		}else if(seatList.length == countPeople){
			if(seatList.length == ticketTypeNum.length){
				location.href='reservation_snack?play_num=${reservation.play_num}&seat_name=' + seatList + '&ticket_type_num=' + ticketTypeNum;      
				
			}else{
				alert("오류가 발생했습니다. 다시 선택해 주세요");
				location.reload();
			}
			
		}else if(seatList.length < countPeople){
			alert("좌석 선택이 완료되지 않았습니다");
			
		}else if(seatList.length > countPeople){
			alert("선택한 좌석 수가 관람인원수를 초과하였습니다." + "\n" + "다시 선택해주세요" + "\n" + "seatList.length : " + seatList.length + "\n" + "countPeople : " + countPeople);
			location.reload();
			
		}
	}
	
	$(function(){
		$("#reset").on("click", function() {
			location.reload();
		})		
	})
</script>
</head>
<body>
	<%--네비게이션 바 영역 --%>
	<header id="pageHeader"><%@ include file="../inc/header.jsp"%></header>
 
	<article id="mainArticle">
	<%--본문내용 --%>
	<h2>영화 예매</h2>
	<div class="container-fluid" >
		<div class="row row1">
			<div class="col-12">
				<div class="row">
					<div class="col-12">
						<div class="row">
							<div class="col-12 title-area">
								<h5>관람인원선택</h5>
							</div>
						</div>
					</div>
				</div>
				
				<%-- 좌석 선택 파트 --%>
				<div class="row">
					<div class="col-12">
						<div class="row mt-3 pl-3">
							<div class="col-12" id="selectPeople">
								<div class="row">
 									<div class="col-2"  id="adult">
 										<span>성인</span>
 										<div class="mt-1">
 											<button class="down" onclick="adultDown()"> - </button><button class="result">0</button><button class="up" onclick="adultUp()"> + </button>
 										</div>
 									</div>
 									<div class="col-2"  id="teenager">
 										<span>청소년</span>
 										<div class="mt-1">
										<button class="down" onclick="teenagerDown()"> - </button><button class="result">0</button><button class="up" onclick="teenagerUp()"> + </button>
										</div>
									</div>
									<div class="col-2"  id="child">
										<span>우대</span>
										<div class="mt-1">
											<button class="down" onclick="childDown()"> - </button><button class="result">0</button><button class="up" onclick="childUp()"> + </button>
										</div>
									</div>
									<div class="col-2"  id="handi">
										<span>장애인</span>
										<div class="mt-1">
											<button class="down" onclick="handiDown()"> - </button><button class="result">0</button><button class="up" onclick="handiUp()"> + </button>
										</div>
									</div>
									<script type="text/javascript">
										let adultResult = $("#selectPeople #adult button.result").text();
										let teenagerResult = $("#selectPeople #teenager button.result").text();
										let childResult = $("#selectPeople #child button.result").text();
										let handiResult = $("#selectPeople #handi button.result").text();
										let adultCount = Number(adultResult);
										let teenagerCount = Number(teenagerResult);
										let childCount = Number(childResult);
										let handiCount = Number(handiResult);
										let countPeople = adultCount + teenagerCount + childCount + handiCount;
										
										function adultDown() {
											if(adultCount <= 0){
												$("#selectPeople #adult button.down").addClass("disabled");
											}else {
												adultCount = adultCount - 1;
												$("#selectPeople #adult button.up").removeClass("disabled");
												$("#selectPeople #teenager button.up").removeClass("disabled");
												$("#selectPeople #child button.up").removeClass("disabled");
												$("#selectPeople #handi button.up").removeClass("disabled");
												$("#selectPeople #adult button.result").html(adultCount);
											}
										} 
										
										function adultUp() {
											if(adultCount >= 8){
												$("#selectPeople #adult button.up").addClass("disabled");
											}else {
												adultCount = adultCount + 1;
												$("#selectPeople #adult button.down").removeClass("disabled");
												$("#selectPeople #adult button.result").html(adultCount); 
												
											}
										}
										
										
										// ------------------------------------------------------------------------------
										function teenagerDown() {
											if(teenagerCount <= 0){
												$("#selectPeople #teenager button.down").addClass("disabled");
											}else {
												teenagerCount = teenagerCount - 1;
												$("#selectPeople #adult button.up").removeClass("disabled");
												$("#selectPeople #teenager button.up").removeClass("disabled");
												$("#selectPeople #child button.up").removeClass("disabled");
												$("#selectPeople #handi button.up").removeClass("disabled");
												$("#selectPeople #teenager button.result").html(teenagerCount);
											}
										}
										
										function teenagerUp() {
											if(teenagerCount >= 8){
												$("#selectPeople #teenager button.up").addClass("disabled");
											}else {
												teenagerCount = teenagerCount + 1;
												$("#selectPeople #teenager button.down").removeClass("disabled");
												$("#selectPeople #teenager button.result").html(teenagerCount);
											}
										} 
										
										// ------------------------------------------------------------------------------
										function childDown() {
											if(childCount <= 0){
												$("#selectPeople #child button.down").addClass("disabled");
		                                    }else {
		                                    	childCount = childCount - 1;
		                                    	$("#selectPeople #adult button.up").removeClass("disabled");
												$("#selectPeople #teenager button.up").removeClass("disabled");
												$("#selectPeople #child button.up").removeClass("disabled");
												$("#selectPeople #handi button.up").removeClass("disabled");
		                                    	$("#selectPeople #child button.result").html(childCount);
		                                    }
										}
										
										function childUp() {
											if(childCount >= 8){
												$("#selectPeople #child button.up").addClass("disabled");
											}else {
												childCount = childCount + 1;
												$("#selectPeople #child button.down").removeClass("disabled");
												$("#selectPeople #child button.result").html(childCount);
											}
										} 
										
										// ------------------------------------------------------------------------------
										function handiDown() {
											if(handiCount <= 0){
												$("#selectPeople #handi button.down").addClass("disabled");
											}else {
												handiCount = handiCount - 1;
												$("#selectPeople #adult button.up").removeClass("disabled");
												$("#selectPeople #teenager button.up").removeClass("disabled");
												$("#selectPeople #child button.up").removeClass("disabled");
												$("#selectPeople #handi button.up").removeClass("disabled");
												$("#selectPeople #handi button.result").html(handiCount);
											}
										}
										
										function handiUp() {
											if(handiCount >= 8){
												$("#selectPeople #handi button.up").addClass("disabled");
											}else {
												handiCount = handiCount + 1;
												$("#selectPeople #handi button.down").removeClass("disabled");
												$("#selectPeople #handi button.result").html(handiCount);
											}
										} 
// 										// ------------------------------------------------------------------------------
									</script>
									</div>
									<hr>
								</div>
							</div>
						<div class="row">
							<div class="col-10 disabled" id="seat-part">
								<hr>
<!-- 								<b>SCREEN 화면</b> <span class="door align-right">출구</span> -->
								<b>SCREEN 화면</b> <span class="align-right"><img alt="exit" src="${pageContext.request.contextPath }/resources/img/door.png"></span>
								<br>
								<div class="seatArea">
									<!-- 좌석 출력되는 부분 -->
								</div>
							</div>
							<div class="col-2 selectPart">
								<div id="seatType">
									<button class="selectedSeat"></button> 선택 <br>
									<button class="disabledSeat"></button> 예매완료 <br>
									<button class="handiSeat"></button> 휠체어석
								</div>
								<button id="reset" class="btn btn-secondary mt-3"><img src="${pageContext.request.contextPath }/resources/img/reset.png" width="20px"> 다시 선택하기</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<%-- 선택사항 안내 구간, 다음으로 넘어가기 --%>
		<div class="row row2">
			<div class="col-1 p-2">
				<button class="btn btn-secondary" onclick="history.back()"> &lt; 이전</button>
			</div>
			<%-- 선택한 영화 포스터와 영화명, 극장, 일시, 상영관 노출 --%>
			<div class="col-6">
				<div class="row">
					<div class="col-12">
						<h5>선택 정보</h5>						
					</div>
				</div>
				<div class="row">
					<div class="col-7">
						<div class="row" id="movieInfo">
							<div class="col-6 pr-1 text-center movie_poster"><img src="${reservation.movie_poster }" alt="선택영화포스터" height="170px"></div>
							<div class="col-6 pl-1 text-left movie_name_kr"><b>${reservation.movie_name_kr }</b></div><br>
						</div>
					</div>
					<div class="col-5">
						<div class="row">
							<div class="col-12">
								<div id="theaterInfo" style="display: table;">
									<span style="display: table-cell;">극장&nbsp;</span>
									<span style="display: table-cell;"><b>${reservation.theater_name }</b></span>
								</div>
								
								<div id="dateInfo" style="display: table;">
									<span style="display: table-cell;">날짜&nbsp;</span>
									<span data-play-date="${reservation.play_date }" style="display: table-cell;"><b>${reservation.play_date }</b></span>
									<span data-play-num="${reservation.play_num }" data-play-start-time="${reservation.play_start_time }" data-play-time-type="${reservation.play_time_type }" style="display: table-cell;">
										<fmt:parseDate value="${reservation.play_start_time }" var="play_start_time" pattern="HH:mm:ss"/>
										<b>(<fmt:formatDate value="${play_start_time}" pattern="HH:mm"/>)</b>
									</span>
								</div>
								<div id="roomInfo" style="display: table;">
									<span style="display: table-cell;">상영관&nbsp;</span>
									<span class="roomInfo2" data-play-num="${reservation.play_num }" style="display: table-cell;"><b>${reservation.room_name }</b></span>
								</div>						
							</div>
						</div>
					</div>
				</div>
			</div>
			<%-- 미선택 사항 노출 --%>
			<div class="col-2">
				<h5>좌석 선택</h5>
				<div id="seatInfo" style="text-align: center;">
					<div id="seat_name"></div>
				</div>
			</div>
				
			<%-- 미선택 사항(결제) 노출 --%>
			<div class="col-2">
			<h5>결제</h5>
			<div id="paymentInfo"  style="display: table;">
				<div style="display: table-cell;">
					<div style="display: table;"><span class="adult" style="display: table-cell;"></span><span class="adultPrice" style="display: table-cell;"></span></div>                 
					<div style="display: table;"><span class="teenager" style="display: table-cell;"></span><span class="teenagerPrice" style="display: table-cell;"></span></div>          
					<div style="display: table;"><span class="child" style="display: table-cell;"></span><span class="childPrice" style="display: table-cell;"></span></div>      
					<div style="display: table;"><span class="handi" style="display: table-cell;"></span><span class="handiPrice" style="display: table-cell;"></span></div>     
					<div style="display: table;"><span class="total" style="display: table-cell;">합계&nbsp;</span><span class="totalPrice" style="display: table-cell;"></span></div>
				</div>
			</div>
			</div>
			<%-- 다음 페이지 이동 버튼 --%>
			<div class="col-1 p-2">
				<button class="btn btn-danger vertical-center" onclick="reservationSnack()"> next > </button>
<%--                   <button class="btn btn-danger vertical-center" onclick="location.href='reservation_snack?play_num=${reservation.play_num}&seat_name=' + seatList + '&ticket_type_num=' + ticketTypeNum"> next > </button> --%>
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