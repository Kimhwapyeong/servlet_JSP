package dto;

public class Board {

	private String num;
	private String title;
	private String contect;
	private String id;
	private String postDate;
	private String visitCount;

	public Board() {
		// TODO Auto-generated constructor stub
	}

	public Board(String num, String title, String contect
				, String id, String postDate, String visitCount) {
		this.num = num;
		this.title = title;
		this.contect = contect;
		this.id = id;
		this.postDate = postDate;
		this.visitCount = visitCount;
	}




	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContect() {
		return contect;
	}

	public void setContect(String contect) {
		this.contect = contect;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPostDate() {
		return postDate;
	}

	public void setPostDate(String postDate) {
		this.postDate = postDate;
	}

	public String getVisitCount() {
		return visitCount;
	}

	public void setVisitCount(String visitCount) {
		this.visitCount = visitCount;
	}

}
