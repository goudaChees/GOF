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
						String id = rs.getString("id");
						dto = new NoticeDTO(seq, writer, title, contents, write_date, view_count, id);
					}
					con.commit();
					return dto;
				}
		}
	}
	
	// 글쓰기
	public int insert(NoticeDTO dto) throws Exception {
		String sql = "insert into notice values(notice_seq.nextval,?,?,?,default,0,?)";
		try (Connection con = this.getConnection(); PreparedStatement stat = con.prepareStatement(sql);) {
			stat.setString(1, dto.getWriter());
			stat.setString(2, dto.getTitle());
			stat.setString(3, dto.getContents());
			stat.setString(4, dto.getId());
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
				String id = rs.getString("id");
				NoticeDTO dto = new NoticeDTO(seq, writer, title, contents, write_date, view_count, id);
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
			sb.append("<a href='csnotice.cscenter?cpage=" + (endNavi + 1) + "'>></a>");
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
		try (Connection con = this.getConnection(); 
				PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, start);
			pstat.setInt(2, end);
			try (ResultSet rs = pstat.executeQuery();) {
				while (rs.next()) {
					int seq = rs.getInt("seq");
					String writer = rs.getString("writer");
					String title = rs.getString("title");
					String contents = rs.getString("contents");
					Timestamp write_date = rs.getTimestamp("write_date");
					int view_count = rs.getInt("view_count");
					String id = rs.getString("id");
					arr.add(new NoticeDTO(seq, writer, title, contents, write_date, view_count, id));
					
				}
			}
		}
		return arr;
	}
	
	// 닉네임 구하기
	public String findNicknameById(String id) throws Exception{
		String sql = "select nickname from member where id=?";
		try (Connection con = this.getConnection(); 
				PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, id);
			try (ResultSet rs = pstat.executeQuery();) {
				String nickname = null;
				if (rs.next()) {
					nickname = rs.getString("nickname");
				}
				return nickname;
			}
		}
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

	public List<NoticeDTO> searchNotice(String target, int searchCategory, int cpage) throws Exception{
		String sql = null;
		
		if(searchCategory==1){
			sql = "select * from (select row_number() over(order by seq desc) line, notice.* from notice where title like ?) where line between ? and ?";
		}else if(searchCategory==2) {
			sql = "select * from (select row_number() over(order by seq desc) line, notice.* from notice where contents like ?) where line between ? and ?";
		}else {
			sql = "select * from (select row_number() over(order by seq desc) line, notice.* from notice) where line between ? and ?";
		}
		
		int startNum = cpage*10-9;
		int endNum = cpage*10;
		
		try(
			Connection con = this.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);
			){
			if(searchCategory>0) {
				pstat.setString(1, "%"+target+"%");
				pstat.setInt(2, startNum);
				pstat.setInt(3, endNum);				
			}else {
				pstat.setInt(1, startNum);
				pstat.setInt(2, endNum);	
			}
				
			List<NoticeDTO> list = new ArrayList<NoticeDTO>();
			try(ResultSet rs = pstat.executeQuery()){
				while(rs.next()) {
					int seq = rs.getInt("seq");
					String writer = rs.getString("writer");
					String title = rs.getString("title");
					String contents = rs.getString("contents");
					Timestamp write_date = rs.getTimestamp("write_date");
					int view_count = rs.getInt("view_count");
					String id = rs.getString("id");
					list.add(new NoticeDTO(seq, writer, title, contents, write_date, view_count, id));
				}
			}
			return list;
		}

	}
	
	
	public String getNavi(int cpage,int searchCategory,String searchTarget)throws Exception {
		int recoardTotalCount = 0;
		if(searchCategory>0) {
			recoardTotalCount = this.getRecordCountBySearch(searchCategory,searchTarget);
		}else {
			recoardTotalCount = this.getRecordTotalCount();
		}



		this.getRecordTotalCount(); //전체 레코드 수
		int racordPerPage = 10; // 페이지 당 레코드
		int naviCountPerPage = 10; //페이지 당 네비 수
		int pageTotalCount =0;// 전체 필요 네비  수

		if(recoardTotalCount%racordPerPage>0) {
			pageTotalCount = recoardTotalCount/racordPerPage+1;
		}else {
			pageTotalCount = recoardTotalCount/racordPerPage;
		}

		if(cpage<0) {
			cpage =1;
		}else if(cpage>pageTotalCount) {
			cpage=pageTotalCount;
		}

		int startNavi = ((cpage-1)/naviCountPerPage)*naviCountPerPage+1;
		int endNavi = startNavi+naviCountPerPage-1;

		if(pageTotalCount<endNavi) {
			endNavi=pageTotalCount;
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

		if(needPrev) {
			sb.append("<a href='/csnotice.cscenter?cpage="+(startNavi-1)+"\'> < </a>");
		}

		for(int i=startNavi;i<=endNavi;i++) {
			if(cpage==i) {
				sb.append("<a href='/csnotice.cscenter?cpage="+i+"'>[" + i + "] </a>");
			}else {
				sb.append("<a href='/csnotice.cscenter?cpage="+i+"'>" + i + " </a>");
			}

			if(needNext) {
				sb.append("<a href='/csnotice.cscenter?cpage="+(endNavi+1)+"'> > </a>");
			}

		}

		return sb.toString();
	}
	
	
	public int getRecordCountBySearch(int searchCategory, String searchTarget)throws Exception {

		String sql = null;

		if(searchCategory==1) {
			sql = "select count(*) from notice where title like ?";
		}else if(searchCategory==2) {
			sql = "select count(*) from notice where contents like ?";
		}

		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);				
				){
			pstat.setString(1, "%"+searchTarget+"%");
			try(
					ResultSet rs = pstat.executeQuery();
					){
				rs.next();
				return rs.getInt(1);
			}
		}
	}
	
	
	// 조회수 증가
	public int addViewCount(int seq)throws Exception {
		String sql = "update notice set view_count=view_count+1 where seq=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, seq);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

}