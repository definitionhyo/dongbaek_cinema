<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>

<!doctype html>
<head>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<!-- <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script> -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/sidebar.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/button.css" rel="stylesheet" type="text/css">
<title>동백시네마 회원로그인</title>
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
.w-500{
	width: 500px;
}
.h-500{
	height: 500px;
}

div {
	background-color: transparent;
}

.inputArea {
/* 	 border: 1px solid red; */
	 padding: 15px 20px 10px 20px;
}

.col-3 {
	padding: 0;
}

.col-3>img {
	margin-left: 20px;
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
.container-fluid{
/* 	border: 1px solid gray; */
}

.atext {
	color: #aaa;
	font-weight: bold;
}

.atext:hover {
	color: #dc3545;
}

#naverIdLogin_loginButton {
	border-radius: 5px;
}

</style>
<script type="text/javascript">
	$(function() {
		$("#button-addon1").on("click", function() {
			$("#button-addon1").attr("value", "재전송");			
		});
	});
	
	$(function() {
		$("#button-addon2").on("click", function() {
			$("#button-addon2").attr("value", "확인완료");			
		});
	});
	
	
</script>

<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
</head>
<body>
  <%--네비게이션 바 영역 --%>
  <header id="pageHeader"><%@ include file="../inc/header.jsp"%></header>
 
  <article id="mainArticle">
  <%--본문내용(width: 900px) --%>
  <div class="container-fluid w-900">
 	<%-- 
	  .nav-link:hover 시 글자색 #ef4f4f 
	  .nav-link.active 배경색 #ef4f4f
	  --%>
	<header class="d-flex justify-content-center py-3">
      <ul class="nav nav-pills">
        <li class="nav-item"><a href="#" class="nav-link active" aria-current="page">회원로그인</a></li>
			<%-- 받아온 값 다시 넘기기 --%>
        <li class="nav-item"><a href="no_member_login_form" class="nav-link">비회원 로그인</a></li>
        <li class="nav-item"><a href="no_member_reservation_check_form" class="nav-link">비회원 예매확인</a></li>
      </ul>
    </header>
	
	<div class="row d-flex justify-content-center mt-3">
	  <div class="col-8 inputArea">	<%-- 전체 12개의 col중에 가운데 8개의 col 사용 --%>
		<form action="member_login_pro" method="post">
		    <p class="mb-3 fw-normal">아이디와 비밀번호를 입력하신 후, 로그인 버튼을 눌러주세요.</p>
			
                  
			<%-- 아이디 --%>
			<div class="row mb-3">
              <label for="id" class="col-2 text-nowrap">아이디</label>
              <div class="col-10">
              		<%-- 쿠키에 member_id가 있으면 쿠키에서 id를 가져와 보여주기 --%>
	              <input type="text" class="form-control" name="member_id" id="member_id" placeholder="아이디" required="required" value="${cookie.member_id.value }">
              </div>
	        </div>
	        
	        <%-- 비밀번호 --%>
			<div class="row mb-3">
              <label for="passwd" class="col-2 text-nowrap">비밀번호</label>
              <div class="col-10">
	              <input type="password" class="form-control" name="member_pass" id="member_pass" placeholder="비밀번호" required="required">
              </div>
	        </div>
		
			<%-- 아래 버튼들... --%>
		    <div class="row checkbox mb-3">
		      <label class="col-6" >
		      	<%-- 쿠키에 member_id가 있는 경우 check 상태로 보이게 하기  --%>
		      	<input type="checkbox" name="remember_me" <c:if test="${not empty cookie.member_id}">checked</c:if> > 아이디 저장
		      </label>
		      <div class="col-6" >
			      <span>
			        <a href="member_join_step1" class="atext">회원가입</a>
			      </span>
			      &nbsp;&nbsp;
			      <span>
			        <a href="MemberModifyFormId" class="atext">아이디</a>
			      </span>
			      /
			      <span>
			        <a href="MemberFindPasswd" class="atext">비밀번호 찾기</a>
			      </span>
		      </div>
<!-- 		      <span class="col-2 d-flex justify-content-end"> -->
<!-- 		        <a href="member_join_step1">회원가입</a> -->
<!-- 		      </span> -->
<!-- 		      <span class="col-2 d-flex justify-content-end"> -->
<!-- 		        <a href="MemberModifyFormId" >아이디 찾기</a> -->
<!-- 		      </span> -->
<!-- 		      <span class="col-2 d-flex justify-content-end"> -->
<!-- 		        <a href="MemberFindPasswd" >비밀번호 찾기</a> -->
<!-- 		      </span> -->
		    </div>
		    
		    <%-- '로그인' 버튼 --%>
		    <button class="w-100 btn btn-lg btn-red mb-3" type="submit">로그인</button>
		    
		    <%-- 다른 로그인 방법 --%>
		    <div class="row d-flext justify-content-center">
		    	<%-- 네이버 --%>
		    	<div class="col-3">
		    		<%--  네이버 로그인 버튼 노출 영역  --%>
		    		<img id="naverIdLogin_loginButton" alt="naver" src="${pageContext.request.contextPath }/resources/img/btnG_축약형2.png" height="50px">
<!-- 		    		<a id="naverIdLogin_loginButton" href="javascript:void(0)"><span>네이버</span></a> -->
					<br>
		    	</div>
		    		<!--  네이버 로그인 시작 -->
					<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
					<script type="text/javascript">
// 						$('#naverIdLogin_loginButton').on('click', function() {
// 							let url = "https://nid.naver.com/oauth2.0/authorize?"
// 											+ "response_type=code"
// 											+ "&client_id=FapLXYLoVFVUWfuqISrN"
// 											+ "&redirect_uri=http://localhost:8089/dongbaekcinema/member_join_step2"
// 											+ "&state=test";
// 							window.open(url, "loginForm", "");
// 						});
					</script>
					
					<script>
					var naverLogin = new naver.LoginWithNaverId(
							{
								clientId: "FapLXYLoVFVUWfuqISrN", // cliendId
// 								callbackUrl: "http://localhost:8089/dongbaekcinema/member_join_step2", // Callback URL 
								callbackUrl: "http://c5d2302t1.itwillbs.com/Movie_DongBaek/member_join_step2", // Callback URL 
								isPopup: false,
								callbackHandle: true
							} );
					
					naverLogin.init();
					
					$('#naverIdLogin_loginButton').on('click', function() {
					    naverLogin.getLoginStatus(function(status) {
					    	
// 					    	alert("a333333333333333333333333333333333" +status); // false
					    	
					    	if (status) {
					            var email = naverLogin.user.getEmail();
					            console.log(email);
					            console.log(naverLogin);
					            
					            $.ajax({
					                type: 'post',
					                url: 'checkUserNaver',
					                data: {email:email},
					                dataType: 'text',
					                success: function(response) {
					                  console.log(response);
					                  if (response === 'new') {
					                	  sessionStorage.setItem('email', member_email);
					                	  location.href = '<c:url value="/member_join_step2"/>';
					                	  alert(' 네이버 로그인 성공! 회원가입을 완료해주세요. ');

					                  }  else if (response === 'existing') { 
					                	  sessionStorage.removeItem("email");
					                	  location.href = '<c:url value="/" />';
					                	  alert(' 네이버 로그인 성공!')
					                  }
					                },
					                error: function(xhr, status, error) {
					                  console.log(error);
					                }
					            });
					    	} else {
// 					            alert("fail");
					        }
					    });
					});
				</script> 
		    	
		    	<%-- 카카오 --%>
		    	<div class="col-3">
<!-- 			    	<button type="button" id="submit-btn" onclick="loginWithKakao()"> -->
			    		<img alt="kakao" src="${pageContext.request.contextPath }/resources/img/kakao_login_medium.png" height="50px" onclick="loginWithKakao()">
<!-- 			    	</button> -->
		    	</div>
		    	<%-- 카카오 로그인 --%>
		    	<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.js"></script>
		    	<!-- 카카오 로그인 시작 -->
				<script type="text/javascript">
					Kakao.init('17e8c8c84f86f6d5956a91da31df8878');	// 카카오에서 받아온 앱 키
					Kakao.isInitialized();
					
					function loginWithKakao() {
						Kakao.Auth.login({
							
						// 이 부분은 생략가능한 부분인데, 이용 중 동의를 설정했을 때 scope에 추가해주면 됨
						scope: "profile_nickname, account_email",
						success: function (response) {
							Kakao.API.request({
							url: '/v2/user/me',
							success: function (response) {
								
								// 이메일과 닉네임을 변수에 저장
								// 다른 값들을 받고 싶으면 response.XXX 해서 꺼내오면 된다!
								var email = response.kakao_account.email;
								var nickname = response.kakao_account.profile.nickname;
								
								// JSON 객체 출력하기
								// 카카오 로그인을 성공하면 여기에 전달받은 값들이 출력됨
// 								alert(JSON.stringify(response));
								
								// 여기서 부터는 직접 구현해야 하는 부분임!
								// 이메일을 사용하여 회원가입 여부 판별할 예정임
								// DB에 회원 이메일(아이디)이 존재하면? => 바로 사이트 로그인 처리
								// 존재하지 않으면? => 카카오에서 전달받은 값들을 바탕으로 회원가입 진행
								$.ajax({
									// 이메일 판별을 하기 위해서 아래 주소로 ajax 요청
									// 각자 주소에 맞게 변경하면 됨!
									url: '<c:url value="/checkKakao"/>',
									method: 'POST',
									data: {email: email, nickname: nickname},
									success: function (result) {
										
										if (result === 'new') {	// DB에 없는 새로운 이메일!
											// DB에 카카오에서 받아온 이메일이 존재하지 않을 경우 => 회원가입 진행
											alert('카카오 로그인 성공! 회원가입을 완료해주세요');
// 											console.log('카카오 로그인 성공! 회원가입을 완료해주세요');
											
											// 회원가입 진행시 자동으로 값을 입력해주기 위해서
											// 로컬의 세션 스토리지에 이메일 저장
											sessionStorage.setItem('member_email', email);
											sessionStorage.setItem('member_name', nickname);
											
											// 회원가입 페이지로 이동
											location.href = '<c:url value="/member_join_step2"/>';
											
										} else if (result === 'existing') {	// DB에 있는 이메일!
											alert('카카오 로그인 성공!')
											// DB에 이메일이 존재할 경우 => 이미 가입된 회원인 경우
											// 세션 스토리지 값 비우기
											sessionStorage.removeItem("member_email");
											sessionStorage.removeItem("member_name");
											
											console.log('기존 회원이므로 로그인 처리 진행');
											
											// 로그인 완료 후 메인 페이지로 이동
											location.href = '<c:url value="/" />';
										}
									}
								});
							},
							fail: function (error) {
								alert(JSON.stringify(error));
							}
						});
					},
					fail: function (error) {
					alert(JSON.stringify(error));
					}
				});
				}
				</script>
				<!-- 카카오 로그인 끝 -->
				
		    	<%-- qr --%>
<!-- 		    	<div class="col-2"> -->
<%-- 			    	<a href="#"><img alt="qr" src="${pageContext.request.contextPath }/resources/img/qr.png" width="50px" height="50px"></a> --%>
<!-- 		    	</div> -->
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