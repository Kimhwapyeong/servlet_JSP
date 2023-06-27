package com.library.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.library.service.MemberService;
import com.library.vo.Member;
import com.utils.test;

@WebServlet("/login/LoginAction.do")
public class LoginController extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// name 속성의 값을 매개값으로 넘겨주면 value 속성의 값을 반환한다.
		String id = request.getParameter("userid");
		String pw = request.getParameter("userpw");
		
		// lib 이동
		// java resources -> webapp/WEB-INF/lib
		MemberService service = new MemberService();
		
		Member member = service.login(id, pw);
		
		// 아이디 쿠키에 저장	
		String saveYN = request.getParameter("saveYN");
		if("Y".equals(saveYN)){
			test.makeCookie("userId", id, 3600, response);
		}
		
		//out.print("member : " + member);
		if(member != null && !member.getId().equals("")){
			//response.sendRedirect("login.jsp?name=" + member.getId());
			HttpSession session = request.getSession();
			
			session.setAttribute("member", member);
			session.setAttribute("userId", member.getId());
			
			if(member.getAdminyn().equals("Y")){
				// 관리자인 경우 adminYN = Y
				session.setAttribute("adminYN", "Y");
			}
			response.sendRedirect("../book/list.book");
			/// 포워드 하였더니 로그인 후 나온 페이지 url이 login/LoginAction.do 여서 페이징 처리가 안됨.
			/// script에서 searchName의 action값을 바꿔주면 되지만 response를 해도 됨 
			//request.getRequestDispatcher("../book/list.book").forward(request, response);
		}else{
			response.sendRedirect("../login.jsp?loginErr=Y");
		}
	}
	
	public LoginController() {
		// TODO Auto-generated constructor stub
	}

}
