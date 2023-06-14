<%@page import="dto.Board"%>
<%@page import="dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String num = request.getParameter("num");
	
	BoardDao dao = new BoardDao();
	Board board = dao.selectOne(num);
	
	String id = board.getId();
	String content = board.getContent();
%>
<table border='1'>
	<tr>
		<td>아이디</td>
		<td><%=id %></td>
	</tr>
	<tr>
		<td>내용</td>
		<td><%=content %></td>
	</tr>
</table>
</body>
</html>