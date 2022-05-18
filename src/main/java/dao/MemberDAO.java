package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.MemberDTO;

public class MemberDAO {
private static MemberDAO instance = null;
	
	public synchronized static MemberDAO getInstance() {
		if(instance==null) {
			instance=new MemberDAO();
		}
		return instance;
	}
	
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/orcl");
		return ds.getConnection();
	}
	
	public boolean IsloginOk(String id,String pw) throws Exception {
		String sql = "select * from member where id=? and password=?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, id);
			pstat.setString(2, pw);
			try(ResultSet rs = pstat.executeQuery();){
				return rs.next();
			}
		}
	}
	
	public boolean isIdExist(String id) throws Exception {
		String sql = "select * from member where id=?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, id);
			try(ResultSet rs = pstat.executeQuery();){
				return rs.next();
			}
		}
	}
	
	public boolean isNNExist(String nickname) throws Exception {
		String sql = "select * from member where nickname=?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, nickname);
			try(ResultSet rs = pstat.executeQuery();){
				return rs.next();
			}
		}
	}
	
	public String getNickname(String id) throws Exception {
		String sql = "select nickname from member where id=?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, id);
			try(ResultSet rs = pstat.executeQuery();){
				rs.next();
				String nickname = rs.getString(1);
				return nickname;
			}
		}
	}
	
	public int insert(MemberDTO dto) throws Exception {
		String sql = "insert into member values(member_seq.nextval,?,?,?,?,?,?,default)";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, dto.getId());
			pstat.setString(2, dto.getPassword());
			pstat.setString(3, dto.getName());
			pstat.setString(4, dto.getPhone());
			pstat.setString(5, dto.getEmail());
			pstat.setString(6, dto.getNickname());
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public MemberDTO selectById(String pid) throws Exception{
		String sql = "select * from member where id=?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, pid);
			MemberDTO dto = null;
			try(ResultSet rs = pstat.executeQuery();){
				if(rs.next()) {
					String id = rs.getString("id");
					String name = rs.getString("name");
					String phone = rs.getString("phone");
					String email = rs.getString("email");
					String nickname = rs.getString("nickname");
					Date joindate = rs.getDate("joindate");
					
					dto = new MemberDTO(0, id, null ,name, phone, email, nickname, joindate);
				}
				return dto;
			}
		}
	}
	
	public String searchEmail(String id) throws Exception{
		String sql = "select email from member where id =?";
		try (
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, id);
			try (
					ResultSet rs = pstat.executeQuery();
					){
				String useremail = null;
				if (rs.next()) {
					String email = rs.getString("email");
					useremail = email;
				}
				return useremail;
			}
		}
	}
}
