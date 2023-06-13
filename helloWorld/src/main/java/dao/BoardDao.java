package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.DBConnPool;
import dto.Board;

public class BoardDao {

	public BoardDao() {
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * 게시글을 조회합니다.
	 * @return List<Board>
	 */
	public List<Board> getList() {
		List<Board> list = new ArrayList<>();
		
		String sql = "select * from board order by num desc";
		
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
	public int getTotalCnt() {
		int totalCnt = 0;
		
		String sql = "select count(*) from board order by num desc";
		
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
