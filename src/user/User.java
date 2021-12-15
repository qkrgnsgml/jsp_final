package user;

public class User {
	//회원가입으로 DB에 올라갈 user정보
	private String userID; //userID 겹칠수없으므로 primary key설정 
	private String userPassword; //비밀번호
	private String userName; //이름
	private String userEmail; //이메일
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	
	
}