package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.Board1_ReplyDTO;

public class Board1_ReplyDAO {
	
	private static Board1_ReplyDAO instance = null;

	private synchronized static Board1_ReplyDAO getInstance(){
		if(instance==null){
			instance = new Board1_ReplyDAO();
		}

		return instance;
	}	
	private Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/orcl");
		return ds.getConnection();
	}
	public int insert(Board1_ReplyDTO dto)throws Exception {
		String sql = "insert into board1_reply values(board1reply_seq.nextval,?,?,default,0,?,?)";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, dto.getWriter());
			pstat.setString(2, dto.getContents());
			pstat.setString(3, dto.getAgree());
			pstat.setInt(4, dto.getParent_Seq());
			
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public List<Board1_ReplyDTO> selectReplyByParentSeq(int parent_Seq)throws Exception{
		String sql = "select * from board1_reply where parent_seq=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, parent_Seq);
			try(ResultSet rs = pstat.executeQuery();){
				
				List<Board1_ReplyDTO> list = new ArrayList<Board1_ReplyDTO>();
				while(rs.next()) {
					int seq = rs.getInt("seq");
					String writer = rs.getString("writer");
					String contents = rs.getString("contents");
					Timestamp write_date = rs.getTimestamp("write_date");
					int good = rs.getInt("good");
					String agree = rs.getString("agree");
					
					Board1_ReplyDTO dto = new Board1_ReplyDTO(seq,writer,contents,write_date,good,agree,parent_Seq);
					list.add(dto);
				}
				
				return list;
			}
		}
	}
	
}
