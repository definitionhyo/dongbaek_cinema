<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<title>회원가입 4. 가입완료</title>
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

.container-fluid {
	margin: 10rem;
}
article {
	justify-content: center;
		align-items: center;
		margin: 2em auto;
}
</style>
<script type="text/javascript">
	
	// 회원가입 전 로컬 세션스토리지에 저장한 값들 초기화시키기
	$(function() {
		sessionStorage.removeItem("member_email");
		sessionStorage.removeItem("member_name");
		sessionStorage.removeItem("member_phone");
	});
	
	
</script>
</head>
<body>
	<%--네비게이션 바 영역 --%>
	<header id="pageHeader"><%@ include file="../inc/header.jsp"%></header>
 	
	<%--본문내용 --%>
	<article id="mainArticle">
			<!-- 4단계 탭 -->
	 		<nav class=	"nav nav-pills justify-content-center">
	  			<a class="nav-link" aria-current="page" href="#">본인인증</a>
	 			<a class="nav-link" href="#">약관동의</a>
				<a class="nav-link" href="#">정보입력</a>
				<a class="nav-link active btn-danger" href="#">가입완료</a>
			</nav>
			<hr>
		<div class="container-fluid w-900 d-flex justify-content-center">
			<div class="row row1">
				<div class="col-12">
					<div class="row">
						<div class="col-xl-12">
							<h1 align="center">
								동백 시네마 회원 가입을 축하합니다!
							</h1>			
						</div>
					</div>
					<div class="row row2">
						<div class="col-xl-12">
							<button type="submit" class="btn btn-primary btn-secondary mr-3 btn-lg" onclick="location.href='member_login_form'">&nbsp;&nbsp;&nbsp;로그인&nbsp;&nbsp;&nbsp;</button>
				  			<button type="submit" class="btn btn-primary btn-danger ml-3 btn-lg" onclick="location.href='./'">메인페이지</button>				
						</div>
					</div>
				</div>
			</div>
		</div>
  	</article>
  
