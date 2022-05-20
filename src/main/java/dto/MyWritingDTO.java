package dto;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class MyWritingDTO {
	private int seq;
	private String title;
	private Timestamp write_date;
	
	public MyWritingDTO() {}
	public MyWritingDTO(int seq, String title, Timestamp write_date) {
		super();
		this.seq = seq;
		this.title = title;
		this.write_date = write_date;
	}
	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Timestamp getWrite_date() {
		return write_date;
	}
	public void setWrite_date(Timestamp write_date) {
		this.write_date = write_date;
	}
	
	public String getFormed_WriteDate() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		return sdf.format(this.write_date);
	}
	
	
}
