package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.Board2_replyDTO;

public class Board2_replyDAO {
	private static Board2_replyDAO instance = null;

	private synchronized static Board2_replyDAO getInstance() {
		if (instance == null) {
			instance = new Board2_replyDAO();
		}
		return instance;
	}

	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/orcl");
		return ds.getConnection();
	};

	public boolean ischoice() throws Exception{
		String sql ="select choice from board2_reply";
		boolean ck = false;
		try(Connection con = this.getConnection();
			PreparedStatement stat = con.prepareStatement(sql);
			ResultSet rs = stat.executeQuery();){
			while(rs.next()) {
				String result = rs.getString("choice");
				if(result.equals("Y")) {
					ck = true;
				}
			}
		}
		return ck;
	}
	// 댓글 선택 여부 매서드
	
	
	public int insert(Board2_replyDTO dto) throws Exception {
		String sql = "insert into board2 values(reply2_seq.nextval,?,?,?,?,default)";
		try (Connection con = this.getConnection();
			PreparedStatement stat = con.prepareStatement(sql);) {
			stat.setString(1, dto.getNickname());
			stat.setInt(2, dto.getParent_seq());
			stat.setInt(3, dto.getPrice());
			stat.setString(4, dto.getContents());
			int result = stat.executeUpdate();
			con.commit();
			return result;
		}
	}

	public ArrayList<Board2_replyDTO> list(int pseq) throws Exception {
		String sql = "select * from board2_reply where parent_seq = ? order by seq desc";
		ArrayList<Board2_replyDTO> arr = new ArrayList<>();
		try (Connection con = this.getConnection(); 
				PreparedStatement stat = con.prepareStatement(sql);) {
			stat.setInt(1, pseq);
			try (ResultSet rs = stat.executeQuery();) {
				while (rs.next()) {
					int seq = rs.getInt("seq");
					String writer = rs.getString("writer");
					int parent_seq = rs.getInt("parent_seq");
					String contents = rs.getString("contents");
					int price = rs.getInt("price");
					String date = rs.getString("wirte_date");
					char check = rs.getString("choice").charAt(0);
					arr.add(new Board2_replyDTO(seq, writer, parent_seq, price, contents, date, check));
				}
			}
		}
		return arr;
	}

	public int del(int seq) throws Exception {
		String sql = "delete from board2_reply where seq=?";
		try (Connection con = this.getConnection(); PreparedStatement stat = con.prepareStatement(sql);) {
			stat.setInt(1, seq);
			int result = stat.executeUpdate();
			con.commit();
			return result;
		}
	}

	public int update(int price, String contents, int seq) throws Exception {
		String sql = "update board2_reply set price=?,contents=? where seq=?";
		try (Connection con = this.getConnection(); PreparedStatement stat = con.prepareStatement(sql);) {
			stat.setInt(1, price);
			stat.setString(2, contents);
			stat.setInt(3, seq);
			int result = stat.executeUpdate();
			con.commit();
			return result;
		}
	}

}
