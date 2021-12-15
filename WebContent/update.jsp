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
	//view에서 postID를 넘겨받아 해당 postID의 글을 수정하는 페이지
	String userID=null;
	if(session.getAttribute("userID")!=null){ //로그인 확인
		userID=(String)session.getAttribute("userID");
	}
	int postID = 0;
	if(request.getParameter("postID")!=null){ //넘겨받은게 있으면 가져옴
		postID = Integer.parseInt(request.getParameter("postID"));
	}
	if(postID==0){ //없는글일시
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다')");
		script.println("location.href= 'bbs.jsp'");
		script.println("</script>");
	}
	Post post = new PostDAO().getPost(postID); //넘겨받은 postID를 이용해 해당 글의 정보를 post 객체에 넣음
%>
<%@ include file="top2.jsp" %>

	<h3 style="text-align: center;">글수정화면</h3>
 	<form method="post" action="updateAction.jsp?postID=<%=postID%>"> <!-- 삭제를 위해 postID도 같이 넘겨줌 -->
 		<table style="text-align: center; border:1px;width:60%; background-color: #ffffff; margin: auto;">
    	<tr>
 			<td>제목</td><td><input type="text" name="postTitle" value="<%=post.getPostTitle()%>" required></td>
 		</tr>
 		<tr>
 			<td>가게 이름</td><td><input type="text" name="storeName" value="<%=post.getStoreName()%>" required></td>
 		</tr>
    	<tr>
    		<td>가격</td><td><input type="text"  name="price" value="<%=post.getPrice()%>" required>
    	</tr>
    	<tr>
    		<td>위치</td><td><input type="text" name="location" value="<%=post.getLocation()%>" required></td>
    	</tr>
    	<tr>
    		<td>평점</td><td><input type="number" max="10" step="0.1" name="storeGrade" value="<%=post.getStoreGrade()%>" required></td>
    	</tr>
    	<tr>
 			<td>내용</td><td><textarea name="postContent" style="height:200px;"><%=post.getPostContent()%></textarea></td>
 		</tr>

    	<tr>
    		<td colspan="2"><input type="submit" value="글수정"></td>
    	</tr>
 		</table>
 	</form>

</body>
</html>