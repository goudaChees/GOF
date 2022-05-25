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

	public int insert(Board1DTO dto)throws Exception {//게시판에 넣기
		String sql = "insert into board1 values(?,?,?,?,default,?,?,0,0,0,?,0)";

		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1,dto.getSeq());
			pstat.setString(2, dto.getWriter());
			pstat.setString(3, dto.getTitle());
			pstat.setString(4, dto.getContents());
			pstat.setString(5, dto.getItem());
			pstat.setLong(6, dto.getItem_price());
			pstat.setString(7,dto.getFileName());

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
					Long item_price = rs.getLong("item_price");
					int agree_count = rs.getInt("agree_count");
					int disagree_count = rs.getInt("disagree_count");
					int view_count =  rs.getInt("view_count");
					String fileName = rs.getString("filename");
					int reply_Count = rs.getInt("reply_count");
					
					list.add(new Board1DTO(seq,writer,title,contents,write_date,item,item_price,agree_count,disagree_count,view_count,fileName,reply_Count));
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
				ResultSet rs = pstat.executeQuery();
				){
			rs.next();
			return rs.getInt(1);
		}
	}

	public int getRecordCountBySearch(int searchCategory, String searchTarget)throws Exception {

		String sql = null;

		if(searchCategory==1) {
			sql = "select count(*) from board1 where writer like ?";
		}else if(searchCategory==2) {
			sql = "select count(*) from board1 where title like ?";
		}else if(searchCategory==3) {
			sql = "select count(*) from board1 where item like ?";
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

	public List<Board1DTO> search(String target,int searchCategory,int cpage)throws Exception{

		String sql = null;

		if(searchCategory==1){
			sql = "select * from (select row_number() over(order by seq desc) line, board1.* from board1 where writer like ?) where line between ? and ?";
		}else if(searchCategory==2) {
			sql = "select * from (select row_number() over(order by seq desc) line, board1.* from board1 where title like ?) where line between ? and ?";
		}else if(searchCategory==3) {
			sql = "select * from (select row_number() over(order by seq desc) line, board1.* from board1 where item like ?) where line between ? and ?";
		}else {
			sql = "select * from (select row_number() over(order by seq desc) line, board1.* from board1) where line between ? and ?";
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

			List<Board1DTO> list = new ArrayList<Board1DTO>();
			try(ResultSet rs = pstat.executeQuery()){
				while(rs.next()) {
					int seq = rs.getInt("seq");
					String writer = rs.getString("writer");
					String title = rs.getString("title");
					String contents = rs.getString("contents");
					Timestamp write_date = rs.getTimestamp("write_date");
					String item = rs.getString("item");
					Long item_price = rs.getLong("item_price");
					int agree_count = rs.getInt("agree_count");
					int disagree_count = rs.getInt("disagree_count");
					int view_count =  rs.getInt("view_count");
					String fileName = rs.getString("filename");
					int reply_Count = rs.getInt("reply_count");
					
					list.add(new Board1DTO(seq,writer,title,contents,write_date,item,item_price,agree_count,disagree_count,view_count,fileName,reply_Count));
				}
			}
			return list;
		}
	}

	public Board1DTO selectBySeq(int seq)throws Exception {
		String sql = "select * from board1 where seq =?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, seq);
			try(ResultSet rs = pstat.executeQuery()){

				rs.next();
				String writer = rs.getString("writer");
				String title = rs.getString("title");
				String contents = rs.getString("contents");
				Timestamp write_date = rs.getTimestamp("write_date");
				String item = rs.getString("item");
				Long item_price = rs.getLong("item_price");
				int agree_count= rs.getInt("agree_count");
				int disagree_count = rs.getInt("disagree_count");
				int view_count = rs.getInt("view_count");
				String fileName = rs.getString("filename");
				int reply_Count = rs.getInt("reply_count");
				
				return new Board1DTO(seq,writer,title,contents,write_date,item,item_price,agree_count,disagree_count,view_count,fileName,reply_Count);
			}
		}
	}

	public int modify(Board1DTO dto)throws Exception {
		String sql = "update board1 set title=?,contents=?,item=?,item_price=? where seq=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, dto.getTitle());
			pstat.setString(2, dto.getContents());
			pstat.setString(3, dto.getItem());
			pstat.setLong(4, dto.getItem_price());
			pstat.setInt(5,dto.getSeq());

			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

	public int deleteBySeq(int seq)throws Exception {
		String sql = "delete from board1 where seq=?";
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

	public int addAgree(String agree,int seq)throws Exception {

		String sql = null;
		if(agree.equals("승인")) {//찬성하는 경우
			sql = "update board1 set agree_count = agree_count+1 where seq=?";
		}else {//반대하는 경우
			sql = "update board1 set disagree_count = disagree_count+1 where seq=?";
		}
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

	public int addViewCount(int seq)throws Exception {
		String sql = "update board1 set view_count=view_count+1 where seq=?";
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

	public int updateFileNameBySeq(int seq,String sys_Name)throws Exception {
		String sql = "update board1 set filename = ? where seq =?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, sys_Name);
			pstat.setInt(2,seq);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

	public int modifyAgree(String agree,int seq)throws Exception {
		String sql = null;
		if(agree.equals("승인")) {//승인으로 바꾼 경우 disagree는 -1, agree는 +1을 해준다.
			sql = "update board1 set agree_count=agree_count+1,disagree_count=disagree_count-1 where seq=?";
		}else {//불가로 바꾼 경우 agree는 -1, disagree는 +1을 해준다.
			sql = "update board1 set agree_count=agree_count-1,disagree_count=disagree_count+1 where seq=?";
		}
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
	
	public int subtractAgreeCount(int board_Seq,String agree)throws Exception {
		String sql = null;
		if(agree.equals("승인")) {//승인인 경우
			sql = "update board1 set agree_count=agree_count-1 where seq=?";
		}else {//불가인 경우
			sql = "update board1 set disagree_count=disagree_count-1 where seq=?";
		}
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, board_Seq);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public int addReplyCount(int seq)throws Exception {
		String sql = "update board1 set reply_count=reply_count+1 where seq=?";
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
	public int subtractReplyCount(int seq)throws Exception {
		String sql = "update board1 set reply_count=reply_count-1 where seq=?";
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
