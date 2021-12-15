<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="post.PostDAO"%>
    <%@ page import="java.io.PrintWriter" %>
    <%@ page import="post.Post" %>
  
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
	<%
		int postID = 0;
		postID = Integer.parseInt(request.getParameter("postID"));//파라미터 받아줌
		if(postID==0){
			PrintWriter script =response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다')");
			script.println("location.href= 'postList.jsp'");
			script.println("</script>");
		}
		String postIDstring = request.getParameter("postID");
		PostDAO postDAO = new PostDAO(); //PostDAO객체 생성
		Post post = postDAO.getPost(postID); //다시 post객체를 postID를 이용해 만들어줌
		int result = postDAO.update(postID,request.getParameter("postTitle"),request.getParameter("price"),request.getParameter("state"),request.getParameter("location"),request.getParameter("postContent"),request.getParameter("storeName"),Float.parseFloat(request.getParameter("storeGrade")));
		//전 페이지에서 넘겨받은 파라미터값과 postID값을 update함수의 매개변수로 넘겨줌
		if(result ==-1){ //DB에러나 기타에러에 의해서 수정실패서 -1반환
			PrintWriter script =response.getWriter();
			script.println("<script>");
			script.println("alert('글 수정에 실패하였습니다')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{//성공적으로 수정 후 글목록 페이지로 넘겨줌
			PrintWriter script =response.getWriter();
			script.println("<script>"); 
			script.println("location.href='postList.jsp'"); //수정후 글목록페이지로 돌아감
			//script.println("location.href='view.jsp?postID='+postIDstring"); //왜 view페이지로 안넘어가는지 모르겠음
			script.println("</script>");
		}
	%>
</body>
</html>