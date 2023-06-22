package model2.mvcboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.DBConnPool;
import dto.Criteria;

public class MVCBoardDao {

	public MVCBoardDao() {
		// TODO Auto-generated constructor stub
	}

	public List<MVCBoardDto> getBoardPage(Criteria criteria){
		List<MVCBoardDto> list = new ArrayList<MVCBoardDto>();
		
		String sql = "select * "
					+ "from (select rownum rw, t.* "
					+ "from (select * from mvcboard ";
		if(criteria.getSearchWord() != null && "".equals(criteria.getSearchWord())) {
			sql		+= "where " + criteria.getSearchField() + " like '%" + criteria.getSearchWord() + "%' " ;
		}
			sql		+= ""
					+ "order by idx desc) t) "
					+ "where rw between "
					+ criteria.getStartNo()
					+ " and "
					+ criteria.getEndNo();
		
		try(Connection conn = DBConnPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			ResultSet rs = psmt.executeQuery();
			
			while(rs.next()) {
				MVCBoardDto board = new MVCBoardDto();
				
				board.setContent(rs.getString("content"));
				board.setDowncount(Integer.parseInt(rs.getString("downcount")));
				board.setIdx(rs.getString("idx"));
				board.setName(rs.getString("name"));
				board.setOfile(rs.getString("ofile"));
				board.setPass(rs.getString("pass"));
				board.setPostdate(rs.getString("postdate"));
				board.setSfile(rs.getString("sfile"));
				board.setTitle(rs.getString("title"));
				board.setVisitcount(Integer.parseInt(rs.getString("visitcount")));
				
				list.add(board);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return list;
		
	}
	
	public List<MVCBoardDto> getBoardList(){
		List<MVCBoardDto> list = new ArrayList<MVCBoardDto>();
		
		String sql = "select * from mvcboard order by idx desc";
		
		try(Connection conn = DBConnPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			ResultSet rs = psmt.executeQuery();
			
			while(rs.next()) {
				MVCBoardDto board = new MVCBoardDto();
				
				board.setContent(rs.getString("content"));
				board.setDowncount(Integer.parseInt(rs.getString("downcount")));
				board.setIdx(rs.getString("idx"));
				board.setName(rs.getString("name"));
				board.setOfile(rs.getString("ofile"));
				board.setPass(rs.getString("pass"));
				board.setPostdate(rs.getString("postdate"));
				board.setSfile(rs.getString("sfile"));
				board.setTitle(rs.getString("title"));
				board.setVisitcount(Integer.parseInt(rs.getString("visitcount")));
				
				list.add(board);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return list;
		
	}
	
}
