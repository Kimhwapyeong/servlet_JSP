package com.library.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.Session;

import com.library.service.BookService;
import com.library.vo.Book;
import com.library.vo.Criteria;

@WebServlet("*.book")
public class BookController extends HttpServlet{
	
	BookService bs = new BookService();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		System.out.println("요청 uri : " + uri);
		//System.out.println("uri.index : " + uri.indexOf("list"));
		if(uri.indexOf("list") > 0) {
			//req.setAttribute("list", bs.getList());
			//System.out.println("북컨트롤러호출");
			
			// 검색조건 세팅
			Criteria criteria = new Criteria(req.getParameter("searchField"), req.getParameter("searchWord"), req.getParameter("pageNo"));
			// 리스트 조회 및 요청객체에 저장
			req.setAttribute("bookMap", bs.getBookMap(criteria));
			
			req.getRequestDispatcher("./list.jsp").forward(req, resp);
		
		} else if(uri.indexOf("view") > 0) {
			Book book = bs.selectOne(req.getParameter("no"));
			req.setAttribute("book", book);
			
			req.getRequestDispatcher("./view.jsp").forward(req, resp);
		
		} else if(uri.indexOf("delete") > 0) {
			int res = bs.delete(req.getParameter("delNo"));
			
			// 포워딩
			req.setAttribute("message", res + "건 삭제되었습니다.");
			req.getRequestDispatcher("./list.book").forward(req, resp);
		
		} else if(uri.indexOf("insert") > 0) {
			req.getRequestDispatcher("./insert.jsp").forward(req, resp);
			
		} else if(uri.indexOf("addbook") > 0) {
			int res = bs.insert(req.getParameter("title"), req.getParameter("author"));
			
			req.setAttribute("message", res + "건 입력되었습니다.");
			req.getRequestDispatcher("./list.book").forward(req, resp);
		
		} else if(uri.indexOf("rent") > 0) {
			System.out.println(req.getParameter("id"));
			int res = bs.rentBook(req.getParameter("no"), req.getParameter("id"));
			System.out.println(req.getParameter("no"));
			if(res>0) {
				req.setAttribute("message", "대여 성공");
			}
			req.getRequestDispatcher("./list.book").forward(req, resp);
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(req, resp);
	}
	
	public BookController() {
		// TODO Auto-generated constructor stub
	}

}
