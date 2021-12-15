package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
		//생성자로 바로 mysql과 연결
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
	
	public int login(String userID,String userPassword) {
		//로그인 함수 id와 password를 매개변수로 받아 해당 id의 password가 같은지 확인한후 int를 리턴해준다
		String SQL="SELECT userPassword FROM USER WHERE userID =?";
		try {
			pstmt =conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1;//로그인 성공
				}
				else{
					return 0;//비번 불일치
				}
			}
			conn.close();
			rs.close();
			pstmt.close();
			return -1;//아이다가 없음
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -2;//데이터베이스 오류
	}
	
	public int join(User user) {
		//회원가입해주는 함수 user 자바빈정보를 받아서 values에 넣어줌
		//post도 자바빈 사용하려했는데 file때문에 잘 안되서 파라미터로 일일히 넣어줌
		String SQL="INSERT INTO USER VALUES(?,?,?,?)";
		try{
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserEmail());
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<User> getList(){
		//모든 유저의 정보를 가져오는 getList함수
		String SQL="SELECT * FROM user";
		ArrayList<User> list = new ArrayList<User>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserPassword(rs.getString(2));
				user.setUserName(rs.getString(3));
				user.setUserEmail(rs.getString(4));
				list.add(user);
			}
			conn.close();
			rs.close();
			pstmt.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int update(String userPassword, String userName, String userEmail,String userId) {
		//내 정보를 수정할 수 있는 함수 ID는 PK기 때문에 수정못하게 설정해놓음
		String SQL="UPDATE user SET userPassword=?, userName=?,userEmail=? WHERE userID=?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userPassword);
			pstmt.setString(2, userName);
			pstmt.setString(3, userEmail);
			pstmt.setString(4, userId);

			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //db오류
	}
}
