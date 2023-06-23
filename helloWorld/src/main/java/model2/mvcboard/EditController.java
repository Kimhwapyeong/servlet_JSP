package model2.mvcboard;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/mvcboard/edit.do")
public class EditController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// 게시물 조회
		MVCBoardDao dao = new MVCBoardDao();
		MVCBoardDto dto =  dao.selectOne(req.getParameter("idx"));
		
		// request 영역에 저장
		req.setAttribute("dto", dto);
		
		// jsp파일로 포워딩
		req.getRequestDispatcher("/14MVCBoard/Edit.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
	
	public EditController() {
		// TODO Auto-generated constructor stub
	}

}
