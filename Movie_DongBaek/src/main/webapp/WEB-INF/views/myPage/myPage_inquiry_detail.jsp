<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmf" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<%-- 아임포트 --%>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/myPage.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/button.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/sidebar_myPage.css" rel="stylesheet" type="text/css">
<title>영화 예매 사이트</title>
<style>
	#mainNav{
	/* 		border: 1px solid #f00; */
		padding: 8rem 2rem;	
	}
		
	#mainNav>ul{
		list-style: none;
	}
	/* a링크 활성화 색상 변경 */
	a:hover, a:active{
	 color:  #ff5050 !important;
		
	}
	/* 표 중간배치 */
	.w-900 {
		margin: 0 auto;
	}
	
	.table {
		width: 800px;
	}
	
	#nothing {
		color: gray;
		font-size: 0.8em;
	}
	
</style>
<script type="text/javascript">
	
	
</script>
</head>
<body>
 <%--네비게이션 바 영역 --%>
 <header id="pageHeader"><%@ include file="../inc/header.jsp"%></header>
 
  <article id="mainArticle">
  <input type="hidden" id="cs_num" value="${myInquiryDetailList[0].cs_num}">
  <input type="hidden" id="cs_reply" value="${cs_reply }">
  <%--본문내용 --%>
  	<div class="container container-fluid w-900">
  		<div class="mainTop">
			<h2>나의 문의 내역</h2>
				<%-- 상세보기 테이블 --%>
						<c:choose>
							<c:when test="${empty myInquiryDetailList }">
								<tr>
									<td>고객님의 최근 문의 내역이 존재하지 않습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<%-- 상세보기 내역 --%>
								<form action="myPage_inquiry_detailModify" method="post" name="fr" enctype="multipart/form-data">
								<input type="hidden" value="${myInquiryDetailList[0].cs_num }" name="cs_num">
								<table class="table" >
										<tr>
											<th>
											  	문의 유형
											</th>
											<td>
												${myInquiryDetailList[0].cs_type }
											</td>
								 		</tr>
								 		<tr>
											<th>
												아이디
											</th>
											<td>
												${myInquiryDetailList[0].member_id }
											</td>
										</tr>
										<tr>
											<th>
												휴대전화
											</th>
											<td>
												${myInquiryDetailList[0].cs_phone }
											</td>
										</tr>
										<tr>
											<th>
												작성 날짜
											</th>
											<td>
<%-- 												${myInquiryDetailList[0].cs_date } --%>
												<fmf:formatDate value="${myInquiryDetailList[0].cs_date }" pattern="yyyy년 MM월 dd일 HH:mm"/>
											</td>
										</tr>
								  		<tr>
								    		<th>
								    			제목<em style="color: #EB323A;">*</em>
								    		</th>
								    		<td>
								    			${myInquiryDetailList[0].cs_subject }
<!-- 								    			<textarea rows="1" cols="20" name="cs_subject" required="required" maxlength="30"></textarea> -->
								    		</td>
								  		</tr>
								  		<tr>
								    		<th>
									    		내용<em style="color: #EB323A;">*</em>
									    	</th>
									    	<td>
<!-- 												<textarea class="form-control" rows="10" cols="200" name="cs_content"> -->
									    		<textarea rows="5" cols="50" name="cs_content">
									    			${myInquiryDetailList[0].cs_content }
									    		</textarea>
								    		</td>
								  		</tr>
								  		<tr>
								    		<th>
								    			사진첨부
								    		</th>
				                            <td scope="col" class="align-middle text-left">
				                            	
				                            	<%-- 첨부파일 다운로드 구현 아직 --%>
						                        <c:choose>
													<c:when test="${not empty myInquiryDetailList[0].cs_file }">
														<a href="${pageContext.request.contextPath }/resources/upload/${myInquiryDetailList[0].cs_file_real }" download="${myInquiryDetailList[0].cs_file_real }">
															${fn:split(myInquiryDetailList[0].cs_file_real, '_')[1] }
														</a>
													</c:when>
						                          		<c:otherwise>
						                           		<span id="cs_file_old_span">첨부파일이 없습니다</span>
						                          		</c:otherwise>
						                        </c:choose>
				                            </td>	
				                        <tr>
				                            <th scope="col" class="align-middle" width="100">사진첨부(변경)</th>
				                            <td scope="col" class="align-middle">
				                            	<input type="file" class="form-control" aria-label="cs_file" name="cs_file" />
				                            </td>
				                        </tr>
								  		<tr>
								  			<th>답변</th>
								  			<td>
								  				<c:choose>
								  					<c:when test="${empty myInquiryDetailList[0].cs_reply }">
								  						답변 예정입니다.
								  					</c:when>
								  					<c:otherwise>
										  				${myInquiryDetailList[0].cs_reply }
								  					</c:otherwise>
								  				</c:choose>
								  			</td>
								  		</tr>
									</table>
									
									<%-- 버튼 영역 클릭 --%>
									<div class="row mb-3">
	             						<label for="id" class="col-2 text-nowrap"></label>
			              					<div class="col-10">
			              						<c:choose>
								  					<c:when test="${empty myInquiryDetailList[0].cs_reply }">
														<button class="btn btn-danger" type="submit">&nbsp;&nbsp;&nbsp;수정&nbsp;&nbsp;&nbsp;</button>
														<button class="btn btn-outline-danger" type="button" onclick="history.back()">돌아가기</button>
								                        <button class="btn btn-outline-secondary" type="button" data-toggle="modal" data-target="#deleteWrite">&nbsp;&nbsp;&nbsp;삭제&nbsp;&nbsp;&nbsp;</button>
													</c:when>
								  					<c:otherwise>
								  						<button class="btn btn-outline-danger" type="button" onclick="history.back()">돌아가기</button>
								                        <button class="btn btn-outline-secondary" type="button" data-toggle="modal" data-target="#deleteWrite">&nbsp;&nbsp;&nbsp;삭제&nbsp;&nbsp;&nbsp;</button>
								  					</c:otherwise>
								  				</c:choose>
			              					</div>
		        					</div>
								 </form>
							</c:otherwise>
						</c:choose>
		  		</div>
			</div>
		  </article>
  
  
	<%--왼쪽 사이드바 --%>
  	<nav id="mainNav">
  		<%@ include file="/WEB-INF/views/sidebar/sideBar_myPage.jsp"%>
  	</nav>
    
 	<%--페이지 하단 --%>
	<div id="siteAds"></div>
		<footer id="pageFooter"><%@ include file="../inc/footer.jsp"%></footer>
  
    <%-- 모달 --%>
	<div class="modal fade" id="deleteWrite" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
	    	<div class="modal-content">
	        	<div class="modal-header">
	        		<h5 class="modal-title" id="exampleModalLabel">삭제</h5>
	        			<button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          				<span aria-hidden="true">&times;</span>
			    	    </button>
	    		</div>
	      <div class="modal-body">
	       	1 : 1 문의 글을 삭제하시겠습니까?
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="">취소</button>
	        <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="location.href='delete_myInquiry?cs_num=${myInquiryDetailList[0].cs_num }'">&nbsp;&nbsp;예&nbsp;&nbsp;</button>
	      </div>
	    </div>
	  </div>
	</div>
  
  
  
  
  
  
</body>