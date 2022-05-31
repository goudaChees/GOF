package dto;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class LetterDTO {
	private int seq;
	private String writer;
	private String receiver;
	private String title;
	private String contents;
	private Timestamp write_date;
	private int read;
	private String writerId;
	private String receiverId;
	
	public LetterDTO() {
	}
	
	public LetterDTO(int seq, String writer, String receiver, String title, String contents, Timestamp write_date,
			int read, String writerId, String receiverId) {
		super();
		this.seq = seq;
		this.writer = writer;
		this.receiver = receiver;
		this.title = title;
		this.contents = contents;
		this.write_date = write_date;
		this.read = read;
		this.writerId = writerId;
		this.receiverId = receiverId;
	}
	

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
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

	public Timestamp getWrite_date() {
		return write_date;
	}

	public void setWrite_date(Timestamp write_date) {
		this.write_date = write_date;
	}

	public int getRead() {
		return read;
	}

	public void setRead(int read) {
		this.read = read;
	}

	public String getWriterId() {
		return writerId;
	}

	public void setWriterId(String writerId) {
		this.writerId = writerId;
	}

	public String getReceiverId() {
		return receiverId;
	}

	public void setReceiverId(String receiverId) {
		this.receiverId = receiverId;
	}

	public String getFormed_WriteDate() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		return sdf.format(this.write_date);
	}
	
}
