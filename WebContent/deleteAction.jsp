<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="post.PostDAO"%>
<%@ page import="java.io.PrintWriter" %>
    <%
      	request.setCharacterEncoding("UTF-8");
      %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나만의 맛집 블로그</title>
</head>
<body>
	<!-- view페이지에서 삭제 버튼을 눌렀을때 넘어오는 페이지 PostDAO의 delete메서드를 호출하고 삭제한뒤 다시 글 목록으로 넘어감 -->
	<%
		int	postID = Integer.parseInt(request.getParameter("postID"));//어떤글을 삭제할껀지 파라미터로 글번호 넘겨받음
			
		PostDAO postDAO = new PostDAO(); //PostDAO의 객체를 만든 뒤
		int result = postDAO.delete(postID); //받은 파라미터를 매개변수로 delete 함수를 호출함
		if(result ==-1){ //어떠한 이유로 delete가 안됐을시 -1이 반환되면서 글삭제 실패(DB에러나 오타)
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("alert('글 삭제에 실패하였습니다')");
		script.println("history.back()");
		script.println("</script>");
			}
			else{ //delete 성공했을때는 삭제후 글목록으로 돌아가짐
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("location.href= 'postList.jsp'");
		script.println("</script>");
			}
	%>
</body>
</html>