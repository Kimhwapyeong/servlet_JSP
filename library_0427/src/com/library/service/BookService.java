package com.library.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.library.dao.BookDao;
import com.library.vo.Book;
import com.library.vo.Criteria;
import com.library.vo.PageDto;

public class BookService {
	BookDao dao = new BookDao();
	
	/**
	 * 책 리스트를 조회 합니다.
	 * @return
	 */
	public List<Book> getList(){
		List<Book> list = dao.getList();
		for(Book book : list) {
			System.out.println(book);
		}
		return list;
	}

	public Map<String, Object> getBookMap(Criteria criteria){
		Map<String, Object> map = new HashMap<>();
		
		//System.out.println("searchField : " + criteria.getSearchField() );
		
		// 리스트
		List<Book> list = dao.getListPage(criteria);
		
		// 총 건수
		int totalCnt = dao.getTotalCnt(criteria);
		
		// 페이지DTO
		PageDto dto = new PageDto(totalCnt, criteria);
		
		map.put("list", list);
		map.put("totalCnt", totalCnt);
		map.put("pageDto", dto);
		map.put("criteria", criteria);
		
		return map;
	}
	
	/**
	 * 도서 정보 입력
	 */
	public int insert(Book book) {
		int res = 0;
		res = dao.insert(book);
		/// JSFunction 에 메시지 출력이 있기 때문에 필요 없음
		if(res > 0) {
			System.out.println(res + "건 입력 되었습니다.");
		} else {
			System.err.println("입력중 오류가 발생 하였습니다.");
			System.err.println("관리자에게 문의 해주세요");
		}
		
		return res;
	}

	public int delete(String noStr) {
		int res = dao.delete(noStr);
		if(res>0) {
			System.out.println(res+"건 삭제되었습니다.");
		} else {
			System.err.println("삭제중 오류가 발생 하였습니다.");
			System.err.println("관리자에게 문의 해주세요");
		}
		
		return res;
	}

	public int rentBook(Book book) {
		int res = 0;
		// 대여가능한 도서인지 확인
		String rentYN = dao.getRentYN(book.getNo());
		if("Y".equals(rentYN)) {
			System.err.println("이미 대여중인 도서 입니다.");
			return res;
		} else if ("".equals(rentYN)) {
			System.out.println("없는 도서 번호 입니다.");
			return res;
		}
		
		// 대여처리
		res = dao.rentBook(book);
		
		if(res>0) {
			System.out.println(res + "건 대여 되었습니다.");
		}else {
			System.out.println("대여중 오류가 발생 하였습니다.");
			System.out.println("관리자에게 문의 해주세요");
		}
		return res;
	}

	public int returnBook(String rentno, String bookno) {
		int res = 0;
		// 반납가능한 도서인지 확인
		String rentYN = dao.getRentYN(bookno);
		if("N".equals(rentYN)) {
			System.err.println("반납 가능한 상태가 아닙니다.");
		} else if ("".equals(rentYN)) {
			System.out.println("없는 도서 번호 입니다.");
		}
		
		// 반납처리
		res = dao.returnBook(rentno);
		
		if(res>0) {
			System.out.println(res + "건 반납 되었습니다.");
		}else {
			System.out.println("반납 처리 중 오류가 발생 하였습니다.");
			System.out.println("관리자에게 문의 해주세요");
		}
		return res;
	}

	public Book selectOne(String no) {
		Book book = null;
		book = dao.selectOne(no);
		
		
		return book;
	}

	public Map<String, Object> rentList(Criteria cri, String userId) {
		Map<String, Object> bookMap = new HashMap<>();
		List<Book> list = dao.rentList(cri, userId);
		
		int totalCnt = dao.getRentTotalCnt(cri, userId);
		
		PageDto pageDto = new PageDto(totalCnt, cri);
		
		bookMap.put("list", list);
		bookMap.put("totalCnt", totalCnt);
		bookMap.put("pageDto", pageDto);
		bookMap.put("criteria", cri);
		
		return bookMap;
	}
	
}













