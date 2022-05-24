package dto;

public class Board2_replyDTO {
	private int seq;
	private String nickname;
	private int parent_seq;
	private Long price;
	private String contents;
	private String write_date;
	private char choice;
	public Board2_replyDTO(int seq, String nickname, int parent_seq, Long price, String contents, String write_date,
			char choice) {
		super();
		this.seq = seq;
		this.nickname = nickname;
		this.parent_seq = parent_seq;
		this.price = price;
		this.contents = contents;
		this.write_date = write_date;
		this.choice = choice;
	}
	public Board2_replyDTO() {
		super();
	}
	public int getSeq() {
		return seq;
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
	public int getParent_seq() {
		return parent_seq;
	}
	public void setParent_seq(int parent_seq) {
		this.parent_seq = parent_seq;
	}
	public Long getPrice() {
		return price;
	}
	public void setPrice(Long price) {
		this.price = price;
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
	public char getChoice() {
		return choice;
	}
	public void setChoice(char choice) {
		this.choice = choice;
	}
	
}
