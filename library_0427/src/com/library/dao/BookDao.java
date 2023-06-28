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
				String no = rs.getString(1);
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
				String no = rs.getString(1);
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
		
		String sql = "insert into book (no, title, author, ofile, sfile) "
				+ "values (SEQ_BOOK_NO.NEXTVAL, ?, ?, ?, ?)";

		// 실행될 쿼리를 출력해봅니다
		//System.out.println(sql);
		
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);	){
			
			psmt.setString(1, book.getTitle());
			psmt.setString(2, book.getAuthor());
			psmt.setString(3, book.getOfile());
			psmt.setString(4, book.getSfile());
			
			res = psmt.executeUpdate();
			
		} catch (SQLException e) {
			System.err.println(e.getMessage());
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
					"SELECT nvl((select 대여여부 from 대여 where 도서번호 = no and 대여여부='Y'),'N') rentyn FROM BOOK WHERE NO = %s", bookNo);
		
		
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
		
		String sql = "select b.no, b.title , nvl("
				+ "(select 대여여부 from 대여 where 도서번호 = no and 대여여부='Y'),'N') rentyn "
				+ ", b.author, d.아이디, ofile, sfile, b.rentno "
				+ ", to_char(대여일,'yy/mm/dd') 대여일, to_char(반납가능일,'yy/mm/dd') 반납가능일 from book b, 대여 d "
				+ "where b.rentno = d.대여번호(+) and "
				+ "b.no = " + no ;
		
		try(Connection conn = DBConnPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			ResultSet rs = psmt.executeQuery();
			if(rs.next()) {
				book.setNo(rs.getString("no"));
				book.setTitle(rs.getString("title"));
				book.setAuthor(rs.getString("author"));
				book.setRentyn(rs.getString("rentyn"));
				book.setOfile(rs.getString("ofile"));
				book.setSfile(rs.getString("sfile"));
				book.setRentno(rs.getString("rentno"));
				book.setId(rs.getString("아이디"));
				book.setStartDate(rs.getString("대여일"));
				book.setEndDate(rs.getString("반납가능일"));
			}
			rs.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return book;
	}
	
	public int rentBook(Book book) {
		int res = 0;
		String sql1 = "select 'R'||lpad(seq_대여.nextval,5,0) from dual";
		String sql2 = "update book set rentno = ? where no = ? and (rentno is null or rentno='')";
		String sql3 = "insert into 대여 values (?, ?, ?, 'Y', sysdate, null, sysdate+14, null)";
		
		// 1. 대여번호 조회
		try(Connection conn = DBConnPool.getConnection();) {
			conn.setAutoCommit(false);
			
			PreparedStatement psmt = conn.prepareStatement(sql1);
			ResultSet rs = psmt.executeQuery();
			if(!rs.next()) {
				return res;
			}
			
			String rentno = rs.getString(1);
			System.out.println("rentno : " + rentno);
			psmt.close();
			
			psmt = conn.prepareStatement(sql2);
			psmt.setString(1, rentno);
			psmt.setString(2, book.getNo());
			
			res = psmt.executeUpdate();
			System.out.println("sql2 : " + sql2);
			System.out.println("res : " + res);
			if(res>0){
				psmt.close();
				psmt = conn.prepareStatement(sql3);
				
				psmt.setString(1, rentno);
				psmt.setString(2, book.getId());
				psmt.setString(3, book.getNo());
				
				res = psmt.executeUpdate();
				System.out.println("sql3 : " + sql3);
				System.out.println("res : " + res);
				if(res>0) {
					conn.commit();
				} else {
					conn.rollback();
				}
			} else {
				conn.rollback();
			}
			psmt.close();
			rs.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// 2. Book테이블 업데이트(rentyn=Y, rentno=대여번호)
		//		조건 : 도서번호, rentno가 null 또는 ""
		// 3. 대여 테이블 인서트()

		return res;
	}
	
	public int returnBook(String rentno) {
		int res = 0;
		System.out.println(rentno);
		// book 테이블 rentno 삭제
		String sql1 = "update book set rentno = null where rentno = '" + rentno + "'";
		String sql2 = "update 대여 set 대여여부 = 'N', 반납일 = sysdate"
				+ ", 연체일 = CASE WHEN (SYSDATE - 반납가능일) > 0 THEN trunc(SYSDATE - 반납가능일) "
				+ "WHEN (SYSDATE - 반납가능일) <= 0 THEN 0 END where 대여번호 = '" + rentno + "'";
		// 대여 테이블 대여여부 N, 반납일, 연체일 업데이트
		
		try(Connection conn = DBConnPool.getConnection();) {
			conn.setAutoCommit(false);
			
			PreparedStatement psmt = conn.prepareStatement(sql1);
			System.out.println(sql1);
			res = psmt.executeUpdate();
			
			if(res>0) {
				psmt.close();
				psmt = conn.prepareStatement(sql2);
				
				res = psmt.executeUpdate();
				
				if(res>0) {
					conn.commit();
				} else {
					conn.rollback();
				}
			} else {
				conn.rollback();
			}
			
			psmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return res;
	}


	public List<Book> rentList(Criteria cri, String userId) {
		List<Book> listBook = new ArrayList<>();
		String sql = "select * "
					+ "from ("
					+ "    select t.*, rownum rn "
					+ "    from ("
					+ "select 도서번호, title, author, 대여일, 반납일, 대여번호"
					+ ", 연체일 from book b, 대여 d "
					+ "where b.no = d.도서번호 "
					+ "and 아이디 = ? ";
		if(cri.getSearchWord() != null && !"".equals(cri.getSearchWord())) {
			sql += "and " + cri.getSearchField() + " like '%" + cri.getSearchWord() + "%' "; 
		}
			sql += "order by 대여일 desc) t)"
					+ "where rn between "
					+ cri.getStartNo()
					+ " and "
					+ cri.getEndNo();
					
		
		try(Connection conn = DBConnPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			psmt.setString(1, userId);
			ResultSet rs = psmt.executeQuery();
			while(rs.next()) {
				Book book = new Book();
				book.setNo(rs.getString("도서번호"));
				book.setTitle(rs.getString("title"));
				book.setStartDate(rs.getString("대여일"));
				book.setReturnDate(rs.getString("반납일"));
				book.setOverDate(rs.getString("연체일"));
				book.setRentno(rs.getString("대여번호"));
				book.setAuthor(rs.getString("author"));
				
				listBook.add(book);
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return listBook;
	}
	
	public int getRentTotalCnt(Criteria cri, String userId) {
		int res = 0;
		String sql = ""
				+ "select count(*) from book b, 대여 d "
				+ "where b.no = d.도서번호 "
				+ "and 아이디 = ? ";
		if(cri.getSearchWord() != null && !"".equals(cri.getSearchWord())) {
			sql += "and " + cri.getSearchField() + " like '%" + cri.getSearchWord() + "%' "; 
		}
			sql += "order by 대여일 desc";
		
		try(Connection conn = DBConnPool.getConnection();
				PreparedStatement psmt = conn.prepareStatement(sql);) {
			
			psmt.setString(1, userId);
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()) {
				res = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
			
		return res;
	}
}























