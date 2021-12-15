<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="post.Post" %>
<%@ page import="post.PostDAO" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="custom.css">
<meta charset="UTF-8">
<title>나만의 맛집 블로그</title>
</head>
<body>
	<%
	//내가 쓴 글중에 평점이 높은 순서대로 랭크를 매겨주는 페이지
		String userID=null;
		int rank=1; //랭크 1위부터 시작
		if(session.getAttribute("userID")!=null){ //로그인 확인
		userID=(String)session.getAttribute("userID");
			}
			if(userID==null){ //로그인 안되어있을시 로그인 알림
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href= 'loginForm.jsp'");
		script.println("</script>");
			}
	%>
<%@ include file="top2.jsp" %>

			<table style="text-align: center; border:1px;width:60%; margin: auto;">
 			<thead>
 				<tr>
 				<th style="text-align:center;">순위</th>
 				<th style=" text-align:center;">가게이름</th>
 				<th style=" text-align:center;">평점</th>
 				<th style="text-align:center;">위치</th> 			
 				</tr>
 			</thead>
 			<tbody>
 			<%
 				PostDAO postDAO = new PostDAO(); //PostDAO객체 생성
 			 	ArrayList<Post> list = postDAO.getListRank(userID); //PostDAO의 함수중에 userID가 쓰고 available이 1인글을 평점순으로 매겨서 list에 넣음
 			 	for(int i=0;i<list.size();i++){ //내가 쓴글 사이즈만큼
 			 			 if(i==20){break;} //20위까지만 표현하기위헤 break문 걸어줌
 			%>
 			 	<tr>
 					<td><%= rank %></td>
 					<td><a href="view.jsp?postID=<%=list.get(i).getPostID()%>"><%= list.get(i).getStoreName() %></a></td>
 					<td><%= list.get(i).getStoreGrade() %></td>
 					<td><%= list.get(i).getLocation() %></td>
 				</tr>
 			<%
 				rank++;} //1개 쓰고 1씩 증가시켜줌
 			%>

 			</tbody>
 		</table>
</body>
</html>