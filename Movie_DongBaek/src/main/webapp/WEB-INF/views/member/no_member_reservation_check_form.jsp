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
	 padding: 15px 20px 0 20px;
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

</head>
<body>
  <%--네비게이션 바 영역 --%>
  <header id="pageHeader"><%@ include file="../inc/header.jsp"%></header>
 
  <article id="mainArticle">
  <%--본문내용 (width: 900px) --%>
  <div class="container-fluid w-900">
 	<%-- 회원로그인/비회원로그인/비회원예매 확인 탭 --%>
	<header class="d-flex justify-content-center py-3">
      <ul class="nav nav-pills">
        <li class="nav-item"><a href="member_login_form" class="nav-link">회원로그인</a></li>
        <li class="nav-item"><a href="no_member_login_form" class="nav-link">비회원로그인</a></li>
        <li class="nav-item"><a href="no_member_reservation_check_form" class="nav-link active" aria-current="page">비회원예매 확인</a></li>
      </ul>
    </header>
	
	<%-- 비회원예매 확인 폼 --%>
	<div class="row d-flex justify-content-center mt-3">
		<div class="col-8 inputArea">	<%-- 전체 12개의 col중에 가운데 8개의 col 사용 --%>
		<form action="noMemberCheckPro" method="post">
			<%-- 이름 --%>
            <div class="row mb-3">
              <label for="name" class="col-2 text-nowrap">이름</label>
              <div class="col-10">
	              <input type="text" class="form-control" id="member_name" name="member_name" placeholder="이름" required="required">
              </div>
            </div>
            
            <%-- 휴대폰번호 --%>
            <div class="row mb-3">
              <label for="phoneNum" class="col-2 text-nowrap">휴대폰번호</label>
              <div class="col-10">
				  	<input type="text" class="form-control" id="member_phone" name="member_phone" maxlength="11"
				  			 placeholder="- 없이" required="required">
              </div>
            </div>
            
            <%-- 비밀번호 --%>
            <div class="row mb-3">
              <label for="passwd" class="col-2 text-nowrap">비밀번호</label>
              <div class="col-10">
	              <input type="password" class="form-control" id="member_pass" name="member_pass" maxlength="4"
	              		placeholder="비밀번호(4자리)" required="required">
	          </div>
            </div>
            
		    <p class="mb-3 fw-normal">
		    	* 비회원 정보 오 입력 시 예매 내역 확인/취소 및 티켓 발권이 어려울 수 있으니 다시 한번 확인해 주시기 바랍니다.
		    </p>
		
		    <button class="w-100 btn btn-lg btn-red mb-3" type="submit">비회원예매 확인</button>
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