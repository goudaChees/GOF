package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.Board1DTO;
import dto.Board2DTO;
import dto.MemberDTO;

public class AdminDAO {
private static AdminDAO instance = null;

	public synchronized static AdminDAO getInstance() {
		if(instance == null) {
			instance = new AdminDAO();
		}
		return instance;
	}
	
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/orcl");
		return ds.getConnection();
	}
	
	// 관리자 권한으로 멤버 아이디 넣어 추방 
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
	
	// 관리자 권한으로 멤버 아이디 넣어 수정 
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
	
	// 관리자 확인
	public boolean isAdminOk (String pw) throws Exception {
		String sql = "select * from member where id = 'admin' and password = ?";

		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, pw);
		
			try(
					ResultSet rs = pstat.executeQuery();
					){
				return rs.next();
			}
		}
	}
	
	// 관리자 권한으로 멤버 정보(+이름) 수정 
	public int adminUpdate(MemberDTO dto) throws Exception{
		String sql = "update member set name=?,phone=?, email=?, nickname=? where id=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, dto.getName());
			pstat.setString(2, dto.getPhone());
			pstat.setString(3, dto.getEmail());
			pstat.setString(4, dto.getNickname());
			pstat.setString(5, dto.getId());
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
//	관리자 멤버 페이지 출력 메서드
	
	//멤버 총 숫자
	private int getRecordTotalCount() throws Exception {
		String sql = "select count(*) from member";
		
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();
				){
			rs.next();
			return rs.getInt(1);
		}
		
	}
	
	//멤버 네비
	public String getPageNavi(int currentPage) throws Exception {
		int recordTotalCount = this.getRecordTotalCount(); 
		
		int recordCountPerPage = 10; // 한 페이지에 몇명의 회원
		
		int naviCountPerPage = 10; // 한 페이지에 몇개의 네비를 보여줄 것인지
		
		int pageTotalCount = 0; // 총 몇개의 페이지가 필요한가?
		
		if(recordTotalCount % recordCountPerPage > 0) {
			pageTotalCount = recordTotalCount / recordCountPerPage +1;
		}else {
			pageTotalCount = recordTotalCount / recordCountPerPage;
		}

		if(currentPage < 1) {
			currentPage= 1;
		}else if(currentPage > pageTotalCount) {
			currentPage = pageTotalCount;
		}
		
		int startNavi = (currentPage-1) / naviCountPerPage * naviCountPerPage + 1;
		// startNavi의 공식 
		// (currentPage-1) / naviCountPerPage * naviCountPerPage + 1;
		int endNavi = startNavi + naviCountPerPage - 1;
		// endNavi의 공식
		// startNavi + naviCountPerPage - 1;
		
		if (endNavi > pageTotalCount) {
			endNavi = pageTotalCount;
			// currentPage = pageTotalcount;
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

			sb.append("<a href='adminmain.admin?cpage="+(startNavi-1)+"'>< </a>");
		}
		
		for (int i = startNavi ; i <= endNavi; i++) {
			if (currentPage == i) {

				sb.append("<a href=\'adminmain.admin?cpage="+i+"\'>[" + i + "] </a>");
			}else {

				sb.append("<a href=\'adminmain.admin?cpage="+i+"\'>"+ i +" </a>");
			}
		}
		if (needNext) {

			sb.append("<a href='adminmain.admin?cpage="+(endNavi+1)+"'>> </a>");
		}
		
		return sb.toString();
		
	}
	
	// 멤버 페이지로 출력 구분
	
	public List<MemberDTO> selectByPage(int cpage) throws Exception {
		
		int startPage = cpage * 10 - 9;
		int endPage = cpage * 10;
		
		String sql = "select * from (select row_number() over(order by seq ) line, member.* from member) where line between ? and ?";
		
		try (
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, startPage);
			pstat.setInt(2, endPage);
			
			try (
					ResultSet rs = pstat.executeQuery();
					){
				List<MemberDTO> list = new ArrayList<>();
				while(rs.next()) {
					MemberDTO mdto = new MemberDTO();
					mdto.setId(rs.getString("id"));
					mdto.setSeq(rs.getInt("seq"));
					mdto.setPassword(rs.getString("password"));
					mdto.setName(rs.getString("name"));
					mdto.setPhone(rs.getString("phone"));
					mdto.setEmail(rs.getString("email"));
					mdto.setNickname(rs.getString("nickname"));
					mdto.setJoindate(rs.getDate("joindate"));
					list.add(mdto);
				}
				return list;
			}
		}
	}
	
	// 보드 2 리스트
	public List<Board2DTO> selectBoard2Page (int cpage) throws Exception{
		
		int startPage = cpage * 10 - 9;
		int endPage = cpage * 10; 
		
		String sql = "select * from (select row_number() over(order by seq) line, board2.* from board2) where line between ? and ?";

		List<Board2DTO> list = new ArrayList<>();
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, startPage);
			pstat.setInt(2, endPage);
			
			try (
					ResultSet rs = pstat.executeQuery();
					){
				while (rs.next()) {
					Board2DTO b2dto = new Board2DTO();
					b2dto.setSeq(rs.getInt("seq"));
					b2dto.setNickname(rs.getString("writer"));
					b2dto.setTitle(rs.getString("title"));
					b2dto.setContents(rs.getString("contents"));
					b2dto.setWrite_date(rs.getString("write_date"));
					b2dto.setItem(rs.getString("item"));
					b2dto.setView_count(rs.getInt("view_count"));
					b2dto.setReply(rs.getInt("reply"));
					list.add(b2dto);
										
				}
				return list;
			}
		}
		
	}
	
	public List<Board1DTO> selectBoard1Page (int cpage) throws Exception{
		
		int startPage = cpage * 10 - 9;
		int endPage = cpage * 10; 
		
		String sql = "select * from (select row_number() over(order by seq) line, board1.* from board1) where line between ? and ?";

		List<Board1DTO> list = new ArrayList<>();
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, startPage);
			pstat.setInt(2, endPage);
			
			try (
					ResultSet rs = pstat.executeQuery();
					){
				while (rs.next()) {					
					Board1DTO b1dto = new Board1DTO();
					b1dto.setSeq(rs.getInt("seq"));
					b1dto.setWriter(rs.getString("writer"));
					b1dto.setTitle(rs.getString("title"));
					b1dto.setContents(rs.getString("contents"));
					b1dto.setWrite_date(rs.getTimestamp("write_date"));
					b1dto.setItem(rs.getString("item"));
					b1dto.setItem_price(rs.getInt("item_price"));
					b1dto.setAgree_count(rs.getInt("agree_count"));
					b1dto.setDisagree_count(rs.getInt("disagree_count"));
					b1dto.setView_count(rs.getInt("view_count"));
					b1dto.setFileName(rs.getString("filename"));
					list.add(b1dto);
										
				}
				return list;
			}
		}
		
	}
	
	// 보드 별 총 게시글 수 
	private int getBrdTotalCount(int boardNum) throws Exception{
		
		String sql = "";
		if(boardNum == 1) {
			sql="select count(*) from board1";
		}else if(boardNum == 2) {
			sql="select count(*) from board2";
		}
		
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();
				){
			rs.next();
			return rs.getInt(1);
		}
	}
	
	
	// 보드 별 페이지네이션
	public String getBrdPageNavi(int boardNum, int currentPage) throws Exception {
		int recordTotalCount = this.getBrdTotalCount(boardNum); 
		
		int recordCountPerPage = 10; // 한 페이지에 몇명의 회원
		
		int naviCountPerPage = 10; // 한 페이지에 몇개의 네비를 보여줄 것인지
		int pageTotalCount = 0; // 총 몇개의 페이지가 필요한가?
		
		if(recordTotalCount % recordCountPerPage > 0) {
			pageTotalCount = recordTotalCount / recordCountPerPage +1;
		}else {
			pageTotalCount = recordTotalCount / recordCountPerPage;
		}

		if(currentPage < 1) {
			currentPage= 1;
		}else if(currentPage > pageTotalCount) {
			currentPage = pageTotalCount;
		}
		
		int startNavi = (currentPage-1) / naviCountPerPage * naviCountPerPage + 1;
		int endNavi = startNavi + naviCountPerPage - 1;
		
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
			sb.append("<a href='adminBoardsList.admin?board="+boardNum+"&page="+(startNavi-1)+"'>< </a>");
		}
		
		for (int i = startNavi ; i <= endNavi; i++) {
			if (currentPage == i) {

				sb.append("<a href=\'adminBoardsList.admin?board="+boardNum+"&page="+i+"\'>[" + i + "] </a>");
			}else {

				sb.append("<a href=\'adminBoardsList.admin?board="+boardNum+"&page="+i+"\'>"+ i +" </a>");
			}
		}
		if (needNext) {

			sb.append("<a href='adminBoardsList.admin?board="+boardNum+"&page="+(endNavi+1)+"'>> </a>");
		}
		
		return sb.toString();
		
	}
	
	// 보드 별 서치 기능 
	
	public List<Board1DTO> brd1search(String toSearch, int searchCategory, int page) throws Exception {
		
		String sql ="";
		
		if(searchCategory == 1) {
			sql = "select * from (select row_number() over(order by seq desc) line,"
					+ " board1.* from board1 where writer like ?) where line between ? and ?";
		}else if (searchCategory == 2) {
			sql = "select * from (select row_number() over(order by seq desc) line, "
					+ "board1.* from board1 where title like ?) where line between ? and ?";
		}else if (searchCategory == 3) {
			sql = "select * from (select row_number() over(order by seq desc) line, "
					+ "board1.* from board1 where item like ?) where line between ? and ?";
		}else {
			sql = "select * from (select row_number() over(order by seq desc) line, "
					+ "board1.* from board1) where line between ? and ?";
		}
		
		int startPage = page * 10 - 9;
		int endPage = page * 10; 
		
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			if(searchCategory > 0) {
				pstat.setString(1, "%"+toSearch+"%");
				pstat.setInt(2, startPage);
				pstat.setInt(3, endPage);
			}else {
				pstat.setInt(1, startPage);
				pstat.setInt(2, endPage);
			}
			
			List<Board1DTO> list = new ArrayList<Board1DTO>();
			try(
					ResultSet rs = pstat.executeQuery();
					){
				while(rs.next()) {
					Board1DTO b1dto = new Board1DTO();
					b1dto.setSeq(rs.getInt("seq"));
					b1dto.setWriter(rs.getString("writer"));
					b1dto.setTitle(rs.getString("title"));
					b1dto.setContents(rs.getString("contents"));
					b1dto.setWrite_date(rs.getTimestamp("write_date"));
					b1dto.setItem(rs.getString("item"));
					b1dto.setItem_price(rs.getInt("item_price"));
					b1dto.setAgree_count(rs.getInt("agree_count"));
					b1dto.setDisagree_count(rs.getInt("disagree_count"));
					b1dto.setView_count(rs.getInt("view_count"));
					b1dto.setFileName(rs.getString("filename"));
					list.add(b1dto);
				}
				return list;
				
			}
		}
	}
	
	public List<Board2DTO> brd2search (String toSearch, int searchCategory, int page) throws Exception {
		
		String sql ="";
		
		if(searchCategory == 1) {
			sql = "select * from (select row_number() over(order by seq desc) line,"
					+ " board2.* from board2 where writer like ?) where line between ? and ?";
		}else if (searchCategory == 2) {
			sql = "select * from (select row_number() over(order by seq desc) line, "
					+ "board2.* from board2 where title like ?) where line between ? and ?";
		}else if (searchCategory == 3) {
			sql = "select * from (select row_number() over(order by seq desc) line, "
					+ "board2.* from board2 where contents like ?) where line between ? and ?";
		}else {
			sql = "select * from (select row_number() over(order by seq desc) line, "
					+ "board2.* from board2) where line between ? and ?";
		}
		
		int startPage = page * 10 - 9;
		int endPage = page * 10; 
		
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			if(searchCategory > 0) {
				pstat.setString(1, "%"+toSearch+"%");
				pstat.setInt(2, startPage);
				pstat.setInt(3, endPage);
			}else {
				pstat.setInt(1, startPage);
				pstat.setInt(2, endPage);
			}
			
			List<Board2DTO> list = new ArrayList<Board2DTO>();
			try(
					ResultSet rs = pstat.executeQuery();
					){
				while(rs.next()) {
					Board2DTO b2dto = new Board2DTO();
					b2dto.setSeq(rs.getInt("seq"));
					b2dto.setNickname(rs.getString("writer"));
					b2dto.setTitle(rs.getString("title"));
					b2dto.setContents(rs.getString("contents"));
					b2dto.setWrite_date(rs.getString("write_date"));
					b2dto.setItem(rs.getString("item"));
					b2dto.setView_count(rs.getInt("view_count"));
					b2dto.setReply(rs.getInt("reply"));
					list.add(b2dto);
				}
				
				return list;
			}
		}
	}
	
	// 보드별 서치 카운트
	
	public int getBrdSearchTotalCount(int searchCategory, int boardNum, String toSearch) throws Exception {
		String sql = "";
		int result = 0;
		if (boardNum == 1) {
			if (searchCategory == 1) {
				sql = "select count(*) from board1 where writer like ?";
			}else if (searchCategory == 2) {
				sql = "select count(*) from board1 where title like ?";
			}else if (searchCategory == 3) {
				sql = "select count(*) from board1 where item like ?";
			}
			
			try (
					Connection con = this.getConnection();
					PreparedStatement pstat = con.prepareStatement(sql);
					){
				pstat.setString(1, "%"+toSearch+"%");
				try (
						ResultSet rs = pstat.executeQuery();
						){
					rs.next();
					result = rs.getInt(1);
				}
				
			}
			
		}else if (boardNum == 2) {
			if(searchCategory == 1) {
				sql = "select count(*) from board2 where writer like ?";
			}else if (searchCategory == 2) {
				sql = "select count(*) from board2 where title like ?";
			}else if (searchCategory == 3) {
				sql = "select count(*) from board2 where contents like ?";
			}
			
			try (
					Connection con = this.getConnection();
					PreparedStatement pstat = con.prepareStatement(sql);
					){
				pstat.setString(1, "%"+toSearch+"%");
				try (
						ResultSet rs = pstat.executeQuery();
						){
					rs.next();
					result = rs.getInt(1);
				}
			}
			
			
		}
		return result;
	}
	
	// 보드 서치 네비
	
	
	
}
		
