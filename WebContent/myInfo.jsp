<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="user.UserDAO"%>
    <%@ page import="user.User"%>
    <%@ page import="java.io.PrintWriter" %>
    <%@ page import="java.util.ArrayList" %>
    <% request.setCharacterEncoding("UTF-8"); %>
    
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="custom.css">
<meta charset="UTF-8">
<title>나만의 맛집 블로그</title>
</head>
<body>
<%
	//내 정보를 볼 수 있는 페이지 (ID , password, email, 이름)
	String userID=null; 
	if(session.getAttribute("userID")!=null){ //세션이 있으면
		userID=(String)session.getAttribute("userID"); //userID로 가져옴
	}
	if(userID==null){ // 세션이 없다면(로그인이 안됐다면) 로그인하라고 알려주고 로그인창으로 이동
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href= 'loginForm.jsp'");
		script.println("</script>");
	}
%>

<%@ include file="top2.jsp" %> <!--  로그인 되있으므로 top2.jsp include -->
 
 <%
 	UserDAO userDAO = new UserDAO(); //userDAO객체 생성
	ArrayList<User> list = userDAO.getList(); //getList를 통해 DB에 있는 모든 유저의 정보를 list에 넣음
	int index = 0; //인덱스
	for(int i=0; i<list.size();i++){ //리스트 사이즈만큼 포문
		if(userID.equals(list.get(i).getUserID())){ //세션에 있는 userID와 DB에서 가져온것중에 ID를 비교(Primary Key라 가능)
			index = i; //같으면 index에 i값 저장하고 break로 for문 빠져나옴
			break;
		}
	}
	//아래 테이블에 찾은 index의 정보를 나타내줌
 %>
		<h3 style="text-align: center;">내 정보화면</h3>
 		<table style="text-align: center;width:30%; margin: auto;">
 			<tbody>
 				<tr>
 					<td style="width:20%;">아이디</td>
 					<td colspan="2"> <%=list.get(index).getUserID() %></td>
 				</tr>
 				<tr>
 					<td >비밀번호</td>
 					<td colspan="2"> <%=list.get(index).getUserPassword() %></td>
 				</tr>
 				<tr>
 					<td>이름</td>
 					<td colspan="2"><%=list.get(index).getUserName() %></td>
 				</tr>
 				<tr>
 					<td>이메일</td>
 					<td colspan="2"><%=list.get(index).getUserEmail() %></td>
 				</tr>
 				<tr>
 					<td colspan="3">
 						<button onclick="location.href='main.jsp'">메인화면</button>
 						<button onclick="location.href='updateUser.jsp?index=<%=index%>'">수정</button>
 						<!-- 수정버튼을 누르면 해당 찾은 user의 index를 갖고 updateUser로 넘어감 -->
 					</td>
 				</tr>
 			</tbody>
 		</table>
	

 		

 <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>