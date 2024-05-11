<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="${pageContext.request.contextPath }/resources/css/sidebar.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
$(document).ready(function(){
	let currentPosition = parseInt($(".sidebar").css("top"));
	$(window).scroll(function() {
		let position = $(window).scrollTop(); 
		$(".sidebar").stop().animate({"top":position+currentPosition+"px"},800);
	});
});	
</script>
<div class="sidebar">
<p class="title"> 관리자페이지 </p>
  <ul class="nav flex-column">
    <li class="nav-item">
      <a class="nav-link" href="admin_main">
        홈<span class="sr-only">(current)</span>
      </a>
    </li>
    <hr>
    <li class="nav-item">
      <a class="nav-link" href="admin_member_list">
        회원관리
      </a>
    </li>
    <hr>
    <li class="nav-item">
      <a class="nav-link" href="admin_movie_management">
        영화관리
      </a>
    </li>
    <hr>
    <li class="nav-item">
      <a class="nav-link" href="admin_payment_list">
        결제관리
      </a>
    </li>
    <hr>
    <li class="nav-item">
      <a class="nav-link" href="admin_schedule_list">
        상영스케줄 관리
      </a>
    </li>
    <hr>
    <li class="nav-item">
      <a class="nav-link" href="admin_cs_notice">
        공지사항 관리
      </a>
    </li>
    <hr>
    <li class="nav-item">
      <a class="nav-link" href="admin_cs_qna">
        1:1질문 관리
      </a>
    </li>
    <hr>
    <li class="nav-item">
      <a class="nav-link" href="admin_cs_faq">
        자주묻는 관리
      </a>
    </li>
    <hr>
    <li class="nav-item">
<!--       <a class="nav-link" href="#"> -->
<!--         분실물 관리 -->
<!--       </a> -->
    </li>
    <hr>
  </ul>
</div>

