package dto;

public class Board1_GoodDTO {
	private int seq;
	private String nickname;
	private int board_Seq;
	private int reply_Seq;
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
	public Board1_GoodDTO(int seq, String nickname, int board_Seq, int reply_Seq) {
		super();
		this.seq = seq;
		this.nickname = nickname;
		this.board_Seq = board_Seq;
		this.reply_Seq = reply_Seq;
	}
	public Board1_GoodDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	

}
