package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import common.DBConnPool;
import dto.Board;
import dto.Criteria;

public class NewBoardDao {

	public NewBoardDao() {
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * 게시물 리스트 반환
	 * @param searchField
	 * @param searchWord
	 * @return
	 */
	public List<Board> getList(Criteria criteria){
		List<Board> list = new ArrayList<>();
		
		String sql = "select num, title, content, visitcount, id"
					+ ", decode(trunc(sysdate), trunc(postdate)"
					+ ", to_char(postdate, 'hh24:mm:ss')"
					+ ", to_char(postdate, 'yyyy-mm-dd')) postdate "
					+ "from board ";
		if(criteria.getSearchWord() != null && !"".equals(criteria.getSearchWord())) {
			sql 	+= "where " + criteria.getSearchField() 
						+ " like '%" + criteria.getSearchWord() + "%' ";
		}
			sql		+= "order by num desc";
		
		try(Connection conn = DBConnPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			ResultSet rs = psmt.executeQuery();
			
			while(rs.next()) {
				Board board = new Board();
				
				board.setNum(rs.getString("num"));
				board.setTitle(rs.getString("title"));
				board.setContent(rs.getString("content"));
				board.setPostDate(rs.getString("postdate"));
				board.setVisitCount(rs.getString("visitcount"));
				board.setId(rs.getString("id"));
				
				list.add(board);
			}
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
	
	public List<Board> getListPage(Criteria criteria){
		List<Board> list = new ArrayList<>();
		
		String sql = "select * from (select rownum rn, t.* from ("
					+ "select num, title, content, visitcount, id"
					+ ", decode(trunc(sysdate), trunc(postdate)"
					+ ", to_char(postdate, 'hh24:mm:ss')"
					+ ", to_char(postdate, 'yyyy-mm-dd')) postdate "
					+ "from board ";
		if(criteria.getSearchWord() != null && !"".equals(criteria.getSearchWord())) {
			sql 	+= "where " + criteria.getSearchField() 
						+ " like '%" + criteria.getSearchWord() + "%' ";
		}
			sql		+= "order by num desc"
					+ ") t) where rn between " 
					+ criteria.getStartNo() 
					+ " and " 
					+ criteria.getEndNo();
		
		try(Connection conn = DBConnPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			ResultSet rs = psmt.executeQuery();
			
			while(rs.next()) {
				Board board = new Board();
				
				board.setNum(rs.getString("num"));
				board.setTitle(rs.getString("title"));
				board.setContent(rs.getString("content"));
				board.setPostDate(rs.getString("postdate"));
				board.setVisitCount(rs.getString("visitcount"));
				board.setId(rs.getString("id"));
				
				list.add(board);
			}
			rs.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
	
	public int insert(Board board) {
		int res = 0;
		
		String sql = "insert into board (num, title, content, id, postdate, visitcount) "
					+ "values (seq_board_num.nextval, ?, ?, ?, sysdate, 0)";
		
		try(Connection conn = DBConnPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			psmt.setString(1, board.getTitle());
			psmt.setString(2, board.getContent());
			psmt.setString(3, board.getId());
			
			res = psmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return res;
	}
	
	public Board seletOne(String num) {
		Board board = null;
				
		String sql = "select * from board where num = " + num;
		
		try(Connection conn = DBConnPool.getConnection();
				Statement stmt = conn.createStatement();) {
			
			ResultSet rs = stmt.executeQuery(sql);
			if(rs.next()) {
				board = new Board();
				
				board.setContent(rs.getString("content"));
				board.setId(rs.getString("id"));
				board.setNum(rs.getString("num"));
				board.setPostDate(rs.getString("postdate"));
				board.setTitle(rs.getString("title"));
				board.setVisitCount(rs.getString("visitcount"));
			}
			rs.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return board;
	}
	
	public int updateVisitCount(String num) {
		int res = 0;
		
		String sql = "update board set visitcount "
				+ "= visitcount+1 where num = " + num;
		
		try(Connection conn = DBConnPool.getConnection();
				Statement stmt = conn.createStatement();) {
			
			res = stmt.executeUpdate(sql);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return res;
	}
	
	public int updateBoard(Board board) {
		int res = 0;
		
		String sql = "update board set title = ?, content = ? where num = ?";
		
		try(Connection conn = DBConnPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			psmt.setString(1, board.getTitle());
			psmt.setString(2, board.getContent());
			psmt.setString(3, board.getNum());
			
			res = psmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return res;
	}
	
	/**
	 * 게시물의 갯수를 반환
	 * @return 게시물의 총 갯수
	 */
	public int getTotalCnt(Criteria criteria) {
		int totalCnt = 0;
		
		String sql = "select count(*) from board ";
					
		if(criteria.getSearchWord() != null && !criteria.getSearchWord().equals("")) {
			sql	 	+= "where " + criteria.getSearchField() + " like '%" + criteria.getSearchWord() + "%' ";
		}
			sql		+= "order by num desc";
		
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
}
