package dto;

public class Board2DTO {
	private int seq;
	private String nickname;
	private String title;
	private String contents;
	private String write_date;
	private String item;
	private int view_count;
	private int reply;
	private String id;
	
	public Board2DTO() {
		super();
	}
	

	public Board2DTO(int seq, String nickname, String title, String contents, String write_date, String item,
			int view_count, int reply, String id) {
		super();
		this.seq = seq;
		this.nickname = nickname;
		this.title = title;
		this.contents = contents;
		this.write_date = write_date;
		this.item = item;
		this.view_count = view_count;
		this.reply = reply;
		this.id = id;
	}

	

	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public int getSeq() {
		return seq;
	}
	public int getReply() {
		return reply;
	}


	public void setReply(int reply) {
		this.reply = reply;
	}


	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getWrite_date() {
		return write_date;
	}
	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}
	public String getItem() {
		return item;
	}
	public void setItem(String item) {
		this.item = item;
	}
	public int getView_count() {
		return view_count;
	}
	public void setView_count(int view_count) {
		this.view_count = view_count;
	}
	
}
