<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<head>

<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
	integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
	integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js"
	integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
	crossorigin="anonymous"></script>
<link
	href="${pageContext.request.contextPath }/resources/css/default.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath }/resources/css/sidebar.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath }/resources/css/button.css"
	rel="stylesheet" type="text/css">


<title>영화 예매 사이트</title>
<style>
	<%-- a링크 활성화 색상 변경 --%>
	a:hover, a:active{
	 color:  #ff5050 !important;
		
	}
	
</style>

<script type="text/javascript">
	function selectDomain(domain) {
		// 직접입력의 경우 널스트링("") 값이 할당되어 있으므로
		// 모든 값을 email2 영역에 표시하면 직접입력 선택 시 널스트링이 표시됨
		document.fr.email2.value = domain;
	}
	
	function isPhoneNum(phone) {
		let getPhone = RegExp(/^(010|011)[\d]{3,4}[\d]{4}$/);
		
		if(!getPhone.test(phone)) {
			$("#phoneCkArea").text("올바른 전화번호를 입력하세요");
			$(this).focus();
		} else {
			$("#phoneCkArea").empty();
			$("button[type='submit']").attr("disabled", false);
		}
	}
	
</script>

</head>
<body>
 <header id="pageHeader">
 <%--네비게이션 바 영역 --%>
  <%@ include file="../inc/header.jsp"%>
 </header>
 
  <article id="mainArticle">
  <%--본문내용 --%>
  
   <div class="container-fluid w-900" >
	 <nav aria-label="breadcrumb">
	  <ol class="breadcrumb bg-white">
	    <li class="breadcrumb-item"><a href="cs_main">고객센터 홈</a></li>
	    <li class="breadcrumb-item active" aria-current="page">1:1 문의</li>
	  </ol>
	</nav>
  
<h1>1:1문의</h1>
<br>
<form action="csQnaPro" method="post" name="fr" enctype="multipart/form-data">
	<table class="table" >
		<tr>
			<th>
			  	문의 유형<em style="color: #EB323A;">*</em> 
			</th>
			<td>
				<select name="cs_type" required="required">
	   				<option value="">선택</option>
					<option value="영화정보문의">영화정보문의</option>
					<option value="회원 문의">회원 문의</option>
					<option value="예매 결제 관련 문의">예매 결제 관련 문의</option>
					<option value="일반 문의">일반 문의</option>
				</select>
			</td>
 		</tr>
 		<tr>
			<th>
				아이디<em style="color: #EB323A;">*</em>&nbsp;&nbsp;&nbsp;
			</th>
			<td>
				
				<input type="text" name="member_id" required="required" readonly="readonly" value="${sessionScope.member_id }">
			</td>
		</tr>
		<tr>
			<th>
				이메일<em style="color: #EB323A;"></em>
			</th>
			<td>
				<input type="text" id="email1" style="width:150px" maxlength="15">
				@ <input type="text" id="email2">
					<select name="emailDomain" onchange="selectDomain(this.value)">
						<option value="">직접입력</option>
						<option value="naver.com">naver.com</option>
						<option value="gmail.com">gmail.com</option>
						<option value="nate.com">nate.com</option>
					</select>
				<%-- (값을 받아 저장x, but 사용 시 hidden으로 결합된 이메일주소 값 받기 --%>
				<input type="hidden" name="cs_email">
			</td>
		</tr>
		<tr>
			<th>
				휴대전화<em style="color: #EB323A;">*</em> 
			</th>
			<td>
				<input type="text" name="cs_phone" width="3em" maxlength="11" required="required" onkeyup="isPhoneNum(this.value)">
				<span id="phoneCkArea"></span>
<!-- 				<input type="text" name="phone-number1" width="3em" maxlength="3"> -->
<!-- 				-<input type="text" name="phone-number2" width="5em" maxlength="4"> -->
<!-- 				-<input type="text" name="phone-number3" width="5em"  maxlength="4"> -->
			</td>
		</tr>
  		<tr>
    		<th>
    			제목<em style="color: #EB323A;">*</em>
    		</th>
    		<td>
    			<textarea rows="1" cols="20" name="cs_subject" required="required" maxlength="30"></textarea>
    		</td>
  		</tr>
  		<tr>
    		<th>
	    		내용<em style="color: #EB323A;">*</em>
	    	</th>
	    	<td>
	    		<textarea rows="5" cols="70" name="cs_content" required="required"
	    			placeholder="-문의내용에 개인정보가 포함되지 않도록 유의하시기 바랍니다.&#13;&#10;-회원로그인 후 문의작성시 나의 문의내역을 통해 답변을 확인하실 수 있습니다."></textarea>
    		</td>
  		</tr>
  		<tr>
    		<th>
    			사진첨부
    		</th>
    		<td>
    			<input type="file" name="cs_file">
    		</td>
  		</tr>
  		<tr>
	  		<td colspan="2" style="text-align: center">
				<button class="btn btn-danger" disabled="disabled" type="submit">등록</button>	
	  		</td>
  		</tr>
	</table>
</form>
		
	</div>

  </article>
  
  <nav id="mainNav" class="d-none d-md-block sidebar">
  <%--왼쪽 사이드바 --%>
	<jsp:include page="/WEB-INF/views/sidebar/sideBar_cs.jsp"></jsp:include>
  </nav>
  
  <div id="siteAds"></div>
  <%--페이지 하단 --%>
  <footer id="pageFooter"><%@ include file="../inc/footer.jsp"%></footer>
</body>