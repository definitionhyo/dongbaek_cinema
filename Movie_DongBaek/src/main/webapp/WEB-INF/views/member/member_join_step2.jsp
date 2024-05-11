<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<head>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<title>동백시네마 회원가입 2. 약관동의</title>
<!-- <script src="../js/jquery-3.7.0.js"></script> -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script type="text/javascript">
	// 전체선택 체크박스 체크 시 하위 체크박스 모두 checked로 변경
	$(function() {
		$("#checkAll").on("change", function() {
			if($("#checkAll").is(":checked")) { // 체크 시
				$(":checkbox").prop("checked", true);
			} else { // 체크해제 시				
				$(":checkbox").prop("checked", false);
			}
		});
	});
</script>
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

.terms_box {
    overflow: auto;
    box-sizing: border-box;
    max-height: 100px;
    margin: 9px 0 0 32px;
    padding: 15px;
    border-radius: 6px;
    border: 1px solid #d6d6d6;
}


input[type=checkbox], input[type=radio] {
    box-sizing: border-box;
    padding-right: 10px;
    height: 17px;
    width: 17px;
}

.terms_p {
	margin-top: 35px;
}
</style>
</head>
<body>
<%--네비게이션 바 영역 --%>
<header id="pageHeader"><%@ include file="../inc/header.jsp"%></header>
		<article id="mainArticle">
	<!-- 	<div class="container-fluid w-900" style="border: 1px solid gray"> -->
		<%--본문내용 --%>
	 	 	<!-- 4단계 탭 -->
	 	 		<%-- 네이게이션 중앙 정렬 : justify-content-center --%>
	 		<nav class=	"nav nav-pills justify-content-center">
	  			<a class="nav-link" aria-current="page">본인인증</a>
	 			<a class="nav-link active btn-danger">약관동의</a>
				<a class="nav-link">정보입력</a>
				<a class="nav-link">가입완료</a>
			</nav>
	  		<hr>
	  		
	  	<%-- 마게팅 약관의 동의를 파라미터로  다음 페이지인 정보 입력 페이지로 넘긴 후에 DB로 INSERT --%>
		<form action="member_join_step3" method="post">
			<div class="container-fluid w-600">
		  		<!-- 약관 전체 동의 체크박스 - jQuery 기능 구현 -->
		  		<div class="terms_p">
		  			<p class="terms_check_all">
		            	<span class="input_check">
		                	<input type="checkbox" id="checkAll" name="checkAll">
			                <label for="checkAll">
			                	<span class="checkAll_txt "> 전체 동의하기 <br>
			                		 <h5>동백씨-네마 이용약관, 개인정보 수집 및 이용, 마케팅 활용을 위한 개인 정보 수집 이용 안내(선택)</h5>
			                	</span>
			                </label>
		                </span>
					</p>
		  		</div>
		         <%-- 약관 1 : 필수 항목 : required  --%>
		  		<div class="terms_p">
		  			<p class="terms_check">
		            	<span class="input_check">
		                	<input type="checkbox" id="check1" name="check1" required="required">
		                <label for="check1">
		                	<span class="check1_txt">
		                		동백극장 이용약관 동의<em style="color: #ef4f4f; font-style: normal;"> (필수) </em>
		                		<%-- 수정 필요 : textarea 웹 화면에서 크기 조절이 가능한 상태
		                		크기 조절이 불가능하게 바꾸어야 함 --%>
		                		<div class="terms_box">
<!-- 		 							<textarea class="form-control" id="floatingTextarea" readonly="readonly"> -->
		 							 여러분을 환영합니다.
									 동백씨-네마 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 
									 본 약관은 다양한 동백씨-네마 서비스의 이용과 관련하여 동백씨-네마 서비스를 제공하는 동백씨-네마 주식회사(이하 ‘동백씨-네마’)와
									 이를 이용하는 동백씨-네마 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 
									 아울러 여러분의 동백씨-네마 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.

										동백씨-네마 서비스를 이용하시거나 동백씨-네마 서비스 회원으로 가입하실 경우 여러분은 본 약관 및 관련 운영 정책을 확인하거나 동의하게 되므로, 
									잠시 시간을 내시어 주의 깊게 살펴봐 주시기 바랍니다.
<!-- 		 							</textarea> -->
		 							<label for="floatingTextarea"></label>
								</div>
		                	</span>
		                </label>
		                </span>
					</p>
		  		</div>
		  		
		        <%-- 약관 2 : 필수 항목 : required  --%>
		  		<div class="terms_p">
		  			<p class="terms_check">
		            	<span class="input_check"> 
		            		<!-- 필수 항목 : required 속성-->
		                	<input type="checkbox" id="check2" name="check2" required="required">
		                <label for="check2">
		                	<span class="check2_txt">
		                		개인정보 수집 및 이용 동의 <em style="color: #ef4f4f; font-style: normal;"> (필수) </em>
<!-- 								<div class="form-floating overflow-auto"> -->
								<div class="terms_box">
<!-- 		 							<textarea class="form-control" placeholder="Leave a comment here" id="floatingTextarea" readonly="readonly"> -->
		 								개인정보보호법에 따라 동백씨-네마 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 및 이용목적, 개인정보의 보유 및 이용기간, 
		 								동의 거부권 및 동의 거부 시 불이익에 관한 사항을 안내 드리오니 자세히 읽은 후 동의하여 주시기 바랍니다.
<!-- 		 							</textarea> -->
								</div>
		                	</span>
		                </label>
		                </span>
					</p>
		  		</div>
		  		
		  		<%-- 약관 3 : 선택 항목 --%>
		  		<%-- 파라미터로 다음 페이지로 가지고 가야하는 항목 --%>
		  		<div class="terms_p">
		  			<p class="terms_check">
		            	<span class="input_check">
		            		<!-- 필수 항목 : required 속성 -->
		            		<%-- 선택 사항 중 마케팅 활용은 컬럼이 있어 id로 컬럼명 넣음 --%>
		                	<input type="checkbox" id="check3" name="member_agree_marketing" name="check3">
		                <label for="check3">
		                	<span class="check3_txt">
		                		마케팅 활용을 위한 개인 정보 수집 이용 안내(선택)
								<div class="terms_box">
<!-- 		 							<textarea class="form-control" placeholder="Leave a comment here" id="floatingTextarea" readonly="readonly"></textarea> -->
									네이버 서비스 및 제휴 이벤트・혜택 등의 정보를 휴대전화(네이버앱 알림 또는 문자), 이메일로 받을 수 있습니다. 
									일부 서비스(별개의 회원 체계 운영, 네이버 가입 후 추가 가입하는 서비스 등)의 경우, 수신에 대해 별도로 안내드리며 동의를 구합니다.
								</div>
		                	</span>
		                </label>
		                </span>
					</p>
		  		</div>
		  		
		  		<%-- 네이버 callback 구현--%>
		  		<script type="text/javascript">
// 					  var naver_id_login = new naver_id_login("FapLXYLoVFVUWfuqISrN", "http://localhost:8089/dongbaekcinema/member_join_step2");
					  var naver_id_login = new naver_id_login("FapLXYLoVFVUWfuqISrN", "http://c5d2302t1.itwillbs.com/Movie_DongBaek/member_join_step2");
					  // 접근 토큰 값 출력
// 					  alert(naver_id_login.oauthParams.access_token);
// 					  네이버 사용자 프로필 조회
					  if (naver_id_login.is_callback == true){
						  naver_id_login.get_naver_userprofile("naverSignInCallback()");
					  }
					  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
					  function naverSignInCallback() {
						 // 수정 필요 - 휴대전화 와 이름 가져오기 
// 					    alert(naver_id_login.getProfileData('email'));
// 					    alert("b" + naver_id_login.getProfileData('nickname'));
// 					    alert("c" + naver_id_login.getProfileData('age'));
// 					    naver_id_login.getProfileData('email');
					    sessionStorage.setItem('member_email', naver_id_login.getProfileData('email'));
// 					    naver_id_login.getProfileData('nickname');
// 					    naver_id_login.getProfileData('age');
					  }

				</script>
				
		  		
		<!-- 		<div class="d-grid gap-2"> -->
				<div class="col-12 d-flex justify-content-center">
					<!-- 취소 버튼 클릭 시 메인페이지로 돌아가기 -->
					<!-- 확인 버튼 클릭 시 다음 단계인 정보입력 페이지로 넘어아기 -->
		  			<button class="btn btn-secondary mr-3 btn-lg" type="button" onclick="location.href='./'">&nbsp;&nbsp;취소&nbsp;&nbsp;</button>
		  			<button class="btn btn-danger ml-3 btn-lg" type="submit">&nbsp;&nbsp;확인&nbsp;&nbsp;</button>
				</div>
			</div>
		</form>
  </article>
  <nav id="mainNav" class="d-none d-md-block sidebar">
  	<%-- 사이드바(최대 width:200px, 최소 width:150px, 전체 화면 사이즈 middle 이하되면 사라짐) --%>
  </nav>
  
  <div id="siteAds"></div>
  <%--페이지 하단 --%>
  <footer id="pageFooter"><%@ include file="../inc/footer.jsp"%></footer>
</body>