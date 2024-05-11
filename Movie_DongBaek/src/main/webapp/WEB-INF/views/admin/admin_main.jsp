<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	
<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
    integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
  <!-- 차트 링크 -->
<!--   <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script> -->
<title>영화 예매 사이트</title>
<style>

div {
background-color: transparent;
}

.navbar {
    background-color: #fff!important;
}
.menuItem {padding-top: 35px!important;
}

<%-- 페이징 색상변경 --%>
.page-link {
  color: #000; 
  background-color: #fff;
  border: 1px solid #ccc; 
}

.page-item.active .page-link {
 z-index: 1;
 color: #555;
 font-weight:bold;
 background-color: #f1f1f1;
 border-color: #ccc;
 
}

.page-link:focus, .page-link:hover {
  color: #000;
  background-color: #fafafa; 
  border-color: #ccc;
}

/* 제목 글자 설정*/
#adminTitle {
  color:#000000;
  font-weight: bold;
  font-size: 32px;
  /* 타이틀그라디언트 효과*/
  background: linear-gradient(to right, #270a09, #8ca6ce);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

<%-- a링크 활성화 색상 변경 --%>
a:hover, a:active{
 color:  #ff5050 !important;
	
}
</style>
<%-- ajax.차트 --%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</head>
<body>
 <header id="pageHeader">
 <%--네비게이션 바 영역 --%>
  <%@ include file="../inc/header.jsp"%>
 </header>
 
  <article id="mainArticle">
  <%--본문내용 --%>
  
<div class="container-fluid w-900" >

	 <br> <br> <br>
	 <div id="adminTitle">관리자 페이지</div><br>
	  <div class="d-flex justify-content-center">
		<h4>환영합니다 ${sessionScope.member_id }님!</h4>
	  </div>
	  
	  <div class="row my-2">
	  
	      <div class="col-md-6 my-2">
		  	  <div class="card">
					<div class="card-body text-center text-align-center">
	               		<h3>일일 가입자 수/일일 예매 수</h3>
	             	</div>
					<div class="card-body">
						<canvas id="myChart"></canvas> 
					</div>
			  </div>
	  	  </div>
	  	  <div class="col-md-5 my-2">
		  	  <div class="card">
					<div class="card-body text-center text-align-center">
	               		<h3>주간 영화 예매율 순위</h3>
	             	</div>
					<div class="card-body">
						<canvas id="chDonut"></canvas> 
					</div>
			  </div>
		  </div>


	  </div>


  </div>

  <!-- 차트 -->
  <script>
  $(function(){
	  
	  $.ajax({
    	  url: 'adminLate',
    	  type: 'GET',
//     	  dataType: 'json',
    	  success: function(data) {
    		console.log(data);

    	    let adminLate0 = data[0]; // adminLate를 JSON 문자열에서 객체로 변환
    	    let adminLate1 = data[1];
    	    let adminLate2 = data[2];
    	    let adminLate3 = data[3];
    		console.log(adminLate0.dateNow);
  			// 막대 직선 차트 데이터 입력
		    const ctx = document.getElementById('myChart');
		
		    const mixedChart = new Chart(ctx, {
		    	   type: 'bar',
		    	   data: {
		    	       datasets: [{
		    	           label: '일일 가입자 수',
		    	           data: [adminLate3.joinLate, adminLate2.joinLate, adminLate1.joinLate, adminLate0.joinLate],
		    	           
		    	           order: 2
		    	       }, {
		    	           label: '일일 예매 수',
		    	           data: [adminLate3.orderLate, adminLate2.orderLate, adminLate1.orderLate, adminLate0.orderLate],
		    	           type: 'line',
		    	           // this dataset is drawn on top
		    	           order: 1
		    	       }],
		    	       // 가로 축 인덱스
		    	       labels: [adminLate3.dateNow, adminLate2.dateNow, adminLate1.dateNow, adminLate0.dateNow]
		    	   },
		    	   options: {
		    		    scales: {
		    		      y: {
		    		        beginAtZero: true
		    		      }
		    		    }
		    		  }
		    	}); // 혼합 차트 끝
		    	
		    	// 도넛 차트
		    	const ctx2 = document.getElementById('chDonut');
		    	
		    	const mixedChart2 = new Chart(ctx2, {
		    		 type: 'doughnut',
		    		 data: {
		    			 labels: [adminLate0.movie_name_kr, adminLate1.movie_name_kr, adminLate2.movie_name_kr, adminLate3.movie_name_kr],
		    				  datasets: [{
		    				    label: '주간 영화 예매 순위',
		    				    data: [adminLate0.movieLate, adminLate1.movieLate, adminLate2.movieLate, adminLate3.movieLate],
		    				    backgroundColor: [
		    				      'rgb(255, 205, 86)',
		    				      'rgb(255, 99, 132)',
		    				      'rgb(255, 159, 64)',
		    				      'rgb(54, 162, 235)',
		    				    ],
		    				    hoverOffset: 4
		    				}]
		    		}
		    	}); // 도넛 차트 끝
    	
    	  }, // 석세스 끝    	
	   	  error: function(err) {
	  	  alert(err);
	//	            alert("해당 상영정보가 없습니다!");
	    }
	  
	}); // ajax adminLate 끝
    
  }); // onload 함수 끝
  </script>
	
	
	

<%-- 		<%@ include file="/WEB-INF/views/chart.jsp"%> --%>
</div>


       
		

  
  </article>
  

  <%--왼쪽 사이드바 --%>
	<nav id="mainNav" class="d-none d-md-block sidebar">
		<%@ include file="/WEB-INF/views/sidebar/sideBar.jsp"%>
	</nav>
  
	<div id="siteAds"></div>
	<%--페이지 하단 --%>
	<footer id="pageFooter"><%@ include
			file="../inc/footer.jsp"%></footer>
			

</body>