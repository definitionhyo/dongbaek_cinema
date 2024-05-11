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
	
// 비밀번호 정규식
function checkPass(memberNewPasswd) {
	let regex = /^[A-Za-z0-9!@#$%]{8,16}$/;
	
	if(regex.exec(memberNewPasswd)) {
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
	
	let memberNewPasswd = document.fr.memberNewPasswd.value;
	
	if(memberNewPasswd == passwdCheck) {
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
		<div class="row d-flex justify-content-center mt-3">
			<div class="col-8">	<%-- 전체 12개의 col중에 가운데 8개의 col 사용 --%>
				<form action="MemberWithdrawal" method="post" name="fr" class="fr">
			    	<input type="hidden" name="member_id" value="${member_id }">
			    	   	<h2>탈퇴하기</h2>
			    	<p class="mb-3 fw-normal">
			    		탈퇴를 원하신다면 비밀번호를 정확하게 입력해주세요. </p>
			    	
					<hr>
				
					<%-- 아이디 --%>
					<div class="row mb-3">
		            	<label for="id" class="col-sm-5 ">아이디</label>
		            		<div class="col-sm-6">
		            			${member_id }
		            		</div>
			        </div>
			        
			        	<!-- 비밀번호 (필수)  -->
					  	<div class="row mb-3">
					    	<label for="inputPassword" class="col-sm-5 "> 비밀번호 <em style="color:red;">*</em></label>
					    	<div class="col-sm-6">
					     	 	<input type="password" class="form-control" id="withdrawalPasswd" name="withdrawalPasswd" required="required" 
					     	 		   onchange="checkPass(this.value)" placeholder="">
					   		</div>
					  	</div>
					  	
<!-- 					  	비밀번호 정규식 : regex -->
<!-- 						<div class="row mb-3"> -->
<!-- 					    	<label for="inputPasswordRegex_Result" class="col-sm-5 "></label> -->
<!-- 						    	<div class="col-sm-12"> -->
<!-- 									<span id="pass_check"></span> -->
<!-- 						   		</div> -->
<!-- 						</div>		 -->
					  	
						<!-- 비밀번호 확인 (필수)  -->
					  	<div class="row mb-3">
					    	<label for="inputPasswordDupCheck" class="col-sm-5"> 비밀번호 확인 <em style="color:red;">*</em></label>
					    	<div class="col-sm-6">
					     	 	<input type="password" class="form-control" id="withdrawalPasswd2" name="withdrawalPasswd2" required="required"
					     	 		   onchange="checkconfirmPasswd(this.value)" placeholder="">
					   		</div>
					  	</div>
					  	
					  	<!-- 비밀번호 와 비밀번호 확인 일치 여부-->
						<div class="row mb-3">
					    	<label for="inputPasswordDupCheck_Result" class="col-sm-5 "></label>
						    	<div class="col-sm-12">
									<span id="pass_confirm"></span>
						   		</div>
						</div>
			        
				        <%-- 비밀번호 변경 버튼  --%>
						<div class="row mb-3">
			            	<label for="certify" class="col-2 text-nowrap"></label>
			            	<div class="col-10">
<!-- 								<input type="submit" id="DoneBtn" value="탈퇴하기"> -->
								<button class="btn btn-outline-danger btn-lg ml-3" type="submit">탈퇴하기
								</button>
			             	</div>
				        </div>
				    </form>
	
	  		</div>
	  	</div>
	  </div>
  </article>
  
  <nav id="mainNav" class="d-none d-md-block sidebar">
  <%--왼쪽 사이드바 --%>
  </nav>
  
  <div id="sieAds"></div>
  <%--페이지 하단 --%>
  <footer id="pageFooter"><%@ include file="../inc/footer.jsp"%></footer>
</body>