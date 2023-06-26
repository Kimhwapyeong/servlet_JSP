package model2.mvcboard;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import common.FileUtil;
import common.JSFunction;

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
		
		String saveDirectory = "C:/upload";
		
		MultipartRequest mr = FileUtil.uploadFile(req, "C:/upload", 1024*1000);
		
		if(mr == null) {
			JSFunction.alertBack(resp, "파일 저장 중 오류 발생");
			return;
		}
		
		MVCBoardDto dto = new MVCBoardDto();
		MVCBoardDao dao = new MVCBoardDao();
		dto = dao.selectOne(mr.getParameter("idx"));
		dto.setName(mr.getParameter("name"));
		dto.setTitle(mr.getParameter("title"));
		dto.setContent(mr.getParameter("content"));
		
		String fileName = mr.getFilesystemName("ofile");
		if(fileName != null) {
			FileUtil.deleteFile("C:/upload", mr.getParameter("prevSfile"));
			// 첨부파일의 확장자
			String ext = fileName.substring(fileName.lastIndexOf("."));
			String oFileName = fileName.substring(0,fileName.lastIndexOf("."));
			// H : 0~23, S : millisecond
			// 현재 시간을 파일이름으로 지정
			String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
			
			String sFileName = oFileName + "_" + now + ext; 
			
			// 3. 파일명 변경
			File oldFile = new File(saveDirectory + File.separator + fileName);
			File newFile = new File(saveDirectory + File.separator + sFileName);
			oldFile.renameTo(newFile);
			
			
			dto.setOfile(fileName);	// 원본 파일명
			dto.setSfile(sFileName);	// 저장된 파일명
		}
		
		int res = dao.update(dto);
		
		if(res>0) {
			JSFunction.alertLocation(resp, "수정되었습니다.", "../mvcboard/view.do?idx=" + dto.getIdx());
			//resp.sendRedirect("../mvcboard/list.do");
		} else {
			JSFunction.alertBack(resp, "수정중 오류가 발생하였습니다. 관리자에게 문의해주세요.");
		}
	}
	
	public EditController() {
		// TODO Auto-generated constructor stub
	}

}
