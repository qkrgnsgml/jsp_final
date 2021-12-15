<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나만의 맛집 블로그</title>
</head>
<body>
	<%
		//로그아웃 페이지 userID가 저장되어있던 session을 지워줌
		session.invalidate();
	%>
	<script>
		location.href='main.jsp';
	</script>
</body>
</html>