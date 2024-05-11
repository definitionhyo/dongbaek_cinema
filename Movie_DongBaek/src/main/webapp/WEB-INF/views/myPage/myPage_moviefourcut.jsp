<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/myPage.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/sidebar_myPage.css" rel="stylesheet" type="text/css">

<title>영화 예매 사이트</title>
<style>

	<%-- a링크 활성화 색상 변경 --%>
	a:hover, a:active{
	 color:  #ff5050 !important;
		
	}

	.container-top{
/* 		margin: 3rem; */
	}
	
	aside{
		margin: 10px;
		background-color: #d5b59c;
	}
	
	/* 예매 선택 구간 */
	/* 크기 조절 */
	.container-fluid{
		border: 2px solid #aaa;
	/* 	background-color: #d5b59c; */
	}
	
	div{
		background-color: transparent;
	}
	.container-fluid h5{
		text-align: center;
		font-weight: bold;
	}
	/* 각 파트 구별을 위한 색상 조절, 여백 */
	.row1>div{
		height: 300px;
		margin: 0.5rem;
		padding: 10px;
		background-color: white;
	}
	/* 페이지 이름 잘보이게 설정 */
	#mainArticle>h2{
		font-weight: bold;
		padding-left: 1rem;
	}
	
	/* 선택사항 안내 구간 */
	/* 위 파트와 구별을 위한 색상 부여 */
	.row2{
		padding-top: 0.5rem;
		height: 150px;
		background-color: #e2cdbc;
	}

	.row>div {
		margin: 1rem;
/* 		border: 1px solid red; */
	}
	.photo{
		margin: 10px;
		background-color: white;
		
	}
	#text{
		height: 50px;
	}
	#imagePreview{
		background-color: #aaa;
		text-align: right;
	}
	#makePlace{
		margin: 2rem;
		padding: 1rem;
		background-color: white;
/* 		border: 1px solid red; */
	}
	#makePlace td{
		padding: 1rem 10px;
/* 		border: 1px solid blue; */
	}
	#downDiv{
		text-align: right;
		margin: 3rem 1rem;
		bottom: 0;
		position: inherit;
/* 		border: 1px solid blue; */
	}
	/* 모달창 안 바디부분 조절 */
	.modal-body img{
		width: 200px;
/* 		height: 100px; */
/* 		margin: px; */
	}
	/* Important part */
	.modal-content{
		overflow-y: initial !important
	}
	.modal-body{
		overflow-x: scroll;
		white-space: nowrap;
	}
	.modal-body div{
		margin: 0.5rem;
	}
	[type=radio] { 
	  position: absolute;
	  opacity: 0;
	  width: 0;
	  height: 0;
	}
	[type=radio]:checked + div {
		outline: 5px solid indigo;
	}
</style>
<script type="text/javascript">
	
	let list_photo = new Array();

	$(function() {
		
		let obj = window.dialogArguments;
		
		
		// 모달창 안 선택 버튼 클릭 시
		$(".btn-select").on("click", function() {
			// 라디오버튼 중 선택된 태그의 value값 가져오기
			let a = $("input[name=posterPick]:checked").val();
			// value값을 원래의 페이지 원하는 부분에 넣기
			window.returnValue = ;
			alert(a);
		});
	});

</script>
</head>
<body>
 <%--네비게이션 바 영역 --%>
 <header id="pageHeader"><%@ include file="../inc/header.jsp"%></header>
 
  <article id="mainArticle">
  <%--본문내용 --%>
	<h2>인생영화네컷 만들기</h2>
	<div class="container container-fluid w-900 reservation_con" >
            <div class="row">
            	
            	<%-- 미리보기 파트 --%>
                <div class="col-4">
                	<h5>미리보기</h5>
				 	<div class="row d-flex justify-content-center">
				 		<div class="col-8" id="imagePreview">
				 			<div class="photo picked1">
				 				<img src="" width="170px" height="100px">
				 			</div>
				 			<div class="photo picked2">
				 				<img src="" width="170px" height="100px">
				 			</div>
				 			<div class="photo picked3">
				 				<img src="" width="170px" height="100px">
				 			</div>
				 			<div class="photo picked4">
				 				<img src="" width="170px" height="100px">
				 			</div>
				 			<div id="text">(입력값)</div>
				 			<div id="logo"><img src="/resources/img/logo.png" alt="동씨" width="50"></div>
				 		
				 		</div>
				 	</div>
                </div>
                
                <%-- 명장면, 명대사 선택 파트 --%>
                <div class="col-7">
	                <h5>명장면과 명대사로 나만의 인생티켓을 꾸며보세요!</h5>
				 	
				 	<%--
				 	DB에서 영화번호로 선택해 포스터, 스틸컷을 가져와서 photoArr 배열에 저장하고
				 	모달 파트, 미리보기 파트(모달에서 선택되면)에 노출시키기
				 	--%>
				 	<div id="makePlace">
				 		<table>
				 			<tr>
				 				<td>첫번째 컷 :</td>
				 				<td>
				 					<button type="button" class="btn btn-outline-danger" data-toggle="modal" 
				 							data-target="#exampleModalCenter" name="cut1"> 영화포스터
									</button>
				 				</td>
				 				<td><button onclick="#" class="btn btn-outline-dark">파일 불러오기</button></td>
				 			</tr>
				 			<tr>
				 				<td>두번째 컷 :</td>
				 				<td>
				 					<button type="button" class="btn btn-outline-danger" data-toggle="modal" 
				 							data-target="#exampleModalCenter" name="cut2"> 영화포스터
									</button>
				 				</td>
				 				<td><button onclick="#" class="btn btn-outline-dark">파일 불러오기</button></td>
				 			</tr>
				 			<tr>
				 				<td>세번째 컷 :</td>
				 				<td>
				 					<button type="button" class="btn btn-outline-danger" data-toggle="modal" 
				 							data-target="#exampleModalCenter" name="cut3"> 영화포스터
									</button>
				 				</td>
				 				<td><button onclick="#" class="btn btn-outline-dark">파일 불러오기</button></td>
				 			</tr>
				 			<tr>
				 				<td>네번째 컷 :</td>
				 				<td>
				 					<button type="button" class="btn btn-outline-danger" data-toggle="modal" 
				 							data-target="#exampleModalCenter" name="cut4"> 영화포스터
									</button>
				 				</td>
				 				<td><button onclick="#" class="btn btn-outline-dark">파일 불러오기</button></td>
				 			</tr>
				 			<tr>
				 				<td>명대사 :</td>
				 				<td colspan="2">
				 					<input type="text" placeholder="20자 이하 입력가능">
				 					<button onclick="#" class="btn btn-outline-dark">입력</button>
				 				</td>
				 			</tr>
				 		</table>
				 			<div id="downDiv"><button class="btn btn-danger">인생영화네컷 받기</button></div>
				 	</div>
                </div>
               </div>
	</div>
<%--
  <!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter">
  영화포스터
</button>
 --%>

<!-- Modal -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalCenterTitle">포스터, 스틸컷</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<label>
      		<input type="radio" name="posterPick" value="photo1">
      		<div class="insertPoster">
      			<img src="/resources/img/poster02@2.jpg" alt="..." class="img-thumbnail">
      		</div>
      		</input>
      	</label>
      	<label>
      		<input type="radio" name="posterPick" value="photo2">
      		<div class="insertPoster">
      			<img src="/resources/img/poster04@2.jpg" alt="..." class="img-thumbnail">
      		</div>
      		</input>
      	</label>
      	<label>
      		<input type="radio" name="posterPick" value="photo3">
      		<div class="insertPoster">
      			<img src="/resources/img/poster09.jpg" alt="..." class="img-thumbnail">
      		</div>
      		</input>
      	</label>
      	<label>
      		<input type="radio" name="posterPick" value="photo4">
      		<div class="insertPoster">
      			<img src="/resources/img/poster02@2.jpg" alt="..." class="img-thumbnail">
      		</div>
      		</input>
      	</label>
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary btn-select">선택</button>
      </div>
    </div>
  </div>
</div>
  </article>
  
  	<nav id="mainNav" class="d-none d-md-block sidebar">
		<%--왼쪽 사이드바 --%>
  		<%@ include file="/WEB-INF/views/sidebar/sideBar_myPage.jsp"%>
  	</nav>
  
<!--   <nav id="mainNav" class="d-none d-md-block sidebar"> -->
<%--   <%--왼쪽 사이드바 --%> --%>
<!--   	<h3>마이페이지</h3> -->
<!-- 		<ul class="left-tap"> -->
<!-- 			<li class="myPage-ticketing-buy"><a class="nav-link" href="myPage_reservation_buy_history">예매 -->
<!-- 					/ 구매내역</a></li> -->
<!-- 			<li class="myPage-review"><a class="nav-link" href="myPage_myReview">나의 리뷰</a></li> -->
<!-- 			<li class="myPage-moviefourcut"><a class="nav-link" href="myPage_moviefourcut">영화네컷</a></li> -->
<!-- 			<li class="myPage-quest"><a class="nav-link" href="myPage_inquiry">문의 내역</a></li> -->
<!-- 			<li class="myPage-grade"><a class="nav-link" href="myPage_grade">등급별 혜택</a></li> -->
<!-- 			<li class="myPage-privacy"><a class="nav-link" href="myPage_modify_check">개인정보수정</a></li> -->
<!-- 		</ul> -->
<!--   </nav> -->
  
  <div id="siteAds"></div>
  <%--페이지 하단 --%>
  <footer id="pageFooter"><%@ include file="../inc/footer.jsp"%></footer>
</body>