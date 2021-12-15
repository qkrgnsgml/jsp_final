<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="post.Post" %>
<%@ page import="post.PostDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나만의 맛집 블로그</title>
<link rel="stylesheet" href="custom.css">
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	String userID=null; 
	if(session.getAttribute("userID")!=null){ //로그인 확인
		userID=(String)session.getAttribute("userID");
	}
	int postID = 0; 
	postID = Integer.parseInt(request.getParameter("postID")); //main에서 postID를 넘겨받음
	if(postID==0){
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다')");
		script.println("location.href= 'postList.jsp'");
		script.println("</script>");
	}
	Post post = new PostDAO().getPost(postID); //postID를 매개변수로 해당 글을 찾아옴 아래는 해당 가게에 대한 정보
											//컨셉이 private한 블로그 이므로 작성자에 대한 정보는 일체 넣지 않고 가게 정보만 넣음
%>

		<%@ include file="top2.jsp" %>
 		<table  style="text-align: center; border:1px;width:60%; margin: auto;">
 			<thead>
 				<tr>
 				<th colspan="3" style="text-align:center;">추천음식 보기</th>			
 				</tr>
 			</thead>
 			<tbody>
 				<tr>
 					<td >가게 이름</td>
 					<td colspan="2"><%= post.getStoreName() %></td>
 				</tr>
 				<tr>
 					<td >가격</td>
 					<td colspan="2"><%= post.getPrice() %>원</td>
 				</tr>
 				<tr>
 					<td >지역</td>
 					<td colspan="2"><a href="map.jsp?location=<%= post.getLocation() %>"><%= post.getLocation() %></a></td>
 				</tr>
 				<tr>
 					<td >이미지</td>
 					<td colspan="2"><img src="upload/<%= post.getImg() %>" width=512 height=384 ></img></td>
 				</tr>
 				<tr>
 					<td colspan="3">
 						<button onclick="location.href='main.jsp'">메인화면</button>										
 					</td>
 				<tr>
 			</tbody>
 		</table>


</body>
</html>