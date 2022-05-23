package dto;

import java.sql.Timestamp;

public class Board1_ReplyDTO {
		private int seq;
		private String writer;
		private String contents;
		private Timestamp write_date;
		private int good;
		private String agree;
		private int parent_Seq;
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
		public int getGood() {
			return good;
		}
		public void setGood(int good) {
			this.good = good;
		}
		public String getAgree() {
			return agree;
		}
		public void setAgree(String agree) {
			this.agree = agree;
		}
		public int getParent_Seq() {
			return parent_Seq;
		}
		public void setParent_Seq(int parent_Seq) {
			this.parent_Seq = parent_Seq;
		}
		public Board1_ReplyDTO(int seq, String writer, String contents, Timestamp write_date, int good, String agree,
				int parent_Seq) {
			super();
			this.seq = seq;
			this.writer = writer;
			this.contents = contents;
			this.write_date = write_date;
			this.good = good;
			this.agree = agree;
			this.parent_Seq = parent_Seq;
		}
		public Board1_ReplyDTO() {
			super();
			// TODO Auto-generated constructor stub
		}

}
