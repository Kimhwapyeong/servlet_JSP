<%@page import="com.library.service.BookService"%>
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
		String title = request.getParameter("title");
		String author = request.getParameter("author");
	
		BookService bookService = new BookService();
		
		if(title != null && !title.equals("") 
				&& author != null && !author.equals("")){
			bookService.insert(title, author);
			response.sendRedirect("loginAdmin.jsp");
		}else{
			response.sendRedirect("insertBook.jsp?insertErr=Y");
		}		
	%>
</body>
</html>