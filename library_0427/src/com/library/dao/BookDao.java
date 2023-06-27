package com.library.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.library.common.DBConnPool;
import com.library.vo.Book;
import com.library.vo.Criteria;

public class BookDao {
	/**
	 * 도서목록 조회
	 * @return
	 */
	public List<Book> getList(){
		List<Book> list = new ArrayList<Book>();
		
		//String sql = "select * from book order by no";
		String sql = 
				"select no, title"
				+ "    , nvl((select 대여여부 "
				+ "			 from 대여 "
				+ "			where 도서번호 = no "
				+ "			  and 대여여부='Y'),'N') rentyn "
				+ "    , author "
				+ "from book "
				+ "order by no";
		
		// try ( 리소스생성 ) => try문이 종료되면서 리소스를 자동으로 반납
		try (Connection conn = DBConnPool.getConnection();
				Statement stmt = conn.createStatement();
				// stmt.executeQuery : resultSet (질의한 쿼리에 대한 결과집합)
				// stmt.executeUpdate : int (몇건이 처리되었는지!!!)
				ResultSet rs = stmt.executeQuery(sql)){
			while(rs.next()) {
				int no = rs.getInt(1);
				String title = rs.getString(2);
				String rentYN = rs.getString(3);
				String author = rs.getString(4);
				
				Book book = new Book(no, title, rentYN, author);
				list.add(book);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	
	/**
	 * 도서목록 조회
	 * @return
	 */
	public List<Book> getListPage(Criteria criteria){
		List<Book> list = new ArrayList<Book>();
		
		//String sql = "select * from book order by no";
		String sql = 
					"select * "
					+ "from "
					+ "(select t.*, rownum rn "
					+ "from (select no, title , nvl("
					+ "(select 대여여부 from 대여 where 도서번호 = no and 대여여부='Y'),'N') rentyn "
					+ ", author from book ";
		if(criteria.getSearchWord() != null && !criteria.getSearchWord().equals("")) {
			sql += "where " + criteria.getSearchField() + " like "
					+ "'%" + criteria.getSearchWord() + "%' ";
		}
		
		    sql     += "order by no desc) t) "
		    		+ "where rn between "
		    		+ criteria.getStartNo()
		    		+ " and "
		    		+ criteria.getEndNo();
		
		// try ( 리소스생성 ) => try문이 종료되면서 리소스를 자동으로 반납
		try (Connection conn = DBConnPool.getConnection();
				Statement stmt = conn.createStatement();
				// stmt.executeQuery : resultSet (질의한 쿼리에 대한 결과집합)
				// stmt.executeUpdate : int (몇건이 처리되었는지!!!)
				ResultSet rs = stmt.executeQuery(sql)){
			while(rs.next()) {
				int no = rs.getInt(1);
				String title = rs.getString(2);
				String rentYN = rs.getString(3);
				String author = rs.getString(4);
				
				Book book = new Book(no, title, rentYN, author);
				list.add(book);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	public int getTotalCnt(Criteria criteria) {
		int res = 0;
		String sql="select count(*) from book ";

		if(criteria.getSearchWord() != null && !criteria.getSearchWord().equals("")){
				sql += "where " + criteria.getSearchField() + " like "
					+ "'%" + criteria.getSearchWord() + "%' ";
		}
		
		try(Connection conn = DBConnPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			ResultSet rs = psmt.executeQuery();
			if(rs.next()) {
				res = rs.getInt(1);
			}
			
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return res;
	}
	
	/**
	 * 도서 등록
	 * @param book
	 * @return
	 */
	public int insert(Book book) {
		int res = 0;
		
		String sql = String.format
	("insert into book (no, title, author) values (SEQ_BOOK_NO.NEXTVAL, '%s', '%s')"
				, book.getTitle(), book.getAuthor());

		// 실행될 쿼리를 출력해봅니다
		//System.out.println(sql);
		
		try (Connection conn = DBConnPool.getConnection();
				Statement stmt = conn.createStatement();	){
			res = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return res;
	}
	
	/**
	 * 도서 삭제
	 * @return
	 */
	public int delete(String noStr) {
		int res = 0;
		
		String sql = "delete from book where no in (" + noStr + ")";
		//String sql = "delete from book where no in ( ? )";
	
		// 실행될 쿼리를 출력해봅니다
		//System.out.println(sql);
		
		try(Connection conn = DBConnPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			//psmt.setString(1, noStr);
			//System.out.println(sql);
			res = psmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return res;
	}
	
	/**
	 * 도서 업데이트
	 * @return
	 */
	public int update(String no, String rentYN) {
		int res = 0;
		
		String sql = String.format
		("update book set rentYN = '%s' where no = %s", rentYN ,no);
	
		// 실행될 쿼리를 출력해봅니다
		//System.out.println(sql);
		
		try (Connection conn = DBConnPool.getConnection();
				Statement stmt = conn.createStatement();	){
			res = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return res;
	}

	public String getRentYN(String bookNo) {
		String rentYN = "";
		String sql = 
				String.format(
					"SELECT RENTYN FROM BOOK WHERE NO = %s", bookNo);
		
		
		try (Connection conn = DBConnPool.getConnection();
				Statement stmt= conn.createStatement();
				ResultSet rs = stmt.executeQuery(sql);){
			// 조회된 행이 있는지 확인
			if(rs.next()) {
				// DB에서 조회된 값을 변수에 저장
				rentYN = rs.getString(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return rentYN;
	}


	public Book selectOne(String no) {
		Book book = new Book();
		
		String sql = "select * from book where no = " + no;
		
		try(Connection conn = DBConnPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			ResultSet rs = psmt.executeQuery();
			if(rs.next()) {
				book.setNo(rs.getInt("no"));
				book.setTitle(rs.getString("title"));
				book.setAuthor(rs.getString("author"));
				book.setRentyn(rs.getString("rentyn"));
			}
			rs.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return book;
	}
}























