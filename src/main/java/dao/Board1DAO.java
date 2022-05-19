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
		String sql = "insert into board1 values(?,?,?,?,default,?,?,0,0,0)";

		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1,dto.getSeq());
			pstat.setString(2, dto.getWriter());
			pstat.setString(3, dto.getTitle());
			pstat.setString(4, dto.getContents());
			pstat.setString(5, dto.getItem());
			pstat.setInt(6, dto.getItem_price());

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

	public int getBoard1SeqNextval()throws Exception {
		String sql = "select board1_seq.nextval from dual";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();
				){
			rs.next();
			return rs.getInt(1);
		}
	}

	public List<Board1DTO> selectByPage(int cpage)throws Exception {// cpage에 따른 리스트 목록 출력
		String sql = "select * from (select row_number() over(order by seq desc) line, board1.* from board1) where line between ? and ?";

		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			int startNum = cpage*10-9;
			int endNum = cpage*10;
			pstat.setInt(1, startNum);
			pstat.setInt(2, endNum);

			List<Board1DTO> list = new ArrayList<Board1DTO>();

			try(
					ResultSet rs = pstat.executeQuery();
					){

				while(rs.next()) {
					int seq = rs.getInt("seq");
					String writer = rs.getString("writer");
					String title = rs.getString("title");
					String contents = rs.getString("contents");
					Timestamp write_date = rs.getTimestamp("write_date");
					String item = rs.getString("item");
					int item_price = rs.getInt("item_price");
					int agree_count = rs.getInt("agree_count");
					int disagree_count = rs.getInt("disagree_count");
					int view_count =  rs.getInt("view_count");

					list.add(new Board1DTO(seq,writer,title,contents,write_date,item,item_price,agree_count,disagree_count,view_count));
				}
				return list;
			}
		}
	}

	public int getRecordTotalCount()throws Exception {
		String sql = "select count(*) from board1";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			ResultSet rs = pstat.executeQuery();
			rs.next();
			return rs.getInt(1);
		}
	}

	public String getNavi(int cpage)throws Exception {
		int recoardTotalCount = this.getRecordTotalCount(); //전체 레코드 수
		System.out.println(recoardTotalCount);
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
			sb.append("<a href='/list.brd1?cpage="+(startNavi-1)+"\'> < </a>");
		}

		for(int i=startNavi;i<=endNavi;i++) {
			if(cpage==i) {
				sb.append("<a href='/list.brd1?cpage="+i+"'>[" + i + "] </a>");
			}else {
				sb.append("<a href='/list.brd1?cpage="+i+"'>" + i + " </a>");
			}

			if(needNext) {
				sb.append("<a href='/list.brd1?cpage="+(endNavi+1)+"'> > </a>");
			}

		}

		return sb.toString();
	}
	
	public List<Board1DTO> searchByWriter(String target,int cpage)throws Exception{
		String sql = "select * from (select row_number() over(order by seq desc) line, board1.* from board1) where line between ? and ? and writer like ?";
		int startNum = cpage*10-9;
		int endNum = cpage*10;
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, startNum);
			pstat.setInt(2, endNum);
			pstat.setString(3, "%"+target+"%");
			List<Board1DTO> list = new ArrayList<Board1DTO>();
			try(ResultSet rs = pstat.executeQuery()){
				while(rs.next()) {
					int seq = rs.getInt("seq");
					String writer = rs.getString("writer");
					String title = rs.getString("title");
					String contents = rs.getString("contents");
					Timestamp write_date = rs.getTimestamp("write_date");
					String item = rs.getString("item");
					int item_price = rs.getInt("item_price");
					int agree_count = rs.getInt("agree_count");
					int disagree_count = rs.getInt("disagree_count");
					int view_count =  rs.getInt("view_count");

					list.add(new Board1DTO(seq,writer,title,contents,write_date,item,item_price,agree_count,disagree_count,view_count));
				}
			}
			return list;
		}
	}
}