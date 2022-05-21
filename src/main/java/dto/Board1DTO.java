package dto;

import java.sql.Timestamp;

public class Board1DTO {

	private int seq;
	private String writer;
	private String title;
	private String contents;
	private Timestamp write_date;
	private String item;
	private int item_price;
	private int agree_count;
	private int disagree_count;
	private int view_count;
	private String fileName;
	public Board1DTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Board1DTO(int seq, String writer, String title, String contents, Timestamp write_date, String item,
			int item_price, int agree_count, int disagree_count, int view_count, String fileName) {
		super();
		this.seq = seq;
		this.writer = writer;
		this.title = title;
		this.contents = contents;
		this.write_date = write_date;
		this.item = item;
		this.item_price = item_price;
		this.agree_count = agree_count;
		this.disagree_count = disagree_count;
		this.view_count = view_count;
		this.fileName = fileName;
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
	public String getItem() {
		return item;
	}
	public void setItem(String item) {
		this.item = item;
	}
	public int getItem_price() {
		return item_price;
	}
	public void setItem_price(int item_price) {
		this.item_price = item_price;
	}
	public int getAgree_count() {
		return agree_count;
	}
	public void setAgree_count(int agree_count) {
		this.agree_count = agree_count;
	}
	public int getDisagree_count() {
		return disagree_count;
	}
	public void setDisagree_count(int disagree_count) {
		this.disagree_count = disagree_count;
	}
	public int getView_count() {
		return view_count;
	}
	public void setView_count(int view_count) {
		this.view_count = view_count;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

}
