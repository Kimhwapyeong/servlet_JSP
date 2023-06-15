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
<%@include file='../6세션/IsLogin.jsp' %>
<%
	String id = (String)session.getAttribute("UserId");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	Board board = new Board();
	board.setId(id);
	board.setTitle(title);
	board.setContent(content);
	
	NewBoardDao dao = new NewBoardDao();
	int res = dao.insert(board);
	
	if(res>0){
		out.print("<script>");
		out.print("		alert('게시글 올리기 성공');");
		out.print("		location.href='List.jsp';");
		out.print("</script>");
	} else {
		out.print("<script>");
		out.print("		alert('게시글 올리기 실패');");
		out.print("		history.go(-1);");
		out.print("</script>");
	}
%>
</body>
</html>