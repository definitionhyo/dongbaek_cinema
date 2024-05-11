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
.w-900{
	width: 900px;
}
.h-500{
	height: 500px;
}

div {
	background-color: transparent;
}

th{
	width: 200px;
}

.fr {
	margin-top: 100px;
}
</style>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script type="text/javascript">
	
	// 정규표현식으로 전화번호 판별
// 	function phoneCheck(phone) {
// 		let regExp = /^(010|011)[-\s]?[\d]{3,4}(-|\s)?\d{4}$/;
		
// 		if(!regExp.test(phone)) {
// 			// 입력창에 정규표현식에 맞지 않는 값이면
// 			alert("맞지 않는 형식");
			
// 		}
// 	}
	
</script>
</head>
<body>
 <%--네비게이션 바 영역 --%>
 <header id="pageHeader"><%@ include file="../inc/header.jsp"%></header>
 
  <article id="mainArticle">
  <%--본문내용 --%>
			<%-- 회원 정보 수정에 사용될 아이디 hidden 타입으로 전달
			이 방법 외에 입력박스 표시 후 readonly 로 처리해도 가능!
			--%>
  <%--본문내용(width: 900px) --%>
  <div class="container-fluid w-900">

<!-- 	<header class="d-flex justify-content-center py-3"> -->
<!--       <ul class="nav nav-pills"> -->
<!--         <li class="nav-item"><a href="#" class="nav-link active" aria-current="page">회원로그인</a></li> -->
<!--         <li class="nav-item"><a href="no_member_login_form" class="nav-link">비회원로그인</a></li> -->
<!--         <li class="nav-item"><a href="no_member_reservation_check_form" class="nav-link">비회원예매 확인</a></li> -->
<!--       </ul> -->
<!--     </header> -->
	
	<div class="row d-flex justify-content-center mt-3">
		<div class="col-8">	<%-- 전체 12개의 col중에 가운데 8개의 col 사용 --%>
			<form action="MemberIdFind" method="post" name="fr" class="fr">
				<h2>아이디 찾기</h2>
		    	<p class="mb-3 fw-normal">이름과 전화번호를 입력하신 후, 아이디 찾기 버튼을 눌러주세요.</p>
			
				<%-- 아이디 --%>
				<div class="row mb-3">
	              <label for="id" class="col-2 text-nowrap">이름</label>
	              <div class="col-10">
	              		<%-- 쿠키에 member_id가 있으면 쿠키에서 id를 가져와 보여주기 --%>
<%-- 		              <input type="text" class="form-control" name="member_id" id="member_id" placeholder="아이디" required="required" value="${cookie.member_id.value }"> --%>
		              <input type="text" class="form-control" name="member_name" id="member_name"required="required">
	              </div>
		        </div>
	        
		        <%-- 휴대폰 번호  --%>
				<div class="row mb-3">
	            	<label for="passwd" class="col-2 text-nowrap">휴대폰 번호 </label>
	            	<div class="col-10">
						<input type="text" id="member_phone" name="member_phone" title="전화번호 입력" required maxlength="11" placeholder="핸드폰번호 (-)없이 입력">
	             		<input type="button" id="phoneChk" class="doubleChk" value="인증번호 보내기">
	             	</div>
		        </div>
	        
		        <%-- 인증 번호  --%>
				<div class="row mb-3">
	            	<label for="certify" class="col-2 text-nowrap">인증 번호</label>
	            	<div class="col-10">
						<input type="text" id="phone2" title="인증번호 입력" placeholder="인증번호">
	             		<input type="button" id="phoneChk2" class="doubleChk" value="인증확인">
	             	</div>
		        </div>
		        
		        <%-- 인증 번호  --%>
				<div class="row mb-3">
	            	<label for="certify" class="col-2 text-nowrap"></label>
	            	<div class="col-10">
	             		<span class="point successPhoneChk">휴대폰 번호 입력 후 인증번호 보내기를 해주십시오.</span>
						<input type="hidden" id="phoneDoubleChk">
	             	</div>
		        </div>
		        
		        <%-- 아이디 찾기 버튼  --%>
				<div class="row mb-3">
	            	<label for="certify" class="col-2 text-nowrap"></label>
	            	<div class="col-10">
						<input type="submit" id="DoneBtn" value="아이디 찾기" disabled="disabled">
	             	</div>
		        </div>
		    </form>
		
		    <script type="text/javascript">
						//휴대폰 번호 인증
						$("#phoneChk").click(function(){
							var code2 = "";
							alert("인증번호 발송이 완료되었습니다.\n휴대폰에서 인증번호 확인을 해주십시오.");
							let member_phone = $("#member_phone").val();
							console.log("1");
							
							$.ajax({
						        type:"POST",
						        url: '<c:url value="/phoneCheck"/>',
						        data: "member_phone=" + member_phone,
// 						        cache : false,
						        dataType: "json",
						        success : function(data){
						        	
						         	console.log("2");
						         	let checkNum = data;
// 						         	alert(member_phone + ', checkNum: ' + checkNum);
						         	
						        	if(data == "error"){
						        		console.log("3");
						        		alert("휴대폰 번호가 올바르지 않습니다.")
										$(".successPhoneChk").text("유효한 번호를 입력해주세요.");
										$(".successPhoneChk").css("color","red");
										$("#member_phone").attr("autofocus",true);
						        	}else{	        		
						        		console.log("4");
						        		$("#phone2").attr("disabled",false);
						        		$("#phoneChk2").css("display","inline-block");
						        		$(".successPhoneChk").text("인증번호를 입력한 뒤 본인인증을 눌러주십시오.");
						        		$(".successPhoneChk").css("color","green");
						        		$("#member_phone").attr("readonly",true);
						        		code2 = data;
						        	}

									//휴대폰 인증번호 대조
									$("#phoneChk2").click(function(){
										if($("#phone2").val() == code2){
											$(".successPhoneChk").text("인증번호가 일치합니다.");
											$(".successPhoneChk").css("color","green");
											$("#phoneDoubleChk").val("true");
											$("#DoneBtn").attr("disabled",false);
											// 회원가입 진행시 자동으로 값을 입력해주기 위해서
											// 로컬의 세션 스토리지에 이메일 저장
											sessionStorage.setItem('member_phone', member_phone);
										}else{
											$(".successPhoneChk").text("인증번호가 일치하지 않습니다. 확인해주시기 바랍니다.");
											$(".successPhoneChk").css("color","red");
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
		    
		    
		</div>
	</div>
</div>

  
  </article>
  
  <nav id="mainNav" class="d-none d-md-block sidebar">
  <%--왼쪽 사이드바 --%>
  </nav>
  
  <div id="sieAds"></div>t
  <%--페이지 하단 --%>
  <footer id="pageFooter"><%@ include file="../inc/footer.jsp"%></footer>
</body>