package model2.mvcboard;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/mvcboard/view.do")
public class ViewController extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 게시물 조회
		MVCBoardDao dao = new MVCBoardDao();
		MVCBoardDto dto = dao.selectOne(req.getParameter("idx"));
		// 조회된 게시물 저장(request영역)
		req.setAttribute("dto", dto);
		// View.jsp 페이지로 포워딩
		req.getRequestDispatcher("/14MVCBoard/View.jsp").forward(req, resp);
	}
	
	public ViewController() {
		// TODO Auto-generated constructor stub
	}

}
