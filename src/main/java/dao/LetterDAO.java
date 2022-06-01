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

import dto.LetterDTO;

public class LetterDAO {
	private static LetterDAO instance = null;
	
	public synchronized static LetterDAO getInstance() {
		if(instance==null) {
			instance=new LetterDAO();
		}
		return instance;
	}
	
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/orcl");
		return ds.getConnection();
	}
	
	//아이디로 닉네임 찾기
	public String getNickname(String id) throws Exception {
		String sql = "select nickname from member where id=?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, id);
			try(ResultSet rs = pstat.executeQuery();){
				rs.next();
				return rs.getString(1);
			}
		}
	}
	
	//닉네임으로 아이디 찾기
	public String getId(String nickname) throws Exception {
		String sql = "select id from member where nickname=?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, nickname);
			try(ResultSet rs = pstat.executeQuery();){
				rs.next();
				return rs.getString(1);
			}
		}
	}
	
	//쪽지 seq 가져오기
	public int getNextSeq() throws Exception{
		String sql = "select letter_seq.nextval from dual";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);
			ResultSet rs = pstat.executeQuery();){
			rs.next();
			return rs.getInt(1);
		}
	}
	
	//쪽지보내기 - 받은쪽지함 db에 저장
	public int insertRLetter(LetterDTO ldto) throws Exception{
		String sql = "insert into rletter values (?,?,?,?,?,default,default,?,?)";
		try(Connection con = this.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);){
				pstat.setInt(1, ldto.getSeq());
				pstat.setString(2, ldto.getWriter());
				pstat.setString(3, ldto.getReceiver());
				pstat.setString(4, ldto.getTitle());
				pstat.setString(5, ldto.getContents());
				pstat.setString(6, ldto.getWriterId());
				pstat.setString(7, ldto.getReceiverId());
				
				int result = pstat.executeUpdate();
				con.commit();
				return result;
			}
	}
	
	//쪽지보내기 - 보낸쪽지함 db에 저장
		public int insertSLetter(LetterDTO ldto) throws Exception{
			String sql = "insert into sletter values (?,?,?,?,?,default,default,?,?)";
			try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
					pstat.setInt(1, ldto.getSeq());
					pstat.setString(2, ldto.getWriter());
					pstat.setString(3, ldto.getReceiver());
					pstat.setString(4, ldto.getTitle());
					pstat.setString(5, ldto.getContents());
					pstat.setString(6, ldto.getWriterId());
					pstat.setString(7, ldto.getReceiverId());
					
					int result = pstat.executeUpdate();
					con.commit();
					return result;
				}
		}
	
	
	//닉네임 검색 - 본인 제외
	public List<String> searchNN(String target, String nickname) throws Exception{
		String sql = "select nickname from member where nickname like '%'||?||'%'";
		List<String> list =new ArrayList<>();
		
		try(Connection con = this.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, target);
			try(ResultSet rs = pstat.executeQuery()){
				while(rs.next()) {
					list.add(rs.getString(1));
				}
				if(list.contains(nickname)) {
					list.remove(nickname);
				}
				return list;
			}
		}
	}
	
	
	// 받은메세지함 - 페이지별로 보여줄 메세지 선택
	public List<LetterDTO> rSelectPage(String id,int page) throws Exception{
		int startNum = page*10-9;
		int endNum = page*10;

		String sql = "select * from (select rownum as num, tmp.*"
				+ "from (select * from rletter where receiverid=? order by 6 desc)tmp)"
				+ "where num between ? and ?";
		List<LetterDTO> list = new ArrayList<>();

		try(Connection con = this.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, id);
			pstat.setInt(2, startNum);
			pstat.setInt(3, endNum);
			try(ResultSet rs = pstat.executeQuery();){
				while(rs.next()) {
					int seq = rs.getInt(2);
					String writer = rs.getString(3);
					String receiver = rs.getString(4);
					String title = rs.getString(5);
					String contents = rs.getString(6);
					Timestamp write_date = rs.getTimestamp(7);
					int read = rs.getInt(8);
					String writingId = rs.getString(9);
					String receiverId = rs.getString(10);
					LetterDTO ldto = new LetterDTO(seq,writer,receiver,title,contents,write_date,read,writingId,receiverId);
					list.add(ldto);
				}			
				return list;
			}
		}
	}
	
	//받은메세지함 - 내 전체 메세지수
	private int getRTotalCount(String id) throws Exception{
		String sql = "select count(*) from rletter where receiverid=?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, id);
			try(ResultSet rs = pstat.executeQuery()){
				rs.next();
				return rs.getInt(1);
			}
		}
	}
	
	//받은메세지함 - pagination
	public String rPageList(String id,int page) throws Exception{
		
		int recordTotalCount = this.getRTotalCount(id);
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
		if(needPrev) {
			sb.append("<a href='list.letter?type=r&page="+(startNavi-1)+"'>< </a>");
		}
		for(int i = startNavi;i<=endNavi;i++) {
			if(page==i) {
				sb.append("<a href=\"list.letter?type=r&page="+i+"\">[<b>"+i+"</b>] </a>");
			}else {
				sb.append("<a href=\"list.letter?type=r&page="+i+"\">"+i+" </a>");
			}
		}
		if(needNext) {
			sb.append("<a href='list.letter?type=r&page="+(endNavi+1)+"'>></a>");
		}
		return sb.toString();
	}
	
	// 새 메세지 수
	public int newLetter(String id) throws Exception{ 
		String sql = "select count(*) from rletter where receiverid=? and read=0";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, id);
			try(ResultSet rs = pstat.executeQuery()){
				rs.next();
				return rs.getInt(1);
			}
		}
		
	}
	
	
	// 새 메세지 seq list
		public List<Integer> newLetterList(String id) throws Exception{ 
			List<Integer> list = new ArrayList<>();
			String sql = "select seq from rletter where receiverid=? and read=0";
			
			try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
				pstat.setString(1, id);
				try(ResultSet rs = pstat.executeQuery()){
					while(rs.next()) {
						list.add(rs.getInt(1));
					}
					return list;
				}
			}
			
		}
		
	
	// 보낸메세지함 - 페이지별로 보여줄 메세지 선택
	public List<LetterDTO> sSelectPage(String id,int page) throws Exception{
		int startNum = page*10-9;
		int endNum = page*10;

		String sql = "select * from (select rownum as num, tmp.*"
				+ "from (select * from sletter where writerid=? order by 6 desc)tmp)"
				+ "where num between ? and ?";
		List<LetterDTO> list = new ArrayList<>();

		try(Connection con = this.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, id);
			pstat.setInt(2, startNum);
			pstat.setInt(3, endNum);
			try(ResultSet rs = pstat.executeQuery();){
				while(rs.next()) {
					int seq = rs.getInt(2);
					String writer = rs.getString(3);
					String receiver = rs.getString(4);
					String title = rs.getString(5);
					String contents = rs.getString(6);
					Timestamp write_date = rs.getTimestamp(7);
					int read = rs.getInt(8);
					String writingId = rs.getString(9);
					String receiverId = rs.getString(10);
					LetterDTO ldto = new LetterDTO(seq,writer,receiver,title,contents,write_date,read,writingId,receiverId);
					list.add(ldto);
				}			
				return list;
			}
		}
	}
	
	//보낸메세지함 - 내 전체 메세지수
	private int getSTotalCount(String id) throws Exception{
		String sql = "select count(*) from sletter where writerid=?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, id);
			try(ResultSet rs = pstat.executeQuery()){
				rs.next();
				return rs.getInt(1);
			}
		}
	}
	
	//보낸메세지함 - pagination
	public String sPageList(String id,int page) throws Exception{
		
		int recordTotalCount = this.getSTotalCount(id);
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
		if(needPrev) {
			sb.append("<a href='list.letter?type=s&page="+(startNavi-1)+"'>< </a>");
		}
		for(int i = startNavi;i<=endNavi;i++) {
			if(page==i) {
				sb.append("<a href=\"list.letter?type=s&page="+i+"\">[<b>"+i+"</b>] </a>");
			}else {
				sb.append("<a href=\"list.letter?type=s&page="+i+"\">"+i+" </a>");
			}
		}
		if(needNext) {
			sb.append("<a href='list.letter?type=s&page="+(endNavi+1)+"'>></a>");
		}
		return sb.toString();
	}
	
	
	// 메세지 읽음 처리
	public int letterChecked(int seq) throws Exception{ 
		String sql = "update rletter set read=1 where seq=?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, seq);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	
	// 메세지 읽기 - 받은 메세지함
	public LetterDTO readRBySeq(int seq) throws Exception{ 
		String sql = "select * from rletter where seq=?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, seq);
			try(ResultSet rs = pstat.executeQuery()){
				rs.next();
				String writer = rs.getString(2);
				String receiver = rs.getString(3);
				String title = rs.getString(4);
				String contents = rs.getString(5);
				Timestamp write_date = rs.getTimestamp(6);
				int read = rs.getInt(7);
				String writingId = rs.getString(8);
				String receiverId = rs.getString(9);
				LetterDTO ldto = new LetterDTO(seq,writer,receiver,title,contents,write_date,read,writingId,receiverId);
				return ldto;
			}
		}
	}
	
	
	// 메세지 읽기 - 보낸 메세지함
		public LetterDTO readSBySeq(int seq) throws Exception{ 
			String sql = "select * from sletter where seq=?";
			
			try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
				pstat.setInt(1, seq);
				try(ResultSet rs = pstat.executeQuery()){
					rs.next();
					String writer = rs.getString(2);
					String receiver = rs.getString(3);
					String title = rs.getString(4);
					String contents = rs.getString(5);
					Timestamp write_date = rs.getTimestamp(6);
					int read = rs.getInt(7);
					String writingId = rs.getString(8);
					String receiverId = rs.getString(9);
					LetterDTO ldto = new LetterDTO(seq,writer,receiver,title,contents,write_date,read,writingId,receiverId);
					return ldto;
				}
			}
		}
	
	
	// 답장하기 - 보낼 사람의 아이디 받아오기
	public String getReceiver(int seq) throws Exception{
		String sql = "select writerid from rletter where seq=?";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, seq);
			try(ResultSet rs = pstat.executeQuery()){
				rs.next();
				return rs.getString(1);
			}
		}
	}
	
	// 메세지 삭제하기
	public int deleteLetter(String type,int seq) throws Exception{ 
		String sql ="";
		
		if(type.equals("r")) {
			sql="delete from rletter where seq=?";
		}else if(type.equals("s")) {
			sql="delete from sletter where seq=?";
		}
		
		try(Connection con = this.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, seq);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
}
