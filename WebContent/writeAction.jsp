<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="post.Post"%>
    <%@ page import="post.PostDAO"%>
    <%@ page import="java.io.PrintWriter" %>
    <%@ page import="java.io.File" %>
	<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
	<%@ page import="com.oreilly.servlet.MultipartRequest"%>
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
		//게시글의 parameter를 받아와서 DB에 올려주는 페이지이다
		String userID = null;
		if(session.getAttribute("userID")!=null){ //로그인 세션 가져옴
			userID=(String)session.getAttribute("userID");
		}
		
		PostDAO postDAO = new PostDAO(); //postDAO객체 생성
		String directory = application.getRealPath("/upload"); //폴터 위치
		File targetDir = new File(directory);
		if(!targetDir.exists()){ //폴더가 없을 시 만들어줌
			targetDir.mkdirs();
		}
		
		int maxSize = 1024 * 1024 * 5; //maxsize
		
		MultipartRequest multipartRequest
		= new MultipartRequest(request, directory, maxSize, "utf-8",
		new DefaultFileRenamePolicy()); //MultipartRequest객체 생성
		
		String fileName = multipartRequest.getOriginalFileName("file"); //파일의 이름 parameter
		
		//이 아래는 받아온 파라미터를 선언하고 세터로 
		String postTitle = multipartRequest.getParameter("postTitle");
		String postContent = multipartRequest.getParameter("postContent");
		String price = multipartRequest.getParameter("price");
		String state = multipartRequest.getParameter("state");
		String img = multipartRequest.getParameter("img");
		String location = multipartRequest.getParameter("location");
		String storeName = multipartRequest.getParameter("storeName");
		float storeGrade = Float.valueOf(multipartRequest.getParameter("storeGrade"));
		PrintWriter script =response.getWriter();
		
		int result = postDAO.write(postTitle,userID,postContent,price,fileName,location,storeName,storeGrade); //위에서 받은 파라미터를 매개변수로 write함수에 넣어줌
		if(result ==-1){ //글쓰기 실패시 -1반환(기타에러 db에러 등등)
			
			script.println("<script>");
			script.println("alert('글쓰기에 실패하였습니다')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{ //성공적으로 작성시 postList로 이동
			
			script.println("<script>");
			script.println("location.href= 'postList.jsp'");
			script.println("</script>");
		}
	%>

</body>
</html>