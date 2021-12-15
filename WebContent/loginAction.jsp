<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="user.UserDAO" %>
    <%@ page import="java.io.PrintWriter" %>
    <% request.setCharacterEncoding("UTF-8"); %>
    <jsp:useBean id="user" class="user.User" scope="page"/>
    <jsp:setProperty name="user" property="userID"/>
    <jsp:setProperty name="user" property="userPassword"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나만의 맛집 블로그</title>
</head>
<body>
	<%
	//로그인을 실제로 처리해주는 페이지 자바빈을 통해 user로 property를 2개 넣어주고 로그인을 진행함
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
		UserDAO userDAO = new UserDAO(); //userDAO객체 생성
		int result = userDAO.login(user.getUserID(),user.getUserPassword()); //받은 ID와 Password를 로그인함수로 넘겨줌
		if(result ==1){ //로그인이 정상적으로 실행되면 세션에 넣으주고 메인화면으로 감
			session.setAttribute("userID", user.getUserID());
			PrintWriter script =response.getWriter();
			script.println("<script>");
			script.println("location.href= 'main.jsp'");
			script.println("</script>");
		}//비민번호가 불일치하면 0을 반환해주고 비밀번호 틀리다고 공지
		else if(result==0){
			PrintWriter script =response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
		} //같은 아이디를 찾지못하면 -1반환
		else if(result==-1){
			PrintWriter script =response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
		} //기타에러 -2
		else if(result==-2){
			PrintWriter script =response.getWriter();
			script.println("<script>");
			script.println("alert('DB오류가 발생하였습니다')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>