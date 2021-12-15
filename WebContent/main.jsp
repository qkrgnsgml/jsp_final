<%@page import="java.util.Random"%>
<%@page import="java.util.ArrayList"%>
<%@page import="post.PostDAO"%>
<%@page import="post.Post"%>
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
			String userID = (String)session.getAttribute("userID"); //세션에 userID라는 이름으로 저장돼있는 값을 받옴
			if(userID == null){ //userID가 없으면(로그인을 안햇을시) top.jsp를 include해주고 로그인을 하라는 table를 보여줌
		%>
	<%@ include file="top.jsp" %>
	
	<table style="width:40%;margin: auto;">
	<tr style="text-align:center;font-size:24px"><td>안녕하세요!! 로그인하고 나만의 맛집을 기록하세요!</td></tr>
	</table>
	<%
		}else{ // 로그인이 되어있으면 top2.jsp를 include해주고 어서오라는 테이블을 띄움
	%>
		<%@ include file="top2.jsp" %>	
		<table style="width:40%;margin: auto;">
		<tr style="text-align:center;font-size:24px;"><td><%=userID%>님 어서오세요~!! 나만의 맛집을 기록해보세요!</td></tr>
		</table>		
		<%
			}
		%>
			
	 		<table style="text-align: center; border:1px;width:40%; margin: auto;">
 			<%	//랜덤 추천음식을 뽑아주는 table
 								PostDAO postDAO = new PostDAO(); //PostDAO객체 생성
 			 					ArrayList<Post> list = postDAO.getListAll(); //postDAO의 getListAll함수 호출(현재 DB에 Available이 1인 모든 post를 가져옴)
 			 					int i =-1; //랜덤숫자를 받을 i생성
 			 					Random r = new Random(); //랜덤객체 생성
 			 					if(list.size()>0){ //글을 1개이상 썻을시 (나뿐만 아니라 다른 이용자 포함)
 			 					i = r.nextInt(list.size());} //쓴 글의 갯수중에 랜덤으로 1개 뽑음
 			%>
 			<thead>
 				<tr> 				
 				<td><h1>랜덤 추천 음식!</h1></td>
 				</tr>
 			</thead>
 			<tbody>
 			<tr>
 				<%if(i>=0){  //i가 0보다 크거나 같으면 블로그를 이용한 모든 사용자의 글중에 1개의 이미지를 가져와서 보여줌 이미지 누르면 해당 가게 볼 수 있음, 이미지는 upload폴더에 저장되어있음 이름은 DB에%>
 				<td><a href="recommend.jsp?postID=<%=list.get(i).getPostID()%>"><img src="upload/<%= list.get(i).getImg() %>"  width=500 height=500 ></a></td>	
 				<% } else{ //i가 -1이면 블로그에 아무도 글을 쓰지 않음(나포함)%> 
 				<td>아직 블로그에 아무도 글을 쓰지 않았습니다</td>
 			 		<%} %>				 		
			</tr>
			</tbody>
 		</table>
 		

	


</body>
</html>