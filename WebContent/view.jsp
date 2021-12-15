<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="post.Post" %>
<%@ page import="post.PostDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나만의 맛집 블로그</title>
<link rel="stylesheet" href="custom.css">
<style>
</style>
</head>
<body>
<%
	//제목을 눌렀을때 해당 글을 보는 페이지
	request.setCharacterEncoding("utf-8");
	String userID=null;
	if(session.getAttribute("userID")!=null){ //로그인 확인
		userID=(String)session.getAttribute("userID");
	}
	int postID = 0;
	if(request.getParameter("postID")!=null){ //해당 글의 postID받아옴
		postID = Integer.parseInt(request.getParameter("postID"));
	}
	if(postID==0){ //유효한 글인지 확인
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다')");
		script.println("location.href= 'postList.jsp'");
		script.println("</script>");
	}
	Post post = new PostDAO().getPost(postID); //받아온 postID를 통해 post객체 생성
%>

		<%@ include file="top2.jsp" %>
 		<table  style="text-align; center; border:1px;width:60%; margin: auto;">
 			<thead>
 				<tr>
 				<th colspan="3" style="text-align:center;">글 보기</th>			
 				</tr>
 			</thead>
 			<tbody>
 				<tr>
 					<td style="width:20%;">글 제목</td>
 					<td colspan="2"><%= post.getPostTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
 				</tr>
 				<tr>
 					<td >작성자</td>
 					<td colspan="2"><%= post.getUserID() %></td>
 				</tr>
 				<tr>
 					<td >가게 이름</td>
 					<td colspan="2"><%= post.getStoreName() %></td>
 				</tr>
 				<tr>
 					<td>작성일자</td>
 					<td colspan="2"><%= post.getPostDate().substring(0,11)+post.getPostDate().substring(11,13)+"시"+post.getPostDate().substring(14,16)+"분" %></td>
 				</tr>
 				<tr>
 					<td >가격</td>
 					<td colspan="2"><%= post.getPrice() %>원</td>
 				</tr>
 				<tr>
 					<td >평점</td>
 					<td colspan="2"><%= post.getStoreGrade() %></td>
 				</tr>
 				<tr>
 					<td >지역</td>
 					<td colspan="2"><a href="map.jsp?location=<%= post.getLocation() %>"><%= post.getLocation() %></a></td>
 				</tr>
 				<tr>
 					<td >이미지</td>
 					<td colspan="2"><img src="upload/<%= post.getImg() %>" width=512 height=384 ></img></td>
 				</tr>
 				<tr>
 					<td >내용</td>
 					<td colspan="2" style="min-height:500px; text-align:left"><%= post.getPostContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
 				</tr>
 				<tr>
 					<td colspan="3">
 						<button onclick="location.href='postList.jsp'">목록</button>
						<button onclick="location.href='update.jsp?postID=<%= postID%>'">수정</button>				
						<button onclick="func_confirm ()">삭제</button>  <!-- 버튼을 누르면 func_confirm 함수로 넘어감 -->
						<%-- <a onclick="return confirm('정말로 삭제하시겠습니까?')"><button onclick="location.href='deleteAction.jsp?postID=<%= postID%>'">삭제</button></a> --%>
						<%-- <a class="btn" onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?postID=<%= postID%>">삭제</a> --%>	
 					</td>
 				<tr>
 			</tbody>
 		</table>
		<script type="text/javascript">
        	function func_confirm () { //삭제를 해주기위한 함수 confirm을 띄워주기위해 함수로 만듬
        		if(confirm('삭제하시겠습니까??')){
        			location.href="deleteAction.jsp?postID=<%=postID%>";
        		} else {
        			alert("삭제가 취소되었습니다.");
        		}
        	}
        </script>

</body>
</html>