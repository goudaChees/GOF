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
	public int insert(Board1_ReplyDTO dto)throws Exception {//댓글 작성 기능
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
	
	public List<Board1_ReplyDTO> selectReplyByParentSeq(int parent_Seq)throws Exception{//댓글 목록 불러오기
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
	
	public String getAgreeByseq(int seq)throws Exception{
		String sql = "select Agree from board1_reply where seq=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, seq);
			try(
				ResultSet rs = pstat.executeQuery();	
					){
				rs.next();
				return rs.getString("agree");
			}
		}
	}
	
	public int modifyReply(int seq,String agree,String contents)throws Exception {//댓글 수정 기능
		String sql = "update board1_reply set agree=?, contents=? where seq =? ";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, agree);
			pstat.setString(2, contents);
			pstat.setInt(3, seq);
			
			int result = pstat.executeUpdate();
			return result;
		}
		
	}
	public int deleteReplyBySeq(int seq)throws Exception {
		String sql = "delete from board1_reply where seq=?";	
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, seq);
			int result = pstat.executeUpdate();
			return result;
		}
	}
	
	public int deleteReplyByParent_Seq(int parent_Seq)throws Exception {
		String sql = "delete from board1_reply where parent_seq=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, parent_Seq);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public int countReplyByParentSeq(int parent_Seq)throws Exception {//각 게시판 별 댓글 수 구하기
		String sql = "select count(*) from board1_reply where parent_seq=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, parent_Seq);
			try(
				ResultSet rs = pstat.executeQuery();
					){
				rs.next();
				return rs.getInt(1);
			}
		}
	}
	
	public boolean didIDwrite(int seq,String nickname)throws Exception {
		String sql = "select * from board1_reply where parent_seq=? and writer=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, seq);
			pstat.setString(2, nickname);
			try(
				ResultSet rs = pstat.executeQuery();
					){
				if(rs.next()) {
					return true;
				}
				
				return false;
			}
		}
	}
	public int insertGood(String id,int board1_Seq, int reply1_Seq)throws Exception {
		String sql = "insert into good_board1 values(good_seq.nextval,?,?,?)";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, id);
			pstat.setInt(2, board1_Seq);
			pstat.setInt(3, reply1_Seq);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
		
	}
	
	public int addGoodBySeq(int reply_Seq)throws Exception {
		String sql = "update board1_reply set good=good+1 where seq =?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, reply_Seq);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public Board1_ReplyDTO getGoodBySeq(int reply_Seq)throws Exception{
		String sql = "select * from board1_reply where seq=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, reply_Seq);
			try(
				ResultSet rs = pstat.executeQuery();	
					){
				rs.next();
				int seq = rs.getInt("seq");
				String writer = rs.getString("writer");
				String contents = rs.getString("contents");
				Timestamp write_date = rs.getTimestamp("write_date");
				int good = rs.getInt("good");				
				String agree = rs.getString("agree");
				int parent_Seq = rs.getInt("parent_seq");
				
				return new Board1_ReplyDTO(seq,writer,contents,write_date,good,agree,parent_Seq);
			}
		}
	}
	
	public List<Integer> isGoodChecked(int board1_Seq,String id)throws Exception{
		String sql = "select reply_seq from good_board1 where  id=? and board_seq=? ";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, id);
			pstat.setInt(2, board1_Seq);
			try(
				ResultSet rs = pstat.executeQuery();	
					){
				List<Integer> list = new ArrayList<Integer>();
				while(rs.next()) {
					int i=rs.getInt(1);
					list.add(i);
				}
				
				return list;
			}
		}
	}
}
