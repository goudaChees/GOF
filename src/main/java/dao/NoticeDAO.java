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

import dto.Board1DTO;
import dto.Board2DTO;
import dto.NoticeDTO;

public class NoticeDAO {
	private static NoticeDAO instance = null;
	
	public synchronized static NoticeDAO getInstance() {
		if(instance==null) {
			instance=new NoticeDAO();
		}
		return instance;
	}
	
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/orcl");
		return ds.getConnection();
	}
	
	// detail notice
	public NoticeDTO SelectPage(int nseq) throws Exception {
		String sql = "select * from notice where seq=?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
				pstat.setInt(1, nseq);
				try(ResultSet rs = pstat.executeQuery();){
					NoticeDTO dto = null;
					if(rs.next()) {
						int seq = rs.getInt("seq");
						String writer = rs.getString("writer");
						String title = rs.getString("title");
						String contents = rs.getString("contents");
						Timestamp write_date = rs.getTimestamp("write_date");
						int view_count = rs.getInt("view_count");
						dto = new NoticeDTO(seq, writer, title, contents, write_date, view_count);
					}
					con.commit();
					return dto;
				}
		}
	}
	
	// 글쓰기
	public int insert(NoticeDTO dto) throws Exception {
		String sql = "insert into notice values(notice_seq.nextval,?,?,?,default,0)";
		try (Connection con = this.getConnection(); PreparedStatement stat = con.prepareStatement(sql);) {
			stat.setString(1, dto.getWriter());
			stat.setString(2, dto.getTitle());
			stat.setString(3, dto.getContents());
			int result = stat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	// 목록리스트 출력
	public List<NoticeDTO> selectAll() throws Exception { 
		String sql = "select * from notice order by write_date desc";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery()
				){
			
			List<NoticeDTO> list = new ArrayList<>();
			while(rs.next()) {				
				int seq = rs.getInt("seq");
				String writer = rs.getString("writer");
				String title = rs.getString("title");
				String contents = rs.getString("contents");
				Timestamp write_date = rs.getTimestamp("write_date");
				int view_count = rs.getInt("view_count");
				NoticeDTO dto = new NoticeDTO(seq, writer, title, contents, write_date, view_count);
				list.add(dto);
			}
			con.commit();
			return list;
		}
	}

	private int getRecordTotalCount()throws Exception {
		String sql = "select count(*) from notice";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();
				){
			rs.next();
			return rs.getInt(1);
		}
	}

	public String navi(int currentPage) throws Exception {

		// 현제 페이지 = currentPage
		int recordTotalCount = this.getRecordTotalCount();
		// 총 데이터의 갯수 -> 향후 실제 데이터 베이스의 갯수를 세어 와야함
		int recordCountPerPage = 10;
		// 한 페이지에 몇개의 게시글을 보여 줄건지
		int naviCountPerPage = 10;
		// 한 페이지에 몇개의 네비를 보여줄건지

		int pageTotalCount = 0;
		// 총 몇개의 페이지가 필요한가?

		if (recordTotalCount % recordCountPerPage > 0) {
			pageTotalCount = recordTotalCount / recordCountPerPage + 1;
		} else {
			pageTotalCount = recordTotalCount / recordCountPerPage;
		}
		;

		if (currentPage < 1) {
			currentPage = 1;
		} else if (currentPage > pageTotalCount) {
			currentPage = pageTotalCount;
		}

		int startNavi = (currentPage - 1) / naviCountPerPage * naviCountPerPage + 1;
		int endNavi = startNavi + naviCountPerPage - 1;
		// 네비 시작 과 끝 의 갯수
		if (endNavi > pageTotalCount) {
			endNavi = pageTotalCount;
		}

		boolean needNext = true;
		boolean needPrev = true;

		if (startNavi == 1) {
			needPrev = false;
		}
		if (endNavi == pageTotalCount) {
			needNext = false;
		}

		StringBuilder sb = new StringBuilder();

		if (needPrev) {
			sb.append("<a href='csnotice.cscenter?cpage=" + (startNavi - 1) + "'>< </a>");
		}
		for (int i = startNavi; i <= endNavi; i++) {
			if (currentPage == i) {
				sb.append("<a href='csnotice.cscenter?cpage=" + i + "'>[" + i + "] </a>");
			} else {
				sb.append("<a href='csnotice.cscenter?cpage=" + i + "'>" + i + " </a>");
			}
		}
		if (needNext) {
			sb.append("<a href='csnotice.cscenter>cpage=" + (endNavi + 1) + "'>></a>");
		}
		return sb.toString();
	}
	
	public int getSeqNaextval() throws Exception {
		String sql = "select notice_seq.nextval from dual";
		try (Connection con = this.getConnection();
				PreparedStatement stat = con.prepareStatement(sql);
				ResultSet rs = stat.executeQuery();) {
			rs.next();
			return rs.getInt(1);
		}
	}

	public ArrayList<NoticeDTO> selectByPage(int cpage) throws Exception {

		int start = cpage * 10 - 9;
		int end = cpage * 10;

		String sql = "select * from(select row_number() over(order by seq desc) as line,Notice.*from Notice)where line between ? and ?";
		ArrayList<NoticeDTO> arr = new ArrayList<>();
		try (Connection con = this.getConnection(); PreparedStatement stat = con.prepareStatement(sql);) {
			stat.setInt(1, start);
			stat.setInt(2, end);
			try (ResultSet rs = stat.executeQuery();) {
				while (rs.next()) {
					int seq = rs.getInt("seq");
					String writer = rs.getString("writer");
					String title = rs.getString("title");
					String contents = rs.getString("contents");
					Timestamp write_date = rs.getTimestamp("write_date");
					int view_count = rs.getInt("view_count");
					arr.add(new NoticeDTO(seq, writer, title, contents, write_date, view_count));
					
				}
			}
		}
		return arr;
	}
	
	// 공지사항 글 삭제
	public int delNotice(int seq) throws Exception {
		String sql = "delete notice where seq = ?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, seq);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	// 공지사항 글 수정
	public int udtNotice(int seq, String title, String contents) throws Exception {
		String sql = "update notice set title=?, contents=? where seq=?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1,title);
			pstat.setString(2,contents);
			pstat.setInt(3, seq);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	// 공지사항 검색하기
	
}