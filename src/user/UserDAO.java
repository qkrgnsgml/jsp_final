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
		//�����ڷ� �ٷ� mysql�� ����
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
		//�α��� �Լ� id�� password�� �Ű������� �޾� �ش� id�� password�� ������ Ȯ������ int�� �������ش�
		String SQL="SELECT userPassword FROM USER WHERE userID =?";
		try {
			pstmt =conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1;//�α��� ����
				}
				else{
					return 0;//��� ����ġ
				}
			}
			conn.close();
			rs.close();
			pstmt.close();
			return -1;//���̴ٰ� ����
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -2;//�����ͺ��̽� ����
	}
	
	public int join(User user) {
		//ȸ���������ִ� �Լ� user �ڹٺ������� �޾Ƽ� values�� �־���
		//post�� �ڹٺ� ����Ϸ��ߴµ� file������ �� �ȵǼ� �Ķ���ͷ� ������ �־���
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
		//��� ������ ������ �������� getList�Լ�
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
		//�� ������ ������ �� �ִ� �Լ� ID�� PK�� ������ �������ϰ� �����س���
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
		return -1; //db����
	}
}
