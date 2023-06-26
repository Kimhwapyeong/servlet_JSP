package com.library.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.library.service.BookService;
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
			Criteria criteria = new Criteria(req.getParameter("searchField"), req.getParameter("searchWord"), req.getParameter("pageNo"));
			req.setAttribute("bookMap", bs.getBookMap(criteria));
			
			req.getRequestDispatcher("./list.jsp").forward(req, resp);
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
