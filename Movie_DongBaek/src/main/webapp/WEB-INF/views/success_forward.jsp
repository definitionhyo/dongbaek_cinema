<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	
	// 요청 작업 성공 시 받은 url 페이지로 돌아가기
	// 로그인 성공 시
	if("${msg}" != null || "${msg}" != "") {
		alert("${msg}");
	}
	location.href = "${targetURL}";
</script>
</head>
<body>

</body>
</html>