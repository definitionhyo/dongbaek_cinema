<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<title>회원가입 3. 정보입력</title>
<style>
.w-900{
	width: 900px;
}
.w-600{
	width: 600px;
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

.select {
/* 	appearance:none;  /* 화살표 없애기 공통*/
/* 	-webkit-appearance:none;  */ /* Safari and Chrome */
/* 	-moz-appearance:none;  */ /* Firefox */
	width: 475px; 
	height: 40px;
	padding: 5px 30px 5px 10px;
	border-radius: 4px;
	outline: 0 none;
}

.select::-ms-expand {  /* IE10, IE11*/
   display:none;   /*숨겨진 화살표의 영역유지 X */
   display:hidden;  /*숨겨진 화살표의 영역유지 O */

}

.id_ok {
	color: #000000;
	display: none;
}

.id_already {
	color: #6A82FB;
	display: none;
}

</style>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script type="text/javascript">

	// 아이디 중복 확인
	function checkId() {
		var id = $('#member_id').val(); // id 의 값이 "member_id" 인 입력칸의 값을 변수 id에 저장		
		
		$.ajax({
			url:'./idCheck', 			// Controller 에서 요청 받을 주소
			type:'post', 	 			// POST 방식으로 전달
			data:{id:id},				// 
			success:function(cnt) {		// Controller 에서 넘어온 cnt 값을 받는다
				if(cnt == 0) { 			//  cnt 가 1이 아니면(==0일 경우) => 사용 가능한 아이디
					$('.id_already').css("display", "none");
					$('.id_ok').css("display", "inline-block");
				} else {				// 이미 존재하는 아이디
					$('.id_already').css("display", "inline-block");
					$('.id_ok').css("display", "none");
					alert("아이디를 다시 입력해주세요!");
					$('#member_id').val('');
				}
			},
			error:function(error) {
				alert("error : " + error);
			}
		})		
	}
	
	// 아이디 정규식
	function checkIdRegex(member_id) {
		let regex =/^[a-z0-9]{5,10}$/;
		
		if(member_id == null) { // 일반 회원 가입
			if(regex.exec(member_id)) {
				document.querySelector("#id_check").innerHTML = ""
				document.querySelector("#id_check").style.color = "green";
			} else {
				document.querySelector("#id_check").innerHTML = "사용 불가능한 아이디입니다!"
				document.querySelector("#id_check").style.color = "red";
				alert("영어 소문자와 숫자를 조합하여 5 ~ 10글자로 다시 입력해주세요!");
				$("#member_id").val('');
			}
		}
	
	}
	
	// 비밀번호 정규식
	function checkPass(member_pass, member_pass2) {
		let regex = /^(?=.*[a-zA-Z])(?=.*[!@#$%])(?=.*[0-9]).{8,16}$/;
		
		if(regex.exec(member_pass)) {
			document.querySelector("#pass_check").innerHTML = "사용 가능한 비밀번호입니다!"
			document.querySelector("#pass_check").style.color = "green";
		} else {
			document.querySelector("#pass_check").innerHTML = "사용 불가능한 비밀번호입니다!"
			document.querySelector("#pass_check").style.color = "red";
			alert("비밀번호를 다시 입력해주세요!");
			$("#member_pass").val('');
			$("#member_pass2").val('');
		}
	}
	
	// 비밀번호 와 비밀번호 확인 일치
	function checkconfirmPasswd(passwdCheck) {
		let member_pass = document.fr.member_pass.value;
		
		if(member_pass == passwdCheck) {
			document.querySelector("#pass_confirm").innerHTML = "비밀번호가 일치합니다!"
			document.querySelector("#pass_confirm").style.color = "green";
		} else {
			document.querySelector("#pass_confirm").innerHTML = "비밀번호가 일치하지 않습니다!"
			document.querySelector("#pass_confirm").style.color = "red";
			alert("비밀번호를 다시 입력해주세요!");
			$("#member_pass").val('');
			$("#member_pass2").val('');
		}
	}
	
	// 이름 정규식
	function inputName(member_name) {
		let regex = /^[A-Za-z가-힣]{2,15}$/;
		
		if(regex.exec(member_name)) {
			document.querySelector("#name_confirm").innerHTML = ""
			document.querySelector("#name_confirm").style.color = "green";
		} else {
			document.querySelector("#name_confirm").innerHTML = "이름을 한글 또는 영어로 입력해주세요!"
			document.querySelector("#name_confirm").style.color = "red";
			alert("이름을 다시 입력해주세요!");
			$("#member_birth").val('');
		}
	}
	
	// 생년월일 정규식
	function inputNum(member_birth) {
		let regex = /^(19[0-9][0-9]|20\d{2})(0[0-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/;
		
		if(regex.exec(member_birth)) {
			document.querySelector("#birth_check").innerHTML = ""
			document.querySelector("#birth_check").style.color = "green";
		} else {
			document.querySelector("#birth_check").innerHTML = "생년월일 8자리를 입력해주세요!"
			document.querySelector("#birth_check").style.color = "red";
			alert("생년월일을 다시 입력해주세요!");
			$("#member_birth").val('');
		}
	
	}
	
	// 전화번호 정규식
// 	function inputNum_phone(member_phone) {
// // 		let regex = /^((19)[0-9]{2}|(200)[0-8]+)(0[1-9]|1[012])(0[0-9]|[12][0-9]|3[01])$/;
// 		let regex = /^(010|011)[\d]{3,4}[\d]{4}$/;
		
// 		if(regex.exec(member_phone)) {
// 			document.querySelector("#phone_check").innerHTML = ""
// 			document.querySelector("#phone_check").style.color = "green";
// 		} else {
// 			document.querySelector("#phone_check").innerHTML = "전화번호를 다시 입력해주세요!"
// 			document.querySelector("#phone_check").style.color = "red";
// 			alert("전화번호를 다시 입력해주세요!");
// 			$("#member_phone").val('');
// 		}
// 	}

	// 이메일 정규식
	function inputEmail(member_email) {
		let regex = /^[a-zA-Z0-9+-_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
		
		if(regex.exec(member_email)) {
			document.querySelector("#email_check").innerHTML = ""
			document.querySelector("#email_check").style.color = "green";
		} else {
			document.querySelector("#email_check").innerHTML = "이메일을 다시 입력해주세요!"
			document.querySelector("#email_check").style.color = "red";
			alert("이메일을 다시 입력해주세요!");
			$("#member_email").val('');
		}	
		
	}
	
//-----------------------------------------------------------

	// ------ 카카오 로그인 후 회원가입 진행 작업 -------------
	// 로컬의 세션 스토리지에 저장한 이메일과 닉네임을 <input> 요소에 설정
	$(function() {
		let member_name = sessionStorage.getItem('member_name');
		let member_email = sessionStorage.getItem('member_email');
		let member_phone = sessionStorage.getItem('member_phone');
		
		// 세션 스토리지에 카카오 값이 존재할 경우 <input> 요소를 읽기 전용으로 설정
		if(member_name != null) {
			$("#member_name").val(member_name);
			$("#member_name").attr("readOnly", "readOnly");
		}
		if(member_email != null) {
			$("#member_id").val(member_email);
			$("#member_id").attr("readOnly", "readOnly");
		}
		if(member_phone != null) {
			$("#member_phone").val(member_phone);
			$("#member_phone").attr("readOnly", "readOnly");
		}
	});
	
	// ------------------------------

</script>
</head>
<body>
	<%-- Header 영역 --%>
	<header id="pageHeader"><%@ include file="../inc/header.jsp"%></header>
	<%--본문 영역 --%>
	<!--  가운데 정렬 코드 : class="container d-flex justify-content-center"  -->
	<article id="mainArticle">
 	 	<%-- 4단계 탭 --%>
 	 	<%-- 네이게이션 중앙 정렬 : justify-content-center --%>
		 <nav class=	"nav nav-pills justify-content-center">
		  	<a class="nav-link" aria-current="page" href="#">본인인증</a>
		 	<a class="nav-link" href="#">약관동의</a>
			<a class="nav-link active btn-danger" href="#">정보입력</a>
			<a class="nav-link" href="#">가입완료</a>
		</nav>
		<hr>
		
		<%-- 회원정보 입력 폼 시작 --%>		
		<div class="container-fluid w-600">
			<div class="row d-flex justify-content-center mt-3">
				<div class="col-10">	<%-- 전체 12개의 col중에 가운데 10개의 col 사용 --%>
					<form action="member_join_pro" method="post" name="fr" class="memberjoin">
						<input type="hidden" name="member_status" value="활동">
					 	<input type="hidden" name="member_type" value="회원">
						<c:choose>
							<c:when test="${member_agree_marketing eq false}">
								<input type="hidden" name="member_agree_marketing" value="0">
							</c:when>
							<c:otherwise>
								<input type="hidden" name="member_agree_marketing" value="1">
							</c:otherwise>
						</c:choose>
					<%-- 회원 가입 폼 시작 --%>
					<!--  아이디 (필수)  -->
					<div class="row mb-3">
				    	<label for="inputEmail3" class="col-sm-5 "></label> <!-- col-sm-2 에서 col-sm-5 로 수정 , 아래 상동 -->
					    	<div class="col-sm-12">
					    		<h6><em style="color:red;">*</em> 는 필수 입력 항목입니다!</h6>
					    	</div>
					</div>
					<!--  아이디 (필수)  -->
					<div class="row mb-3">
				    	<label for="inputEmail3" class="col-sm-5 ">아이디<em style="color:red;">*</em> </label> <!-- col-sm-2 에서 col-sm-5 로 수정 , 아래 상동 -->
					    	<div class="col-sm-12">
					    		<input type="text" class="form-control" id="member_id" name="member_id" required="required" placeholder="영어 소문자와 숫자를 조합하여 5 ~ 10글자를 입력하세요."
						    			minlength="5" maxlength="20" onchange="checkId(); checkIdRegex(this.value);">
<!-- 					    		<div class="check_font" id="id_check"></div> -->
					    	</div>
					</div>
					
<!-- 					아이디 중복확인 : ajax -->
					<div class="row mb-3">
				    	<label for="inputPassword3" class="col-sm-5 "></label>
					    	<div class="col-sm-12">
								<span class="id_ok" style="color:green;">사용 가능한 아이디 입니다.</span>
								<span class="id_already" style="color:red;">이미 사용중인 아이디 입니다.</span>
					   		</div>
					</div>	
					
					<!-- 아아디 정규식 : regex -->
					<div class="row mb-3">
				    	<label for="inputPasswordRegex_Result" class="col-sm-5 "></label>
					    	<div class="col-sm-12">
								<span id="id_check"></span>
					   		</div>
					</div>
				  	
					<!-- 비밀번호 (필수)  -->
				  	<div class="row mb-3">
				    	<label for="inputPassword" class="col-sm-5 ">비밀번호<em style="color:red;">*</em></label>
				    	<div class="col-sm-12">
				     	 	<input type="password" class="form-control" id="member_pass" name="member_pass" required="required" 
				     	 		   onchange="checkPass(this.value)" placeholder="영어 대,소문자와 !@#$%를 조합하여 8 ~ 16 글자 입력하세요.">
				   			<div class="check_font" id="pw_check"></div>
				   		</div>
				  	</div>
				  	
				  	<!-- 비밀번호 정규식 : regex -->
					<div class="row mb-3">
				    	<label for="inputPasswordRegex_Result" class="col-sm-5 "></label>
					    	<div class="col-sm-12">
								<span id="pass_check"></span>
					   		</div>
					</div>		
				  	
					<!-- 비밀번호 확인 (필수)  -->
				  	<div class="row mb-3">
				    	<label for="inputPasswordDupCheck" class="col-sm-5">비밀번호 확인<em style="color:red;">*</em></label>
				    	<div class="col-sm-12">
				     	 	<input type="password" class="form-control" id="member_pass2" name="member_pass2" required="required"
				     	 		   onchange="checkconfirmPasswd(this.value)">
<!-- 				     	 	<div class="check_font" id="pw2_check"></div>    -->
				   		</div>
				  	</div>
				  	
				  	<!-- 비밀번호 와 비밀번호 확인 일치 여부-->
					<div class="row mb-3">
				    	<label for="inputPasswordDupCheck_Result" class="col-sm-5 "></label>
					    	<div class="col-sm-12">
								<span id="pass_confirm"></span>
<!-- 								<font id="pass_confirm" size="2"></font> -->
					   		</div>
					</div>
				    
				    <!-- 이름 (필수)  -->
				  	<div class="row mb-3">
				  		<label for="inputEmail3" class="col-sm-5 col-form-label">이름<em style="color:red;">*</em></label>
				  		<div class="col-sm-12">
				  			<input type="text" class="form-control" id="member_name" name="member_name" required="required"
				  					 onchange="inputName(this.value)">
				 		</div>
				  	</div>
				  	
				  	<!-- 이름 정규식-->
					<div class="row mb-3">
				    	<label for="inputPasswordDupCheck_Result" class="col-sm-5 "></label>
					    	<div class="col-sm-12">
								<span id="name_confirm"></span>
					   		</div>
					</div>
				
					<!-- 생년월일 (필수)  -->
				    <div class="row mb-3">
				  		<label for="inputEmail3" class="col-sm-5 col-form-label">생년월일<em style="color:red;">*</em></label>
				  		<div class="col-sm-12">
				  			<input type="text" class="form-control" id="member_birth" name="member_birth" placeholder="생년월일 8자리를 입력하세요." maxlength="8"
				  				    onchange="inputNum(this.value)" required="required">
				 		</div>
				  	</div>
				  	
				  	<!-- 생년월일 정규식-->
					<div class="row mb-3">
				    	<label for="inputPasswordDupCheck_Result" class="col-sm-5 "></label>
					    	<div class="col-sm-12">
								<span id="birth_check"></span>
					   		</div>
					</div>
				  	
					<!-- 전화번호 (필수) -->
					<div class="row mb-3">
					    <label for="inputCity" class="col-sm-12">전화번호<em style="color:red;">*</em></label>
					    <div class="col-sm-12"> <!-- 여기의 숫자 : input 입력 박스의 길이 조절 -->
						    <div class="input-group">
						    	<c:choose>
						    	<c:when test="${empty member_phone }">
									<input type="text" class="form-control" id="member_phone" name="member_phone" placeholder="- 없이 전화번호를 입력하세요." maxlength="11"
									   onchange="inputNum_phone(this.id)" required="required">
						    		<div class="check_font" id="phone_check"></div>
						    	</c:when>
						    	<c:otherwise>
									<input type="text" class="form-control" id="member_phone" name="member_phone" maxlength="11" value="${member_phone }"
										   oninput="inputNum_phone(this.id)">
						    	</c:otherwise>
						    	</c:choose>
							</div>
					 	</div>
					 </div>
				 	
					<!-- 이메일 (선택)  -->
					<div class="row mb-3">
					    <label for="inputCity" class="col-sm-12">이메일 <font size="2px">(선택)</font></label>
						  	<div class="col-sm-12">
						  		<input type="text" class="form-control" id="member_email" name="member_email" placeholder="이메일 주소를 입력하세요."
						  				onchange="inputEmail(this.value)">
						 	</div>
					</div>
					
				  	<!-- 이메일 정규식-->
					<div class="row mb-3">
				    	<label for="inputPasswordDupCheck_Result" class="col-sm-5 "></label>
					    	<div class="col-sm-12">
								<span id="email_check"></span>
					   		</div>
					</div>

					<!-- 좋아하는 장르(선택) -->				 	
					<div class="row mb-3">
				    	<label for="inputCity" class="col-sm-12">좋아하는 장르<font size="2px">(선택)</font></label>
						<!-- 좋아하는 장르(선택) : 셀렉트 박스 -->
						<div class="col-sm-12">
							<div class="selectBox_movie">
								<select name="member_like_genre" class="select">
									<option value="선택 안함" <c:if test="${member_like_genre=='선택 안함'}">${'selected' }</c:if>>선택 안함</option>
									<option value="로맨스코미디" <c:if test="${member_like_genre=='로맨스 코미디'}">${'selected' }</c:if>>로맨스코미디</option>
									<option value="스릴러"<c:if test="${member_like_genre=='스릴러'}">${'selected' }</c:if>>스릴러</option>
									<option value="공포"<c:if test="${member_like_genre=='공포'}">${'selected' }</c:if>>공포</option>
									<option value="SF"<c:if test="${member_like_genre=='SF'}">${'selected' }</c:if>>SF</option>
									<option value="범죄"<c:if test="${member_like_genre=='범죄'}">${'selected' }</c:if>>범죄</option>
									<option value="액션"<c:if test="${member_like_genre=='액션'}">${'selected' }</c:if>>액션</option>
									<option value="코미디"<c:if test="${member_like_genre=='코미디'}">${'selected' }</c:if>>코미디</option>
									<option value="판타지"<c:if test="${member_like_genre=='판타지'}">${'selected' }</c:if>>판타지</option>
									<option value="음악"<c:if test="${member_like_genre=='음악'}">${'selected' }</c:if>>음악</option>
									<option value="멜로"<c:if test="${member_like_genre=='멜로'}">${'selected' }</c:if>>멜로</option>
									<option value="뮤지컬"<c:if test="${member_like_genre=='뮤지컬'}">${'selected' }</c:if>>뮤지컬</option>
									<option value="스포츠"<c:if test="${member_like_genre=='스포츠'}">${'selected' }</c:if>>스포츠</option>
									<option value="애니메이션"<c:if test="${member_like_genre=='애니메이션'}">${'selected' }</c:if>>애니메이션</option>
									<option value="다큐멘터리"<c:if test="${member_like_genre=='다큐멘터리'}">${'selected' }</c:if>>다큐멘터리</option>
									<option value="기타"<c:if test="${member_like_genre=='기타'}">${'selected' }</c:if>>기타</option>
								</select>
							</div>
						</div>
				 	</div> 
				 	
				 	<!-- 돌아가기 버튼 과 회원가입 버튼  -->
					<div class="col-12 d-flex justify-content-center">
				 		<input type="button" class="btn btn-secondary mr-3 btn-lg" onclick="location.href='./'" value="돌아가기">
				  		<input type="submit" class="btn btn-danger ml-3 btn-lg" value="회원가입">
				  	</div>
				</form>
			</div>
		</div>

	<!-- </section> -->
	</div>
	</article>
  <nav id="mainNav" class="d-none d-md-block sidebar">
  	<%-- 사이드바(최대 width:200px, 최소 width:150px, 전체 화면 사이즈 middle 이하되면 사라짐) --%>
  </nav>
  
  <div id="siteAds"></div>
  <%--페이지 하단 --%>
  <footer id="pageFooter"><%@ include file="../inc/footer.jsp"%></footer>
</body>