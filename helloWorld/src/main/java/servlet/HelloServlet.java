package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HelloServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setAttribute("message", "서블릿 호출!!");
		//PrintWriter out = resp.getWriter();
		//out.print("서블릿 호출!!!");
		
		
		// request 영역이 공유가 안됨
		// resp.sendRedirect("HelloServlet.jsp");
		
		// request 영역이 공유
		req.getRequestDispatcher("HelloServlet.jsp").forward(req, resp);
	}
	
	public HelloServlet() {
		// TODO Auto-generated constructor stub
	}
	
}
