package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.DBConnPool;
import dto.Board;
import dto.Criteria;

public class BoardDao {

	public BoardDao() {
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * 게시글을 조회합니다
	 * 
	 * @param searchField : 검색 조건
	 * @param searchWord : 검색어
	 * @return List<Board> : 게시글 목록
	 */
	public List<Board> getListPage(Criteria criteria) {
		List<Board> list = new ArrayList<>();
		
		String sql = ""
					+ "select * "
					+ "from ("
					+ "select rownum rn, t.* "
					+ "from ("
					+ "select * from board ";
					
		// 검색어가 입력 되었으면 검색 조건을 추가합니다.
		if(criteria.getSearchWord() != null && !criteria.getSearchWord().equals("")) {
				sql	+= "where " + criteria.getSearchField() 
					+ " like '%" + criteria.getSearchWord() + "%'";
		}
		sql			+= "order by num desc"
					+  ") t )"
					+  "where rn between "
					+  criteria.getStartNo()
					+  " and "
					+  criteria.getEndNo();
		
		try(Connection conn = DBConnPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			ResultSet rs = psmt.executeQuery();
			// 게시글의 수만큼 반복
			while(rs.next()) {
				String num = rs.getString("num");
				String title = rs.getString("title");
				String content = rs.getString("content");
				String id = rs.getString("id");
				String postdate = rs.getString("postdate");
				String visitcount = rs.getString("visitcount");
				
				// 게시물의 한 행을 DTO에 저장
				Board board = new Board(num, title, content, id, postdate, visitcount);
				list.add(board);
			}
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
	
	
	/**
	 * 게시글을 조회합니다
	 * 
	 * @param searchField : 검색 조건
	 * @param searchWord : 검색어
	 * @return List<Board> : 게시글 목록
	 */
	public List<Board> getList(String searchField, String searchWord) {
		List<Board> list = new ArrayList<>();
		
		String sql = "select * "
					+ "from board ";
					
		// 검색어가 입력 되었으면 검색 조건을 추가합니다.
		if(searchWord != null && !searchWord.equals("")) {
				sql	+= "where " + searchField + " like '%" + searchWord + "%'";
		}
		sql			+= "order by num desc";
		
		try(Connection conn = DBConnPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			ResultSet rs = psmt.executeQuery();
			// 게시글의 수만큼 반복
			while(rs.next()) {
				String num = rs.getString("num");
				String title = rs.getString("title");
				String content = rs.getString("content");
				String id = rs.getString("id");
				String postdate = rs.getString("postdate");
				String visitcount = rs.getString("visitcount");
				
				// 게시물의 한 행을 DTO에 저장
				Board board = new Board(num, title, content, id, postdate, visitcount);
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
	
	/**
	 * 게시글을 등록 합니다.
	 * @param board
	 * @return
	 */
	public int insert(Board board) {
		int res = 0;
		
		String sql = "insert into board "
				+ "(num, title, content, id, postdate, visitcount) values "
				+ "(seq_board_num.nextval, ?, ?, ?, sysdate, 0)";
		
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
	
	/**
	 * 게시글 번호를 입력받아 게시글을 조회합니다.
	 * @param num
	 * @return
	 */
	public Board selectOne(String num) {
		Board board = null;
		
		String sql = "select * from board where num = ?";
		
		if(num == null || "".equals(num)) {
			return null;
		}
		
		try(Connection conn = DBConnPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			psmt.setString(1, num);
			
			ResultSet rs = psmt.executeQuery();
			
			// 1건의 게시글을 조회하여 board 객체를 담아준다.
			if(rs.next()) {
				board = new Board();
														// 줄바꿈 처리
				board.setContent(rs.getString("content").replace("\r\n", "<br>"));
				board.setId(rs.getString("id"));
				board.setNum(rs.getString("num"));
				board.setPostDate(rs.getString("postdate"));
				board.setTitle(rs.getString("title"));
				board.setVisitCount(rs.getString("visitcount"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return board;
		
	}
	
	/**
	 * 게시물의 조회수를 1 증가 시킵니다.
	 * @param num : 게시물 번호
	 * @return 업데이트된 건수
	 */
	public int updateVisitCount(String num) {
		int res = 0;
		
		String sql = "update board set visitcount = visitcount + 1 where num = ?";
		
		try(Connection conn = DBConnPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			psmt.setString(1, num);
			
			res = psmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return res;
	}
	
	/// 게시글 수정
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
	
	
	public int delete(String num) {
		int res = 0;
		
		String sql = "delete board where num = ?";
		
		try(Connection conn = DBConnPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			psmt.setString(1, num);
			
			res = psmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return res;
		
	}
	
	/*
	public static void main(String[] args) {
		List<Board> list = new ArrayList<>();
		list = getList();
		for(Board b : list){
			System.out.println(b.getNum() + " " + b.getId() + " " + b.getTitle());
		}
	}
	*/
	
	
}
