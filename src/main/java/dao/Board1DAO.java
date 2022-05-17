package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.Board1DTO;

public class Board1DAO {
	private static Board1DAO instance = null;
	
	private synchronized static Board1DAO getInstance() {
		if(instance == null) {
			instance = new Board1DAO();
		}
		return instance;
	}
	
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/orcl");
		return ds.getConnection();
	};
	
	public int insert(Board1DTO dto)throws Exception {
		String sql = "insert into board1 values(board1_seq.nextval,?,?,?,default,?,?,0,0,0)";
		
		try(
			Connection con = this.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);
				){
				pstat.setString(1, dto.getWriter());
				pstat.setString(2, dto.getTitle());
				pstat.setString(3, dto.getContents());
				pstat.setString(4, dto.getItem());
				pstat.setInt(5, dto.getItem_price());
				
				int result = pstat.executeUpdate();
				con.commit();
				
				return result;
		}
	}
	
	public String selectNicknameById(String id)throws Exception {
		String sql = "select nickname from member where id=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
					){
			pstat.setString(1, id);
			
			try(
				ResultSet rs = pstat.executeQuery();
					){
				rs.next();
				return rs.getString("nickname");
			}
		}
	}
}
