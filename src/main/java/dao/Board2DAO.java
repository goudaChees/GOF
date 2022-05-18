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
		String sql = "insert into board2 values(Board2_seq.nextval,?,?,?,default,?,default)";
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
			String sql= "update board2 set title=?,contents=?,item=? where seq=?";
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
		private int getRecordTotalCount() throws Exception{
			String sql="select count(*) from board2";
			try(Connection con = this.getConnection();
					PreparedStatement stat = con.prepareStatement(sql);
					ResultSet rs = stat.executeQuery();){
				rs.next();
				return rs.getInt(1);
			}
		}
		public String navi(int currentPage) throws Exception{
			
			//현제 페이지 = currentPage
			int recordTotalCount = this.getRecordTotalCount();
			// 총 데이터의 갯수 -> 향후 실제 데이터 베이스의 갯수를 세어 와야함
			int recordCountPerPage = 10;
			// 한 페이지에 몇개의 게시글을 보여 줄건지
			int naviCountPerPage = 10; 
			// 한 페이지에 몇개의 네비를 보여줄건지
			
			int pageTotalCount = 0; 
			// 총 몇개의 페이지가 필요한가?
			
			if(recordTotalCount %recordCountPerPage>0) {
				pageTotalCount = recordTotalCount /recordCountPerPage+1;
			}else {
				pageTotalCount = recordTotalCount /recordCountPerPage;
			};

			if(currentPage < 1) {
				currentPage=1;
			}else if (currentPage>pageTotalCount) {
				currentPage = pageTotalCount;
			}
			
			int startNavi = (currentPage-1)/naviCountPerPage*naviCountPerPage+1;
			int endNavi = startNavi + naviCountPerPage-1;
			//네비 시작 과 끝 의 갯수
			if(endNavi > pageTotalCount) {
				endNavi = pageTotalCount;
			}
			
			boolean needNext = true;
			boolean needPrev = true;
			
			if(startNavi == 1) {
				needPrev = false;
			}
			if(endNavi == pageTotalCount) {
				needNext = false;
			}
			
			StringBuilder sb = new StringBuilder();
			
			
			if(needPrev) {
				sb.append("<a href='list.brd2?cpage="+(startNavi-1)+"'>< </a>");
			}
			for(int i = startNavi;i <=endNavi;i++) {
				if(currentPage == i) {
					sb.append("<a href='list.brd2?cpage="+i+"'>["+i+"] </a>");
				}else {
				sb.append("<a href='list.brd2?cpage="+i+"'>"+i+" </a>");
				}
			}
			if(needNext) {
				sb.append("<a href='list.brd2>cpage="+(endNavi+1)+"'>></a>");
			}	
			return sb.toString();
		}
		public int getSeqNaextval() throws Exception{
			String sql ="select board2_seq.nextval from dual";
			try(Connection con = this.getConnection();
					PreparedStatement stat = con.prepareStatement(sql);
					ResultSet rs = stat.executeQuery();){
				rs.next();
				return rs.getInt(1);
			}
		}
		public ArrayList<Board2DTO> selectByPage(int cpage) throws Exception{
			
			int start = cpage * 10 - 9;
			int end = cpage * 10;
			
			String sql ="select * from(select row_number() over(order by seq desc) as line,board2.*from board2)where line between ? and ?";
			ArrayList<Board2DTO> arr = new ArrayList<>();
			try(Connection con = this.getConnection();
				PreparedStatement stat = con.prepareStatement(sql);){
				stat.setInt(1, start);
				stat.setInt(2, end);
				try(ResultSet rs = stat.executeQuery();){
					while(rs.next()) {
						int seq =rs.getInt("seq");
						String writer = rs.getString("writer");
						String title = rs.getString("title");
						String contents = rs.getString("contents");
						String date= rs.getString("write_date");
						String item = rs.getString("item");
						int count = rs.getInt("view_count");
						arr.add(new Board2DTO(seq,writer,title,contents,date,item,count));
					}
				}
			}
			return arr;
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
		public Board2DTO contents(int seq) throws Exception{
			String sql="select * from board2 where seq=?";
			Board2DTO dto = new Board2DTO();
			try(Connection con = this.getConnection();
				PreparedStatement stat = con.prepareStatement(sql);){
				stat.setInt(1, seq);
				try(ResultSet rs = stat.executeQuery();){
					rs.next();
					dto.setSeq(rs.getInt("seq"));
					dto.setNickname(rs.getString("writer"));
					dto.setTitle(rs.getString("title"));
					dto.setContents(rs.getString("contents"));
					dto.setWrite_date(rs.getString("write_date"));
					dto.setItem(rs.getString("item"));
					dto.setView_count(rs.getInt("view_count"));
					return dto;
				}
			}
		}
}
