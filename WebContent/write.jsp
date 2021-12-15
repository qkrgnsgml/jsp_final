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
	String userID = (String)session.getAttribute("userID");
	%>
	<%@ include file="top2.jsp" %>

	<!-- 글을 작성하는 화면이다 file type이 있으므로 enctype를 붙혀주고 writeAction페이지로 넘겨준다 -->
    <h3 style="text-align: center;">글쓰기화면</h3>
    <form  method="post" action="writeAction.jsp" enctype="multipart/form-data">
    <table style="text-align: center;width:60%; background-color: #ffffff; margin: auto;">
    	<tr>
 			<td>글 제목</td><td><input type="text" name="postTitle" required></td>
 		</tr>
 		<tr>
    		<td>가게 이름</td><td><input type="text"  name="storeName" required>
    	</tr>
    	<tr>
    		<td>가격</td><td><input type="text"  name="price" required>
    	</tr>
    	<tr>
    		<td>음식 사진</td><td><input type="file"name="file" required></td>
    	</tr>
    	<tr>
    		<td>위치</td><td><input type="text" name="location" required>
    	</tr>
    	<tr>
    		<td>평점</td><td><input type="number"  name="storeGrade" max="10" step="0.1" required>
    		<!-- 평점은 0~10점 0.1점 단위로 측정 -->
    	</tr>
    	<tr>
 			<td>내용</td><td><textarea name="postContent" style="height:200px;" required></textarea></td>
 		</tr>
    	<tr>
    		<td colspan="2"><input type="submit" value="글쓰기"></td>
    	</tr>
    </table>
    </form>
	
	
</body>
</html>