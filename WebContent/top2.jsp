<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나만의 맛집 블로그</title>
</head>
<!--  로그인이 되어있을때 include해주기 위한 jsp page이다  컨셉이 private한 블로그기때문에 몇몇 일부페이지를 제외하고는 거의 top2를 사용-->
<body>
	<br><br>
	<table style="width:90%;height:100px;margin: auto;" border="1">
		<tr style="text-align:center;font-size: 24px">
		<td style="width:20%" onClick="location.href='main.jsp'">나만의 맛집 블로그</td>
		<td onClick="location.href='postList.jsp'">나의 기록</td>
		<td onClick="location.href='rank.jsp'">랭킹</td>
		<td onClick="location.href='mapInfo.jsp'">지도</td>
		<td onClick="location.href='logout.jsp'">로그아웃</td>
		<td onClick="location.href='myInfo.jsp'">내 정보</td>
		</tr>
	</table>
	<br>
	<br>
</body>
</html>