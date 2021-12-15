<%@page import="java.io.PrintWriter"%>
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
	<%
		//지도를 눌렀을때 내가 주변의 식당 뭐 있는지 보고싶어서 그 동네를 검색할때 쓰는 페이지
		request.setCharacterEncoding("utf-8");
		String userID = (String)session.getAttribute("userID"); //세션에 아이디 가져옴
		if(userID==null){ //로그인 체크
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href= 'loginForm.jsp'");
		script.println("</script>");
	}	
	%>
	<%@ include file="top2.jsp" %> <!-- 로그인 된상태라 top2.jsp를 불러옴-->
    <h3 style="text-align: center;">지도 찾아가기</h3>
    <form  method="get" action="map.jsp"> <!-- amp으로 location을 넘겨서 처리해줌 -->
    <table style="text-align: center;width:30%; background-color: #ffffff; margin: auto;">
    	<tr>
    		<td>찾고 싶은 곳</td><td><input type="text" placeholder="위치(동까지)" name="location" maxlength="20" required></td>
    	</tr>
    	<tr>
    		<td colspan="2"><input type="submit" value="찾기"></td>
    	</tr>
    </table>
    </form>
</body>
</html>