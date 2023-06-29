package com.library.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.library.service.MemberService;
import com.library.vo.Criteria;

@WebServlet("*.member")
public class MemberController extends HttpServlet{

	MemberService ms = new MemberService();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		System.out.println("요청 uri : " + uri);
		
		if(uri.indexOf("list") > 0) {
			Criteria cri = new Criteria(req.getParameter("searchField")
					, req.getParameter("searchWord"), req.getParameter("pageNo"));
			
			req.setAttribute("map", ms.getList(cri));
			
			req.getRequestDispatcher("./memberList.jsp").forward(req, resp);
		}
		
		if(uri.indexOf("delete") > 0) {
			int res = ms.delete(req.getParameter("delId"));
			
			if(res > 0) {
				req.getRequestDispatcher("./list.member?pageNo="+req.getParameter("pageNo")
								+"&searchField="+req.getParameter("searchField")+"&searchWord="+req.getParameter("searchWord")).forward(req, resp);
			}
		}
	}
	
	
	
	public MemberController() {
		// TODO Auto-generated constructor stub
	}

}
