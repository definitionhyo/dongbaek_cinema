<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
	function logout() {
		// 컨펌창으로 로그아웃 여부 한번 확인 후 로그아웃하기
		let isLogout = confirm("로그아웃 하시겠습니까?");
		
		// isLogout이 true일 때 member_logout 서블릿 요청
		if(isLogout) {	// 로그아웃하겠다
			location.href = "member_logout";
		}
	}

</script>

<nav id="global">

<span id="navbar-memberbox">
	<%-- JSTL과 EL을 사용하여 로그인여부 뷰화면에 보여주기 --%>
	<%-- EL의 내장객체 sessionScope 에 접근하여 "sId" 속성값 판별 --%>
	<c:choose>
		<c:when test="${empty sessionScope.member_id }">
			<a href="member_login_form">로그인</a> &nbsp;
			<a href="member_join_step1">회원가입</a> &nbsp;
		</c:when>
		<c:otherwise>
			<%-- 아이디 클릭 시 회원 정보 조회를 위한 MemberInfo.me 요청(아이디 전달) --%>
			 <a href="myPage?id=${sessionScope.member_id }">${sessionScope.member_id }님</a> &nbsp;
			<%-- 로그아웃하기전에 알림창띄우기 위해 javascript로 함수 한번 쓰기 --%>
			 <a href="javascript:logout()">로그아웃</a> &nbsp;
		</c:otherwise>
	</c:choose>
		<%-- 만약, 세션 member_type이 "직원" 일 경우 관리자페이지(admin_main) 링크 표시 --%>
		<c:if test="${member_type eq '직원' }">
			 <a href="admin_main">관리자페이지</a>
		</c:if>
</span>
</nav>
<nav class="navbar  navbar-light bg-light" >
     <ul class="nav" >
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarToggleExternalContent" aria-controls="navbarToggleExternalContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
  <li class="nav-item" >
    <a class="nav-link menuItem" href="movie_list_present" style="background-color:white; color:black;">영화</a>
  </li>
  <li class="nav-item">
    <a class="nav-link menuItem" href="reservation_main" style="background-color:white; color:black;">예매</a>
  </li>
  <li class="nav-item" style=margin-right:30px>
    <a class="nav-link menuItem" href="theater_main" style="background-color:white; color:black;">영화관</a>
  </li>
  <a class="navbar-brand" href="./">

   <img src="${pageContext.request.contextPath}/resources/img/logo2.png" width="220"  alt="">

    </a>
  <li class="nav-item" style=margin-left:30px>
    <a class="nav-link active menuItem" href="grade" style="background-color:white; color:black;">멤버십</a>
  </li>
  <li class="nav-item">
    <a class="nav-link menuItem" href="snack_main" style="background-color:white; color:black;">스토어</a>
  </li>
  <li class="nav-item">
    <a class="nav-link menuItem" href="cs_main" style="background-color:white; color:black;">고객센터</a>
  </li>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
</ul>
  <span class="underline"></span>
  </nav>
<div class="pos-f-t">
  <div class="collapse" id="navbarToggleExternalContent">
    <div class="bg-white p-4">
    
     	<table class="table table-hover" >
   <tbody>
    <tr>
      <th style=color:red;>SITEMAP</th>
      
    </tr>
     <tr>
      
      <th>영화</th>
      <th>극장</th>
      <th>고객센터</th>
      <th>마이페이지</th>
    </tr>
    <tr>
      
      <td><a href="movie_list_present">전체영화</a> </td>
      <td><a href="theater_main">전체극장</a></td>
      <td><a href="cs_main">고객센터홈</a></td>
      <td>
	      <c:choose>
	      	<c:when test="${empty sessionScope.member_id }">
	      	  로그인 후 사용가능
	      	</c:when>
	      	<c:otherwise>
	      	  <a href="myPage_reservation_history">예매/구매내역</a>
	      	</c:otherwise>
	      </c:choose>
      </td>
    </tr>
    <tr>
     
      <td></td>
      <td></td>
      <td><a href="cs_notice">공지사항</a></td>
      <td>
      	<c:if test="${not empty sessionScope.member_id }">
	      <a href="#">나의 리뷰</a>
      	</c:if>
      </td>
    </tr>
    <tr>
     
      <th>스토어</th>
      <th>예매</th>
      <td><a href="cs_faq">자주묻는질문</a></td>
	  <td>
      	<c:if test="${not empty sessionScope.member_id }">
          <a href="myPage_inquiry">나의 문의내역</a>
      	</c:if>
	  </td>
    </tr>
    <tr>
     
      <td><a href="snack_main">전체상품</a></td>
      <td><a href="reservation_main">빠른예매</a></td>
      <td>
      <c:if test="${not empty sessionScope.member_id }">
	      <a href="cs_qna_form">1:1 질문</a>
      </c:if>
      </td>
      <td>
      <c:if test="${not empty sessionScope.member_id }">
	      <a href="#">등급별혜택</a>
      </c:if>
      </td>
    </tr>
     <tr>
    <td></td>
      <td><a href="theater-runningtime_tap">극장별예매</a></td>
      <td></td>
      <td>
	      <c:if test="${not empty sessionScope.member_id }">
	      	<a href="myPage_modify_check">개인정보 수정</a>
	      </c:if>
      </td>
      </tr>
      <td></td>
      <td></td>
      <td></td>
      <td>
<!--       	<a href="#">인생영화네컷 만들기</a> -->
      </td>
      </tr>
  </tbody>
</table>

    </div>
  </div>
</div>