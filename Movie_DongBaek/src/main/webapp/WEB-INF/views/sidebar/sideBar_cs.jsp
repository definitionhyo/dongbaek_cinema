<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="${pageContext.request.contextPath }/resources/css/sidebar.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
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
  <p class="title"> 고객센터 </p>
  <ul class="nav flex-column">
    <li class="nav-item">
      <a class="nav-link" href="cs_main">
        고객센터홈<span class="sr-only">(current)</span>
      </a>
    </li>
    <hr>
    <li class="nav-item">
      <a class="nav-link" href="cs_notice">
        공지사항
      </a>
    </li>
    <hr>
    <li class="nav-item">
      <a class="nav-link" href="cs_faq">
        자주묻는질문
      </a>
    </li>
    <hr>
    <li class="nav-item">
      <a class="nav-link" href="cs_qna_form">
        1:1문의
      </a>
    </li>
    <hr>
  </ul>
</div>