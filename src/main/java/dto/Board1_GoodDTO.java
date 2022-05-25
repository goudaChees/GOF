package dto;

public class Board1_GoodDTO {
	private int seq;
	private String id;
	private int board_Seq;
	private int reply_Seq;
	public Board1_GoodDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Board1_GoodDTO(int reply_Seq) {
		super();
		this.reply_Seq = reply_Seq;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getBoard_Seq() {
		return board_Seq;
	}
	public void setBoard_Seq(int board_Seq) {
		this.board_Seq = board_Seq;
	}
	public int getReply_Seq() {
		return reply_Seq;
	}
	public void setReply_Seq(int reply_Seq) {
		this.reply_Seq = reply_Seq;
	}
}
