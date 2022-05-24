package dto;

public class Board2_replyDTO {
	private int seq;
	private String nickname;
	private int parent_seq;
	private Long price;
	private String contents;
	private String wirte_date;
	private char choice;
	public Board2_replyDTO(int seq, String nickname, int parent_seq, Long price, String contents, String wirte_date,
			char choice) {
		super();
		this.seq = seq;
		this.nickname = nickname;
		this.parent_seq = parent_seq;
		this.price = price;
		this.contents = contents;
		this.wirte_date = wirte_date;
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
	public String getWirte_date() {
		return wirte_date;
	}
	public void setWirte_date(String wirte_date) {
		this.wirte_date = wirte_date;
	}
	public char getChoice() {
		return choice;
	}
	public void setChoice(char choice) {
		this.choice = choice;
	}
	
}
