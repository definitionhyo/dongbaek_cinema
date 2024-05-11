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

.col-8 {
	margin-top: 100px;
	font-size: 20px;
}


</style>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script type="text/javascript">

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
<!-- 			<form action="MemberIdFind" method="post" name="fr"> -->
				<h2> 아이디 찾기 </h2>
		    	<p class="mb-3 fw-normal">이름과 전화번호를 입력하신 후, 아이디 찾기 버튼을 눌러주세요.</p>
			
				<%-- 아이디 --%>
				<div class="row mb-3">
	              <label for="id" class="col-2 text-nowrap">이름</label>
	              <div class="col-10">
		              ${member_name }
	              </div>
		        </div>
	       
	        
		        <%-- 인증 번호  --%>
				<div class="row mb-3">
	            	<label for="certify" class="col-2 text-nowrap">아이디</label>
	            	<div class="col-10">
						${find_id }
	             	</div>
		        </div>
		        
		        <%-- 아이디 찾기 버튼  --%>
				<div class="row mb-3">
	            	<label for="certify" class="col-2 text-nowrap"></label>
	            	<div class="col-10">
	            		<button class="btn btn-outline-danger btn-lg ml-3" type="button" onclick="location.href='./'">메인 화면</button>
	            		<button class="btn btn-outline-danger btn-lg ml-3" type="button" onclick="location.href='member_login_form'">&nbsp;&nbsp;로그인&nbsp;&nbsp;</button>
<!-- 						<input type="button" value="메인 화면" onclick="location.href='./'"> -->
<!-- 						<input type="button" value="로그인 화면" onclick="location.href='member_login_form'"> -->
<!-- 						<input type="button" value="비밀번호 찾기" onclick="location.href='member_passwd_find'"> -->
	             	</div>
		        </div>
<!-- 		    </form> -->
		

		    
		    
		</div>
	</div>
</div>
		
			
			
			
			
			
<!-- 			<table border="1"> -->
<!-- 				<tr> -->
<!-- 					<th>아이디</th> -->
<!-- 					<td> -->
<!-- 						<input type="text" name="member_id" placeholder="비밀번호 변경 시 입력"> -->
					
<!-- 					</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<th>변경할 비밀번호</th> -->
<!-- 					<td> -->
<!-- 						키 누를때마다 checkNewPasswd() 함수에 입력받은 패스워드 전달하여 호출 -->
<!-- 						<input type="text" name="member_pass" maxlength="15" placeholder="비밀번호 변경 시 입력"> -->
<!-- 						<span id="checkNewPasswdResult"></span> -->
<!-- 					</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<th>변경할 비밀번호 확인</th> -->
<!-- 					<td> -->
<!-- 						키 누를때마다 checkConfirmNewPasswd() 함수에 입력받은 패스워드 전달하여 호출 -->
<!-- 					</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td colspan="2" align="center"> -->
<!-- 						<input type="submit" value="정보수정"> -->
<!-- 						<input type="button" value="돌아가기" onclick="history.back()"> -->
<!-- 					</td> -->
<!-- 				</tr> -->
<!-- 			</table> -->
<!-- 		</form> -->
  
  </article>
  
  <nav id="mainNav" class="d-none d-md-block sidebar">
  <%--왼쪽 사이드바 --%>
  </nav>
  
  <div id="sieAds"></div>t
  <%--페이지 하단 --%>
  <footer id="pageFooter"><%@ include file="../inc/footer.jsp"%></footer>
</body>