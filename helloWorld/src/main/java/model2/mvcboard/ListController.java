package model2.mvcboard;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Criteria;

public class ListController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 파라메터 저장
		String searchField = req.getParameter("searchField");
		String searchWord = req.getParameter("searchWord");
		String pageNo = req.getParameter("pageNo");
		
		// 검색어, 페이지정보 저장
		Criteria criteria = new Criteria(searchField, searchWord, pageNo);
		
		// 리스트 조회
		MVCBoardDao dao = new MVCBoardDao();
		//List<MVCBoardDto> listSize = dao.getBoardList();
		List<MVCBoardDto> list = dao.getBoardPage(criteria);

		// 총 게시물 수 저장
		int totalCnt = dao.getTotalCnt(criteria);
		
		// 페이징처리 정보 저장
		PageDto pageDto = new PageDto(totalCnt, criteria);

		// request영역에 저장
		req.setAttribute("list", list);
		req.setAttribute("criteria", criteria);
		req.setAttribute("totalCnt", totalCnt);
		req.setAttribute("pageDto", pageDto);
		
		// 화면 페이지 전환
		req.getRequestDispatcher("/14MVCBoard/List.jsp").forward(req, resp);
	
	}
	
	public ListController() {
		// TODO Auto-generated constructor stub
	}

}
