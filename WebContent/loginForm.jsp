<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나만의 맛집 블로그</title>
<link rel="stylesheet" href="custom.css">
</head>
<body>
	<%@ include file="top.jsp" %> <!-- 로그인 안된상태라 top.jsp를 불러옴-->
    <h3 style="text-align: center;">로그인화면</h3>
    <form  method="post" action="loginAction.jsp"> <!-- loginAction으로 넘어가서 처리해줌 -->
    <table style="text-align: center;width:30%; background-color: #ffffff; margin: auto;">
    	<tr>
    		<td>아이디</td><td><input type="text" placeholder="아이디" name="userID" maxlength="20" required></td>
    	</tr>
    	<tr>
    		<td>비밀번호</td><td><input type="password" placeholder="비밀번호" name="userPassword" maxlength="20" required></td>
    	</tr>
    	<tr>
    		<td colspan="2"><input type="submit" value="로그인"></td>
    	</tr>
    </table>
    </form>
</body>
</html>