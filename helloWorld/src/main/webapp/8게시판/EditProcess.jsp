<%@page import="common.JSFunction"%>
<%@page import="dto.Board"%>
<%@page import="dao.NewBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@include file="../6세션/IsLogin.jsp" %>
<%
	String num = request.getParameter("num");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	NewBoardDao dao = new NewBoardDao();
	Board board = new Board(num, title, content, "", "", "");
	int res = dao.updateBoard(board);
   	
	/// 게시물 수정 후 게시물이 있던 페이지를 보기 위한 파라메터 
	String pageNo = request.getParameter("pageNo") == null ? "1"
			: request.getParameter("pageNo");
	
	if(res > 0){
		JSFunction.alertLocation("게시물이 수정되었습니다.", "View.jsp?num="+num+"&pageNo="+pageNo, out);
	} else {
		JSFunction.alertBack("게시물 수정 중 오류 발생", out);
	}
%>
</body>
</html>