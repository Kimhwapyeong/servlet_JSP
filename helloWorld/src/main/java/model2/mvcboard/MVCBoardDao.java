package model2.mvcboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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
		if(criteria.getSearchWord() != null && !"".equals(criteria.getSearchWord())) {
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
	
	/**
	 * 게시물의 갯수를 반환
	 * @return 게시물의 총 갯수
	 */
	public int getTotalCnt(Criteria criteria) {
		int totalCnt = 0;
		String sql = "select count(*) from mvcboard ";
					
		if(criteria.getSearchWord() != null && !criteria.getSearchWord().equals("")) {
			sql	 	+= "where " + criteria.getSearchField() + " like '%" + criteria.getSearchWord() + "%' ";
		}
			sql		+= "order by idx desc";
		
		try(Connection conn = DBConnPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			ResultSet rs = psmt.executeQuery();
			if(rs.next()) {
				// 첫 번째 컬럼의 값을 반환
				totalCnt = rs.getInt(1);
			}
			rs.close();
		} catch (SQLException e) {
			System.err.println("총 게시물의 수를 조회하던 중 예외가 발생하였습니다.");
			e.printStackTrace();
		}
		
		return totalCnt;
	}
	
	public int insert(MVCBoardDto board) {
		int res = 0;
		String sql = "insert into mvcboard "
					+ "(idx, name, title, content, ofile, pass) "
					+ "values (seq_mvcboard_idx.nextval, "
					+ "?, ?, ?, ?, ?)";
		
		// TODO
		
		
		return res;
	}

	public MVCBoardDto selectOne(String idx) {
		MVCBoardDto dto = new MVCBoardDto();
		String sql = "select * from mvcboard where idx = " + idx;
		
		try(Connection conn = DBConnPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			ResultSet rs = psmt.executeQuery();
			if(rs.next()) {
				dto.setContent(rs.getString("content"));
				dto.setDowncount(rs.getInt("downcount"));
				dto.setIdx(rs.getString("idx"));
				dto.setName(rs.getString("name"));
				dto.setOfile(rs.getString("ofile"));
				dto.setPass(rs.getString("pass"));
				dto.setPostdate(rs.getString("postdate"));
				dto.setSfile(rs.getString("sfile"));
				dto.setTitle(rs.getString("title"));
				dto.setVisitcount(rs.getInt("visitcount"));
			}
			
		} catch (SQLException e) {
			System.err.println("게시물 상세보기 조회중 오류 발생");
			e.printStackTrace();
		}
		
		return dto;
	}

	public boolean comfirmPassword(String idx, String pass) {
		boolean res = false;
		String sql = "select * from mvcboard where idx = ? and pass = ?";
		
		try(Connection conn = DBConnPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			psmt.setString(1, idx);
			psmt.setString(2, pass);
			
			ResultSet rs = psmt.executeQuery();
			
			res = rs.next();
			
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return res;
	}

	public int delete(String idx) {
		int res = 0;
		String sql = "delete from mvcboard where idx = " + idx;
		
		try(Connection conn = DBConnPool.getConnection();
				 PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			res = psmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return res;
	}
	
}
