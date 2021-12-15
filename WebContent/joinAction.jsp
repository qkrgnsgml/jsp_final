<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="user.UserDAO"%>
    <%@ page import="java.io.PrintWriter" %>
    <% request.setCharacterEncoding("UTF-8"); %>
    <jsp:useBean id="user" class="user.User" scope="page"/>
    <jsp:setProperty name="user" property="userID"/>
    <jsp:setProperty name="user" property="userPassword"/>
    <jsp:setProperty name="user" property="userName"/>
    <jsp:setProperty name="user" property="userEmail"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나만의 맛집 블로그</title>
</head>
<body>
	<%
	//회원가입을 실제로 처리해주는 페이지 자바빈을 통해 user로 property를 4개 넣어주고 회원가입을 진행함
	String userID = null;
	if(session.getAttribute("userID")!=null){ //이미 로그인이 되어있으면
		userID=(String)session.getAttribute("userID"); //세션을 설정하고
	}
	if(userID!=null){ //이미 로그인이 되어있음을 알림
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인이 되어있습니다.')");
		script.println("location.href= 'main.jsp'");
		script.println("</script>");
	}	
	
			UserDAO userDAO = new UserDAO(); //로그인이 되어있지 않다면 UserDAO객체를 생성한후
			int result = userDAO.join(user); //위에서 만든 user객체를 매개변수로 join함수 호출
			if(result ==-1){//회원가입이 똑바로 안되었을시 -1반환(DB에러, 아이디 겹침(아이디가 PK기 때문),오타)
				PrintWriter script =response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else{ // 회원가입이 정상적으로 됐으면 userID란 이름으로 세션을 저장해주고 메인화면으로 넘어감
				session.setAttribute("userID", user.getUserID());
				PrintWriter script =response.getWriter();
				script.println("<script>");
				script.println("location.href= 'main.jsp'");
				script.println("</script>");
			}
		
	%>
</body>
</html>