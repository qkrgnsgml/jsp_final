package post;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class PostDAO {
	private Connection conn;
	private ResultSet rs;

	public PostDAO() {
		//생성자 선언하면서 mysql과 연결
		try {
			String dbURL= "jdbc:mysql://localhost:3306/jsp?characterEncoding=UTF-8&serverTimezone=UTC";
			String dbID="root";
			String dbPassword="root";
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(dbURL,dbID,dbPassword);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getDate() {
		//현재 시각 구하는 함수 게시판 올린시각
		String SQL="SELECT NOW()";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ""; //db에러
	}
	
	public int getNext() {
		//primary key인 postID를 구해주는 중요한 함수 큰순서로 정렬시킨뒤 맨위에 수 +1을 반환
		String SQL="SELECT postID FROM post ORDER BY postID DESC";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1; //첫개시물
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //db오류
	}
	
	public int write(String postTitle, String userID, String postContent,String price, String img, String location,String storeName, float storeGrade) {
		String SQL="INSERT INTO post(postID, postTitle, userID, postDate, postContent, postAvailable, price, img, location,storeName,storeGrade) VALUES (?,? , ?, ?, ?, ?, ?, ?, ?,?,?)";
		
		//글을 DB에 올리는 함수 PreparedStatement를 이용해 글의 정보를 하나하나 올려줌
		
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, postTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, postContent);
			pstmt.setInt(6, 1);
			pstmt.setString(7, price);
			pstmt.setString(8, img);
			pstmt.setString(9, location);
			pstmt.setString(10, storeName);
			pstmt.setFloat(11, storeGrade);
			return pstmt.executeUpdate();			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //db오류
	}
	
	public ArrayList<Post> getList(String userID){
		//컨셉이 나만의 블로그기때문에 해당 로그인한 userID만이 쓴 글의 정보를 가져오는 함수
		String SQL="SELECT * FROM post WHERE userID= ? and postAvailable=1 ORDER BY postID DESC";
		ArrayList<Post> list = new ArrayList<Post>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,userID);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Post post = new Post();
				post.setPostID(rs.getInt(1));
				post.setPostTitle(rs.getString(2));
				post.setUserID(rs.getString(3));
				post.setPostDate(rs.getString(4));
				post.setPostContent(rs.getString(5));
				post.setPostAvailable(rs.getInt(6));
				post.setPrice(rs.getString(7));
				post.setImg(rs.getString(8));
				post.setLocation(rs.getString(9));
				post.setStoreName(rs.getString(10));
				post.setStoreGrade(rs.getFloat(11));
				list.add(post); //post객체에 해당 정보들을 넣고 post형태의 arraylist에 추가해줌				
			} 
			conn.close();
			rs.close();
			pstmt.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	
	public int update(int postID, String postTitle, String price,String state, String location, String postContent,String storeName, float storeGrade) {
		String SQL="UPDATE post SET postTitle =?, price =?, location=?,postContent =? ,storeName=?, storeGrade=? WHERE postID =?";
		//쓴 게시글을 업데이트 해주는 함수
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, postTitle);
			pstmt.setString(2, price);
			pstmt.setString(3, location);
			pstmt.setString(4, postContent);			
			pstmt.setString(5,storeName);
			pstmt.setFloat(6,storeGrade);
			pstmt.setInt(7,postID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //db오류
	}
	
	public int delete(int postID) {
		//쓴 게시물을 삭제하는 함수 delete하지 않고 postAvailable을 0으로 만들어 보이지는 않지만 보존되게 함
		String SQL="UPDATE post SET postAvailable = 0 WHERE postID =?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, postID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //db오류
	}
	

	
	public ArrayList<Post> getListRank(String userID){
		//가게 평점에 따른 순위를 매겨주기위해 해당유저가 쓴글들을 storeGrade 내림차순으로 select하는 함수
		String SQL="SELECT * FROM post where userID = ? and postAvailable=1 ORDER BY storeGrade DESC";
		ArrayList<Post> list = new ArrayList<Post>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,userID);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Post post = new Post();
				post.setPostID(rs.getInt(1));
				post.setPostTitle(rs.getString(2));
				post.setUserID(rs.getString(3));
				post.setPostDate(rs.getString(4));
				post.setPostContent(rs.getString(5));
				post.setPostAvailable(rs.getInt(6));
				post.setPrice(rs.getString(7));
				post.setImg(rs.getString(8));
				post.setLocation(rs.getString(9));
				post.setStoreName(rs.getString(10));
				post.setStoreGrade(rs.getFloat(11));
				list.add(post);
			}
			conn.close();
			rs.close();
			pstmt.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Post> getListAll(){
		//첫 페이지에서 랜덤음식을 해주기위해 나뿐만 아니라 해당 블로그를 이용하는 모든 사람들의 정보를 가져옴
		String SQL="SELECT * FROM post where postAvailable = 1";
		ArrayList<Post> list = new ArrayList<Post>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);			
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Post post = new Post();
				post.setPostID(rs.getInt(1));
				post.setPostTitle(rs.getString(2));
				post.setUserID(rs.getString(3));
				post.setPostDate(rs.getString(4));
				post.setPostContent(rs.getString(5));
				post.setPostAvailable(rs.getInt(6));
				post.setPrice(rs.getString(7));
				post.setImg(rs.getString(8));
				post.setLocation(rs.getString(9));
				post.setStoreName(rs.getString(10));
				post.setStoreGrade(rs.getFloat(11));
				list.add(post);
			}
			conn.close();
			rs.close();
			pstmt.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public Post getPost(int postID) {
		String SQL="SELECT * FROM post WHERE postID = ?";
		//postID를 파라미터로 받아 해당글의 정보를 얻어오기 위한 중요한 함수
		
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1,postID);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				Post post = new Post();
				post.setPostID(rs.getInt(1));
				post.setPostTitle(rs.getString(2));
				post.setUserID(rs.getString(3));
				post.setPostDate(rs.getString(4));
				post.setPostContent(rs.getString(5));
				post.setPostAvailable(rs.getInt(6));
				post.setPrice(rs.getString(7));
				post.setImg(rs.getString(8));
				post.setLocation(rs.getString(9));
				post.setStoreName(rs.getString(10));
				post.setStoreGrade(rs.getFloat(11));
				return post;
			}
			conn.close();
			rs.close();
			pstmt.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
}
