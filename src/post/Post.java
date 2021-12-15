package post;

public class Post {
	//게시글에 올라갈 post
	private int postID; //primary key로 설정 1부터 증가
	private String postTitle; //글의 제목
	private String userID; //사용자 아이디
	private String postDate; //글쓴 시간
	private String postContent; //내용
	private int postAvailable; //삭제 여부
	private String price; //가격
	private String img; //사진
	private String location; //가게 위치
	private String storeName; //가게 평점
	//아래는 겟터와 셋터
	public String getStoreName() {
		return storeName;
	}
	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}
	public float getStoreGrade() {
		return storeGrade;
	}
	public void setStoreGrade(float storeGrade) {
		this.storeGrade = storeGrade;
	}
	private float storeGrade;
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getImagename() {
		return imagename;
	}
	public void setImagename(String imagename) {
		this.imagename = imagename;
	}
	private String imagename;
	public int getPostID() {
		return postID;
	}
	public void setPostID(int postID) {
		this.postID = postID;
	}
	public String getPostTitle() {
		return postTitle;
	}
	public void setPostTitle(String postTitle) {
		this.postTitle = postTitle;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getPostDate() {
		return postDate;
	}
	public void setPostDate(String postDate) {
		this.postDate = postDate;
	}
	public String getPostContent() {
		return postContent;
	}
	public void setPostContent(String postContent) {
		this.postContent = postContent;
	}
	public int getPostAvailable() {
		return postAvailable;
	}
	public void setPostAvailable(int postAvailable) {
		this.postAvailable = postAvailable;
	}
	
	
}
