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
<meta charset="UTF-8">
<title>나만의 맛집 블로그</title>
<link rel="stylesheet" href="custom.css">
</head>
<body>
<%
	
	String userID=null;
	if(session.getAttribute("userID")!=null){ //로그인 확인
		userID=(String)session.getAttribute("userID");
	}
%>
 <%@ include file="top2.jsp" %>
  <%
 	UserDAO userDAO = new UserDAO();
	ArrayList<User> list = userDAO.getList(); //myInfo페이지에서 똑같은 함수 호출함(모든 유저 정보 list)
	int index = 0;
	index = Integer.parseInt(request.getParameter("index")); //myInfo에서 넘겨받은 정보
	
	//아이디만 읽기전용 readonly 붙혀줌
 %>
 	<h3 style="text-align: center;">정보수정화면</h3>
    <form  method="post" action="updateUserAction.jsp">
    <table style="text-align: center;width:60%;  background-color: #ffffff; margin: auto;">
    	<tr>
    		<td>아이디</td><td><input type="text" placeholder="아이디" name="userID" maxlength="20" value = "<%=list.get(index).getUserID() %>" readonly></td>
    	</tr>
    	<tr>
    		<td>비밀번호</td><td><input type="text" placeholder="비밀번호" name="userPassword" maxlength="20" value = "<%=list.get(index).getUserPassword() %>" required></td>
    	</tr>
    	<tr>
    		<td>이름</td><td><input type="text" placeholder="이름" name="userName" maxlength="20" value = "<%=list.get(index).getUserName() %>" required></td>
    	</tr>
    	<tr>
    		<td>이메일</td><td><input type="email" placeholder="이메일" name="userEmail" maxlength="50" value = "<%=list.get(index).getUserEmail() %>" required></td>
    	</tr>
    	<tr>
    		<td colspan="2"><input type="submit" value="내 정보 수정"></td>
    	</tr>
    </table>
    </form>
</body>
</html>