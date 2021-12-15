<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="post.PostDAO" %>
<%@ page import="post.Post" %>
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
	request.setCharacterEncoding("utf-8");
	String title = request.getParameter("title"); //검색버튼을 누르면 가져오고 아니면 null
	String userID = (String)session.getAttribute("userID"); //세션에 아이디 가져옴
	if(userID==null){ //로그인 체크
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href= 'loginForm.jsp'");
		script.println("</script>");
	}	
	int pageNumber =1; //첫페이지는 페이지가 1 10개씩 글 끊어줌
	if(request.getParameter("pageNumber")!=null){ //다음이나 이전페이지를 눌러줬을때
		pageNumber=Integer.parseInt(request.getParameter("pageNumber")); //가져와서 int로 parse
	}
	%>
	<%@ include file="top2.jsp" %>

	

<%if(title==null){  //검색을 안했을때 %>
 		<table style="text-align: center; border:1px;width:60%; margin: auto;">
 			<thead>
 				<tr>
 				<th>번호</th>
 				<th style="width:40%">제목</th>
 				<th>평점</th>
 				<th style="width:25%">작성일</th> 			
 				</tr>
 			</thead>
 			<tbody>
 			<%
 				PostDAO postDAO = new PostDAO(); //PostDAO객체 생성
 				ArrayList<Post> list = postDAO.getList(userID); //DB에 쓴 글중에 작성자가 현재 로그인한 아이디이고 available이 1인 글들을 최신순으로(postID가 클수록 최신) 가져와서 list에 넣어줌
 				if(pageNumber==1){//첫페이지면 size만큼 10이하 만큼 처리
 				for(int i=0;i<list.size();i++){
 					if(i==10){break;} // 10개 째에서 break로 끊어줌
 			%>
 			 	<tr>
 					<td><%= i+1 %></td> <!--  인덱스값 -->
 					<td><a href="view.jsp?postID=<%=list.get(i).getPostID()%>"><%= list.get(i).getPostTitle() %></a></td> <!--  제목을 누르면 게시글의 ID(Primary key)를 매개변수로 view페이지로 넘김 -->
 					<td><%= list.get(i).getStoreGrade() %></td>
 					<td><%= list.get(i).getPostDate().substring(0,11)+list.get(i).getPostDate().substring(11,13)+"시"+list.get(i).getPostDate().substring(14,16)+"분" %></td>
 				</tr>
 				
 			<%
 				}}else{ //pageNumber가 1보다 클때 > list.size()가 10보다 클때
 					for(int i=(pageNumber-1)*10;i<list.size();i++){ //pageNumber은 무조건 2이상이니까 i는 10,20,30등등 부터 시작
 						if(i==pageNumber*10){break;}//20,30,40번째에서 다음페이지로 가야하므로 break걸어줌 다음페이지 가면 자연스럽게 pageNumber이 1씩 증가함
 			%>
 				<tr>
 					<td><%= i+1 %></td>
 					<td><a href="view.jsp?postID=<%=list.get(i).getPostID()%>"><%= list.get(i).getPostTitle() %></a></td>
 					<td><%= list.get(i).getStoreGrade() %></td>
 					<td><%= list.get(i).getPostDate().substring(0,11)+list.get(i).getPostDate().substring(11,13)+"시"+list.get(i).getPostDate().substring(14,16)+"분" %></td>
 				</tr>
 				<%}} %>
				<tr >
 					<td colspan="4"><button onclick="location.href='write.jsp'">글쓰기</button></td>
 				</tr>
 				<tr>
 					<td colspan="4">
 						<form method="post" action="./postList.jsp"><!-- 검색버튼 자기자신 페이지로 돌아옴 -->
						<input type="text" style="width:40%;border:1px;" placeholder="제목" name="title" value = "">
    					<button type="submit">검색</button>
						</form>
					</td>
 				</tr>
 				<%
 				if(pageNumber !=1&&list.size()>10){ //페이지 넘버거 1도 아니고 사이즈가 10보다 클때 이전버튼 표시
 				%>
 				<tr><td colspan="4"><button onclick="location.href='postList.jsp?pageNumber=<%=pageNumber-1 %>'">이전</button><button onclick="location.href='postList.jsp?pageNumber=<%=pageNumber+1 %>'">다음</button></td></tr>
 				<%
 				}else if(list.size()>10){ //사이즈만 10보다 클때 첫페이지인데 list가 10개가 넘어가면 다음버튼 표시
 				%>
 				<tr><td colspan="4"><button onclick="location.href='postList.jsp?pageNumber=<%=pageNumber+1 %>'">다음</button></td></tr>
 				<%} %>
 				
 			</tbody>
 		</table>
 		
 <%}else{ //검색 버튼을 눌러서 title에 매개변수가 들어왔을떄%>
 		<table style="text-align: center; border:1px;width:60%; margin: auto; ">
 			<thead>
 				<tr>
 				<th>번호</th>
 				<th style="width:40%">제목</th>
 				<th>평점</th>
 				<th style="width:25%">작성일</th> 			
 				</tr>
 			</thead>
 			<tbody>
 			<%
 				PostDAO postDAO = new PostDAO(); //PostDAO객체 생성
 				ArrayList<Post> list = postDAO.getList(userID); //해당 유저가 쓴 글들 불러옴
 				for(int i=0;i<list.size();i++){ //리스트 사이즈만큼 돌려서
 					if(list.get(i).getPostTitle().contains(title)){ //contains(포함하면 true)를 이용해서 검색한 것이 제목에 포함되어있으면 if문진행해서 글 보여줌
 			%>
 			 	<tr>
 					<td><%= i+1 %></td>
 					<td><a href="view.jsp?postID=<%=list.get(i).getPostID()%>"><%= list.get(i).getPostTitle() %></a></td>
 					<td><%= list.get(i).getStoreGrade() %></td>
 					<td><%= list.get(i).getPostDate().substring(0,11)+list.get(i).getPostDate().substring(11,13)+"시"+list.get(i).getPostDate().substring(14,16)+"분" %></td>
 				</tr>
 			<%
 					}else{ //contains에 안걸린것들은 그냥 continue 포문 진행
 						continue;
 					}
 				}
 			%>
 				<tr>
 					<td align="right" colspan="4"><button onclick="location.href='write.jsp'">글쓰기</button></td>
 				</tr>
 				<tr>
 					<td colspan="4">
 						<form method="post" action="./postList.jsp"><!-- 검색버튼 자기자신 페이지로 돌아옴 -->
						<input type="text" style="width:40%;border:1px;" placeholder="제목" name="title" value = "">
    					<button type="submit">검색</button>
						</form>
					</td>
 				</tr>
 				<%
 				if(pageNumber !=1&&list.size()>10){ //페이지 넘버거 1도 아니고 사이즈가 10보다 클때 이전버튼 표시
 				%>
 				<tr><td colspan="4"><button onclick="location.href='postList.jsp?pageNumber=<%=pageNumber-1 %>'">이전</button><button onclick="location.href='postList.jsp?pageNumber=<%=pageNumber+1 %>'">다음</button></td></tr>
 				<%
 				}else if(list.size()>10){ //사이즈만 10보다 클때 첫페이지인데 list가 10개가 넘어가면 다음버튼 표시
 				%>
 				<tr><td colspan="4"><button onclick="location.href='postList.jsp?pageNumber=<%=pageNumber+1 %>'">다음</button></td></tr>
 				<%} %>
 				
 			</tbody>
 		</table>
 <%} %>
 

</body>
</html>
