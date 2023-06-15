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
	
	if(res > 0){
		JSFunction.alertLocation("게시물이 수정되었습니다.", "List.jsp", out);
	} else {
		JSFunction.alertBack("게시물 수정 중 오류 발생", out);
	}
%>
</body>
</html>