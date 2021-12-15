<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="user.UserDAO"%>
    <%@ page import="java.io.PrintWriter" %>
    <%@ page import="user.User" %>
  
    <% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나만의 맛집 블로그</title>
</head>
<body>
	<%
	String userID = null;
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
	}
	if(userID==null){ //로그인 확인
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href= 'login.jsp'");
		script.println("</script>");
	}	
	
	else{ //로그인 되어있을시
			UserDAO userDAO = new UserDAO();//UserDAO객체 생성
			int result = userDAO.update(request.getParameter("userPassword"),request.getParameter("userName"),request.getParameter("userEmail"),userID);
			//userDAO의 update 함수의 매개변수로 전에 받은 비밀번호 이름 메일을 전달
			if(result ==-1){ //에러가 있을시 -1반환
				PrintWriter script =response.getWriter();
				script.println("<script>");
				script.println("alert('글 수정에 실패하였습니다')");
				script.println("history.back()");
				script.println("</script>");
			}
			else{ //정상적으로 수정후 다시 내 페이지로
				PrintWriter script =response.getWriter();
				script.println("<script>");
				script.println("location.href= 'myInfo.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>