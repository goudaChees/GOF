package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.Board2DTO;

public class Board2DAO {
	private static Board2DAO instance = null;
	
	private synchronized static Board2DAO getInstance() {
		if(instance == null) {
			instance = new Board2DAO();
		}
		return instance;
	}
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/orcl");
		return ds.getConnection();
	};
	public int insert(Board2DTO dto) throws Exception {
		String sql = "insert into board2 values(Board_seq.nextval,?,?,?,default,?,default)";
		try (Connection con = this.getConnection();
				PreparedStatement stat = con.prepareStatement(sql);
				){
			stat.setString(1, dto.getNickname());
			stat.setString(2, dto.getTitle());
			stat.setString(3, dto.getContents());
			stat.setString(4, dto.getItem());
			int result = stat.executeUpdate();
			con.commit();
			return result;
	}
	}
		public ArrayList<Board2DTO> list() throws Exception{
			String sql = "select * from board order by seq desc";
			ArrayList<Board2DTO> arr = new ArrayList<>();
			try(Connection con = this.getConnection();
				PreparedStatement stat = con.prepareStatement(sql);
				ResultSet rs = stat.executeQuery();){
				while(rs.next()) {
					int seq =rs.getInt("seq");
					String writer = rs.getString("writer");
					String title = rs.getString("title");
					String contents = rs.getString("contents");
					String date= rs.getString("write_date");
					String item = rs.getString("item");
					int count = rs.getInt("view_count");
					arr.add(new Board2DTO(seq,writer,title,contents,item,date,0));
				}
			}
			return arr;
		}
		public int del(int seq) throws Exception{
			String sql = "delete from board2 where seq=?";
			try(Connection con = this.getConnection();
				PreparedStatement stat = con.prepareStatement(sql);){
				stat.setInt(1, seq);
				int result = stat.executeUpdate();
				con.commit();
				return result;
			}
		}
		public int update(String title,String contents,String item,int seq) throws Exception{
			String sql= "update board set title=?,contents=?,item=? where seq=?";
			try(Connection con = this.getConnection();
					PreparedStatement stat = con.prepareStatement(sql);){
				stat.setString(1, title);
				stat.setString(2, contents);
				stat.setString(3, item);
				stat.setInt(4, seq);
				int result = stat.executeUpdate();
				con.commit();
				return result;
			}
		}
		public void count(int seq,int count) throws Exception{
			String sql = "update board2 set view_count=? where seq=?";
			try(Connection con = this.getConnection();
				PreparedStatement stat = con.prepareStatement(sql);){
				count++;
				stat.setInt(1, count);
				stat.setInt(2, seq);
				stat.executeQuery();
				con.commit();
			}
					
		}
		// 뷰 카운트
		
		
		
		
		
}
