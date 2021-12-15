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
		//������ �����ϸ鼭 mysql�� ����
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
		//���� �ð� ���ϴ� �Լ� �Խ��� �ø��ð�
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
		return ""; //db����
	}
	
	public int getNext() {
		//primary key�� postID�� �����ִ� �߿��� �Լ� ū������ ���Ľ�Ų�� ������ �� +1�� ��ȯ
		String SQL="SELECT postID FROM post ORDER BY postID DESC";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1; //ù���ù�
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //db����
	}
	
	public int write(String postTitle, String userID, String postContent,String price, String img, String location,String storeName, float storeGrade) {
		String SQL="INSERT INTO post(postID, postTitle, userID, postDate, postContent, postAvailable, price, img, location,storeName,storeGrade) VALUES (?,? , ?, ?, ?, ?, ?, ?, ?,?,?)";
		
		//���� DB�� �ø��� �Լ� PreparedStatement�� �̿��� ���� ������ �ϳ��ϳ� �÷���
		
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
		return -1; //db����
	}
	
	public ArrayList<Post> getList(String userID){
		//������ ������ ��αױ⶧���� �ش� �α����� userID���� �� ���� ������ �������� �Լ�
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
				list.add(post); //post��ü�� �ش� �������� �ְ� post������ arraylist�� �߰�����				
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
		//�� �Խñ��� ������Ʈ ���ִ� �Լ�
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
		return -1; //db����
	}
	
	public int delete(int postID) {
		//�� �Խù��� �����ϴ� �Լ� delete���� �ʰ� postAvailable�� 0���� ����� �������� ������ �����ǰ� ��
		String SQL="UPDATE post SET postAvailable = 0 WHERE postID =?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, postID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //db����
	}
	

	
	public ArrayList<Post> getListRank(String userID){
		//���� ������ ���� ������ �Ű��ֱ����� �ش������� ���۵��� storeGrade ������������ select�ϴ� �Լ�
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
		//ù ���������� ���������� ���ֱ����� ���Ӹ� �ƴ϶� �ش� ��α׸� �̿��ϴ� ��� ������� ������ ������
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
		//postID�� �Ķ���ͷ� �޾� �ش���� ������ ������ ���� �߿��� �Լ�
		
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
