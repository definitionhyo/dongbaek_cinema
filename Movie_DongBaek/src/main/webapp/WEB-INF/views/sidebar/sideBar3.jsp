<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(function(){
		$("#nav-link:hover").css("background-color", "#c9a182");
		
		$("#nav-link").on("click", function() {
			$(this).css("background-color", "#ef4f4f");
		})
		
	});
</script>
<div class="sidebar-sticky">
  <ul class="nav flex-column">
    <li class="nav-item">
      <a class="nav-link" href="#" data-toggle="tab">
        홈
      </a>
    </li>
    <hr>
    <li class="nav-item">
      <a class="nav-link" href="#" data-toggle="tab">
        회원관리
      </a>
    </li>
    <hr>
    <li class="nav-item">
      <a class="nav-link" href="#" data-toggle="tab">
        상영스케쥴 관리
      </a>
    </li>
    <hr>
    <li class="nav-item">
      <a class="nav-link" href="../payment_list.jsp" data-toggle="tab">
        결제관리
      </a>
    </li>
    <hr>
    <li class="nav-item">
      <a class="nav-link" href="#" data-toggle="tab">
        공지사항 관리
      </a>
    </li>
    <hr>
    <li class="nav-item">
      <a class="nav-link" href="#" data-toggle="tab">
        1:1질문 관리
      </a>
    </li>
    <hr>
    <li class="nav-item">
      <a class="nav-link" href="#" data-toggle="tab">
        자주묻는 관리
      </a>
    </li>
    <hr>
    <li class="nav-item">
      <a class="nav-link" href="#" data-toggle="tab">
        분실물 관리
      </a>
    </li>
    <hr>
  </ul>
</div>

