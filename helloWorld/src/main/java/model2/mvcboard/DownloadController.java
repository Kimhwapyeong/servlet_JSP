package model2.mvcboard;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.FileUtil;

@WebServlet("/mvcboard/download.do")
public class DownloadController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println(req.getParameter("ofile"));
		System.out.println(req.getParameter("sfile"));
		
		//System.out.println(req.getParameter("idx"));
		MVCBoardDao dao = new MVCBoardDao();
		int res = dao.updateDownCount(req.getParameter("idx"));
		//System.out.println(res);
		FileUtil.download(req, resp, "C:/upload", req.getParameter("ofile"), req.getParameter("sfile"));
		
		
	}
	
	public DownloadController() {
		// TODO Auto-generated constructor stub
	}

}
