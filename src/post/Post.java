package post;

public class Post {
	//�Խñۿ� �ö� post
	private int postID; //primary key�� ���� 1���� ����
	private String postTitle; //���� ����
	private String userID; //����� ���̵�
	private String postDate; //�۾� �ð�
	private String postContent; //����
	private int postAvailable; //���� ����
	private String price; //����
	private String img; //����
	private String location; //���� ��ġ
	private String storeName; //���� ����
	//�Ʒ��� ���Ϳ� ����
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
