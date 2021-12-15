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
	<%@ include file="top.jsp" %> <!-- 회원가입은 로그인 안된상태라 top.jsp include 해줌 -->
    <h3 style="text-align: center;">회원가입화면</h3>
    <form  method="post" action="joinAction.jsp"> <!-- joinAction 으로 보내서 처리해줌 -->
    <table style="text-align: center;width:60%; background-color: #ffffff; margin: auto;">
    <!-- style지정 4개 파라미터로 넘겨줌 required써서 빈칸은 못하게 막아둠 -->
    	<tr>
    		<td>아이디</td><td><input type="text"  name="userID" maxlength="20" required></td>
    	</tr>
    	<tr>
    		<td>비밀번호</td><td><input type="password"  name="userPassword" maxlength="20" required></td>
    	</tr>
    	<tr>
    		<td>이름</td><td><input type="text"  name="userName" maxlength="20" required></td>
    	</tr>
    	<tr>
    		<td>이메일</td><td><input type="email" name="userEmail" maxlength="50" required></td>
    	</tr>
    	<tr>
    		<td colspan="2"><input type="submit"  value="회원가입"></td>
    	</tr>
    </table>
    </form>

</body>
</html>