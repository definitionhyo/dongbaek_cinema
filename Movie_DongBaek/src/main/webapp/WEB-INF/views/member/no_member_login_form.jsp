<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/sidebar.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/button.css" rel="stylesheet" type="text/css">

<title>영화 예매 사이트</title>
<style>
.jumbotron{
	padding: 1rem 1rem;
}

.jumbotron div, .jumbotron p{
	background-color: inherit;
}
.w-900{
	width: 900px;
}
.h-500{
	height: 500px;
}

div {
	background-color: transparent;
}

.inputArea {
/* 	 border: 1px solid red; */
/* 	 padding: 15px 20px 0 20px; */
}

/* 회원로그인/비회원로그인/비회원예매 확인 탭 */
.nav-pills .nav-link.active {
	color: #fff;
	background-color: #ef4f4f;
	border-bottom:none;
}
.nav-link {
	width: 150px;
}

.nav-link:hover {
	color: #ef4f4f;
}

/* 확인용 */
/* .container-fluid{ */
/* 	border: 1px solid gray; */
/* } */

</style>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script type="text/javascript">
	
	// ------[인증 요청 시 사용되는 버튼 변경]-------------
	// 인증요청 버튼 클릭 시 재전송으로 value 변경
	$(function() {
		$("#phoneChk").on("click", function() {
			$("#phoneChk").attr("value", "재전송");			
		});
	});
	
	// 확인 버튼 클릭 시 확인완료로 value 변경
// 	$(function() {
// 		$("#phoneChk2").on("click", function() {
// 			$("#phoneChk2").attr("value", "");			
// 		});
// 	});
	
	// ------[입력값 유효성 검사] --------------------
	// 이름 체크
	function checkName(value) {
		let getName = RegExp(/^[A-Za-z가-힣]{2,15}$/);
		 
		if (!getName.test(value)) {
			$("#namefeedback").text("올바른 이름을 입력해주세요.");
			$("#namecheck").attr("disabled", false);
			$(this).focus();
		} else {
			$("#namecheck").attr("disabled", true);
			$("#namefeedback").text("");
		}
	}
	
	// 생년월일 체크
	function checkBirth(value) {
		let getBirth = RegExp(/^((19)[0-9]{2}|(200)[0-8]+)(0[1-9]|1[012])(0[0-9]|[12][0-9]|3[01])$/);
		
		if(!getBirth.test(value)) {
			$("#birthfeedback").text("생년월일 8자를 입력해주세요.");
			$("#birthcheck").attr("disabled", false);
			$(this).focus();
		} else {
// 			alert(value);
			$("#birthfeedback").text("");
			$("#birthcheck").attr("disabled", true);
		}
	}
	
	// 전화번호 체크
	function checkPhone(value) {
		let getPhone = RegExp(/^(010|011)[\d]{3,4}[\d]{4}$/);
		
		if(!getPhone.test(value)) {
			$("#phonefeedback").text("올바른 전화번호를 입력하세요");
			$(this).focus();
		} else {
// 			alert(value);
			$("#phonefeedback").text("");
			$("#phoneChk").attr("disabled", false);
		}
	}
	
	
	// 비밀번호 체크
	function checkPasswd1(value) {
		let getPass = RegExp(/^[\d]{4}/);
		if(!getPass.test(value)) {	// 맞지 않을 때
			$("#passwdfeedback1").text("비밀번호 4자리를 입력해주세요.");
			$("#passcheck1").attr("disabled", false);
		} else {
			$("#passwdfeedback1").text("");
			$("#passwdfeedback2").text("");
			$("#passcheck1").attr("disabled", true);
		}
	}
	
	
	// 비밀번호 확인 체크
	function checkPasswd2(value) {
		let getPass = RegExp(/^[\d]{4}/);
		if(!getPass.test(value)) {	// 맞지 않을 때
			$("#passwdfeedback2").text("비밀번호 확인 : 비밀번호가 일치하지 않습니다.");
			$("#passcheck2").attr("disabled", false);
			$(this).focus();
		} else {
			if($("#passwd").val() === $("#passwdCheck").val() ){	// 두 칸에 들어간 값이 같으면
				$("#passcheck2").attr("disabled", true);
				$("#passwdfeedback2").text("");
// 				alert(value);
			} else {
				$("#passwdfeedback2").text("비밀번호와 일치하지 않습니다.");
				$("#passcheck2").attr("disabled", false);
			}
		}
	}
	
	
	// 되돌아와서 비밀번호 변경 시 비밀번호 확인 체크
	function checkPasswd() {
		let getPass = RegExp(/^[\d]{4}/);
		let passwd = $("#passwd").val();
		let passwdCheck = $("#passwdCheck").val();
		
		if((!getPass.test(passwd) || !getPass.test(passwdCheck)) || !(passwd == passwdCheck)) {	// 맞지 않을 때
			$("#passwdfeedback2").text("비밀번호 확인 : 비밀번호가 일치하지 않습니다.");
			$("#passcheck2").attr("disabled", false);
			$(this).focus();
		} else {
				$("#passcheck2").attr("disabled", true);
				$("#passwdfeedback2").text("");
		}
	}
	
	// ------[확인 버튼 클릭 시 정보확인 모달창 내용 관리]-------------
	$(function() {
		
		$("#infoBtn").on("click", function() {
			let nameck = $("#namecheck").prop("disabled");
			let birthck = $("#birthcheck").prop("disabled");
			let phoneck = $("#phoneDoubleChk").prop("disabled");
			let passwdck = $("#passcheck1").prop("disabled");
			let passwdck2 = $("#passcheck2").prop("disabled");
			
			let member_name = $("#name").val();
			let member_birth = $("#birth").val();
			let member_phone = $("#phone").val();
			let member_pass = $("#passwd").val();
			
// 			alert(nameck);
// 			alert(birthck);
// 			alert(phoneck);
// 			alert(passwdck);
// 			alert(passwdck2);
			
			// 동의 버튼 클릭, 정상적으로 입력값 입력 시
			// 입력정보 안내와 로그인 확인버튼 보이게 하기
			if($("#agree").is(':checked') && nameck && birthck && phoneck && passwdck && passwdck2) {	
				// 모달창에 값 넣기
				$("#member_name").val(member_name);
         		$("#member_birth").val(member_birth);
         		$("#member_phone").val(member_phone);
         		$("#member_pass").val(member_pass);
         			
         		$("#nameSpace").text(member_name);
         		$("#birthSpace").text(member_birth);
         		$("#phoneSpace").text(member_phone);
         		
				$("#modelcheck").show();
				$("#modelcheck2").hide();
				$("#submitBtn").show();
				
			} else {
				// 입력값 유효성 검사 실패 상태나 동의 버튼 미선택 시 보이는 창
				$("#modelcheck2").show();
				$("#modelcheck").hide();
				$("#submitBtn").hide();
			}
		});
	});
	
	
</script>

</head>
<body>
  <%--네비게이션 바 영역 --%>
  <header id="pageHeader"><%@ include file="../inc/header.jsp"%></header>
 
  <article id="mainArticle">
  <%--본문내용 --%>
  <div class="container-fluid w-900">
 	<%-- 회원로그인/비회원로그인/비회원예매 확인 탭 --%>
	<header class="d-flex justify-content-center py-3">
      <ul class="nav nav-pills">
        <li class="nav-item"><a href="member_login_form" class="nav-link">회원로그인</a></li>
        <li class="nav-item"><a href="#" class="nav-link active" aria-current="page">비회원로그인</a></li>
        <li class="nav-item"><a href="no_member_reservation_check_form" class="nav-link">비회원예매 확인</a></li>
      </ul>
    </header>
	
<!-- 	<form action="#" method="post" class="needs-validation mt-3 py-3"> -->
	<%-- 비회원 로그인 폼 --%>
	<div class="row mt-3 inputArea">
		<div class="col-6 mt-3">
			
				<%-- 이름 --%>
	            <div class="row mb-3">
	              <label for="name" class="col-3 text-nowrap">이름</label>
	              <div class="col-9">
		              <input type="text" class="form-control" id="name" name="name" placeholder="이름" required="required" onkeyup="checkName(this.value)">
		              <div class="invalid-feedback">이름을 입력하세요</div>
		              <div id="namefeedback"></div>
		              <input type="hidden" id="namecheck">
	              </div>
	            </div>
	            
	            <%-- 생년월일 --%>		
	            <div class="row mb-3">
	              <label for="birth" class="col-3 text-nowrap">생년월일</label>
	              <div class="col-9">
		              <input type="text" class="form-control" id="birth" name="birth" placeholder="생년월일(8자리)"
		              		maxlength="8" required="required" onkeyup="checkBirth(this.value)">
		              <div id="birthfeedback"></div>
		              <input type="hidden" id="birthcheck">
	              </div>
	            </div>
	            
	            <%-- 휴대폰번호 --%>
	            <div class="row mb-3">
	              <label for="phoneNum" class="col-3 text-nowrap">휴대폰번호</label>
	              <div class="col-9">
		              <div class="input-group">
					  	<input type="text" class="form-control" id="phone" name="phone" placeholder="- 없이 입력해주세요" onkeyup="checkPhone(value)"
					  			maxlength="11" required="required" aria-describedby="button-addon1">
					  	<input class="btn btn-outline-red" type="button" value="인증요청" id="phoneChk" disabled="disabled" data-toggle="modal" data-target="#sendCheckNum">
					  </div>
		              <div id="phonefeedback"></div>
	              </div>
	            </div>
	            
	            <%-- 인증번호 --%>
	            <div class="row mb-3">
	              <label for="checkNum" class="col-3 text-nowrap">인증번호</label>
	              <div class="col-9">
		              <div class="input-group">
					  	<input type="text" class="form-control" id="checkNum" name="checkNum" required="required" aria-describedby="button-addon2" maxlength="4">
					  	<input class="btn btn-outline-red" type="button" value="    확인    " id="phoneChk2" disabled="disabled" data-toggle="modal" data-target="#sendCheckNum">
					  </div>
		              <div class="invalid-feedback">
		                인증번호를 입력하세요
		              </div>
		              <input type="hidden" id="phoneDoubleChk">
		              <%-- value로 true를 가지면 인증완료했다는 의미 --%>
	              </div>
	            </div>
	            
	            <%-- CoolSMS 문자인증 시작 --%>
					<script type="text/javascript">
						//휴대폰 번호 인증
						$("#phoneChk").click(function(){
							var code2 = "";
							let member_phone = $("#phone").val();
							
							$.ajax({
						        type:"POST",
						        url: '<c:url value="/phoneCheck"/>',
						        data: "member_phone=" + member_phone,
// 						        cache : false,
						        dataType: "json",
						        success : function(data){
						        	
						         	let checkNum = data;
// 						         	alert(member_phone + ', checkNum: ' + checkNum); // 확인용
						         	
						        	if(data == "error"){
										$("#modalMsg").html("휴대폰 번호가 올바르지 않습니다.<br>유효한 번호를 입력해주세요.");
										$("#member_phone").attr("autofocus",true);
						        	}else{	        		
						        		$("#phoneChk2").attr("disabled",false);
						        		$("#phoneChk2").css("display","inline-block");
						        		$("#modalMsg").html("인증번호를 입력한 뒤 본인인증을 눌러주십시오.");
						        		$("#phone").attr("readonly",true);
										$("#phoneChk2").attr("disabled",false);
						        		code2 = data;
						        	}

									//휴대폰 인증번호 대조
									$("#phoneChk2").click(function(){
										if($("#checkNum").val() == code2){
											$("#modalMsg").html("휴대폰 인증 완료!<br>나머지 정보를 입력해주세요.");
// 											$(".invalid-feedback").css("color","green");
											$("#phoneDoubleChk").attr("disabled", true);
											$("#phoneChk2").attr("value", "인증완료");
							        		$("#checkNum").attr("readonly",true);
// 											$("#phoneChk2").attr("disabled", true);
											// 회원가입 진행시 자동으로 값을 입력해주기 위해서
											// 로컬의 세션 스토리지에 이메일 저장
										}else{
											$("#modalMsg").html("인증번호가 일치하지 않습니다.<br>다시 확인해주시기 바랍니다.");
											$("#phoneDoubleChk").val("false");
											$(this).attr("autofocus",true);
										}
									});
						        },
						        error: function() {
						        	alert("에러")
						        }
						    });
						});
						
					</script>
					<%-- CoolSMS 문자인증 끝 --%>
	            
	            
	            <%-- 비밀번호 --%>
	            <div class="row mb-3">
	              <label for="passwd" class="col-3 text-nowrap">비밀번호</label>
	              <div class="col-9">
		              <input type="password" class="form-control" id="passwd" name="passwd"
		              		maxlength="4" placeholder="비밀번호(숫자4자리)" required="required" onkeyup="checkPasswd1(this.value)">
		              <div id="passwdfeedback1"></div>
		              <input type="hidden" id="passcheck1">
		          </div>
	            </div>
	            
	            <%-- 비밀번호 확인 --%>
	            <div class="row">
	              <label for="passwdCheck" class="col-3 text-nowrap">비밀번호확인</label>
	              <div class="col-9">
		              <input type="password" class="form-control" id="passwdCheck" name="passwdCheck"
		              	 	maxlength="4" placeholder="비밀번호(숫자4자리)확인" required="required" onkeyup="checkPasswd2(this.value)">
		              <div class="invalid-feedback">비밀번호를 입력하세요</div>
		              <div id="passwdfeedback2"></div>
		              <input type="hidden" id="passcheck2">
	              </div>
	            </div>            	
<!-- 			</form> -->
		</div>
				
		<%-- 비회원예매 개인정보 처리방침 --%>
		<div class="col-6 mt-3">
			<div class="jumbotron">
				<h4>비회원예매 개인정보 처리방침</h4>
				<hr>
				
				<%-- 수집목적 --%>
				<div class="row mb-3">
					<div class="col-3">
						<b class="text-nowrap">수집목적</b>
					</div>
					<div class="col-9 text-break">
						비회원예매 서비스 제공/ 이용자식별 / 구매 및 결제
					</div>
				</div>
				
				<%-- 수집항목 --%>
				<div class="row mb-3">
					<div class="col-3">
						<b class="text-nowrap">수집항목</b>
					</div>
					<div class="col-9 text-break">
						이름, 생년월일, 휴대폰번호, 비밀번호 
					</div>
				</div>
				
				<%-- 보유기간 --%>
				<div class="row mb-3">
					<div class="col-3">
						<b class="text-nowrap">보유기간</b>
					</div>
					<div class="col-9 text-break">
						관람 또는 취소 후 7일 이내
					</div>
				</div>
				
				<%-- 동의/비동의 버튼 --%>
				<div class="row mb-3 px-3">
					<div class="col-lg-12 p-2 bg-light bg-opacity-25 rounded d-flex justify-content-center">
						<div class="form-check form-check-inline pr-3">
						  <input class="form-check-input" type="radio" name="agree_disagree" id="agree">
						  <label class="form-check-label" for="agree">동의</label>
						</div>
						<div class="form-check form-check-inline pl-3">
						  <input class="form-check-input" type="radio" name="agree_disagree" id="disagree">
						  <label class="form-check-label" for="disagree">비동의</label>
						</div>
					</div>
				</div>
				
				<%-- 주의사항 --%>
				<p class="mb-3">
					정보수집에 동의를 거부할 수 있으며, 동의하지 않을 경우 비회원 예매서비스를 이용하실 수 없습니다
				</p>
				<%-- '확인'버튼 --%>
				<div class="col-12 pt-3 d-flex justify-content-center">
				<input type="button" class="btn btn-outline-red" data-toggle="modal" data-target="#agreeFinish" onclick="checkPasswd()"
					id ="infoBtn" value="확인">
          	    </div>
			</div>
		</div>		
	</div>
  </div>
  
	<%-- 인증요청 모달 영역 --%>
	<div class="modal fade" id="sendCheckNum" tabindex="-1" role="dialog" aria-labelledby="sendCheckNumTitle" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="sendCheckNumTitle">휴대폰인증</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body text-center" id="modalMsg">
	      <%-- 휴대폰번호 인증 관련 메세지가 표시되는 부분 --%>
	      </div>
	      <div class="modal-footer justify-content-center">
	        <button type="button" class="btn btn-red" data-dismiss="modal">확인</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	
	<%-- 최종 '확인' 모달 영역 --%>
	<div class="modal fade" id="agreeFinish" tabindex="-1" role="dialog" aria-labelledby="agreeFinishTitle" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="agreeFinishTitle">입력정보 확인</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <%-- 비회원 회원가입, 로그인 정보 --%>
	      <form action="no_member_login_pro" method="post">
		      <div class="modal-body text-center">
		      
		      <%-- 정상정보 입력 시 보여지는 영역 --%>
		      <div id="modelcheck">
		        티켓발권을 위한 입력정보를 확인해 주세요.
		        <table class="table table-bordered">
				  <tbody>
				    <tr>
				      <th scope="row">이름</th>
				      <td>
				      	<span id="nameSpace"><%-- 입력한 이름 --%></span>
				      	<input type="hidden" name="member_name" id="member_name">
				      </td>
				    </tr>
				    <tr>
				      <th scope="row">생년월일</th>
				      <td>
				      	<span id="birthSpace"><%-- 입력한 이름 --%></span>
				      	<input type="hidden" name="member_birth" id="member_birth">
				      </td>
				    </tr>
				    <tr>
				      <th scope="row">휴대폰번호</th>
				      <td>
				      	<span id="phoneSpace"><%-- 입력한 이름 --%></span>
				      	<input type="hidden" name="member_phone" id="member_phone">
				      	<input type="hidden" name="member_pass" id="member_pass">
				      </td>
				    </tr>
				  </tbody>
				</table>
		      </div>
		      <%-- 정보가 정상적으로 입력되지 않았을 때 보여지는 영역 --%>
		      <div id="modelcheck2">올바른 값을 입력 후 동의버튼을 눌러주세요.</div>
		      </div>
		      <div class="modal-footer justify-content-center">
		      <input type="submit" class="btn btn-red" id="submitBtn" value="확인">
		      <button type="button" class="btn btn-secondary" data-dismiss="modal" aria-label="Close">돌아가기
<!-- 			      <span aria-hidden="true">&times;</span> -->
		        </button>
		      </div>
	      </form>
	    </div>
	  </div>
	</div>
	
	
  </article>
  
<!--   <nav id="mainNav" class="d-none d-md-block sidebar"> -->
  	<%-- 사이드바(최대 width:200px, 최소 width:150px, 전체 화면 사이즈 middle 이하되면 사라짐) --%>
<!--   </nav> -->
  
  <div id="siteAds"></div>
  <%--페이지 하단 --%>
  <footer id="pageFooter"><%@ include file="../inc/footer.jsp"%></footer>
</body>
