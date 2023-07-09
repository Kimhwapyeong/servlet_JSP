package com.library.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.apache.tomcat.util.http.fileupload.FileUpload;

import com.library.common.FileUtil;
import com.library.common.JSFunction;
import com.library.service.BookService;
import com.library.vo.Book;
import com.library.vo.Criteria;
import com.oreilly.servlet.MultipartRequest;

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
			req.setAttribute("map", bs.getBookMap(criteria));
			
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
		
		} else if(uri.indexOf("write") > 0) {
			req.getRequestDispatcher("./write.jsp").forward(req, resp);
			
//		} else if(uri.indexOf("addbook") > 0) {
//			int res = bs.insert(req.getParameter("title"), req.getParameter("author"));
//			
//			req.setAttribute("message", res + "건 입력되었습니다.");
//			req.getRequestDispatcher("./list.book").forward(req, resp);

			

//		} else if(uri.indexOf("rent") > 0) {
//			System.out.println(req.getParameter("id"));
//			int res = bs.rentBook(req.getParameter("no"), req.getParameter("id"));
//			System.out.println(req.getParameter("no"));
//			if(res>0) {
//				req.setAttribute("message", "대여 성공");
//			}
//			req.getRequestDispatcher("./list.book").forward(req, resp);
		} else if(uri.indexOf("myPage") > 0) {
			// 검색조건 세팅
			Criteria criteria = new Criteria(req.getParameter("searchField")
							, req.getParameter("searchWord"), req.getParameter("pageNo"));
			
			HttpSession session = req.getSession();
			req.setAttribute("bookMap", bs.rentList(criteria, session.getAttribute("userId").toString()));
			
			req.getRequestDispatcher("./myPage.jsp").forward(req, resp);
		
			/// 마이 페이지에서 반납했을 때 다시 마이페이지로 돌아가기 위해 doGet에도 return을 만들어줌
		} else if(uri.indexOf("return") > 0) {
			// 로그인 아이디 확인
			HttpSession session = req.getSession();
			if(session.getAttribute("userId") == null) {
				JSFunction.alertBack(resp, "로그인 후 이용 가능한 메뉴입니다.");
				return;
			} else {
				int res = bs.returnBook(req.getParameter("rentno"), req.getParameter("no"));
				
				if(res>0) {
					JSFunction.alertLocation(resp, "반납되었습니다.", "./myPage.book?pageNo="
								+ req.getParameter("pageNo") + "&searchField="
								+ req.getParameter("searchField") + "&searchWord="
								+ req.getParameter("searchWord"));
				} else {
					JSFunction.alertBack(resp, "반납중 오류 발생");
				}
			}
		} else {
			JSFunction.alertBack(resp, "url을 확인해주세요!");
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		System.out.println("요청 uri : " + uri);
		
		if(uri.indexOf("write") > 0) {
			// 도서등록
			// String saveDirectory = "D:\\workServlet\\git\\servlet_JSP\\library_0427\\webapp\\images\\bookimg";  // 학원
			// String saveDirectory = "C:\\Users\\user\\자바\\servlet_JSP\\servlet_JSP\\library_0427\\webapp\\images\\bookimg"; // 그램
			String saveDirectory = "C:\\Users\\User\\study\\servlet_JSP\\servlet_JSP\\library_0427\\webapp\\images\\bookimg"; // 갤북
			MultipartRequest mr = FileUtil.uploadFile(req, saveDirectory, 1024*10000);
			
			String ofile = mr.getFilesystemName("bookImg");
			
			//Book book = new Book(mr.getParameter("title"), mr.getParameter("author"));
			
			String sfile = "";
			if(ofile != null && !"".equals(ofile)) {
				sfile = FileUtil.fileNameChange(saveDirectory, ofile);
				
				//book.setOfile(ofile);
				//book.setSfile(sfile);
				
			}
							/// multipart로 받았기 때문에 mr 객체로부터 받아와야 한다!!!!!!!!
			Book book = new Book("", mr.getParameter("title"), mr.getParameter("author"), ofile, sfile);
			int res = bs.insert(book);
			
			//req.setAttribute("message", res + "건 추가되었습니다.");
			//req.getRequestDispatcher("list.book").forward(req, resp);
			if(res>0) {
				JSFunction.alertLocation(resp, res + "건 등록되었습니다.", "./list.book");
			} else {
				JSFunction.alertBack(resp, "등록 중 예외사항이 발생하였습니다.");
			}
		} else if(uri.indexOf("rent") > 0) {
			// 로그인 아이디 확인
			HttpSession session = req.getSession();
			if(session.getAttribute("userId") == null) {
				JSFunction.alertBack(resp, "로그인 후 이용 가능한 메뉴입니다.");
				return;
			} else {
				// 대여하기 - 책번호, 로그인 아이디
				Book book = new Book();
				book.setNo(req.getParameter("no"));
				book.setId(session.getAttribute("userId").toString());
				
				int res = bs.rentBook(book);
				
				if(res>0) {
					JSFunction.alertLocation(resp, "대여 되었습니다.", "./view.book?no="+book.getNo());
				} else {
					JSFunction.alertBack(resp, "대여 중 오류가 발생하였습니다.");
				}
			}
		} else if(uri.indexOf("return") > 0) {
			// 로그인 아이디 확인
			HttpSession session = req.getSession();
			if(session.getAttribute("userId") == null) {
				JSFunction.alertBack(resp, "로그인 후 이용 가능한 메뉴입니다.");
				return;
			} else {
				int res = bs.returnBook(req.getParameter("rentno"), req.getParameter("no"));
				
				if(res>0) {
					JSFunction.alertLocation(resp, "반납되었습니다.", "./list.book");
				} else {
					JSFunction.alertBack(resp, "반납중 오류 발생");
				}
			}
		}
		
	}
	
	public BookController() {
		// TODO Auto-generated constructor stub
	}

}
