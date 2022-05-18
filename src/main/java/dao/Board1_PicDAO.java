package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.Board1_PicDTO;

public class Board1_PicDAO {
	private static Board1_PicDAO instance = null;
	
	private synchronized static Board1_PicDAO getInstance(){
		if(instance==null){
			instance = new Board1_PicDAO();
		}
		
		return instance;
	}
	
	private Connection getConnetction() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/orcl");
		return ds.getConnection();
	}
	
	public int insert(Board1_PicDTO dto)throws Exception {
		String sql = "insert into Board1_Pic values(?,?,?,?)";
		try(
			Connection con = this.getConnetction();
			PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, dto.getSeq());
			pstat.setString(2, dto.getOri_name());
			pstat.setString(3, dto.getSys_name());
			pstat.setInt(4, dto.getParent_seq());
			
			int result = pstat.executeUpdate();
			con.commit();
			
			return result;
		}
	}
	
}
