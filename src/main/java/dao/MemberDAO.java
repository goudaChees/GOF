package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.MemberDTO;
import dto.MyReplyDTO;
import dto.MyWritingDTO;

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
	
	public int insert(MemberDTO dto, String jointype) throws Exception {
		String sql = "insert into member values(member_seq.nextval,?,?,?,?,?,?,default,?)";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, dto.getId());
			pstat.setString(2, dto.getPassword());
			pstat.setString(3, dto.getName());
			pstat.setString(4, dto.getPhone());
			pstat.setString(5, dto.getEmail());
			pstat.setString(6, dto.getNickname());
			pstat.setString(7, jointype);
			
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
	
	public int deleteById(String id) throws Exception {
		String sql = "delete member where id=?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1,id);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public int update(MemberDTO dto) throws Exception{
		String sql = "update member set phone=?, email=?, nickname=? where id=?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, dto.getPhone());
			pstat.setString(2, dto.getEmail());
			pstat.setString(3, dto.getNickname());
			pstat.setString(4, dto.getId());
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public int updatePw(String newpw, String id) throws Exception{
		String sql = "update member set password=? where id=?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, newpw);
			pstat.setString(2, id);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	


	// 내 글보기 - 페이지별 게시글 선택
	public List<MyWritingDTO> SelectPage(String nickname,int boardNum, int page) throws Exception{ 
		int startNum = page*10-9;
		int endNum = page*10;
		
		String sql="";
		if(boardNum==1) {
			sql = "select * from( select rownum as num, mywriting.* from"
				+ "(select seq, title, write_date from board1 where writer=? order by 3 desc)mywriting)"
				+ "where num between ? and ?";
		}else if(boardNum==2) {
			sql = "select * from( select rownum as num, mywriting.* from"
				+ "(select seq, title, write_date from board2 where writer=? order by 3 desc)mywriting)"
				+ "where num between ? and ?";
		}
		
		List<MyWritingDTO> list = new ArrayList<>();

		try(Connection con = this.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, nickname);
			pstat.setInt(2, startNum);
			pstat.setInt(3, endNum);
			try(ResultSet rs = pstat.executeQuery();){
				while(rs.next()) {
					int seq = rs.getInt(2);
					String title = rs.getString(3);
					Timestamp write_date = rs.getTimestamp(4);
					list.add(new MyWritingDTO(seq,title,write_date));
				}
				return list;
			}
		}
	}
	
	// 내 글보기-총 게시글 수
	private int getTotalCount(String nickname,int boardNum) throws Exception{
		
		String sql = "";
		if(boardNum==1) {
			sql="select count(*) from (select * from board1 where writer=?)";
		}else if(boardNum==2) {
			sql="select count(*) from (select * from board2 where writer=?)";
		}
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
				pstat.setString(1, nickname);
				try(ResultSet rs = pstat.executeQuery()){
				rs.next();
				return rs.getInt(1);
				}
			}
	}

	// 내 글보기 - pagination
	public String PageList(String nickname,int boardNum, int page) throws Exception{
		
		int recordTotalCount = this.getTotalCount(nickname,boardNum);
		int recordCountPerPage = 10; 
		int naviCountPerPage= 10; 
		int pageTotalCount = (int)Math.ceil(recordTotalCount/(double)recordCountPerPage);
		
		if(page<1) {
			page=1;
		}else if(page>pageTotalCount) {
			page=pageTotalCount;
		}
		
		int startNavi = (page-1)/naviCountPerPage*naviCountPerPage+1;
		int endNavi = startNavi + naviCountPerPage -1;
		if(endNavi>pageTotalCount) {
			endNavi = pageTotalCount;
		}
		
		boolean needNext = true;
		boolean needPrev = true;
		
		if(startNavi==1) {
			needPrev = false;
		}
		if(endNavi==pageTotalCount) {
			needNext = false;
		}
		
		StringBuilder sb = new StringBuilder();
		String link = "<a href='/myWriting.member?board="+boardNum+"&page=";
		
		if(needPrev) {
			sb.append(link+(startNavi-1)+"'>< </a>");
		}
		for(int i = startNavi;i<=endNavi;i++) {
			if(page==i) {
				sb.append(link+i+"'>[<b>"+i+"</b>] </a>");
			}else {
				sb.append(link+i+"'>"+i+" </a>");
			}
		}
		if(needNext) {
			sb.append(link+(endNavi+1)+"'>></a>");
		}
		return sb.toString();
	}
	
	
	// 내 댓글보기 - 페이지별 게시글 선택
		public List<MyReplyDTO> reply_SelectPage(String nickname,int boardNum, int page) throws Exception{ 
			int startNum = page*10-9;
			int endNum = page*10;
			
			String sql="";
			if(boardNum==1) {
				sql = "select * from( select rownum as num, myreply.* from"
					+ "(select seq,parent_seq,contents,write_date from board1_reply where writer=? order by 4 desc)myreply)"
					+ "where num between ? and ?";
			}else if(boardNum==2) {
				sql = "select * from( select rownum as num, myreply.* from"
					+ "(select seq,parent_seq,contents,write_date from board2_reply where writer=? order by 4 desc)myreply)"
					+ "where num between ? and ?";
			}
			
			List<MyReplyDTO> list = new ArrayList<>();

			try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
				pstat.setString(1, nickname);
				pstat.setInt(2, startNum);
				pstat.setInt(3, endNum);
				try(ResultSet rs = pstat.executeQuery();){
					while(rs.next()) {
						int seq = rs.getInt(2);
						int parent_seq = rs.getInt(3);
						String title = rs.getString(4);
						Timestamp write_dqte = rs.getTimestamp(5);	
						list.add(new MyReplyDTO(seq,parent_seq,title,write_dqte));
					}
					return list;
				}
			}
		}
		
		// 내 댓글보기-총 댓글 수
		private int reply_getTotalCount(String nickname,int boardNum) throws Exception{
			
			String sql = "";
			if(boardNum==1) {
				sql="select count(*) from (select * from board1_reply where writer=?)";
			}else if(boardNum==2) {
				sql="select count(*) from (select * from board2_reply where writer=?)";
			}
			try(Connection con = this.getConnection();
					PreparedStatement pstat = con.prepareStatement(sql);){
					pstat.setString(1, nickname);
					try(ResultSet rs = pstat.executeQuery()){
					rs.next();
					return rs.getInt(1);
					}
				}
		}

		// 내 댓글보기 - pagination
		public String reply_PageList(String nickname,int boardNum, int page) throws Exception{
			
			int recordTotalCount = this.reply_getTotalCount(nickname,boardNum);
			int recordCountPerPage = 10; 
			int naviCountPerPage= 10; 
			int pageTotalCount = (int)Math.ceil(recordTotalCount/(double)recordCountPerPage);
			
			if(page<1) {
				page=1;
			}else if(page>pageTotalCount) {
				page=pageTotalCount;
			}
			
			int startNavi = (page-1)/naviCountPerPage*naviCountPerPage+1;
			int endNavi = startNavi + naviCountPerPage -1;
			if(endNavi>pageTotalCount) {
				endNavi = pageTotalCount;
			}
			
			boolean needNext = true;
			boolean needPrev = true;
			
			if(startNavi==1) {
				needPrev = false;
			}
			if(endNavi==pageTotalCount) {
				needNext = false;
			}
			
			StringBuilder sb = new StringBuilder();
			String link = "<a href='/myReply.member?board="+boardNum+"&page=";
			
			if(needPrev) {
				sb.append(link+(startNavi-1)+"'>< </a>");
			}
			for(int i = startNavi;i<=endNavi;i++) {
				if(page==i) {
					sb.append(link+i+"'>[<b>"+i+"</b>] </a>");
				}else {
					sb.append(link+i+"'>"+i+" </a>");
				}
			}
			if(needNext) {
				sb.append(link+(endNavi+1)+"'>></a>");
			}
			return sb.toString();
		}

		public String getLink(int boardNum) {
			String link="";
			if(boardNum==1) {
				link = "/detail.brd1?seq=";
			}else if(boardNum==2) {
				link="/read.brd2?seq=";
			}
			return link;
		}
		public String getID(String name,String email) throws Exception{
			String sql = "Select * from member where name=? and email=?";
			try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
				pstat.setString(1, name);
				pstat.setString(2, email);
				try(ResultSet rs = pstat.executeQuery()){
					rs.next();
					return rs.getString("id");
				}
			}
		}
		public boolean isgetID(String name,String email) throws Exception{
			String sql = "Select * from member where name=? and email=?";
			try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
				pstat.setString(1, name);
				pstat.setString(2, email);
				try(ResultSet rs = pstat.executeQuery()){
					return rs.next();
				}
			}
		}
		
		public String howJoin(String name, String email) throws Exception{
			String sql = "Select * from member where name=? and email=?";
			try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
					pstat.setString(1, name);
					pstat.setString(2, email);
					try(ResultSet rs = pstat.executeQuery()){
						if (rs.next()) {
							return rs.getString("jointype");
						} 
						return null;	
					}
				}
		}
		
		public boolean isidok(String id) throws Exception{
			String sql = "Select * from member where id=?";
			try(Connection con = this.getConnection();
					PreparedStatement pstat = con.prepareStatement(sql);){
					pstat.setString(1, id);
					try(ResultSet rs = pstat.executeQuery()){
						return rs.next();
					}
				}
		}
		public boolean emailidok(String email) throws Exception{
			String sql = "Select * from member where email=?";
			try(Connection con = this.getConnection();
					PreparedStatement pstat = con.prepareStatement(sql);){
					pstat.setString(1, email);
					try(ResultSet rs = pstat.executeQuery()){
						return rs.next();
					}
				}
		}
		public int chpw(String pw,String id,String email) throws Exception{
			String sql = "update member set password=? where id=? and email=?";
			try(Connection con = this.getConnection();
					PreparedStatement pstat = con.prepareStatement(sql);){
				pstat.setString(1, pw);
				pstat.setString(2, id);
				pstat.setString(3, email);
				int result = pstat.executeUpdate();
				con.commit();
				return result;
			}

		}
		public boolean isallok(String id,String email)throws Exception{
			String sql = "Select * from member where id=? and email=?";
			try(Connection con = this.getConnection();
					PreparedStatement pstat = con.prepareStatement(sql);){
					pstat.setString(1, id);
					pstat.setString(2, email);
					try(ResultSet rs = pstat.executeQuery()){
						return rs.next();
					}
				}
		}
		
		// -- 회원탈퇴시 내 글 모두 삭제
		public int deleteAllContents(String id) throws Exception {
			String seq = "delete * from board1, board2 where id=?";
			try(Connection con = this.getConnection();
					PreparedStatement pstat = con.prepareStatement(seq);){
				pstat.setString(1, id);
				int result = pstat.executeUpdate();
				con.commit();
				return result;
			}
		}
		
		// -- 회원탈퇴시 내 댓글 모두 삭제
		public int deleteAllReplys(String id) throws Exception {
			String seq = "delete * from board1_reply,board2_reply board2 where id=?";
			try(Connection con = this.getConnection();
					PreparedStatement pstat = con.prepareStatement(seq);){
				pstat.setString(1, id);
				int result = pstat.executeUpdate();
				con.commit();
				return result;
			}
		}

}
